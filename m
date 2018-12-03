Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF20C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5C214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LF/v749K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A5C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLCJcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:32:24 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40548 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeLCJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829502; x=1575365502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dYd8iKflNj2WhuUbU5vTCUyK22g6jzcrkVeJCUDw5WQ=;
  b=LF/v749Ken5HWHP0JKlBP4+wo3/jMblvQbF6vixjzyviay5rqZBS+ayM
   pBXS3yt709oeu/jXa1E3DGBqsHxWtomN+CmxYR/ZRiAIL3anNfcZv6n+M
   erm6jFpbPqbHXZnvdYVdLpYXVPHxbU+jfouavY4IncDYNwvHq6WfYDpmo
   U=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="748228493"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:41 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VY51077442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:36 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VXc9018154;
        Mon, 3 Dec 2018 10:31:33 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VXLp018153;
        Mon, 3 Dec 2018 10:31:33 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 10/14] KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
Date:   Mon,  3 Dec 2018 10:31:03 +0100
Message-Id: <1543829467-18025-11-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map in synic_clear_sint_msg_pending since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Update to match the new API return codes
---
 arch/x86/kvm/hyperv.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4e80080..63941ac 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -162,26 +162,22 @@ static void synic_clear_sint_msg_pending(struct kvm_vcpu_hv_synic *synic,
 					u32 sint)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
-	gpa_t gpa;
+	struct kvm_host_map map;
 	struct hv_message *msg;
 	struct hv_message_page *msg_page;
 
-	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page)) {
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(synic->msg_page), &map)) {
 		vcpu_err(vcpu, "Hyper-V SynIC can't get msg page, gpa 0x%llx\n",
-			 gpa);
+			 synic->msg_page);
 		return;
 	}
-	msg_page = kmap_atomic(page);
 
+	msg_page = map.hva;
 	msg = &msg_page->sint_message[sint];
 	msg->header.message_flags.msg_pending = 0;
 
-	kunmap_atomic(msg_page);
-	kvm_release_page_dirty(page);
-	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
+	kvm_vcpu_unmap(&map);
+	kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(synic->msg_page));
 }
 
 static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
-- 
2.7.4

