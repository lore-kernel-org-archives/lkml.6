Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA67923FFF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA67923FFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933792AbeGFQXc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:23:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55140 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933442AbeGFQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:23:28 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbTVp-000060-Ee; Fri, 06 Jul 2018 18:23:13 +0200
Message-ID: <20180706161307.733337643@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Jul 2018 18:13:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: [patch 0/7] x86/kvmclock: Remove memblock dependency and further
 cleanups
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow early utilization of kvmclock it is required to remove the
memblock dependency. memblock is currently used to allocate the per
cpu data for kvmclock.

The first patch replaces the memblock with a static array sized 64bytes *
NR_CPUS and was posted by Pavel. That patch allocates everything statically
which is a waste when kvmclock is not used.

The rest of the series cleans up the code and converts it to per cpu
variables but does not put the kvmclock data into the per cpu area as that
has an issue vs. mapping the boot cpu data into the VDSO (leaks arbitrary
data, unless page sized).

The per cpu data consists of pointers to the actual data. For the boot cpu
a page sized array is statically allocated which can be mapped into the
VDSO. That array is used for initializing the first 64 CPU pointers. If
there are more CPUs the pvclock data is allocated during CPU bringup.

So this still will have some overhead when kvmclock is not in use, but
bringing it down to zero would be a massive trainwreck and even more
indirections.

Thanks,

	tglx

8<--------------
 a/arch/x86/include/asm/kvm_guest.h |    7 
 arch/x86/include/asm/kvm_para.h    |    1 
 arch/x86/kernel/kvm.c              |   14 -
 arch/x86/kernel/kvmclock.c         |  262 ++++++++++++++-----------------------
 arch/x86/kernel/setup.c            |    4 
 5 files changed, 105 insertions(+), 183 deletions(-)




