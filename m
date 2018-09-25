Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A522320842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RvLtWeA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A522320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeIYQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:15:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40714 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:15:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so18817447edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QnUXJUPd6TCG4sUJMp4hNvS8wUVHLsjO/RqZDJ/NOuA=;
        b=RvLtWeA/bfuPB3K4iDmoRHJPiDh4GSnQMPFQsugJw0v8BaR90bn/rHSqoO/e7nKJZa
         ZoL8OT2VaJWHP3YEvMO3U0QfXXR5aDHuuMrh9gnln8HxzQTEpsIhD+5kd/XwFG4OgtMg
         wVTllP6iGxEsH9vQYuwz4OL2XNbBhlH541Tq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QnUXJUPd6TCG4sUJMp4hNvS8wUVHLsjO/RqZDJ/NOuA=;
        b=WEr1OCum0OYDi9N8O/tzWAsaYLF8lheljWf1XsXJhGxm66V6yn3U9HcUB8hP7l5OZc
         mHrHiArhVY6OIOT7vCDwErbqN3N/rZ/vb/ITdRFwwh6TuVu+Rx+DKNJCDBnfrk1/JMGt
         oRWPwzgyJ2JzE5wD3KkVqeJ2m0uDiYyQ0iggmxMmDCh8HZnp4gBHWJzwAXyaQRWtDiWE
         GdxYcClxeuRV01Q8EqHeZ4ntNoqpJceoicRof9Dp3kaFUkJKbc/f0N3FVg2gLRnjgLlm
         19YWnwDGNPIi2TRDF+CLG142AAwj3QP80X7Z6GtCpljpPw0XrwZk3gXoVP7IokUJD82y
         YoVQ==
X-Gm-Message-State: ABuFfojH32/PwGdX3wNOHXsHKQBWk6JXaRhT2P6K+QR5J44fVie47Uth
        yGBnUiALNrfOLS3xH6yAFAF3B4enq8gmVA==
X-Google-Smtp-Source: ACcGV61Vew38uboXWodgnXxxZxk9c2AhvDvo+b07uak+sumZNWHlyEKUEUr1mC+uQx7BtOx5zeoA8A==
X-Received: by 2002:a50:b704:: with SMTP id g4-v6mr7656269ede.139.1537870092062;
        Tue, 25 Sep 2018 03:08:12 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3313442edr.82.2018.09.25.03.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 03:08:11 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:08:03 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 17/30] csky: Misc headers
Message-ID: <20180925100803.GA6891@andrea>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

> +/*
> + * set_bit - Atomically set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * This function is atomic and may not be reordered.  See __set_bit()
> + * if you do not require the atomic guarantees.
> + *
> + * Note: there are no guarantees that this function will not be reordered
> + * on non x86 architectures, so if you are writing portable code,
> + * make sure not to rely on its reordering guarantees.
> + *
> + * Note that @nr may be almost arbitrarily large; this function is not
> + * restricted to acting on a single-word quantity.
> + */
> +static inline void set_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long tmp;
> +
> +	/* *p  |= mask; */
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2)	\n"
> +		"	or32		%0, %0, %1	\n"
> +		"	stex.w		%0, (%2)	\n"
> +		"	bez		%0, 1b		\n"
> +		: "=&r"(tmp)
> +		: "r"(mask), "r"(p)
> +		: "memory");
> +	smp_mb();
> +}
> +
> +/**
> + * clear_bit - Clears a bit in memory
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + *
> + * clear_bit() is atomic and may not be reordered.  However, it does
> + * not contain a memory barrier, so if it is used for locking purposes,
> + * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
> + * in order to ensure changes are visible on other processors.
> + */
> +static inline void clear_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long tmp;
> +
> +	/* *p &= ~mask; */
> +	mask = ~mask;
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2)	\n"
> +		"	and32		%0, %0, %1	\n"
> +		"	stex.w		%0, (%2)	\n"
> +		"	bez		%0, 1b		\n"
> +		: "=&r"(tmp)
> +		: "r"(mask), "r"(p)
> +		: "memory");
> +	smp_mb();
> +}
> +
> +/**
> + * change_bit - Toggle a bit in memory
> + * @nr: Bit to change
> + * @addr: Address to start counting from
> + *
> + * change_bit() is atomic and may not be reordered. It may be
> + * reordered on other architectures than x86.
> + * Note that @nr may be almost arbitrarily large; this function is not
> + * restricted to acting on a single-word quantity.
> + */
> +static inline void change_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long tmp;
> +
> +	/* *p ^= mask; */
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2)	\n"
> +		"	xor32		%0, %0, %1	\n"
> +		"	stex.w		%0, (%2)	\n"
> +		"	bez		%0, 1b		\n"
> +		: "=&r"(tmp)
> +		: "r"(mask), "r"(p)
> +		: "memory");
> +	smp_mb();
> +}

The {set,clear,change}_bit() operations don't have to be ordered: you
might want to remove the above smp_mb()s (and adjust the comments).

  Andrea
