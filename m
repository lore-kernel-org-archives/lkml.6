Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8845CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F97D20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyXAAA+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F97D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeLCOye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:54:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35485 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:54:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so12513803wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 06:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHkXpmuMJdjOAjc4qNljfTYLICAT4rbpxB36srapNC8=;
        b=iyXAAA+Byee5bNK1snzxlkbZ94zqB17eWM6OZCp09f0eUZdVe1PwczKyfIHUuhGWJI
         tUlIraO/Fj4vr84XwOPC3VJK1TX5+yhRdrf2nXRHXDGxDaG123+IqZFp2TXgbpFGsWWr
         KhOlQFUwqNXB3PjuV4F04ENN0nuS7/L2srwzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHkXpmuMJdjOAjc4qNljfTYLICAT4rbpxB36srapNC8=;
        b=sRFl9u54c4OS02S+oxXhcXYb3t04FzzNE1Fi/MzWe3k+nyhMGR0RIaPAbZ9agztwQG
         gmgdL9p7mMDTvoAUd0IhKQkXyFRDuKpSZzldLrWZi1V7xqVqxNWFfrLc3Zkv6PrpHdmw
         60jMuNmyVbZTmyQfIYeP5DcVzyDGBR6AJCrKUdGeMO7BN+6+wyMmeFNI+7H+QZGwfZ8i
         DXKQU2npBykgTEWbd+GPDT+mE4lueGFWS7pToUaLTjYLSRXmcA9eO31x3UiZcGBguMtp
         CnfJjgZthvUf/KHlSGcpaVxzEpQYV1RYN4BTJxKdxDFVyfJsHRVPpFQLYIJChF/sbmAY
         0ygA==
X-Gm-Message-State: AA+aEWYddqkrjM+KQgYCGYFeGVPoKlwYoZ+Eg5jnYLVBDLm4FtXQS+3d
        Iafbqn98z8RD2mKpPggyh5ntQa0GZVs=
X-Google-Smtp-Source: AFSGD/WFGUhI1F3USVNxeona54w3FOkwB0WN3N669EgtrtqBLAGr3u9f7wD80ChsPf1ylYuzibmoug==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr13647338wri.210.1543848793596;
        Mon, 03 Dec 2018 06:53:13 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id w8sm17442803wrv.7.2018.12.03.06.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 06:53:12 -0800 (PST)
Subject: Re: [PATCH] clocksource: riscv_timer: Provide sched_clock
To:     Anup Patel <anup@brainfault.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20181203123524.11778-1-anup@brainfault.org>
 <c970d873-9dbc-9f21-3380-89635d6f574a@linaro.org>
 <CAAhSdy2rw=4Uw8=MZtfHi_ML9ZBqeiJ2iv+tRmDnjQDh7yuUHg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <63f67f2b-9e17-78e6-beb5-65d32ff2f85c@linaro.org>
Date:   Mon, 3 Dec 2018 15:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2rw=4Uw8=MZtfHi_ML9ZBqeiJ2iv+tRmDnjQDh7yuUHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 15:50, Anup Patel wrote:
> On Mon, Dec 3, 2018 at 6:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 03/12/2018 13:35, Anup Patel wrote:
>>> Currently, we don't have a sched_clock registered for RISC-V systems.
>>> This means Linux time keeping will use jiffies (running at HZ) as the
>>> default sched_clock.
>>>
>>> To avoid this, we explicity provide sched_clock using RISC-V rdtime
>>> instruction (similar to riscv_timer clocksource).
>>>
>>> Signed-off-by: Anup Patel <anup@brainfault.org>
>>
>> Hi Anup,
>>
>> the GENERIC_SCHED_CLOCK dependency in the Kconfig is missing.
> 
> Sure, will do.
> 
> I also have another patch to select GENERIC_SCHED_CLOCK
> for CONFIG_RISCV. Should I squash that patch with this patch??

I prefer the riscv config option to be merged via the riscv tree.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

