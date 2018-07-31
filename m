Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823E1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7DB208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7DB208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeGaLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:55:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbeGaLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:55:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so13214101ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 03:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q2olNchs8Sv3XuWlKjDOMvgEXBeJ3cetECYQLXSqUZM=;
        b=jvzv/CpuUHUpTMzyg1+XWqPOM8ZqZ+baTwx2BSRU+9iTTAjMIaYS6DE6bLJNwShnea
         y5epwZ6aot3dp/GisdVsIF8Ic/ywXHHKmZcc0n6MHW2ybqgltQS4e7uT3uH4ZVHzygMN
         JX+4adwFTbTkFwSkGrJvoRfPcqQs47UunVlViIII2u5XYIm/ZMpjCy7kdUDvdAERrukw
         2SBD0lqq4qCPzagey6YG/5c9Os53gRZrWCLL191UYs5BcSyeJARemVsz0WS295V5hJyT
         4ar9DLvYOQwpqMC46f9o65xBc0vzer6nvGn6RC9tyuy5WmcUmn3dx4www6seFxi38gDg
         i5VA==
X-Gm-Message-State: AOUpUlHoJmi+iuIiUOC83CRufVkwRrZ8Tr2eNfHdKKbTnP8Vumn2+HfI
        CdywNTbIeQQTr1zif1zi4ajCGFeBsUyB1yKPntiDdQ==
X-Google-Smtp-Source: AAOMgpcymJfJqE6+oZ6x3i17NZ8dT6l6z42TssAaB8WWODhx+hJYAx59O6m/JKDsslRpB8Cfnj7Fmk1JTjr7TGk03Ew=
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr14875537ljh.95.1533032134567;
 Tue, 31 Jul 2018 03:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81a:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 03:15:33 -0700 (PDT)
In-Reply-To: <20180731092629.GD4680@arm.com>
References: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
 <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com> <20180731092629.GD4680@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 31 Jul 2018 15:45:33 +0530
Message-ID: <CACi5LpMkuq78Vn6uncZ=StR8dSHzptiZnT9mmQR+OcaLv-ck_Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
To:     Will Deacon <will.deacon@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, James,

On Tue, Jul 31, 2018 at 2:56 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 31, 2018 at 10:19:35AM +0100, James Morse wrote:
>> Hi Bhupesh,
>>
>> On 30/07/18 07:24, Bhupesh Sharma wrote:
>> > Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
>> > debugging. vmcore parsing in user-space already expects this value in
>> > the notes and we are providing it for portability of those existing
>> > tools with x86.
>> >
>> > Ideally we would like core code to do this (so that way this
>> > information won't be missed when an architecture adds KASLR support),
>> > but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
>> > so I am not sure if this is needed for mips (and other such similar arch
>> > cases in future). So, lets keep this architecture specific for now.
>>
>> (heh, I assumed you would rewrite my train-of-thought, but I guess this works!)
>>
>>
>> > As an example of a user-space use-case, consider the
>> > makedumpfile user-space utility which will need fixup to use this
>> > KASLR offset to work with cases where we need to find a way to
>> > translate symbol address from vmlinux to kernel run time address
>> > in case of KASLR boot on arm64.
>>
>> Acked-by: James Morse <james.morse@arm.com>

Thanks James.

>> If we want to send this to stable, it looks like it should have been part of the
>> KASLR series, f80fb3a3d5084 ("arm64: add support for kernel ASLR") was merged
>> for v4.6.
>> CC: <stable@vger.kernel.org> # 4.6.x
>
> Hmm, does this warrant a stable backport? This hasn't ever worked, right?

Yes, it is a new feature being enabled/tested in user-space utilities
now for arm64 (although it's being used for x86_64 since some time).

I would like the user-space utilities to do away with the arch
specific code (as much as possible) for KASLR features, but we are
still kind of stabilizing the same on various archs, so the user-space
cleanup is one of items on my to-do list.

However, since kernel and user-space features are frequently
backported to older versions (e.g. RHEL and OpenSuse), so it would
help to send this patch to stable as well, so that stable kernels >=
4.6.x can work well with such backported user-space utilities and
utilize KASLR features on arm64 well.

As such, I see no side-effect of adding this information to the
vmcoreinfo in the stable kernels as well.

Thanks,
Bhupesh
