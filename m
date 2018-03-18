Return-Path: <kernel-hardening-return-12692-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvHgVTIWwrVEX58iftVhE9m4pK/5DVY1HAj0SE4T9Yynh0LN44bwz0Cbr0noDoM8aLMhfHg
ARC-Seal: i=1; a=rsa-sha256; t=1521405277; cv=none;
        d=google.com; s=arc-20160816;
        b=NfztXBqLPX7cFHkLMhsTFkt8vXj01hPiYQajBWNQhLJEW+UzVp2yo0xHjcpMGOcuKw
         SP1alTBB/3Koi62bKOY8bb+kTcw+2FmQ5T06QXXePjr8mY5BSVHbVbwtJMxM3txXDI5M
         WMRTPRXz2Zi//1j0HLePkVMTt3rGXiNI6PJXlHsIgqoaKX265S6AfanCDQnlVHKueSmr
         ZZVI2rGuwC22kwyc3LugQNry8/utshbmZQ8V1xqIGY4tASuU331YotD8riXnDgbmYaQp
         iKXktXMWNalrRY98ZyLkd2HDHVkRbFDAmxx8wHWDOiP5AH4bV2PXsoaNaqtUasuc9GnK
         e6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Rf5gOgm+K3dV8RV6FvL1tqgOMzNFRLRtcGqSFGzGTOY=;
        b=xIh6GTpAI7cfUD8F/sO5I67UxjnF1OBdlp9gCKlIRS7HdBWXM2vt+MA9i8flOKuByH
         HGroW9L/q2sfkh3E1kI0WJa7yF3NF4rRUZI3gUqXf/fTc1Pj/ARzaO6eznd6K1CJdaCh
         h/5oCUf6xVw0BgOhbndeLsXAUUcObSAZG6NJW/GMQ9zb7atHFuWqV+pTlXNFx4B29Led
         BOFv7sZ83JEPbe7xPObXCW89xy0XpiLZYYrefWSQRksZhB719WmbZgtyzwacciM2TNer
         A9TbTH+G4GETQpI/K7E+Coq8DikJz2eZaQYBiTrP7KZPdWjo64HZdDMF4s47bLNwm5fX
         pgRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=e1/g4/K6;
       spf=pass (google.com: domain of kernel-hardening-return-12692-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12692-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=e1/g4/K6;
       spf=pass (google.com: domain of kernel-hardening-return-12692-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12692-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
To: Lukas Wunner <lukas@wunner.de>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Laura Abbott <labbott@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Mathias Duckeck <m.duckeck@kunbus.de>,
 Nandor Han <nandor.han@ge.com>, Semi Malinen <semi.malinen@ge.com>,
 Patrice Chotard <patrice.chotard@st.com>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
 <20180317082509.GA2579@wunner.de> <20180318142327.GA23761@wunner.de>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0f17eb05-c183-bec9-0076-5ddd00d70f15@rasmusvillemoes.dk>
Date: Sun, 18 Mar 2018 21:34:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318142327.GA23761@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1595309060997514663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-18 15:23, Lukas Wunner wrote:
>>>
>>> Other random thoughts: maybe two allocations for each loop iteration is
>>> a bit much. Maybe do a first pass over the array and collect the maximal
>>> chip->ngpio, do the memory allocation and freeing outside the loop (then
>>> you'd of course need to preserve the memset() with appropriate length
>>> computed). And maybe even just do one allocation, making bits point at
>>> the second half.
>>
>> I think those are great ideas because the function is kind of a hotpath
>> and usage of VLAs was motivated by the desire to make it fast.
>>
>> I'd go one step further and store the maximum ngpio of all registered
>> chips in a global variable (and update it in gpiochip_add_data_with_key()),
>> then allocate 2 * max_ngpio once before entering the loop (as you've
>> suggested).  That would avoid the first pass to determine the maximum
>> chip->ngpio.  In most systems max_ngpio will be < 64, so one or two
>> unsigned longs depending on the arch's bitness.
> 
> Actually, scratch that.  If ngpio is usually smallish, we can just
> allocate reasonably sized space for mask and bits on the stack,

Yes.

> and fall back to the kcalloc slowpath only if chip->ngpio exceeds
> that limit.

Well, I'd suggest not adding that fallback code now, but simply add a
check in gpiochip_add_data_with_key to ensure ngpio is sane (and refuse
to register the chip otherwise), at least if we know that every
currently supported/known chip is covered by the 256 (?). That keeps the
code simple and fast, and then if somebody has a chip with 40000 gpio
lines, we can add a fallback path. Or we could consider alternative
solutions, to avoid a 10000 byte GFP_ATOMIC allocation (maybe hang a
pre-allocation off the gpio_chip; that's only two more bits per
descriptor, and there's already a whole gpio_desc for each - but not
sure about the locking in that case).

Rasmus
