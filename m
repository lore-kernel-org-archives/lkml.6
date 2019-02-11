Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294F020700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896283;
	bh=y60sTBUmHMn+uHplmAuHA+nOtfMgyE/Xgr3wEZsEeR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWy0yjKUvG8HBBxdM5hBO9Q5xQxfKTjFHJ34BfboSZVHe8S60xN3dJS+nR/nsmmLu
	 oUui3RfuZd1cPhiXv0yo+Xvz65TuvQ+4ltYAEyx4/bxCEqzpBXvoMvnK+FiyaoT/JF
	 6QtZ6+sCMLPYD7OtXGnMVZBtl4rjc5MeL3CYkyKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfBKOol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732876AbfBKOoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33B1206BA;
        Mon, 11 Feb 2019 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896279;
        bh=y60sTBUmHMn+uHplmAuHA+nOtfMgyE/Xgr3wEZsEeR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ki+GOROVHHk8wSZ/y33wYOeAMSllCJCyv0MZ1cJWRcgFC/wy3Dw5MZcrpiT+zHHYh
         RfLH28yQQbj4GJ+xQg+650hBPTd4wc5PPUUF1JCad4qdDHeB8jzfJz6oakrhsLrBd3
         +qtK37onVBKPK/gCpWgyFHyHD0cRK7IE15G+WnA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hua Su <suhua.tanke@gmail.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 132/313] lightnvm: pblk: add lock protection to list operations
Date:   Mon, 11 Feb 2019 15:16:52 +0100
Message-Id: <20190211141902.525901417@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit fde201a466c6ad5efd72cb54fdf2cefa8b6c6ad7 ]

Protect the list_add on the pblk_line_init_bb() error
path in case this code is used for some other purpose
in the future.

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2940cdc87af1..95be6e36c7dd 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1252,15 +1252,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 	ret = pblk_line_alloc_bitmaps(pblk, line);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (!pblk_line_init_bb(pblk, line, 0)) {
-		list_add(&line->list, &l_mg->free_list);
-		return -EINTR;
+		ret = -EINTR;
+		goto fail;
 	}
 
 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
 	return 0;
+
+fail:
+	spin_lock(&l_mg->free_lock);
+	list_add(&line->list, &l_mg->free_list);
+	spin_unlock(&l_mg->free_lock);
+
+	return ret;
 }
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1



