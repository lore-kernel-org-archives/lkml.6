Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84D2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0A720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TD2vljlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0A720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeKICdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:33:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:33:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so7223683pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KezV1JFuoks0ChOPNTTXi/hsEFFcC46T33uZsk1QVdw=;
        b=TD2vljlX2uYHrwsacdv7Q04XUv+HDJTo/Kw8irBg/TxfFTESJUdJLOeqhpQXR31ye3
         9A4bYs+R5Sf+pHbMXTstK5qeMYVYPKmqDb/a9YLZey2Kw+g6iRlvilXKR1U6BO8LtRz3
         ElZ2aF3zEnamj3hXpHbNEKdD6PnwYQQ7TwWEaC2KmfHgwpLNJEUoOz3EXNnVWI3hjEg/
         gSP1MCVjUI1LZDJWEpw7A3v0cl7CxV96rCqX9DKjXgSAKa1sS7Q3B7CJq5Gakmx3Xil2
         eLdPJbdKKKknSMyXPLR/2QrRuczISWXxZ0E6zg61QUjIQaCPgsdO3y44WLwQnvhpPjT6
         AFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KezV1JFuoks0ChOPNTTXi/hsEFFcC46T33uZsk1QVdw=;
        b=HUCUidi5An+veqbbPqNgeMVV8I6nCvLaEjaa58f7t5tBR6uDkXWEnauMLeALSBqZsV
         yb7addQ/b0uCi9mPcJ2AOzoBB1E1oM30yV2kTR8QwwKeIOQkliLEvt2TpJ6OmJFrhdec
         Rie5CbOpt1z4RfUJ8ruL4PuhqR/SeB+Z4m41M6vmYdR8yMb5rkb7oFIM7Ur+qbQat2K1
         uCKZZByRBWSqonYqmCdSAy3aVW4RJ+LolGovEQgPVEVmET9pq9weA34idpE8HCxccc/W
         SimjFrrNpG/hQqDjPnweY0ISgQvjpewRuj/4KlWqo7gwGJAwhHRNNxKnwMUmd7kNu2Hj
         DYuw==
X-Gm-Message-State: AGRZ1gI5FC6AKEevlag77vBuQybjurz6fRXhWD8asDkAYYEk0b5Ubi7R
        fSCRbcstnGLCV01BZDydI3xGPQ==
X-Google-Smtp-Source: AJdET5fSF8rvzlqWfyOgfOgrhcdMyxEvn3zg3CJIGdSIStoro3GkzBjuZph2ZELRDgiBoK04Va4N9w==
X-Received: by 2002:a63:ba19:: with SMTP id k25mr4369844pgf.194.1541696242517;
        Thu, 08 Nov 2018 08:57:22 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k75-v6sm12330121pfb.119.2018.11.08.08.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:57:21 -0800 (PST)
Date:   Thu, 08 Nov 2018 08:57:21 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 08:29:39 PST (-0800)
Subject:     Re: [PATCH] riscv: add asm/unistd.h UAPI header
In-Reply-To: <CAK8P3a2468O=MVXVaZ8_Vq6DuOYV2iwR98upqpWOH67z9Gh-6Q@mail.gmail.com>
CC:     david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcin.juszkiewicz@linaro.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-9210a40d-eee0-4600-ae47-4fdff795f0a6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018 02:30:02 PST (-0800), Arnd Bergmann wrote:
> On Thu, Nov 8, 2018 at 3:10 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 07 Nov 2018 13:09:39 PST (-0800), Arnd Bergmann wrote:
>> > On Wed, Nov 7, 2018 at 7:30 PM David Abdurachmanov
>> > <david.abdurachmanov@gmail.com> wrote:
>> >> On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>> >> > On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
>> >
>> >> > The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
>> >> > That's progressing well, with one last blocking issue related to some of our
>> >> > floating-point emulation routines before we can submit the port.  This should
>> >> > give us ample time to line up the ABIs correctly so everything works.
>> >> >
>> >> > So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
>> >> >
>> >>
>> >> Then if you agree I could do and send v2:
>> >>
>> >> +#ifdef __LP64__
>> >> +#define __ARCH_WANT_NEW_STAT
>> >> +#endif /* __LP64__ */
>> >
>> > Looks good to me.
>>
>> This is a bit pedantic, but I'm not sure what the right answer is here:
>> "-march=rv64gc -mabi=ilp32d" will not define __LP64__, but will define
>> "__riscv_xlen == 64".  I actually don't know enough about how an rv64gc/ilp32d
>> ABI would work to answer this: would we have "long long" all over our syscalls?
>>
>> Probably not worth worrying about for now, as we'll have to go audit all of
>> these if we ever end up with an ilp32 ABI.  So just go for it and we'll throw
>> this on the pile to deal with later :)
>
> Short answer: it doesn't matter because an ilp32d ABI would use neither
> newstat nor stat64, it would only need statx().
>
> Long answer: We've gone through multiple iterations on the question.
> x86 uses long long in syscall interfaces and tries to reuse the native
> 64-bit syscalls as much as possible. This turned out to cause endless
> problems, so for the (never merged but still kept around as a patchset)
> arm64 ABI, we went the opposite way, and made the syscalls use the
> same ABI as the arm32 mode.
>
> From the experience with both of the above, I'd say if you end up
> having to do it, use the same method as arm64, but try to resist
> doing it at all. Unlike arm64 and x86-64, there is no inherent benefit
> to using the 64-bit instruction set (doubled register number etc),
> so compared to the normal lp64 ABI you only gain a little dcache
> space for the smaller pointers at the cost of a smaller address
> space. For you as a maintainer however, the cost of supporting this
> mode is that you are stuck with three user space ABIs instead of
> just two (normal 32-bit and 64-bit).
> If anyone really wants to run 32-bit code, they need a CPU that
> allows switching modes.

Thanks!
