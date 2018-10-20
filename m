Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE92FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4A0215EC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JZqPfWLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4A0215EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeJUHNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 03:13:31 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:42041 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJUHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 03:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540076485; x=1571612485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FblQFH6Uuq+bJdWQpbVJQoaI0uvcY8iH03BW2m8+cpM=;
  b=JZqPfWLUp/lRAvjF/dpbivQC08akCVfg6jgwTLBgxwFsfxgcvm/MgR/v
   z+0pf4Y4QkZl4aNDqHZNUZvp0csnC2eyhAZXyGnYy59BMbE4ZaMqHRTwA
   GEX/mBuL6qnyFurdk+rr6p1EOb348J1JfBMTEu52r8Edyv1STWdRa96En
   g=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="364201545"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:50:44 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMocO7103074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:50:40 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMobwt021408;
        Sun, 21 Oct 2018 00:50:37 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMoZdA021405;
        Sun, 21 Oct 2018 00:50:35 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2] KVM/nVMX: Do not validate that posted_intr_desc_addr is page aligned
Date:   Sun, 21 Oct 2018 00:50:27 +0200
Message-Id: <1540075827-21270-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540071779-20848-1-git-send-email-karahmed@amazon.de>
References: <1540071779-20848-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec only requires the posted interrupt descriptor address to be
64-bytes aligned (i.e. bits[0:5] == 0). Using page_address_valid also
forces the address to be page aligned.

Only validate that the address does not cross the maximum physical address
without enforcing a page alignment.

v1 -> v2:
- Add a missing parenthesis (dropped while merging!)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 6de84e581c0 ("nVMX x86: check posted-interrupt descriptor addresss on vmentry of L2")
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 38f1a16..bb0fcdb 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11667,7 +11667,7 @@ static int nested_vmx_check_apicv_controls(struct kvm_vcpu *vcpu,
 	    !nested_exit_intr_ack_set(vcpu) ||
 	    (vmcs12->posted_intr_nv & 0xff00) ||
 	    (vmcs12->posted_intr_desc_addr & 0x3f) ||
-	    (!page_address_valid(vcpu, vmcs12->posted_intr_desc_addr))))
+	    (vmcs12->posted_intr_desc_addr >> cpuid_maxphyaddr(vcpu))))
 		return -EINVAL;
 
 	/* tpr shadow is needed by all apicv features. */
-- 
2.7.4

