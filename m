Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZrFdxICZDu9wo5+H170xbWeHWeKLYiwYHg8CPad9Kp3zn0rWwywR1LKUkio4dYnUyYTBdu+
ARC-Seal: i=1; a=rsa-sha256; t=1525627217; cv=none;
        d=google.com; s=arc-20160816;
        b=EzCXVSyZf71SNBf0RVINrEIK0XfizFnDj7a4u9v+s20mi7glg+eXe+fiRvIpEtPh6J
         mmKBCmfAxPTa2duQdCAZUm+xHa8KLNaqVzZL8y/E/jblbKZRRoiaKfJYLA97zPrm8/El
         XMxm2GFP0tEsrYphrpwvi2+ephmhpHco+/SCINX5rv8Yc4YJVnq1UGPtpAAbzyxzE3yN
         tYwG0fhYljT0okjSC2hPHMGaIKobp5afKtGSNOsn3WC/jK5NZMBQ+Q7w0hMGKM2m6mtI
         KqRWFHH+TfejvepAnOE5MmTKcbi9HrBDCm2Y4XU0KjJRvQ3uC6r63OQgVfrstKI852k+
         vPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=UAozudyOsQcTG9uhjKg1MvoBvE+/LxHExRDi37I2ALc=;
        b=s7/PgrV+OcfrOFnnHquZThyUyionNgNMnaAZGquf6b6LayJATaOKdEBMaFYt3zEGhb
         DBhKZE5tz3s48hLjgJQkDGcxbEA1xYK6saJet+/O6a8GNjllQiVeCSiXU3xONUfUitWu
         IByiE+MiouIt2LTBD3Mt37aeko2YiFcx9EC3Q29PT7KOnEn59cOg3j5yIz4MvHL6T1Q3
         ZaDuPaff0Dt0EqKDWd0/NoajtWuIBE/8Slexy60IACap6XGMuxECfovexVqdPVnicLmV
         E4pbCejOr7xGIcDVV2DkmbBi7xs9uIxoOhzTo3xsXZbn8c501ZIkjl9v6doB/cPP4vNt
         hLmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ELpjm647;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ELpjm647;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v3] block: add verifier for cmdline partition
To: Wang YanQing <udknight@gmail.com>, axboe@kernel.dk,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 caizhiyong@hisilicon.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180506052356.GA11163@udknight>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cdc6b40d-4bc7-797b-facb-dd2b1552ff49@infradead.org>
Date: Sun, 6 May 2018 10:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506052356.GA11163@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599689092526143942?=
X-GMAIL-MSGID: =?utf-8?q?1599736083493401247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/05/2018 10:23 PM, Wang YanQing wrote:
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
> 
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will log a warning.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  Changes
>  v2-v3:
>  1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
>  2:Fix out of bound access in cmdline_parts_verifier.
> 
>  v1-v2:
>  1:Don't treat overlaps partition as a error, but log a warning.
> 
>  block/partitions/cmdline.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
> index e333583..fefcc72 100644
> --- a/block/partitions/cmdline.c
> +++ b/block/partitions/cmdline.c
> @@ -58,6 +58,71 @@ static int __init cmdline_parts_setup(char *s)
>  }
>  __setup("blkdevparts=", cmdline_parts_setup);
>  
> +static bool has_overlaps(sector_t from, sector_t size,
> +			 sector_t from2, sector_t size2)
> +{
> +	sector_t end = from + size;
> +	sector_t end2 = from2 + size2;
> +
> +	if (from >= from2 && from < end2)
> +		return true;
> +
> +	if (end > from2 && end <= end2)
> +		return true;
> +
> +	if (from2 >= from && from2 < end)
> +		return true;
> +
> +	if (end2 > from && end2 <= end)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline void overlaps_warns_header(void)
> +{
> +	pr_warn("\n");
> +	pr_warn("Overlaps partitions being used in command line partition.\n");

	        "Overlapping partitions are used in the command line partitions.\n"

> +	pr_warn("Don't use filesystems on overlaps partitions:\n");

	        "Don't use filesystems on overlapping partitions:\n"

> +}
> +
> +static inline void overlaps_warns_tailer(void)
> +{
> +	pr_warn("\n");
> +}
> +
> +static void cmdline_parts_verifier(int slot, struct parsed_partitions *state)
> +{
> +	int i;
> +	bool header = true;
> +
> +	for (; slot < state->limit && state->parts[slot].has_info; slot++) {
> +		for (i = slot+1; i < state->limit && state->parts[i].has_info;
> +		     i++) {
> +			if (has_overlaps(state->parts[slot].from,
> +					 state->parts[slot].size,
> +					 state->parts[i].from,
> +					 state->parts[i].size)) {
> +				if (header) {
> +					header = false;
> +					overlaps_warns_header();
> +				}
> +				pr_warn("%s[%llu,%llu] overlaps with "
> +					"%s[%llu,%llu].\n",
> +					state->parts[slot].info.volname,
> +					(u64)state->parts[slot].from << 9,
> +					(u64)state->parts[slot].size << 9,
> +					state->parts[i].info.volname,
> +					(u64)state->parts[i].from << 9,
> +					(u64)state->parts[i].size << 9);
> +			}
> +		}
> +	}
> +
> +	if (!header)
> +		overlaps_warns_tailer();
> +}
> +
>  /*
>   * Purpose: allocate cmdline partitions.
>   * Returns:
> @@ -93,6 +158,7 @@ int cmdline_partition(struct parsed_partitions *state)
>  	disk_size = get_capacity(state->bdev->bd_disk) << 9;
>  
>  	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
> +	cmdline_parts_verifier(1, (void *)state);
>  
>  	strlcat(state->pp_buf, "\n", PAGE_SIZE);
>  
> 


-- 
~Randy
