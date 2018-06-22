Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28D24431
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E28D24431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFVO4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:56:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751806AbeFVO4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41E3244D01;
        Fri, 22 Jun 2018 14:56:19 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AF5311166E1;
        Fri, 22 Jun 2018 14:56:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: x86: hyperv: PV IPI support for Windows guests
Date:   Fri, 22 Jun 2018 16:56:13 +0200
Message-Id: <20180622145616.5851-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 14:56:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 14:56:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using hypercall for sending IPIs is faster because this allows to specify
any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
will take only one VMEXIT.

Same as PV TLB flush, this allows Windows guests having > 64 vCPUs to boot
on KVM when Hyper-V extensions are enabled.

Vitaly Kuznetsov (3):
  KVM: fix KVM_CAP_HYPERV_TLBFLUSH paragraph number
  x86/hyper-v: rename ipi_arg_{ex,non_ex} structures
  KVM: x86: hyperv: implement PV IPI send hypercalls

 Documentation/virtual/kvm/api.txt  |  10 +++-
 arch/x86/hyperv/hv_apic.c          |  12 ++--
 arch/x86/include/asm/hyperv-tlfs.h |  16 ++---
 arch/x86/kvm/hyperv.c              | 116 +++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/trace.h               |  42 ++++++++++++++
 arch/x86/kvm/x86.c                 |   1 +
 include/uapi/linux/kvm.h           |   1 +
 7 files changed, 184 insertions(+), 14 deletions(-)

-- 
2.14.4

