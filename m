Return-Path: <kernel-hardening-return-12819-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/LdPjcrCG9dDOKUAwUJaGQQRJSCJkhCTn4PuLKNaECo+L1tZ4H/cMV2Npi74/r3v4RPqRs
ARC-Seal: i=1; a=rsa-sha256; t=1522282061; cv=none;
        d=google.com; s=arc-20160816;
        b=cqz4q4NplEUDdIcdn9eOXp1MZoTC6BdpvO49OfrsBFXbA/VEa64jrKSEg9q96xqNEI
         x4cLvJP4Q2DukLsD/gKMpkyKv8T53FEvAbAMvcktalbHyfYf1JqNRbJX09U1HWVfmYBq
         manHcRNVQr7sD5gjLJhWwj/TDy6t5YRh14k0/MQmgbVVm4vP3coyA+6m68DrwSio18J2
         Fshio/eYX4c2HXzfoENoGIZFyN15E24HZsv75dZhV07WkiKCqoStwtt13CnFeZbVV3pF
         t9JsqX/sLBHWKlYJSukOg9ovSPRvQfeQjLwtP1Dp4jphjIY6cdSXTZ2j1nQgijturzHi
         munw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=GHxiHEQsZ+9v2gAnNlal3WXQSYme8NjFVACJvrpa9Vc=;
        b=PvlyBwiFSnPZa3gnEtjvIG7oW8fuez9TdzVGp/bBdEZv5zI9PWWXk6fZU2jleeUxPo
         /jrYP6qWmhnkMvAvQV3mG0r9aR4c2CLnbS/VQb2Ej+D7VODUWV3COuaRurmzcKkkbD/2
         LVSZdmi30zfC1bbr03FstZ5yySX97ABntcA5aT58Kgjevt9mYy8lwtUctJkfToNdfmAt
         UDT2RaaKGcIUa+vpOQl3pEHMg8i5RitQnIdvmTfqQM+XweLd1HIuFSzV7OnIbuWjg0Gd
         Pq8PXqDIZpwkRezR3XMkkkYPgFfcLn/H0PngAPonvuOXYM6B0PSGx9f/DP+1TTx0zQqA
         iZwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12819-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12819-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12819-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12819-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v3] gpio: Remove VLA from stmpe driver
To: Laura Abbott <labbott@redhat.com>,
  Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
  Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
  kernel-hardening@lists.openwall.com
References: <20180328175957.23904-1-labbott@redhat.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <e676f8fc-e619-ac7e-a5e0-8682197c7b9b@electromag.com.au>
Date: Thu, 29 Mar 2018 08:07:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328175957.23904-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596205340288651646?=
X-GMAIL-MSGID: =?utf-8?q?1596228434598526541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29/03/2018 01:59, Laura Abbott wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
> 
> The number of GPIOs on the supported chips is fairly small
> so stack allocate to a known upper bound and spit out a warning
> if any new chips have more gpios.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Split this off from the rest of the series since some of the
> patches had been picked up. Switched to just hardcoding an upper
> bound for the stack array since it's only a few extra bytes
> of stack space.
> ---
>   drivers/gpio/gpio-stmpe.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
> index f8d7d1cd8488..8d6a5a7e612d 100644
> --- a/drivers/gpio/gpio-stmpe.c
> +++ b/drivers/gpio/gpio-stmpe.c
> @@ -363,13 +363,15 @@ static struct irq_chip stmpe_gpio_irq_chip = {
>   	.irq_set_type		= stmpe_gpio_irq_set_type,
>   };
>   
> +#define MAX_GPIOS 24
> +
>   static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>   {
>   	struct stmpe_gpio *stmpe_gpio = dev;
>   	struct stmpe *stmpe = stmpe_gpio->stmpe;
>   	u8 statmsbreg;
>   	int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
> -	u8 status[num_banks];
> +	u8 status[DIV_ROUND_UP(MAX_GPIOS, 8)];
>   	int ret;
>   	int i;
>   
> @@ -434,6 +436,11 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
>   	struct stmpe_gpio *stmpe_gpio;
>   	int ret, irq;
>   
> +	if (stmpe->num_gpios > MAX_GPIOS) {
> +		dev_err(&pdev->dev, "Need to increase maximum GPIO number\n");
> +		return -EINVAL;
> +	}
> +
>   	stmpe_gpio = kzalloc(sizeof(*stmpe_gpio), GFP_KERNEL);
>   	if (!stmpe_gpio)
>   		return -ENOMEM;
> 
FWIW
Reviewed-by: Phil Reid <preid@electromag.com.au>

-- 
Regards
Phil Reid
