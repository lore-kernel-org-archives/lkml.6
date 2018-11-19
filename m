Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7043C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F56820831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZN3h4ztk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F56820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeKSWXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:23:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50744 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbeKSWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:23:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so3016850wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTlL0l7E3B7Y+pB/h4ByjlomxYge4iW3eAh89+cc0B4=;
        b=ZN3h4ztkpd1NU1aUvno9ovQqzKEyqaG4rz0P/y8/Pn+fkX4mLTC31T9SV1MV0dESuY
         fzetAzfiqDrnQ0WULVarGZZScr/cyMJg8GjMT161JC81msrAQSPcYMTyP339aNADlog1
         BwfO5nNVj09Zd7j1iEtdfMavfeYXG+ogjt7lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTlL0l7E3B7Y+pB/h4ByjlomxYge4iW3eAh89+cc0B4=;
        b=TbnnR/B1SHbYkLkYI6EKj3Wv48Ng7J0MCEKA4bkcC9VSbNX9Tuwkfl2BeRPoDhFZP4
         sLmVABqquU+1kY7Y8dPXOB+muzoX61TJymIeDuDm3pdgzlIV7nzPHRURRs2bXtD1O/lX
         nohDvcEXLBpnuQbcPvpei6U68muAKZgEn1BLrUQ7L2ki/3mTYPe9CoK8iqYHeMmyDIW6
         TD5F47yxERo05sdyNv73LskM0FC9rb+G/bYoAT5CQSopNpc83xCgHBOYqOeC4nj95H+i
         g41xxNxRby64zAumwGLeoyHX3UUDmIj84sAeE3IrqeKXXaFsSZGWiBZa/haKb4yoFKqy
         LU1A==
X-Gm-Message-State: AGRZ1gId2QWme4p523BpoWEvTXBfoB7vlzyA7vRx+19OopYEmsArJyt6
        HTPbYcw7X+eNGIpDfwa+9WFSGQ==
X-Google-Smtp-Source: AFSGD/UyENYG/8iiCK0UH+AiCB8UnHmpx0EPXf+yZM8D5eQlPr/eKbGyc4VBQi9GvitChndd8dS2mQ==
X-Received: by 2002:a1c:28c6:: with SMTP id o189-v6mr6677704wmo.89.1542628805697;
        Mon, 19 Nov 2018 04:00:05 -0800 (PST)
Received: from [192.168.0.40] (51.223.136.77.rev.sfr.net. [77.136.223.51])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm89823155wmd.41.2018.11.19.04.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 04:00:05 -0800 (PST)
Subject: Re: [PATCH v3] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181119112917.4214-1-abrodkin@synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b3bc70ba-5e02-0e46-01e8-9c72aa653a54@linaro.org>
Date:   Mon, 19 Nov 2018 13:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119112917.4214-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 12:29, Alexey Brodkin wrote:

[ ... ]

>  arch/arc/Kconfig                |  1 +
>  drivers/clocksource/Kconfig     |  1 +
>  drivers/clocksource/arc_timer.c | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig

Can I have an Ack for the arch part ?

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

