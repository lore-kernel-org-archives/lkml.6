Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994F9C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD1621775
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gXuCQNRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD1621775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHDGhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:37:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38123 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeHDGhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:37:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so3753376pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 21:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HrFHu5/j/arhYev57DuuXbHoBa5A6DHUXqASBZAO+y8=;
        b=gXuCQNRDFi1dx2LOE5xSvzMcKW4j4pHiU6Y8P24d4HBcBWtGGcB+eEgOXnPsBU2Qgy
         hjRrolqypd4KMot0Xx9IGoDKEMkbsqkhWQR19NB31jURVHbO+kxO+sXw9HODauXj2bEC
         mIUd7DCtGXNsGHY3Liyr0TA9ShZny36eI2RLcsq3JUIxp9RS4SrmWrsd8jJH5zU7WtOt
         8IOFsKCv1hgyQ3xps0NBSUqaj3+sLzAa17uZADhEc72cvA7TaQrVkSpJg4uY/PAfNSSw
         pWvjmAxPB2DNXlaT9Vsg/vbs4mvve2IsMpJZvdM3GeUHbLyEgfuB+tJPLI2GwYto2BlZ
         wP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HrFHu5/j/arhYev57DuuXbHoBa5A6DHUXqASBZAO+y8=;
        b=uhHhX8YUKoib58uBO0RGxXrBVGnz0rxBlSujtKil6f7fGNpqirYK6JHC+JtxOuWt2x
         nFm91PY+76UnUl1lMqqNWiJIZAHRqVReuQentCjMs4LmlPA5+Pf9tsbZ0ARnj8kpheqs
         0f1KykPFtCS+HPNPcQNdSO9HsUBMQxO0kHgRnIT+7RmWWMZXy37MdpBEclQa/IBsGWMw
         Ru5ZCrZaDR5CJNbycC5WOIQOu2vdV9WxqYNIhjjjXrn95anhqRjku67odup+Ba9NAtxU
         NwcY6YNhAB8EJ/VVRTBY45PTPdrJ95PJvYjIpjqbbzV1+DM7mhcXFTAPoGIZpBY36bYY
         d3xw==
X-Gm-Message-State: AOUpUlExgfA3yEn6c+aAvjAVZFNmt34tMPNXaMEXGSw5e0mhr9K3FpD9
        Q5zgiMVm33UCbNes9AdT3inB2Q==
X-Google-Smtp-Source: AAOMgpe8khdqhubMU6QWhg4uVo9ZEtQgYyPRQUoX7tMkBWhaSXgwNTVgEkDzhqIrx2x6dq8O9jdOCw==
X-Received: by 2002:a62:3241:: with SMTP id y62-v6mr7568103pfy.4.1533357500919;
        Fri, 03 Aug 2018 21:38:20 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id o27-v6sm9569961pfj.35.2018.08.03.21.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 21:38:19 -0700 (PDT)
Date:   Fri, 03 Aug 2018 21:38:19 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Aug 2018 21:14:20 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Add the directive for alignment of stvec's value
In-Reply-To: <CA+ZOyag=bAB6p_mah+g2DzffsABV3uig0qxMvTWZjunYAtrfkg@mail.gmail.com>
CC:     zong@andestech.com, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        greentime@adnestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com
Message-ID: <mhng-9a679556-1e7c-4948-b8e0-dc8f38d3ad05@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2018 18:26:48 PDT (-0700), zongbox@gmail.com wrote:
> Palmer Dabbelt <palmer@sifive.com> 於 2018年8月2日 週四 上午8:38寫道：
>>
>> On Wed, 20 Jun 2018 18:40:07 PDT (-0700), zong@andestech.com wrote:
>> > The stvec's value must be 4 byte alignment by specification definition.
>> > This directive avoids to stvec be set the non-alignment value by the
>> > following code in head.S
>> >
>> >  /* Point stvec to virtual address of intruction after satp write */
>> > la a0, 1f
>> > add a0, a0, a1
>> > csrw stvec, a0
>> >
>> > Signed-off-by: Zong Li <zong@andestech.com>
>> > ---
>> >  arch/riscv/kernel/head.S | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > index 396ec7b349ce..ae7b204f531c 100644
>> > --- a/arch/riscv/kernel/head.S
>> > +++ b/arch/riscv/kernel/head.S
>> > @@ -94,6 +94,7 @@ relocate:
>> >       or a0, a0, a1
>> >       sfence.vma
>> >       csrw sptbr, a0
>> > +.align 2
>> >  1:
>> >       /* Set trap vector to spin forever to help debug */
>> >       la a0, .Lsecondary_park
>>
>> I don't think this is actually correct: you shouldn't be aligning the address
>> at which stvec is set, but the address that stvec is set to.  If this is fixing
>> anything then it's probably just by coincidence as it's causing
>> .Lsecondary_park to be aligned.
>>
>> I think this patch is the correct fix
>>
>>     diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>     index 6e07ed37bbff..d1beecf1d060 100644
>>     --- a/arch/riscv/kernel/head.S
>>     +++ b/arch/riscv/kernel/head.S
>>     @@ -143,6 +143,7 @@ relocate:
>>         tail smp_callin
>>      #endif
>>
>>     +.align 2
>>      .Lsecondary_park:
>>         /* We lack SMP support or have too many harts, so park this hart */
>>         wfi
>>
>> Thanks for pointing this out!
>>
> The position which I set in this patch is also be set to stvec for jumping to
> correct VA at satp enabling. The label .Lsecondary_park is also be set to stvec,
> I don't notice it because as you said, this label address is correct
> just by coincidence.
> I think there are two places need to be aligned.
>
> The first setting as following:
> relocate:
>         ...
>         /* Point stvec to virtual address of intruction after satp write */
>         la a0, 1f
>         add a0, a0, a1
>         csrw stvec, a0    <-----------  first set
>         ...
>         sfence.vma
>         csrw sptbr, a0
> 1:
>         /* Set trap vector to spin forever to help debug */
>         la a0, .Lsecondary_park
>         csrw stvec, a0

I agree.  I think this should do it:

    commit a8c5f596bcd528c5468d621bc84cd901632a912a
    gpg: Signature made Fri 03 Aug 2018 09:13:56 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Wed Aug 1 17:38:30 2018 -0700
    
        RISC-V: Align early stvec targets
        
        The ISA mandantes that stvec is 4-byte aligned, but we weren't actually
        respecting in the early boot code.  These trap vector are never expected
        to actually be used unless there's a bug in early in the boot process of
        the kernel, which explains why the bug wasn't noticed until recently.
        
        Thanks to Zong for finding the bug!
        
        CC: zong@andestech.com
        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
    
    diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
    index 6e07ed37bbff..c4d2c63f9a29 100644
    --- a/arch/riscv/kernel/head.S
    +++ b/arch/riscv/kernel/head.S
    @@ -94,6 +94,7 @@ relocate:
     	or a0, a0, a1
     	sfence.vma
     	csrw sptbr, a0
    +.align 2
     1:
     	/* Set trap vector to spin forever to help debug */
     	la a0, .Lsecondary_park
    @@ -143,6 +144,7 @@ relocate:
     	tail smp_callin
     #endif
     
    +.align 2
     .Lsecondary_park:
     	/* We lack SMP support or have too many harts, so park this hart */
     	wfi

