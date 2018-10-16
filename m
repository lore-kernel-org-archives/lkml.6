Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32EBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CDD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATydPUtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CDD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJPVJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:09:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33823 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:09:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so11028109plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+6TdobHyMDoqnPD/fyBYAMZHWiZnq2AtaxEKyjpQzk=;
        b=ATydPUtCKNoqYjpuYfyDZM+RszZ58aFrFzB9VdwMdUhlctlfnDtYdTKcLCevfmjERx
         7N+6CcPRheM8nAuaUQ4gGiLJ9AvzW6Sz0vNEGLUHNiUnF4y2A10kv/Ai2oQCq1oKZ44C
         WZh/qO1YOMwYzswGqLzzMX+bExjJYVdhyBHIR8wmaZ946iyWFDG/AcF7psPZgkan3Ldj
         gzJ44zzMRzis2RFxDychcnkiqdeGW14wbmS4KiHYRqv+OJSleHwqgd0NxYhngmpmxUEe
         B0qsFtr1cTrgUi66YTWWOeG2ScoRjBcrvIl9njREwmYwMxbwsdMgESxiRMF+3IcFvlm5
         Niiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+6TdobHyMDoqnPD/fyBYAMZHWiZnq2AtaxEKyjpQzk=;
        b=XtUJ81a90iNJsPr7k6tXmvd6KK4S99cEw1khl0QcLimXspOswKqNd7yTcZpv+mgscN
         FMGXjYHtPSpXi8JZOdk2vQmOFquffTrRXtGCo88zGYGDFlaMEuB8v5fzHCBPCZ9vyrJ0
         lgrdRYssc4ilohr7kzhjPL5tSIa1o9fkmvaJd/xRhcQikb7HubNSijF0BVfsy/pK3NdN
         LmyLesO66QSeYu1v7P7NkFkLPitRsg3A1LTKCjv1Zht5xpwq2NasronIpSqF520mMUxl
         +JjMytw97yhuL+6d1eE74EoJOmAgAVwzuvjzYcJq14y66y+3oYMH01bi5Q3Y14VZtnds
         fbtg==
X-Gm-Message-State: ABuFfohATTtHgnsQIOosY8uQ9R9OjbDfolv73y8PIgDjEeQR/QuBf/o3
        pQDVSFJBivNvNXV5G9RMc96pq3f3
X-Google-Smtp-Source: ACcGV627zspK/clCeq1QePjnbqayfmfFiUsyyLrILKQHvqHoatCKifWOk8x41d3ZQj7HTOR+otWTpg==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr21154995plf.222.1539695932747;
        Tue, 16 Oct 2018 06:18:52 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z15-v6sm17469646pfn.170.2018.10.16.06.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:18:51 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] Cleanup ISA string setting
To:     Palmer Dabbelt <palmer@sifive.com>, alankao@andestech.com
Cc:     zong@andestech.com, nickhu@andestech.com, greentime@andestech.com,
        linux-kernel@vger.kernel.org, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <mhng-48e07863-dd56-4ef6-8342-aa19414bc1b8@palmer-si-x1c4>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fc881ae2-4803-5859-f9c1-52f1a1381f6f@roeck-us.net>
Date:   Tue, 16 Oct 2018 06:18:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-48e07863-dd56-4ef6-8342-aa19414bc1b8@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 03:34 PM, Palmer Dabbelt wrote:
> On Sun, 14 Oct 2018 16:46:40 PDT (-0700), alankao@andestech.com wrote:
>> Hi Guenter,
>>
>> On Sat, Oct 13, 2018 at 05:02:05PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> With this patch in -next applied, I get the following error
>>> when building riscv:defconfig.
>>
>> I guess what you meant was this commit:
>> commit 0a5bee05fc67ce2044b8d91a18abbf14042da531
>>
>> The modification in Makefile was
>>
>> -endif
>> -
>> -KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
>> +# ISA string setting
>> +riscv-march-$(CONFIG_ARCH_RV32I)       := rv32im
>> +riscv-march-$(CONFIG_ARCH_RV64I)       := rv64im
>> +riscv-march-$(CONFIG_RISCV_ISA_A)      := $(riscv-march-y)a
>> +riscv-march-y                          := fd
>> +riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c
>>
>> and the ":= fd" line was wrong.  It should have been
>>
>> +riscv-march-y                          := $(riscv-march-y)fd
>>
>>>
>>>
>>> What am I missing ? Does RISC-V now require a new non-upstream compiler ?
>>> Or a special version of make ? I am currently using GNU Make 4.1.
>>
>> So I sent the v8 to fix this problem.
>> Sorry for the inconvinience.
>>
>>>
>>> Thanks,
>>> Guenter
>>>
>>> ---
>>
>> And Palmer, it seems that the patch that causes this build error has been
>> pulled into linux-next.  Any idea how to fix that one?
> 
> If I run into the new version then I'll overwrite in in my for-next branch.  I don't see one, though...
> 

The series is on lore, lkml, and patchwork. Patchwork link to v8 of this patch:

https://lore.kernel.org/patchwork/patch/997407/

Guenter
