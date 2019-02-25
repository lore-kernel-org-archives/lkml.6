Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72672C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4096D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130067;
	bh=pw/6HB3LWCiWCpnXBGPkPH0TTNaXStr8IJNlifYb7VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBWQqPBTJCmUFgUjgf3Vcv3qvM+r3VWjUJnEaEHsBMZHB/X9j2eyzUtEXZh5Zzu9/
	 SofRxqxTtn20zZGzYIPrDe1aBBsFj6HvKG27Kt2MgGF5xCVbIwcEyfghJKe/ZaWzyR
	 EyRO26k9zbESytiCPG9ONTcS/kJyqhm8VvmFlKnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfBYV1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbfBYV1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F842146F;
        Mon, 25 Feb 2019 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130057;
        bh=pw/6HB3LWCiWCpnXBGPkPH0TTNaXStr8IJNlifYb7VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LARkDDph2KYLXaa39dKRnv9l4/ywghwQB5j7LOFzTiHuA+0HOafPkCO0R8xnbFKGf
         74/LNZ85OiJBRQO3WE2l1Lf0WxRT3qzk6P+34I651v0jWwhXkO1ls997LQppouJYgm
         5sAH8BxQ0znOH3drh0Mb0/RYMhJ+Bg3sB282ulkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 140/152] staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}
Date:   Mon, 25 Feb 2019 22:12:12 +0100
Message-Id: <20190225195053.762789519@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Gao Xiang <gaoxiang25@huawei.com>

commit 73f5c66df3e26ab750cefcb9a3e08c71c9f79cad upstream.

There are two minor issues in the current freeze interface:

   1) Freeze interfaces have not related with CONFIG_DEBUG_SPINLOCK,
      therefore fix the incorrect conditions;

   2) For SMP platforms, it should also disable preemption before
      doing atomic_cmpxchg in case that some high priority tasks
      preempt between atomic_cmpxchg and disable_preempt, then spin
      on the locked refcount later.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/internal.h |   41 +++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -184,40 +184,49 @@ struct erofs_workgroup {
 
 #define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
 
-static inline bool erofs_workgroup_try_to_freeze(
-	struct erofs_workgroup *grp, int v)
+#if defined(CONFIG_SMP)
+static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
+						 int val)
 {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	if (v != atomic_cmpxchg(&grp->refcount,
-		v, EROFS_LOCKED_MAGIC))
-		return false;
 	preempt_disable();
-#else
-	preempt_disable();
-	if (atomic_read(&grp->refcount) != v) {
+	if (val != atomic_cmpxchg(&grp->refcount, val, EROFS_LOCKED_MAGIC)) {
 		preempt_enable();
 		return false;
 	}
-#endif
 	return true;
 }
 
-static inline void erofs_workgroup_unfreeze(
-	struct erofs_workgroup *grp, int v)
+static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
+					    int orig_val)
 {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	atomic_set(&grp->refcount, v);
-#endif
+	atomic_set(&grp->refcount, orig_val);
 	preempt_enable();
 }
 
-#if defined(CONFIG_SMP)
 static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 {
 	return atomic_cond_read_relaxed(&grp->refcount,
 					VAL != EROFS_LOCKED_MAGIC);
 }
 #else
+static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
+						 int val)
+{
+	preempt_disable();
+	/* no need to spin on UP platforms, let's just disable preemption. */
+	if (val != atomic_read(&grp->refcount)) {
+		preempt_enable();
+		return false;
+	}
+	return true;
+}
+
+static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
+					    int orig_val)
+{
+	preempt_enable();
+}
+
 static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 {
 	int v = atomic_read(&grp->refcount);


