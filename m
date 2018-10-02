Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39164C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744D208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bfIi/MZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E744D208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJBNmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:42:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38761 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbeJBNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:42:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so308841ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fH0iHBbAZmSy1QCMYfLpEVj6PayTawUWzJ1lHL2HoGg=;
        b=bfIi/MZ8ZvrM675p/apJdA/Hg3hOgCabAoWrKxibOr3zMcEdZ1HQDPiEsZe64hbeel
         sCFJ4XpZ+Xgsy6pxwo1NwD2vkHDtDwsjDrPLKT97oq2CPU9Hgrsu/79qRedbFp4g83eW
         +jsI/9PdlUwDxW4gw0xhmcJdQBi5VB7nwrbEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fH0iHBbAZmSy1QCMYfLpEVj6PayTawUWzJ1lHL2HoGg=;
        b=XIEa0dFf4qoGCs1DuKqWglpAP/5w/q+tjUurhW0Yqg3HMtsp9GpwmP7FSAHeIiuEpH
         KCXLUzhOR20pLtreznycIVvvFZW0nuRCgr1UCGhI6nI58/1V5m82cBbhRgD84xzKWOAO
         d1krldNonpHtSx508H1x+eNMBmtGhtPKzJj5cAd/Yf9jrJDEnAHOoty2urkjDYBuRzLN
         GefVM5ZgsNswy8Y1Ov0YhoiWCj+jmzbrwPNIiqqqBFMlwbdgouv+bLjbhJWhcjjMQdAd
         BI6K1WbVvKOhOLYcr5K6PYgXPH5TrUSgyLTLaj2ZXOM8JHvrUIphHkNzi4G5HqWWVJF6
         z2Fg==
X-Gm-Message-State: ABuFfogxQkIheCrtEyoyrffYHSKMyWRkhEpuETQ+p04NBrwh/UtfYpG0
        QZfg+Agq1753IKQyoyZ6BXwb8A==
X-Google-Smtp-Source: ACcGV60Fu01+SZMkAEo1Bgz/pJ2WhvsHx+5SL74gwxE+JCxtsM6fUz5KDqTvualD1Ymzjhe9bV6G7g==
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr2843612ljv.31.1538463646910;
        Tue, 02 Oct 2018 00:00:46 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n195-v6sm2678801lfb.26.2018.10.02.00.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:00:46 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 3/8] gpio: 104-dio-48e: Utilize
 for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <822be05b-092b-41c2-3c31-8981acd5cb9e@rasmusvillemoes.dk>
Date:   Tue, 2 Oct 2018 09:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5906381114b14d5b0359510a1d23accbd239eaa5.1538441919.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-02 03:14, William Breathitt Gray wrote:
>  	/* clear bits array to a clean slate */
>  	bitmap_zero(bits, chip->ngpio);
>  
> -	/* get bits are evaluated a gpio port register at a time */
> -	for (i = 0; i < ARRAY_SIZE(ports); i++) {
> -		/* gpio offset in bits array */
> -		bits_offset = i * gpio_reg_size;
> -
> -		/* word index for bits array */
> -		word_index = BIT_WORD(bits_offset);
> -
> -		/* gpio offset within current word of bits array */
> -		word_offset = bits_offset % BITS_PER_LONG;
> -
> -		/* mask of get bits for current gpio within current word */
> -		word_mask = mask[word_index] & (port_mask << word_offset);
> -		if (!word_mask) {
> -			/* no get bits in this port so skip to next one */
> -			continue;
> -		}
> -
> -		/* read bits from current gpio port */
> +	for_each_set_clump(i, word, offset, mask, ARRAY_SIZE(ports), 8) {
>  		port_state = inb(dio48egpio->base + ports[i]);
> -
> -		/* store acquired bits at respective bits array offset */
> -		bits[word_index] |= port_state << word_offset;
> +		bits[word] |= port_state << offset;

Somewhat unrelated to this series, but is the existing code correct? I'd
expect the RHS to be masked by word_mask; otherwise we might set bits in
bits[] that were not requested? And if one does that, the !word_mask
test is merely an optimization to avoid reading the gpios when the
result would be ignored anyway. Perhaps no caller cares.

Rasmus
