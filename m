Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5581ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A262147A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3P+Kthz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A262147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeJYWwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbeJYWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:00 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E2720834;
        Thu, 25 Oct 2018 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477143;
        bh=r9FnCF9sHqjrsaxJ/g4EVS1Ym7RknKTb5922kl9Mg00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3P+Kthz+aidTd4Le490SJM79N7fDhgbDSKxDXJijvqKazWvAyYeWsGiM/96cKO+G
         sPH3zboUmmCCVro6zyFTrNMe6rh7K/gYGNkhDuGNK/PzYebS08uDYfRwfJRiugh4kf
         JSyNXAFDIgY3n7iLLUWc4ntWt3Ac13K7NviKpIMc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 03/98] s390/kvm: REPLACE barrier fixup with READ_ONCE
Date:   Thu, 25 Oct 2018 10:17:18 -0400
Message-Id: <20181025141853.214051-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 5de72a2247ac05bde7c89039631b3d0c6186fafb ]

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Commit 1365039d0cb3 ("KVM: s390: Fix ipte locking") replace
ACCESS_ONCE with barriers. Lets use READ_ONCE instead.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/gaccess.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6dc0ad9c7050..8f195fa904a1 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -229,12 +229,10 @@ static void ipte_lock_simple(struct kvm_vcpu *vcpu)
 		goto out;
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		while (old.k) {
 			cond_resched();
-			old = *ic;
-			barrier();
+			old = READ_ONCE(*ic);
 		}
 		new = old;
 		new.k = 1;
@@ -253,8 +251,7 @@ static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 		goto out;
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		new = old;
 		new.k = 0;
 	} while (cmpxchg(&ic->val, old.val, new.val) != old.val);
@@ -269,12 +266,10 @@ static void ipte_lock_siif(struct kvm_vcpu *vcpu)
 
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		while (old.kg) {
 			cond_resched();
-			old = *ic;
-			barrier();
+			old = READ_ONCE(*ic);
 		}
 		new = old;
 		new.k = 1;
@@ -288,8 +283,7 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 
 	ic = &vcpu->kvm->arch.sca->ipte_control;
 	do {
-		old = *ic;
-		barrier();
+		old = READ_ONCE(*ic);
 		new = old;
 		new.kh--;
 		if (!new.kh)
-- 
2.17.1

