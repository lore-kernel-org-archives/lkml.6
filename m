Return-Path: <jgg@ziepe.ca>
ARC-Seal: i=1; a=rsa-sha256; t=1523030833; cv=none;
        d=google.com; s=arc-20160816;
        b=Qof59JMt1bQ1P6Zc18kNWzQrZcyGS9BhSDmnM7AR4uCAjCkEQKCgZSy+3+PmLXmtKy
         QL9T2JkdWooQJ5l+SRqq7Z2fmBFUQWTY4gypbB8Vf3/pPsS14KU8ldFjhCgOdxzBsJo3
         UOYMLp2/IWZ5owz0rxg7JHOKWcBCI4YvBiyqk/cOjozGjErnTuNARwEocfP2c5VYORed
         H8Zm1KxNrwq4ED8xqZPqS5+6M+aCIkpW7uSL3r/UU62mecRcneR+O+M+u89GvTq+5ecJ
         qgp2A80Ckj7ykfog4cUw2j+HzWR66jT11ohPX3OAsbHj3UrKDSqXMspPs9YKt2oaNjts
         gc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=xhW1P7CfXLY3cC4POcfNdKBuII8lpjpQoT8wHNQVGZ4=;
        b=iz204oXbRutf0Lr8+HqMp5C+sOv6GUVkUDWCxmfhRl0ivC3z6GuoEo0prN/D7Df9Hb
         dy+nrQrxAIM/DWDznzBdg0wu9aompXOEDH4zF8EsIeVh0WZWQFJdf8ouN0gqCMbBzNp8
         h5p0bJXRFiYZ7Hn9Lj2jdIK+5O7FNtSqE+8iu/bHACPwlg5WVm1UZJ+eQe608y+vekav
         vYmnIisgrVA+dmNoiF9nPf2zp+zQaa5lYca8XwdPttpTMUOWZ50hahQsSiqQd8cc9oT0
         ziwHFrMmPXsu9Y1Umbf96+CuVhjGpXk6Z/cGJaUIh7Z9XTSAOB+wep0uhEnTm8g4glbx
         +9Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=IBj4u5ON;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=IBj4u5ON;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
X-Google-Smtp-Source: AIpwx4+LFrF8lQASmvCz4/uroUBMZkPJjz4uSooiamuEim9Js3xpCQLzr928VtRytsccNK29sQemng==
Date: Fri, 6 Apr 2018 10:07:11 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin King <colin.king@canonical.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: st33zp24: check if chip is null before dereferencing
Message-ID: <20180406160711.GA14097@ziepe.ca>
References: <20180406160541.8188-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406160541.8188-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597013487117318145?=
X-GMAIL-MSGID: =?utf-8?q?1597013579163690721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 05:05:41PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently chip is being dereferenced by the call to dev_get_drvdata
> before it is being null checked, hence we have a potential null
> pointer dereference bug. Fix this by only dereferencing it after the
> null check.
> 
> Detected by CoverityScan, CID#1357806 ("Dereference before null check")
> 
> Fixes: 9e0d39d8a6a0 ("tpm: Remove useless priv field in struct tpm_vendor_specific")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>  drivers/char/tpm/st33zp24/st33zp24.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index f95b9c75175b..476865d66a0e 100644
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -367,7 +367,7 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
>  static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
>  			 size_t len)
>  {
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> +	struct st33zp24_dev *tpm_dev;
>  	u32 status, i, size, ordinal;
>  	int burstcnt = 0;
>  	int ret;

Chip can't be NULL here, so I would prefer to see the NULL test
deleted.

Thanks,
Jason
