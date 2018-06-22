Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D46C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE9B24665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE9B24665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeFVRGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:06:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751370AbeFVRG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89DE04023336;
        Fri, 22 Jun 2018 17:06:28 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AADD61C59E;
        Fri, 22 Jun 2018 17:06:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 0/4] x86/hyper-v: optimize PV IPIs
Date:   Fri, 22 Jun 2018 19:06:21 +0200
Message-Id: <20180622170625.30688-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 17:06:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 22 Jun 2018 17:06:28 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing my "x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_
{LIST,SPACE} hypercalls when possible" patch Michael suggested to apply the
same idea to PV IPIs. Here we go!

Despite what Hyper-V TLFS says about HVCALL_SEND_IPI hypercall, it can
actually be 'fast' (passing parameters through registers). Use that too.

This series can collide with my "KVM: x86: hyperv: PV IPI support for
Windows guests" series as I rename ipi_arg_non_ex/ipi_arg_ex structures
there. Depending on which one gets in first we may need to do tiny
adjustments.

Vitaly Kuznetsov (4):
  x86/hyper-v: implement hv_do_fast_hypercall16
  x86/hyper-v: use 'fast' hypercall for HVCALL_SEND_IPI
  x86/hyper-v: use cheaper HVCALL_SEND_IPI hypercall when possible
  x86/hyper-v: trace PV IPI send

 arch/x86/hyperv/hv_apic.c           | 57 ++++++++++++++++++++-----------------
 arch/x86/include/asm/mshyperv.h     | 34 ++++++++++++++++++++++
 arch/x86/include/asm/trace/hyperv.h | 15 ++++++++++
 3 files changed, 80 insertions(+), 26 deletions(-)

-- 
2.14.4

