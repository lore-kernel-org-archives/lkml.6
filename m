Return-Path: <sergey.senozhatsky.work@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523318590; cv=none;
        d=google.com; s=arc-20160816;
        b=t5TPrbpni5fuY8r61ljSn0U0J+zOnpi3CDokDI+CC62Flnx0nYxB5kVb/vLPNsfjV8
         riLj0wfRG9VafJM9yWxubPQMfPb0flB/jUjzjt4x8rcPWGWLGyBnUFyXad+52iN/OP9E
         IpgVrZ0VAFMcwBPfGechon1HARlslQ7uh9PClXvLB26Ib1crTEPi8DMhC1YnJFCGs/lC
         2laDdhxgGX/AZMWznd3N4N7Q5Qno0t0caosVnTEIJ/u54E5iAN7LOy2Uhd/ZYnAkgj57
         XdxVxIWoL50UrM6IDSFYlnypnXIj5mba32K+r1MjeqHfyioI72k90ANT+jE8zyxgEG/m
         jICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=gxvfgfYqlVl+QgP1QNjFX4mKmgJBvmgyKG4jj2nme/c=;
        b=jBfLV/MfpZDa4+Et+CbLA9EA4qW9CxiNsh7CZ0B/xrA0OUgOTmLprT9KBhe+KclHD1
         xv8Z6elSho7M+/b+zXu9pzuLUWjiig0malAkS3RrBx978mdejQti5rXVRQC9/r8NyIOb
         gJi4xLSvSccnTuFiMskXmNkOeItcIIodBp5BcEXaBhWvGss6y4LWvmfmg+G3zrZmQcMj
         sXDulPfLdaFsGkqN/xu1Sle4gVZjdVhV+wUY9+JBPg43mgmt7BxZP4y5E4uxU1Xwq8Pi
         lzVCs2bAbZGK86SpVw/Zg5XLbpZLuHCvZg8FA1hx21LSQpT8uQ7NFHDDKLPnIDe7mFBQ
         B+MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=esFbQtGu;
       spf=pass (google.com: domain of sergey.senozhatsky.work@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergey.senozhatsky.work@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=esFbQtGu;
       spf=pass (google.com: domain of sergey.senozhatsky.work@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergey.senozhatsky.work@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/q+fuTGIcoHACb/5W3i36ZkgU+OGIxag3wJ6aRVoSfS8p/9UoFV5z3bzYdytT2VuwTOZoHgQ==
Date: Tue, 10 Apr 2018 09:03:05 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] zram: introduce zram memory tracking
Message-ID: <20180410000305.GA6942@jagdpanzerIV>
References: <20180409055435.135695-1-minchan@kernel.org>
 <20180409055435.135695-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409055435.135695-5-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597246846962715384?=
X-GMAIL-MSGID: =?utf-8?q?1597315314734360497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Minchan,

On (04/09/18 14:54), Minchan Kim wrote:
> +static long long ns2usecs(u64 nsec)
> +{
> +	nsec += 500;
> +	do_div(nsec, 1000);
> +	return nsec;
> +}

Sorry, I don't quite understand "nsec += 500".

> +static ssize_t read_block_state(struct file *file, char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
[..]
> +
> +	up_read(&zram->init_lock);
> +	copy_to_user(buf, kbuf, written);

drivers/block/zram/zram_drv.c: In function ‘read_block_state’:
drivers/block/zram/zram_drv.c:701:2: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result [-Wunused-result]
  copy_to_user(buf, kbuf, written);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[..]
> @@ -61,7 +61,9 @@ struct zram_table_entry {
>  		unsigned long element;
>  	};
>  	unsigned long value;
> +#ifdef	CONFIG_ZRAM_MEMORY_TRACKING

A silly nitpick, but since you are going to resend this one, could you
remove TAB between ifdef and CONFIG_ZRAM_MEMORY_TRACKING?

	-ss
