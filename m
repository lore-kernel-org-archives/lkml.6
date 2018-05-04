Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoK03YfUzbQf3AB1o8oJ3ut5ZKQqfItNM6o+P2mA9hnnwwEMKlGFejFlmG2tMpNz5ROQdDV
ARC-Seal: i=1; a=rsa-sha256; t=1525392180; cv=none;
        d=google.com; s=arc-20160816;
        b=gWueZhggAC4922yAcwQjNOSouafi+bqlk6zbToJTPYeaPGgN/rGLnfw8PZWMtr2nlk
         zkrmQdE3RWm5JOMg2HIdSyRje35ZoOcAwDxlSotbR3buSX1DkYDBpcnPd5sb60qRSOoe
         IFpmvvTI5Ri2kuOHdjE+wcyUb/7AsNqkAJZpzDnEbHCfpMfNAQvOyee20Vnq8WIC8ccm
         UPNX8S2MOgEFInbFJjXC/iTSFQsvMAop+BW3ITA/Zc6Sj9vFsnDNdRqwNSCe+TwLrTL6
         0NE8dzAEijATrNz3KcPxvmXAMGkeOaAcJVqVqWGJt9oQ1lM676OkdaRqtAWlZkwSmPe4
         hwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/utSPfZlDEIDFTCl6SmSb8XB+JsfkA7aOK8bRMTT4SM=;
        b=NSqvZfxxWFXM0r8vyChGXeCMZ1BRU9SSuuoFtxvINFFVGNc54aE8r6yhkuzrzcyaib
         QvcsNm8rWz893rXK1ximsvM4i+7zbuYOLLOZopJzt1Hny5Y0HjRMTc7muTZry9vfoJI/
         xZVgqvQ3qKsh7iRXeCLOeM9LDpMY8cQ5Dy/SaLQYhUs/bMjprR/cwcJt4yVA1ThDZG4q
         cexVozDXLZsRrsITxwymYEDOUHCdm9CbT6ok8regDY/5H6vRd8C0ch/TJcKMwYcLYMUo
         JZQV2ZONgLwqtB4FogCGmHelHXb8zZeFMFDMA8S/SaUtKu6ZaXUh8pcnhGEhW1DYvRAk
         hMtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 00:02:58 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Peter Jones <pjones@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Matthew Garrett <mjg59@google.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] firmware: permit LSMs and IMA to fail firmware sysfs
 fallback loading
Message-ID: <20180504000258.GP27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-2-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525182503-13849-2-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489630660050876?=
X-GMAIL-MSGID: =?utf-8?q?1599489630660050876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If you can add Andres Rodriguez <andresx7@gmail.com>, and Greg to your Cc list
in the future patches that'd be appreciated.

On Tue, May 01, 2018 at 09:48:18AM -0400, Mimi Zohar wrote:
> Add an LSM hook prior to allowing firmware sysfs fallback loading.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 7 +++++++
>  include/linux/fs.h                      | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 31b5015b59fe..23d2af30474e 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>  
>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  {
> +	int ret;
> +
>  	if (fw_fallback_config.ignore_sysfs_fallback) {
>  		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
>  		return false;
> @@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  	if ((opt_flags & FW_OPT_NOFALLBACK))
>  		return false;
>  
> +	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> +	ret = security_kernel_read_file(NULL, READING_FIRMWARE_FALLBACK);
> +	if (ret < 0)
> +		return ret;
> +
>  	return fw_force_sysfs_fallback(opt_flags);
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..dc16a73c3d38 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2810,6 +2810,7 @@ extern int do_pipe_flags(int *, int);
>  	id(UNKNOWN, unknown)		\
>  	id(FIRMWARE, firmware)		\
>  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> +	id(FIRMWARE_FALLBACK, firmware)	\

If you're going to add this perhaps FIRMWARE_FALLBACK_SYSFS as we may later
get FIRMWARE_FALLBACK_EFI.

  Luis
