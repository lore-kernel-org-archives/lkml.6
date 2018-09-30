Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E6C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830F20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNsadYBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJAB4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:56:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeJAB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:56:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so2232258wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y9HmUaHsstDV8xrpCtkeo2/dz+ABYjh6/92j9s4IGTo=;
        b=jNsadYBPEG3C980KdT2W+/YG3QmfSYq5yWUSIGBvJP6kGjXlOwZj0CxJe/J55sGtVa
         Z6MVJ2G7Wmw1U/68jk2OnZXdfWyDJ3rvwA2qXArkUt+CEXeoGULseT5c59JoWym/Ym7G
         pILXa2bL5UKnMoP3oPJIwS/NUgVDHUO/J8PIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9HmUaHsstDV8xrpCtkeo2/dz+ABYjh6/92j9s4IGTo=;
        b=Iry+uWVHr73GDKL/3ulTrfySYG5uL8j55JcG+YvYc4xaHv6l/3eePwf5StlIcrfWtV
         wanViDWlgWXo4ia7zhdUdmubeeNCMrE6BiY6nc8i64t7K2gSbxU+bavpre+PP7XA+ydl
         IboKs18firhW/+a4axCaAKi37ZiNVRcla6qcGMpe/6IS4A6EwZgmnmz0GDrODOeWshu9
         MD3ulpOLv67Bn24a9KkmHZHJcEULnwyCTIvfltQ+1TlSIjI+4pdOv0JvyXefqkOcylyD
         6Ilm4oFaDkg8cAKxNECzRsTTCNQ8LIQ70DtWjwzXedsFssTgRknWW9FS7gQBAURJfqcg
         QdfA==
X-Gm-Message-State: ABuFfogf/HKSa/elX2mlqY/F9bUQ0N3WTw6lk0+6wuMjbox1bSDuoP/M
        qfCM5ouGCJHe0y6qQfKXNl4nWw==
X-Google-Smtp-Source: ACcGV63Jg7OfTy0yclb6InN00INGlJzcFysyFvxuonr9zuZX8e7ci5NTCAfrIrgIp40SG7JOzdhpQA==
X-Received: by 2002:adf:f346:: with SMTP id e6-v6mr4676481wrp.49.1538335352782;
        Sun, 30 Sep 2018 12:22:32 -0700 (PDT)
Received: from [192.168.0.41] (210.183.88.92.rev.sfr.net. [92.88.183.210])
        by smtp.googlemail.com with ESMTPSA id 62-v6sm16281198wra.48.2018.09.30.12.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:22:31 -0700 (PDT)
Subject: Re: [PATCH V7 3/8] clocksource: add C-SKY SMP timer
To:     Guo Ren <ren_guo@c-sky.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <9d68bdd87a8c91f4ee35ff4311e273ea81ab9eb4.1538323894.git.ren_guo@c-sky.com>
 <eee964dd57d12bc630280ab84235b5356799b1fb.1538323894.git.ren_guo@c-sky.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a15b5e43-0721-8638-f5d2-8bb72df87f4d@linaro.org>
Date:   Sun, 30 Sep 2018 21:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eee964dd57d12bc630280ab84235b5356799b1fb.1538323894.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2018 18:18, Guo Ren wrote:
> This timer is used by SMP system and use mfcr/mtcr instruction
> to access the regs.
> 
> Changelog:
>  - Remove #define CPUHP_AP_CSKY_TIMER_STARTING
>  - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h
>  - Support csky mp timer alpha version.
>  - Just use low-counter with 32bit width as clocksource.
>  - Coding convention with upstream feed-back.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---


Guo,

what is the flow of your patches ?

You sent me a V8 with two patches and those timers which I commented.

And now there is this V7 with the patches previously sent as V8 without
the comments take into account.

I'm a bit lost. Can you clarify ?

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

