Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FBECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C803A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C803A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGSWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:52834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbeGSWkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:40:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B686ACD0;
        Thu, 19 Jul 2018 21:55:05 +0000 (UTC)
Date:   Thu, 19 Jul 2018 14:54:56 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] xen/spinlock: Don't use pvqspinlock if only 1 vCPU
Message-ID: <20180719215456.5ho3udhfoqlkh75a@linux-r8p5>
References: <1532036397-19449-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1532036397-19449-1-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Waiman Long wrote:

>On a VM with only 1 vCPU, the locking fast paths will always be
>successful. In this case, there is no need to use the the PV qspinlock
>code which has higher overhead on the unlock side than the native
>qspinlock code.
>
>The xen_pvspin veriable is also turned off in this 1 vCPU case to
>eliminate unneeded pvqspinlock initialization in xen_init_lock_cpu()
>which is run after xen_init_spinlocks().

Wouldn't kvm also want this?

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a37bda38d205..95aceb692010 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -457,7 +457,8 @@ static void __init sev_map_percpu_data(void)
 static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	native_smp_prepare_cpus(max_cpus);
-	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
+	if (num_possible_cpus() == 1 ||
+	    kvm_para_has_hint(KVM_HINTS_REALTIME))
 		static_branch_disable(&virt_spin_lock_key);
 }
