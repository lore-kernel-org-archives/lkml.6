Return-Path: <kernel-hardening-return-12463-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELthbzh5UIDw04TGjYR6nxR+9V2ouklQWd1eTbQyJ+9oesWi+I7PohA2EhOKrlFwhYqZNAst
ARC-Seal: i=1; a=rsa-sha256; t=1520866857; cv=none;
        d=google.com; s=arc-20160816;
        b=bRJW+Va293MBMNGXQ4/cjq1vOZJ1cXCcZAIBXYOzkUFPYc9+XlqkG2FrzvFOr+HzUN
         v9Di2sJAz2N3pKeHDi6vN0/6CC61jrtCkuB2IKgjAZhGgVD1xJF9BrtmYkV7N4mquHei
         B5ARoyqpuytjo/c5acC8QFsHZ+BlRgtYQG3yOPBfisdXsRFecn+0IMYilFuLp1PJLkIp
         T6AxcGOEa7OZKTYUEGsoHxmZO6sXm233Kx53o6gz4nREFNHvN8lG2ZzEiKTr1dVywYZA
         AgIsM0K57oMkHqy5NdPRv+XtaSp8IMUEMH8Y5961+VeXNqa2QyfVi2J5GI0a5Jd+YMWr
         +Mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=CpnJHZZTxWFHr1nmpSstlHqa72G3hT2YWnf+HkdIzOg=;
        b=Rl8ciGGmU7yzKd0q9p72FQsr8C7hvUF89eLQceAHU5jxz1U9LnyFDCL2yuTvHyaASR
         /CghLHz2b56fYMJV9t9/nLVGl85hleIjiNW56s/nfBOeBaPc6KxXLUxhshWkwarF3eS/
         X3py7fox6krwz5cLUYKJ0dAQvxFqU1gUNjrrM80iqDYyODzM+lnf86aYKdLgdsjH9AzN
         N2SpwTdj8OEx2cMr5/0Xg/5TkQa3YEchI5r3oAiXTcJpQCNOnhmm2LgJSvvNiampDqRs
         JOFE2WfLwcCkmfCH6bQ5qeQn2aSXZuqGmi6SbGBiZb7dlmNqJTpntwd0236HHkEaD8cP
         /j/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=PFYC2W/Y;
       spf=pass (google.com: domain of kernel-hardening-return-12463-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12463-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=PFYC2W/Y;
       spf=pass (google.com: domain of kernel-hardening-return-12463-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12463-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Lukas Wunner <lukas@wunner.de>,
 Mathias Duckeck <m.duckeck@kunbus.de>, Nandor Han <nandor.han@ge.com>,
 Semi Malinen <semi.malinen@ge.com>, Patrice Chotard <patrice.chotard@st.com>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
Date: Mon, 12 Mar 2018 16:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001021.6437-2-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1594744485948931974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-10 01:10, Laura Abbott wrote:
>  		/* collect all inputs belonging to the same chip */
>  		first = i;
> -		memset(mask, 0, sizeof(mask));
> +		memset(mask, 0, sizeof(*mask));

see below

> @@ -2887,14 +2909,30 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
>  
>  	while (i < array_size) {
>  		struct gpio_chip *chip = desc_array[i]->gdev->chip;
> -		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
> -		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
> +		unsigned long *mask;
> +		unsigned long *bits;
>  		int count = 0;
>  
> +		mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
> +				sizeof(*mask),
> +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +
> +		if (!mask)
> +			return;
> +
> +		bits = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
> +				sizeof(*bits),
> +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +
> +		if (!bits) {
> +			kfree(mask);
> +			return;
> +		}
> +
>  		if (!can_sleep)
>  			WARN_ON(chip->can_sleep);
>  
> -		memset(mask, 0, sizeof(mask));
> +		memset(mask, 0, sizeof(*mask));

Hm, it seems you're now only clearing the first word of mask, not the
entire allocation. Why not just use kcalloc() instead of kmalloc_array
to have it automatically cleared?

Other random thoughts: maybe two allocations for each loop iteration is
a bit much. Maybe do a first pass over the array and collect the maximal
chip->ngpio, do the memory allocation and freeing outside the loop (then
you'd of course need to preserve the memset() with appropriate length
computed). And maybe even just do one allocation, making bits point at
the second half.

Does the set function need to be updated to return an int to be able to
inform the caller that memory allocation failed?

Rasmus
