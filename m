Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F812C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193DA206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193DA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeGSGri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:47:38 -0400
Received: from ozlabs.org ([203.11.71.1]:35655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbeGSGrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:47:37 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41WNmy63X5z9s55; Thu, 19 Jul 2018 16:06:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b03897cf318dfc47de33a7ecbc7655584266f034
In-Reply-To: <1531902796-32294-1-git-send-email-ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/powernv : Save/Restore SPRG3 on entry/exit from stop.
Message-Id: <41WNmy63X5z9s55@ozlabs.org>
Date:   Thu, 19 Jul 2018 16:06:10 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 08:33:16 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On 64-bit servers, SPRN_SPRG3 and its userspace read-only mirror
> SPRN_USPRG3 are used as userspace VDSO write and read registers
> respectively.
> 
> SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
> restored.  As a result, any read from SPRN_USPRG3 returns zero on an
> exit from stop4 and above.
> 
> Thus in this situation, on POWER9, any call from sched_getcpu() always
> returns zero, as on powerpc, we call __kernel_getcpu() which relies
> upon SPRN_USPRG3 to report the CPU and NUMA node information.
> 
> Fix this by restoring SPRN_SPRG3 on wake up from a deep stop state
> with the sprg_vdso value that is cached in PACA.
> 
> Fixes: e1c1cfed5432 ("powerpc/powernv: Save/Restore additional SPRs
> for stop4 cpuidle")
> 
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Cc: <stable@vger.kernel.org> # 4.14
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b03897cf318dfc47de33a7ecbc7655

cheers
