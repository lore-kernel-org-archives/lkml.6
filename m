Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E03C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA621939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Nmqj0zwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfAaU1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:13 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:45295 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfAaU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966426; x=1580502426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sm3D4YjPET3zxvP/ZOrm+q2Z+xvHwFSMEM+CubEGa2g=;
  b=Nmqj0zwiOn6WXZTdcVN6CSVb1R8u15A7NfhwiL280ASmpBhBpNfjcE80
   Ey3MYZSE05zAjoiHlSYiVpvyfFqCyUBf2gLGTxjeZRcjIPh0ewUqVLhHo
   L5LGWBv9NPHvGl3rL/4reUzCGdk8hlYHekTC89FKBmxBBQaX6pRqPZq2W
   A=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="780024425"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 31 Jan 2019 20:27:05 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id F2E25C59E6;
        Thu, 31 Jan 2019 20:27:04 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR2s8028995;
        Thu, 31 Jan 2019 21:27:02 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR29h028994;
        Thu, 31 Jan 2019 21:27:02 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 09/14] KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
Date:   Thu, 31 Jan 2019 21:24:39 +0100
Message-Id: <1548966284-28642-10-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map in emulator_cmpxchg_emulated since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <kjonrad.wilk@oracle.com>
---
v5 -> v6:
- Remove explicit call to dirty the page. It is now done by kvm_vcpu_unmap

v4 -> v5:
- unmap with dirty flag

v1 -> v2:
- Update to match the new API return codes
---
 arch/x86/kvm/x86.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d27206..f6800e0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5494,9 +5494,9 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 				     unsigned int bytes,
 				     struct x86_exception *exception)
 {
+	struct kvm_host_map map;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	gpa_t gpa;
-	struct page *page;
 	char *kaddr;
 	bool exchanged;
 
@@ -5513,12 +5513,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
 		goto emul_write;
 
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
 		goto emul_write;
 
-	kaddr = kmap_atomic(page);
-	kaddr += offset_in_page(gpa);
+	kaddr = map.hva + offset_in_page(gpa);
+
 	switch (bytes) {
 	case 1:
 		exchanged = CMPXCHG_TYPE(u8, kaddr, old, new);
@@ -5535,13 +5534,12 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	default:
 		BUG();
 	}
-	kunmap_atomic(kaddr);
-	kvm_release_page_dirty(page);
+
+	kvm_vcpu_unmap(vcpu, &map, true);
 
 	if (!exchanged)
 		return X86EMUL_CMPXCHG_FAILED;
 
-	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
 	kvm_page_track_write(vcpu, gpa, new, bytes);
 
 	return X86EMUL_CONTINUE;
-- 
2.7.4

