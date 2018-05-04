Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrDJMn15HyHSI9BSMg4ARBJSIV43ZQ1pbJ7DT/3bA9FjS/7nmbl3CxvT59+vjW1ALtMizOI
ARC-Seal: i=1; a=rsa-sha256; t=1525392361; cv=none;
        d=google.com; s=arc-20160816;
        b=M4hlczQuDEhCCnPJSEIpjnke7aRs3EJ3llP4gRNBbFj9UAGkJPA4USrR9QiRiNibMl
         ev++jaP2ku+cPAaOmCYbyCx7IRkXp4Z9xv3BBd9R1SzKJoIl1LduqZImF6GjVFTVvg4j
         ADM40PUGbMFirvnH+63R2ouhhu2MrUGP8XRWROtOxYDJcp+iCSstw5hz3K+MCh2gczGC
         UypZuBoYzVH5YKj7MF/kcki+Xi2tHGL8drriJapZuGnpevPnXYIFdREkaInEEM73Bk12
         HHHpJBB4Ov3tdIPctnGM/k2Lh28aLPAYg7eCdIE3T5YWXZDEH1oSvpc6UGzz7B4CbCX6
         Gi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=aJ4yPtIz9Fb7Xpk/qOVKXyYL0fkhxzXGrjzxFE5S3Yk=;
        b=vbr7kyUdOCJU4Wwa0wM98rLVqCbLyWeK5E5uYqNY2CSEQoK2L8dLTBri+O/ZXOieV6
         qpZW7PXY1zILRHF7heog71r2bpUS27kQ2oICwBZDFPc3HHwm8VrcSs6xxT0P+ssgB2pp
         YplD4J3n2pJeCLDHPoHplMu0vExMOZz0sLqGWhDTUbfYvsWlLkysPNx3bf25xZqgdYp6
         6cn99zRNnrI4KxTd2uQ1/wNfKoweCquiQ/s2JKiWi7/Js9TJlxzupVpMdQR/sPMKTAY1
         X79Da7NWu2gqO09lfcgKjcwI50hJq2PGYDbG/nnMw77Quu9qijpEnLOJSXQOiow/G2Nb
         MtOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 00:06:00 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Peter Jones <pjones@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Matthew Garrett <mjg59@google.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/6] ima: prevent sysfs fallback firmware loading
Message-ID: <20180504000600.GQ27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-3-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525182503-13849-3-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489821004419221?=
X-GMAIL-MSGID: =?utf-8?q?1599489821004419221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 09:48:19AM -0400, Mimi Zohar wrote:
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Matthew Garrett <mjg59@google.com>
> ---
>  security/integrity/ima/ima_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 754ece08e1c6..8759280dccf6 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -453,7 +453,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  		}
>  		return 0;
>  	}
> +
> +	if (read_id == READING_FIRMWARE_FALLBACK) {
> +		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("Prevent firmware sysfs fallback loading.\n");
> +			return -EACCES;
> +		}
> +		return 0;
> +	}
>  	return 0;
> +
>  }
>  

Due to the lack of ability to appraise these calls, it has me wondering if having
these drivers be wrapped into a their own kconfig may make sense, ie, they use
a mechanism which IMA cannot possibly work with. Then at least some kernel
builds can exist in which we know we can count on this run time to never
happen. Thoughts?

See for instance use of CONFIG_PREVENT_FIRMWARE_BUILD.

  Luis
