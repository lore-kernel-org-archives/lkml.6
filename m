Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9583FC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684C720879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692210;
	bh=LMYmDl+lZ/uY30dcLNpDMw5evOV2YYkYj+Tyolw2l8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4T7ZMFzjQJDAe2fkUh7uta1iHbpB2zVya9LB7WdLw4vM4Wv7jinCCG+RWAOTNCsC
	 Mgo0KZI4rz8gi2QFji4snHk8B3h7Rwbztlcya/IMBfSqI4crTEMCylDzOHRdx579dc
	 prXZllIsIwq33t+IULiyoopOshVAPbcGhpvB4qCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfA1QQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732685AbfA1QQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B90A21741;
        Mon, 28 Jan 2019 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692205;
        bh=LMYmDl+lZ/uY30dcLNpDMw5evOV2YYkYj+Tyolw2l8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdTOWOnPHEHq1kC+XRauBSU9x4R4tnmoI8lCaLEPd/NhW0UOWXUPXTTO0CPsVnkqu
         iEVsBgDjmnJFdbhPIt586Hh33IYslGGrr6tojHHu0KLRxqmXqZuWN3lBfKzvIGjXLO
         bvoRIBvLXCYQSq4pqoifQ230XHT4e2JTCXr9UZc8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 109/170] KVM: s390: unregister debug feature on failing arch init
Date:   Mon, 28 Jan 2019 11:10:59 -0500
Message-Id: <20190128161200.55107-109-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Mueller <mimu@linux.ibm.com>

[ Upstream commit 308c3e6673b012beecb96ef04cc65f4a0e7cdd99 ]

Make sure the debug feature and its allocated resources get
released upon unsuccessful architecture initialization.

A related indication of the issue will be reported as kernel
message.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181130143215.69496-2-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/kvm-s390.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4f6adbea592b..f674a81c8868 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -361,19 +361,30 @@ static void kvm_s390_cpu_feat_init(void)
 
 int kvm_arch_init(void *opaque)
 {
+	int rc;
+
 	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
 	if (!kvm_s390_dbf)
 		return -ENOMEM;
 
 	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view)) {
-		debug_unregister(kvm_s390_dbf);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out_debug_unreg;
 	}
 
 	kvm_s390_cpu_feat_init();
 
 	/* Register floating interrupt controller interface. */
-	return kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
+	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
+	if (rc) {
+		pr_err("Failed to register FLIC rc=%d\n", rc);
+		goto out_debug_unreg;
+	}
+	return 0;
+
+out_debug_unreg:
+	debug_unregister(kvm_s390_dbf);
+	return rc;
 }
 
 void kvm_arch_exit(void)
-- 
2.19.1

