Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C026C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A8E208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A8E208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeGIRkR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:40:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933594AbeGIRkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1F9240122D4;
        Mon,  9 Jul 2018 17:40:15 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16F8A2156891;
        Mon,  9 Jul 2018 17:40:13 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/hyper-v: cope with VP_INVAL in PV TLB flush code
Date:   Mon,  9 Jul 2018 19:40:10 +0200
Message-Id: <20180709174012.17429-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 09 Jul 2018 17:40:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 09 Jul 2018 17:40:15 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI
 enlightenment") made it possible to observe VP_INVAL returned from 
hv_cpu_number_to_vp_number() and cpumask_to_vpset() and PV TLB flush
code needs to be adjusted.

The window when VP_INVAL is observable is very short, I'm not even sure
we do TLB flushes during this period (secodary CPUs bringup on boot, there
is no CPU hotplug on Hyper-V yet). This, however, may change in future so
let's fix this now.

Thomas, Ingo: these patches are for 'tip/x86/hyperv'. I don't think we have
a real issue in 4.18 but I can definitely prepare fixes for it if you think
this is needed.

Vitaly Kuznetsov (2):
  x86/hyper-v: check cpumask_to_vpset() return value in
    hyperv_flush_tlb_others_ex()
  x86/hyper-v: check for VP_INVAL in hyperv_flush_tlb_others()

 arch/x86/hyperv/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.14.4

