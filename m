Return-Path: <kernel-hardening-return-12698-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuGfcbDfM+DXN5x5+slKzMu+PVroS866V+sU1VtjWD8ZrOY3RXv1irhe5xM/tbNqL0I3kai
ARC-Seal: i=1; a=rsa-sha256; t=1521423024; cv=none;
        d=google.com; s=arc-20160816;
        b=xTjlX60O0suVwPP/H6bAh2zRNOVtSl3YRA7WsCLXCZusnf1xyrIEgWuMeK8O1/Fm5y
         5CuU+nu/+Dk9OGezWM5GYIKxeNOH9UI8cwQo2/fr7OyPWQCYZPMgD+BzpS419D6YTRF+
         OApIB0Dql86fJTF9BGaA7JiG3fUppNy5eKvCppTXHfPTDf5eyx/B6oX2jKMVrY6exshg
         i3VSfack3WVRMwols7izNMmPWCx/iLRtKSeKQq8CBt89L3IlUOamxywy9QxmkJ9G8d30
         oKv2zjnZgnk5VatkhfA+0Ct/Kss74VgG5vh/kLSGKHxiWvyb8wEDsHX82BVGQbP8GQK1
         WK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=3Hicz3seT4Ptw1cYWrt1bMs9ADkVupAMZbNkdc9DXVw=;
        b=IaLJdDAdMpL8rYZzTnUluQno4fwmL/ixC66qPWb0soTx+2GQ6gszGzi1okgMXFHpA9
         EZEiQ+ir0XBBPuL98dcnAPebx/ZSupDZh7u7Vy7xQXntzYMbffd8MK37n/d6nGZo4H1t
         n8OZcorhJfcLoZ6Af2r+PJtpqtVkdN1ocZJFhWAZDYn0I23JbH9egO/Dj2pxl7AE4tXq
         iPgzx2qoHOrJ1SUX9Mq62Fnj5zJE1wKgWhcsU1hK1BWBDu7QWcqCSSaYqvyPzYWKp/eR
         XHcYZ3pggdJVugzqoWGpFDi0ME2V+H+0xI4pTRNDsW4n1aGb6mP9IdsC4NcFoMZILWIy
         FOsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12698-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12698-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12698-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12698-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv2 4/4] gpio: Remove VLA from stmpe driver
To: Laura Abbott <labbott@redhat.com>,
  Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
  Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
  kernel-hardening@lists.openwall.com
References: <20180315180030.20001-1-labbott@redhat.com>
 <20180315180030.20001-5-labbott@redhat.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <21a2e869-62fb-75ef-ae7b-a27e136696f7@electromag.com.au>
Date: Mon, 19 Mar 2018 09:29:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315180030.20001-5-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027652990122948?=
X-GMAIL-MSGID: =?utf-8?q?1595327668476636252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/03/2018 02:00, Laura Abbott wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
> 
> This patch replaces a VLA with an appropriate call to kmalloc_array.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switch to GFP_KERNEL. There was some discussion about if we should
> be doing the allocation at all but given a) the allocation is pretty
> small and b) we can possibly take a mutex in a called function I think
> this is fine.

I still think it's a bad idea. It's simple to preallocate the buffer.
But it's up to the maintainer.


> ---
>   drivers/gpio/gpio-stmpe.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
> index f8d7d1cd8488..c2bb20ace6f5 100644
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
> +	status = kmalloc_array(num_banks, sizeof(*status), GFP_KERNEL);
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


-- 
Regards
Phil Reid
