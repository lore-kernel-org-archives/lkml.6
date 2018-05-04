Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrvkI7df+aGtbVR16wtLbG7rnFQeUQ4HObIhWcYVs400c2WprEcpr0J/eh6Y5Q9fjG9lsm7
ARC-Seal: i=1; a=rsa-sha256; t=1525392463; cv=none;
        d=google.com; s=arc-20160816;
        b=0dIHUDLOYmtzRC4doiC2hmlo4lk5k30LUMvJcng5d7Ka6WdrsXf96ZSCYGDsMtH13E
         ri9Cm4LBIvh4N/SonhYpJHNjDm1J5MZjnicJBKNdIR0/81gB+GVzRhpo7PCRs0evMwz7
         W2UfvpWe+CKPR+xTPCNnmbJ4KEFJqjimCW4z7elr5O5kDFlWinXc3+Keqv8Ki6oLXMqq
         ffcvSTPTfUVZSGlkdfxns4C/iUDo/DvRGEy3txHOoKGp9l1Cm+sWI8J40cpjzd1NRRnW
         3VpwJkyzU/QVnk0qbhTzVf4cmTnZzwH7rfuP5xhWpXxBR5cnVsDzP/n12wQ1560iR/cX
         5tNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=G8R9O2lekWeyXjVZPWU7XI9DH/GroHbUuhEHNVLn2mk=;
        b=o9Gyf9tV30fhJoN+xmtyUu+zkgYI93Mm1P/EHdvUIKZZXtacbMlJ5AmnIN1VgNfs/A
         aX41V5ptnulh4Zmwwpi7HqzDQJuAIj0Hf3D+MRdX6wVTvXh3D6ldq6M92f+043EuoU3/
         JY3QnL79IBIbg0Qlr9dlCDgrRxAyTLlEyco+jFcEZyMLALzn7mR1lISbs3AfrFIMefFE
         t4VpVsfBGuQLvjck9Ikg80QVRCILpfyxMJ353pF3jSkDdn4+nBZDyn3Ohol3Tv4LbKDM
         p3yrSGCXoNDt2tPx/OiJ6lXwWAL0W6OvBdwEvQawe65lFaaK67+6p1LE5SqAHLWovzUl
         FXew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 00:07:43 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Peter Jones <pjones@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Seth Forshee <seth.forshee@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andres Rodriguez <andresx7@gmail.com>
Subject: Re: [PATCH 3/6] firmware: differentiate between signed regulatory.db
 and other firmware
Message-ID: <20180504000743.GR27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1599489927866627191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 09:48:20AM -0400, Mimi Zohar wrote:
> Allow LSMs and IMA to differentiate between signed regulatory.db and
> other firmware.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/base/firmware_loader/main.c | 5 +++++
>  include/linux/fs.h                  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index eb34089e4299..d7cdf04a8681 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
>  			break;
>  		}
>  
> +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> +		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> +		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> +			id = READING_FIRMWARE_REGULATORY_DB;
> +#endif

Whoa, no way.

>  		fw_priv->size = 0;
>  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
>  						msize, id);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dc16a73c3d38..d1153c2884b9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
>  	id(FIRMWARE, firmware)		\
>  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
>  	id(FIRMWARE_FALLBACK, firmware)	\
> +	id(FIRMWARE_REGULATORY_DB, firmware)	\

Why could IMA not appriase these files? They are part of the standard path.

  Luis

>  	id(MODULE, kernel-module)		\
>  	id(KEXEC_IMAGE, kexec-image)		\
>  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> -- 
> 2.7.5
> 
> 

-- 
Do not panic
