Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD0C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76713208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76713208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:48:59 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:57788 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeJPIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:48:59 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0680BFAA7DCECC8A02C0;
        Tue, 16 Oct 2018 09:01:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9G10vg6028307;
        Tue, 16 Oct 2018 09:00:57 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101609010813-4702131 ;
          Tue, 16 Oct 2018 09:01:08 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        x86@kernel.org, hpa@zytor.com, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH v2]  kvm:x86 :remove unnecessary recalculate_apic_map
Date:   Tue, 16 Oct 2018 17:12:30 +0800
Message-Id: <1539681150-9374-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-16 09:01:08,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-16 09:00:53,
        Serialize complete at 2018-10-16 09:00:53
X-MAIL: mse01.zte.com.cn w9G10vg6028307
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous code, the variable sw_apic_disabled influences
recalculate_apic_map. But in "KVM: x86: simplify kvm_apic_map"
(commit:3b5a5ffa928a3f875b0d5dd284eeb7c322e1688a),
the access to sw_apic_disabled in recalculate_apic_map has been
deleted.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kvm/lapic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 70dcb55..0380e37 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -246,10 +246,9 @@ static inline void apic_set_spiv(struct kvm_lapic *apic, u32 val)
 
 	if (enabled != apic->sw_enabled) {
 		apic->sw_enabled = enabled;
-		if (enabled) {
+		if (enabled)
 			static_key_slow_dec_deferred(&apic_sw_disabled);
-			recalculate_apic_map(apic->vcpu->kvm);
-		} else
+		else
 			static_key_slow_inc(&apic_sw_disabled.key);
 	}
 }
-- 
1.8.3.1

