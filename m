Return-Path: <cyrilbur@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519082401; cv=none;
        d=google.com; s=arc-20160816;
        b=L3MRtFXuPPuFFbI8TBlWRddL/ivblJYGlacfPqYkdMaPHv1v/wn0scH65xnkw2bSEz
         DMF9sJ5TQjsRct87I2ytZqfn63Neq3j6ztQwiHgg2531WkoU1zwsmPGpzEnYnECprgKy
         ReoG3Nd2n63cUuiocDoi2cS4QJ2ieM1fMoUEXVAdAW03+h1n20FDh37IYywx6DP2f+OJ
         ntNZuS/r7x6SXqj8OuOaEB4ANx9amxqJcN5VYisUp5i5TksU4QSVvnJ4UturYSgHl7j1
         D5Jdl7GuRkAlFn002lW7fTRi2mQSm8EvYOq+y6ZK8oFOeE4CsTA3wOWkdkAMYm/1v+13
         r9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=In8GoS+mKov6FZu5BkYCQvLLJwbCfKDzMnV9z69voj0=;
        b=FYhgdswbr5v/lqlL6QN/Ws8yjlYHFCu7GpDQchmRyhfuX/+xS1p+tFmN8MK/aCh/RB
         /JT895EQJrBjW/yotVUX0w3JJCaaHwTiznzEpJZ+T+3Dd5EH9t+lpHObjHiPz7GnCrIn
         3LNE8F+uN277ZwFH5p9AZH7j9kAYNsfWJyKn4h9GWR0oPpe2NVmbg8URagvw3idCnhDm
         d+nIwmNyscNWdPHbpr7ueCyEGVWCpxWr+dyhdlwXL/a00NDBpNK3LOWDH6VMsLj+POfm
         MmMOZrvftgXwZ+k/d/TKnCjwP5kRuYlmY4lis/65UQJgw5+iYPecYhKCStAUGcbx+CEV
         y2mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZOpyLiLm;
       spf=pass (google.com: domain of cyrilbur@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cyrilbur@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZOpyLiLm;
       spf=pass (google.com: domain of cyrilbur@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cyrilbur@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227wl6fAVaRBYY8jHpsECttMkFlCSIV2sACePNMSTsK8plTpcsPdmjdbI6d3tze9qnIn02DQ+w==
Message-ID: <1519082393.6563.0.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] misc: aspeed-lpc-ctrl: Enable FWH and A2H bridge
 cycles
From: Cyril Bur <cyrilbur@gmail.com>
To: Joel Stanley <joel@jms.id.au>, Lee Jones <lee.jones@linaro.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Lei YU <mine260309@gmail.com>
Date: Tue, 20 Feb 2018 10:19:53 +1100
In-Reply-To: <20180219072422.22733-4-joel@jms.id.au>
References: <20180219072422.22733-1-joel@jms.id.au>
	 <20180219072422.22733-4-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592813270854938491?=
X-GMAIL-MSGID: =?utf-8?q?1592873348917890786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-19 at 17:54 +1030, Joel Stanley wrote:
> To date this driver has relied on prevous state from out of tree hacks
> and vendor u-boot trees in order to have the host be able to access
> data over the LPC bus.
> 
> Now we explicitly enable the AHB to LPC bridge and FWH cycles from when
> the user first configures the address to map. We chose to do this then
> as before that time there is no way for the kernel to know where it is
> safe to point the LPC window.
> 
> Tested-by: Lei YU <mine260309@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index 1827b7aa6674..a024f8042259 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -21,6 +21,10 @@
>  
>  #define DEVICE_NAME	"aspeed-lpc-ctrl"
>  
> +#define HICR5 0x0
> +#define HICR5_ENL2H	BIT(8)
> +#define HICR5_ENFWH	BIT(10)
> +
>  #define HICR7 0x8
>  #define HICR8 0xc
>  
> @@ -155,8 +159,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  		if (rc)
>  			return rc;
>  
> -		return regmap_write(lpc_ctrl->regmap, HICR8,
> -			(~(map.size - 1)) | ((map.size >> 16) - 1));
> +		rc = regmap_write(lpc_ctrl->regmap, HICR8,
> +				(~(map.size - 1)) | ((map.size >> 16) - 1));
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * Enable LPC FHW cycles. This is required for the host to
> +		 * access the regions specified.
> +		 */
> +		return regmap_update_bits(lpc_ctrl->regmap, HICR5,
> +				HICR5_ENFWH | HICR5_ENL2H,
> +				HICR5_ENFWH | HICR5_ENL2H);
>  	}
>  
>  	return -EINVAL;
