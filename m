Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF7521773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897148;
	bh=hsFEGzcJS1SFrsJt9O8/bw3i0ZuHEEdLeGmnkcS6R10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nngvJqwYYOz3WKYIowY9jxwmoyhPfmC0sbcABf8EfuHYbLOQo9ONTeTlhg2lWLiIb
	 nSzYATjlS4ethv9/Pv+lun+lLpD2l5PiA9Ybuuy+Tcp+vTGR9xnGd7JheN1HcCqtjf
	 ooHwvWUJlTqswhWAFg3M1WaDQ3ku1eNzzWNiiFv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfBKO7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389707AbfBKO7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:59:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78910206BA;
        Mon, 11 Feb 2019 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897141;
        bh=hsFEGzcJS1SFrsJt9O8/bw3i0ZuHEEdLeGmnkcS6R10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywZs5ZX90yOlO2px2unj8cQAU1h+zfReAF2jUBdoZrGJrI0rnOyT06/AM8TrsTYXv
         jHiDrP1x0pkW0E1ypuODCwLTzfnU4MAN5WkVh3WexIu6pivxI1dDD18qNoKOdSMFVw
         Qr7x041b6JNGfLn+tyOXLxUoIbycs5YKX3Tnu2OQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 104/205] KVM: s390: unregister debug feature on failing arch init
Date:   Mon, 11 Feb 2019 15:18:22 +0100
Message-Id: <20190211141835.369942513@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



