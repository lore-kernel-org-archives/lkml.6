Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950A2C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597CD20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108436;
	bh=Usn6+gWx9siWjGYgZUBUUBUv5gnmelCjthMbcaoS14k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l9MIvX2N+VAPZX5CDJZn9K2SaGNg1VUT+IvUQRGZdQPGZQ0zmDcUj2hXcnjFwFeAj
	 qLXqqzLtA3oNOuyG7mmQxx088g+0KpnUXv6xMAPMi27xs6+BDPVG/fhkeUXxjT0uF0
	 wTGx8EsbvkDWdNwxNnPJCW8eOok1/9rtgQw6DBs8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597CD20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLFPAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbeLFOkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9526720672;
        Thu,  6 Dec 2018 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107238;
        bh=Usn6+gWx9siWjGYgZUBUUBUv5gnmelCjthMbcaoS14k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cA5pMRuoPMfYMK15gHOjIbDtTe8nb9nVH/bGioBNK1l/xMoJKl4kr7SR34F+SUIE
         XXhG2q9ZfAvxybZapp6lbpBqCIPACTsKJQmJgU/7oCR9MD+Pw35Upz2xrqFsW1EuaI
         t+4Pntk3RycfGiwJKlSokTwsfWPqkzygRYcuGWaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Wang <wawei@amazon.de>,
        Amadeusz Juskowiak <ajusk@amazon.de>,
        Julian Stecklina <jsteckli@amazon.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 27/41] svm: Add mutex_lock to protect apic_access_page_done on AMD systems
Date:   Thu,  6 Dec 2018 15:39:07 +0100
Message-Id: <20181206142952.093345563@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <wawei@amazon.de>

commit 30510387a5e45bfcf8190e03ec7aa15b295828e2 upstream.

There is a race condition when accessing kvm->arch.apic_access_page_done.
Due to it, x86_set_memory_region will fail when creating the second vcpu
for a svm guest.

Add a mutex_lock to serialize the accesses to apic_access_page_done.
This lock is also used by vmx for the same purpose.

Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Amadeusz Juskowiak <ajusk@amazon.de>
Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1663,20 +1663,23 @@ static u64 *avic_get_physical_id_entry(s
 static int avic_init_access_page(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	int ret;
+	int ret = 0;
 
+	mutex_lock(&kvm->slots_lock);
 	if (kvm->arch.apic_access_page_done)
-		return 0;
+		goto out;
 
-	ret = x86_set_memory_region(kvm,
-				    APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-				    APIC_DEFAULT_PHYS_BASE,
-				    PAGE_SIZE);
+	ret = __x86_set_memory_region(kvm,
+				      APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
+				      APIC_DEFAULT_PHYS_BASE,
+				      PAGE_SIZE);
 	if (ret)
-		return ret;
+		goto out;
 
 	kvm->arch.apic_access_page_done = true;
-	return 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
 }
 
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)


