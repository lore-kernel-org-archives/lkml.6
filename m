Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A72147C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="cRlnlFv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073A72147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLCJcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:32:35 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7528 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLCJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829501; x=1575365501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7t5J8lrlETKkxVgTsRdDcC2rtp7CPVnOzSpgocymNQA=;
  b=cRlnlFv0TTNX37TrJhp48IcrI3ddAQSJI1VkHRUCZNMpXWUn5VbmqXCM
   hsdTDad+Q8UOj3jMhhydwBMYRsj0kd0wEIOSMqaNq2lQNfB2UoQ9uAK5/
   pRPTtmbAuM4FF8ENAG8UyS7jztdBB81I993ZkNzliREEttDbwFWHEYr9H
   A=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="370600012"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:40 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VZtG038735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:37 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VY1v018158;
        Mon, 3 Dec 2018 10:31:34 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VYNc018157;
        Mon, 3 Dec 2018 10:31:34 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 11/14] KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
Date:   Mon,  3 Dec 2018 10:31:04 +0100
Message-Id: <1543829467-18025-12-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map in synic_deliver_msg since using kvm_vcpu_gpa_to_page()
and kmap() will only work for guest memory that has a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Update to match the new API return codes
---
 arch/x86/kvm/hyperv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 63941ac..af6bd18 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -585,7 +585,7 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			     struct hv_message *src_msg)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
+	struct kvm_host_map map;
 	gpa_t gpa;
 	struct hv_message *dst_msg;
 	int r;
@@ -595,11 +595,11 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		return -ENOENT;
 
 	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
 		return -EFAULT;
 
-	msg_page = kmap_atomic(page);
+	msg_page = map.hva;
 	dst_msg = &msg_page->sint_message[sint];
 	if (sync_cmpxchg(&dst_msg->header.message_type, HVMSG_NONE,
 			 src_msg->header.message_type) != HVMSG_NONE) {
@@ -616,8 +616,8 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		else if (r == 0)
 			r = -EFAULT;
 	}
-	kunmap_atomic(msg_page);
-	kvm_release_page_dirty(page);
+
+	kvm_vcpu_unmap(&map);
 	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
 	return r;
 }
-- 
2.7.4

