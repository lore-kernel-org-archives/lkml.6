Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BABAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F205E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F205E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeIEALp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:11:45 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50998 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEALp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:11:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B32AC606D49C;
        Tue,  4 Sep 2018 21:45:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id djQhKjUL7Aqm; Tue,  4 Sep 2018 21:45:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6C4246060952;
        Tue,  4 Sep 2018 21:45:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qfyXZmRsvyWZ; Tue,  4 Sep 2018 21:45:07 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E3268606094F;
        Tue,  4 Sep 2018 21:45:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
Cc:     Will Deacon <Will.Deacon@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, "jdike@addtoit.com" <jdike@addtoit.com>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH] arm64/ptrace: add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support
Date:   Tue, 04 Sep 2018 21:45:06 +0200
Message-ID: <3641125.aEYyuDiOni@blindfold>
In-Reply-To: <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
References: <20180903062310.GA4524@haibo-VirtualBox> <20180903165726.GJ6954@arm.com> <AM4PR08MB29297B27FCC0E8696473523185030@AM4PR08MB2929.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. September 2018, 04:11:07 CEST schrieb Haibo Xu (Arm Technology China):
> Hi Richard,
> 
> What do you mean by done it in the core? moving macro definition to include/uapi/linux/ptrace.h?
> The patch is strictly follow x86's sematic on PTRACE_SYSEMU/SINGLESTEP support.

Well, the feature itself is not really architecture specific.
Just because x86 does it in arch/x86, it does not mean that this is the best way.
I guess this is also what Will tried to say.
If we can, we should implement PTRACE_SYSEMU in the core ptrace code and not
per architecture.

> > > I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> > > Are you porting UML or gvisor to arm64?
> >
> > That's a good question. Haibo?
> 
> The story is we are working on a container runtime(Google Gvisor) support on ARM64 platform,
> and the Gvisor depend on Linux kernel PTRACE_SYSEMU/SINGLESTEP support.

Gvisor also supports a kvm backend which should be *much* faster than PTRACE_SYSEMU.
Otherwise gvisor suffers from the same performance drawbacks as UML does.
Pagefaults via SIGSEGV/mmap, syscall gate via ptrace().

Did you check, is PTRACE_SYSEMU really the way to go for gvisor?
Last time I checked the KVM backend looked promising but still WIP, though.

I also wonder whether PTRACE_SYSEMU is really the only missing bit to support
gvisor on arm64. Did you check how to work around VIPT/VIVT caching issues?
UML (and gvisor in this context) have lots of implicit x86 dependencies.

Thanks,
//richard


