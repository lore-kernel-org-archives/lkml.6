Return-Path: <kernel-hardening-return-12505-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvhoPDm1tzbGck+K+RgiA3F8JQ8JD9ygQFnekndrK6nhfBIQl5CGrMUEAEafhsDVypePrC/
ARC-Seal: i=1; a=rsa-sha256; t=1520949020; cv=none;
        d=google.com; s=arc-20160816;
        b=rDC5zAJPiSDFsEAdjsn4ZkPKcssRLvcS+vS1/m8Isf7bpyXZ4JMqfyfhIgmaJhP+St
         2AYlCSazf4DOw3A4Pcwsyk8fT7ifeCLoSeN7cpJdN8p8EG2Kzl4nKUEmLWRQ4Abegwu/
         Hbnzg1OFr02fYq928eszL3FFDzfwIj1t5zrlb/zNLZVimoq9Wlj9WGQqyfsForw9af0s
         AFZFmHTeW4+JSQ/hbMdMegFvK9qPDMvKnM03NizmQ9GaXRViy3PA6BWLsYYpFBlbRmcJ
         KhxM4GuAzRFC4PBZ0fwmSyyqZ/BPtM5LkR5Qt/LB0NA88aioFTSKEUJmI8dWrqTQiDqr
         /0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Bv/113MeNLFNpaFVC4KkCndAsSuDbTyF7Vq83n6Bod8=;
        b=dOT076KDiV8QMSUR+bfms+mBVmtQrxZRK8wnUIyIk9KybiE6bH+cB9tBSyuRQfFx4e
         cT/5zVPDnMiYkeKccjjJwSj3acEUD7Fg54HCzhvz+Kqe1AV4g+g1/lp/x1MzmnE7mw/c
         K6XJKvEt945fX/pAqLxYbYKDlf100/NAx6ZZmA3Lce8txbnYoUDnQHz3S7DOgmPgEy+X
         M63TQrVnEVwSD+VR2rKo4pmNLKU3oSzBqEnW3nV4EWUjZx9a8Gxp1uTq5a+8iVxwY/cU
         +DmFiDvBXpA+ePVnhbuoHTMSx5AOr3DVxtU3Q1Vwa6uJlpcZYoIdnZHvh/87PidLcx8+
         IPGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12505-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12505-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12505-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12505-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/4] gpio: Remove VLA from stmpe driver
To: Laura Abbott <labbott@redhat.com>,
  Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
  Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
  kernel-hardening@lists.openwall.com
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-5-labbott@redhat.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <9175611d-049d-ec28-0716-e45fccfd579f@electromag.com.au>
Date: Tue, 13 Mar 2018 17:13:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001021.6437-5-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507326034109383?=
X-GMAIL-MSGID: =?utf-8?q?1594830640132788495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10/03/2018 08:10, Laura Abbott wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
> 
> This patch replaces a VLA with an appropriate call to kmalloc_array.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>   drivers/gpio/gpio-stmpe.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
> index f8d7d1cd8488..b7854850bcdb 100644
> --- a/drivers/gpio/gpio-stmpe.c
> +++ b/drivers/gpio/gpio-stmpe.c
> @@ -369,10 +369,14 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>   	struct stmpe *stmpe = stmpe_gpio->stmpe;
>   	u8 statmsbreg;
>   	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
> -	u8 status[num_banks];
> +	u8 *status;
>   	int ret;
>   	int i;
>   
> +	status = kmalloc_array(num_banks, sizeof(*status), GFP_ATOMIC);
> +	if (!status)
> +		return IRQ_NONE;
> +
>   	/*
>   	 * the stmpe_block_read() call below, imposes to set statmsbreg
>   	 * with the register located at the lowest address. As STMPE1600
> @@ -424,6 +428,7 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>   		}
>   	}
>   
> +	kfree(status);
>   	return IRQ_HANDLED;
>   }
>   
> 

Doing this in an irq handler seems wrong.
Perhaps better if a buffer is pre-allocated in stmpe_gpio


-- 
Regards
Phil Reid
