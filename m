Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEAFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8882146E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8882146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeKIKzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:55:01 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47058 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKIKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:55:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gKvPh-0007vI-7Y; Thu, 08 Nov 2018 18:16:45 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gKvPf-0001xJ-JC; Thu, 08 Nov 2018 18:16:45 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rian Quinn <rianquinn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
Date:   Thu, 08 Nov 2018 19:16:39 -0600
In-Reply-To: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
        (Rian Quinn's message of "Thu, 8 Nov 2018 15:23:59 -0700")
Message-ID: <8736sbkq2w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gKvPf-0001xJ-JC;;;mid=<8736sbkq2w.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19SwpGKWdBW8qo6DXAjg+mvYFOKDJJGu3Q=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: x86_64 INIT/SIPI Bug
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rian Quinn <rianquinn@gmail.com> writes:

> I apologize upfront if this is the wrong place to post this, pretty new to this.
>
> We are working on the Bareflank Hypervisor (www.bareflank.org), and we
> are passing through the INIT/SIPI process (similar to how a VMX
> rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
> the INIT/SIPI process stalls, something we are not seeing on Ubuntu.
>
> Turns out, to fix the issue, we had to turn on cpu_init_udelay=10000.
> The problem is, once a hypervisor is turned on, even one that is doing
> nothing but passing through the instructions, the "quick" that is
> detailed below fails as the kernel is not giving the CPU enough time
> to perform a VMExit/VMEntry (even through the VMExit is not doing
> anything).
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v4.20-rc1#n650
>
> You can see our INIT/SIPI code here if you are interested:
> https://github.com/rianquinn/extended_apis/blob/hyperkernel_1/bfvmm/src/hve/arch/intel_x64/vmexit/init_signal.cpp
>
> The reason I suggest this is a bug is the manual clearly states that a
> wait is required and the "quirk" that turns off this delay prevents
> code like this from working. Would it be possible to either:
> - Turn this off by default, but still allow someone to turn it on if
> they are confident the delay is not needed?
> - Provide a generic way to turn this off (maybe if a hypervisor is
> detected, it defaults to off)?
>
> I'd be more than happy to provide a patch and test, but I'm not sure
> if there is any interest in changing this code.

I would suggest testing either for your hypervisor or simply for being
inside some hypervisor.  As I read the code it is only turning off the
10ms delay on processors where it is know that it is safe to do so.
This is a case where it is not safe to disable the 10ms delay,
so it makes sense not not turn off the delay.

Eric

