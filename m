Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11994C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B0621477
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B0621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJMWfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:35:54 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:58390 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbeJMWfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:35:53 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 47F495B7C20281D83FAE;
        Sat, 13 Oct 2018 22:58:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9DEwIGb096843;
        Sat, 13 Oct 2018 22:58:18 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101322590136-4289338 ;
          Sat, 13 Oct 2018 22:59:01 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, stefanha@gmail.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 2/3]  kvm/x86 : add document for coalesced mmio
Date:   Sun, 14 Oct 2018 07:09:56 +0800
Message-Id: <1539472197-111085-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539472197-111085-1-git-send-email-peng.hao2@zte.com.cn>
References: <1539472197-111085-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-13 22:59:01,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-13 22:57:58,
        Serialize complete at 2018-10-13 22:57:58
X-MAIL: mse01.zte.com.cn w9DEwIGb096843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 Documentation/virtual/kvm/api.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 647f941..9615b9e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3676,6 +3676,30 @@ Returns: 0 on success, -1 on error
 This copies the vcpu's kvm_nested_state struct from userspace to the kernel.  For
 the definition of struct kvm_nested_state, see KVM_GET_NESTED_STATE.
 
+4.116 KVM_(UN)REGISTER_COALESCED_MMIO
+
+Capability: KVM_CAP_COALESCED_MMIO
+Architectures: all
+Type: vm ioctl
+Parameters: struct kvm_coalesced_mmio_zone
+Returns: 0 on success, < 0 on error
+
+Coalesced mmio is a performance optimization that defers hardware
+register write emulation so that userspace exits are avoided.  It is
+typically used to reduce the overhead of emulating frequently accessed
+hardware registers.
+
+When a hardware register is configured for coalesced mmio, write accesses
+do not exit to userspace and their value is recorded in a shared coalesced
+ring in the kernel.
+
+Coalesced mmio is applied to the following scenario typically.
+If a write access to a hardware register can be deferred, following a
+read/write access to another hardware register on the same device
+will cause the shared coalesced ring to be processed by userspace
+before emulating the current access. That will reduce the first write
+access to userspace.
+
 5. The kvm_run structure
 ------------------------
 
-- 
1.8.3.1

