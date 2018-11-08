Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE61C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F291720818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fk6kgpfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F291720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeKHLnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:43:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40768 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbeKHLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:43:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so4480877pfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7kEW53Tsf4vuHdcoSOTmu0pyxCYFBfcemBPKy1+w5vQ=;
        b=fk6kgpfl8XwG70W9Sc7cvloIkP5a89O+EiOwfsrji8K2IovJJiWEUhb4pDARDlfXlg
         jr4/qNuTnhtf9fkmuPoNIkaVfpOnbl3O7oORzPrZXatvG/UkJIqFpAu0Gws1SVjxQCho
         Lbd4tiqEyIFaDcXprjoxWQ8cks7WaFXKIQY2g/W2A0RB7cbCAYFEJMzvwDxySpJyLUer
         So6s2l+8MNjwqYMUufHEKvZpPqZvPRt0L7bHGThvGJpl9tfjwO2T0HBkp3HE5nWu65Ur
         swkRZeISUvO5jh/FDnjT4TtV6x1fe1dK+LyVtpwzbx4KrGKxMyHDoK21xjrD/AKXuut6
         bUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7kEW53Tsf4vuHdcoSOTmu0pyxCYFBfcemBPKy1+w5vQ=;
        b=B1z7AKNkuQaQvgltEIhtXY9cFbldZpzkNdmMwxLGad3EfSemUh6sCX9G6V80CB+JPR
         nwn+7AyDGsfELZfbod23iIoX2JqwR2kUf7jiZbK4OcwlRLjU+KJLC1tPRhBEth/Ayb1w
         UDHBDWRaD+Vj5Nxf9/gfJ+vfdqmkgb3XRunFIyTyr4LqRE8zAH3OXbLZ+arjN8UPmhHj
         FtZ4d6dbZU7CRa+Pa5kqbpYLZOT8r2gKOyDLiMA8YDItZKWA82WUUBbjEnWszfhe9oYH
         dn/RI4U8fp5VOgDVjs/qZbhLdsc+B1SHQV3zeL04qkAI3RD2fyV3qYddZ6A84kaJGFer
         ++IA==
X-Gm-Message-State: AGRZ1gI4mbjYVtVDocfAlWjw7voXqmgj//kyOmBfn1ZqdHKAjdvllQYk
        aoEVw/W0Jtdt+oruTfFByoFH+w==
X-Google-Smtp-Source: AJdET5dU2vSAIUZy5vwCvt7RN6sDay0vRPm764BHcjREYrRjeOdiizp25PZyoDsOMnY45bjvh7BZWw==
X-Received: by 2002:a63:5153:: with SMTP id r19mr2257317pgl.281.1541643010023;
        Wed, 07 Nov 2018 18:10:10 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q76-v6sm2512764pfa.18.2018.11.07.18.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 18:10:09 -0800 (PST)
Date:   Wed, 07 Nov 2018 18:10:09 -0800 (PST)
X-Google-Original-Date: Wed, 07 Nov 2018 18:09:18 PST (-0800)
Subject:     Re: [PATCH] riscv: add asm/unistd.h UAPI header
In-Reply-To: <CAK8P3a30Dmq3vp-+=jvVu8VMe+GKc9dU=+ZF0rzhFiUq2NuJ_w@mail.gmail.com>
CC:     david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcin.juszkiewicz@linaro.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-23f94805-b961-4e68-a4c1-7d79b60bd925@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Nov 2018 13:09:39 PST (-0800), Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 7:30 PM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
>> On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>> > On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
>
>> > The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
>> > That's progressing well, with one last blocking issue related to some of our
>> > floating-point emulation routines before we can submit the port.  This should
>> > give us ample time to line up the ABIs correctly so everything works.
>> >
>> > So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
>> >
>>
>> Then if you agree I could do and send v2:
>>
>> +#ifdef __LP64__
>> +#define __ARCH_WANT_NEW_STAT
>> +#endif /* __LP64__ */
>
> Looks good to me.

This is a bit pedantic, but I'm not sure what the right answer is here: 
"-march=rv64gc -mabi=ilp32d" will not define __LP64__, but will define 
"__riscv_xlen == 64".  I actually don't know enough about how an rv64gc/ilp32d 
ABI would work to answer this: would we have "long long" all over our syscalls?

Probably not worth worrying about for now, as we'll have to go audit all of 
these if we ever end up with an ilp32 ABI.  So just go for it and we'll throw 
this on the pile to deal with later :)
