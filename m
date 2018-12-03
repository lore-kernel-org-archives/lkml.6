Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78949C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4130D214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Bb8o4+Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130D214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeLCJbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:31:55 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39201 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeLCJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829500; x=1575365500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+b/SC1cPIcU2rnav/CFnxWZdHXsiJeKBHMDLYEisG9k=;
  b=Bb8o4+RpkjnDug1OkCqvRneKdqr4NPfkKv8akNb5ECe3bD9pC6RpMCuv
   PBmIduPHxE87wqFDSdsGNuiQGiniOtnpuahqVc9/fI8NDlnIsu4392d3y
   0Kiq7Xht5FRlFOj1xExB01X9x1SQYLV7FeXc00Ny7Tqcdz0WbBGbtdSN1
   U=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="706995550"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:38 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VXuG015206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:35 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VW2N018150;
        Mon, 3 Dec 2018 10:31:32 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VW1s018149;
        Mon, 3 Dec 2018 10:31:32 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 09/14] KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
Date:   Mon,  3 Dec 2018 10:31:02 +0100
Message-Id: <1543829467-18025-10-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map in emulator_cmpxchg_emulated since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Update to match the new API return codes
---
 arch/x86/kvm/x86.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d029377..81d75af 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5417,9 +5417,9 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 				     unsigned int bytes,
 				     struct x86_exception *exception)
 {
+	struct kvm_host_map map;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	gpa_t gpa;
-	struct page *page;
 	char *kaddr;
 	bool exchanged;
 
@@ -5436,12 +5436,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
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
@@ -5458,8 +5457,8 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	default:
 		BUG();
 	}
-	kunmap_atomic(kaddr);
-	kvm_release_page_dirty(page);
+
+	kvm_vcpu_unmap(&map);
 
 	if (!exchanged)
 		return X86EMUL_CMPXCHG_FAILED;
-- 
2.7.4

