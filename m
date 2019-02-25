Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9EF20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130606;
	bh=Sv3PCBzc4h+qeUjUv8Ha4P6iNjBWC4IrVaYPK/gskfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4id9f83qjAIqb4BKgCkdUnvlk1fCQZ5KVngcZ3GR7VCeOfacYP/ui1hhZEMpQ+QM
	 51TYSp7JaJDXoYVgV/L1SdWtWKo9MPzdIep77zJ6AyJfKWvbrjBgzdyDtQsjwxbmAl
	 pnwjz4u3IowDroL6pL/N93nbcDz4gVF88oc12q+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbfBYVgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733212AbfBYVgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD48021850;
        Mon, 25 Feb 2019 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130599;
        bh=Sv3PCBzc4h+qeUjUv8Ha4P6iNjBWC4IrVaYPK/gskfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhhs2ctn5WqW+/KMFSytE8z5TxQamk3JLOomYbjzYvjU+eMoZukikn2UckHsMGzDw
         S2R7N3jPJFFM1QAypFDMm8NqxEU84d6UaDxPKYLxsP3+A94FfGK1Y/CdC9chG2SpCB
         mUM/jU3VRaLKSKixXwKhaoOxKrcJEMRQwPbAwWRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.20 171/183] staging: erofs: atomic_cond_read_relaxed on ref-locked workgroup
Date:   Mon, 25 Feb 2019 22:12:24 +0100
Message-Id: <20190225195123.961705410@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit df134b8d17b90c1e7720e318d36416b57424ff7a upstream.

It's better to use atomic_cond_read_relaxed, which is implemented
in hardware instructions to monitor a variable changes currently
for ARM64, instead of open-coded busy waiting.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/internal.h |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -221,23 +221,29 @@ static inline void erofs_workgroup_unfre
 	preempt_enable();
 }
 
+#if defined(CONFIG_SMP)
+static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
+{
+	return atomic_cond_read_relaxed(&grp->refcount,
+					VAL != EROFS_LOCKED_MAGIC);
+}
+#else
+static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
+{
+	int v = atomic_read(&grp->refcount);
+
+	/* workgroup is never freezed on uniprocessor systems */
+	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
+	return v;
+}
+#endif
+
 static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
 {
-	const int locked = (int)EROFS_LOCKED_MAGIC;
 	int o;
 
 repeat:
-	o = atomic_read(&grp->refcount);
-
-	/* spin if it is temporarily locked at the reclaim path */
-	if (unlikely(o == locked)) {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-		do
-			cpu_relax();
-		while (atomic_read(&grp->refcount) == locked);
-#endif
-		goto repeat;
-	}
+	o = erofs_wait_on_workgroup_freezed(grp);
 
 	if (unlikely(o <= 0))
 		return -1;


