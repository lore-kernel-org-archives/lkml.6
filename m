Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE425C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949A6223D1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSuzCQLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949A6223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeKLITt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388027AbeKLITs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A557223C6;
        Sun, 11 Nov 2018 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975392;
        bh=HjS1xuMBD3+pLAsAaZRyWdF/ikY3hxJreupwFtchjfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSuzCQLBsWDXhuQSR0xnMhtpbt8VoPJ7sixdlnT484zywGDBEXelmdZjCZZy3gSld
         9miujftDu85sk4Eb5A0+yRqwonmvsGHH/kdFMhdfRdeVcBe3WTgQcXJrL3Sw6eZjXE
         KrLaFiM8LHotiUa2540mUhGuqcr6Bk9+HajeiAzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 076/350] lightnvm: pblk: fix race condition on metadata I/O
Date:   Sun, 11 Nov 2018 14:19:00 -0800
Message-Id: <20181111221710.307559040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier González <javier@cnexlabs.com>

[ Upstream commit d8adaa3b86324c6186d0adf74bc256bdacfffdb6 ]

In pblk, when a new line is allocated, metadata for the previously
written line is scheduled. This is done through a fixed memory region
that is shared through time and contexts across different lines and
therefore protected by a lock. Unfortunately, this lock is not properly
covering all the metadata used for sharing this memory regions,
resulting in a race condition.

This patch fixes this race condition by protecting this metadata
properly.

Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/lightnvm/pblk-write.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -417,12 +417,11 @@ int pblk_submit_meta_io(struct pblk *pbl
 			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
 	}
 
+	spin_lock(&l_mg->close_lock);
 	emeta->mem += rq_len;
-	if (emeta->mem >= lm->emeta_len[0]) {
-		spin_lock(&l_mg->close_lock);
+	if (emeta->mem >= lm->emeta_len[0])
 		list_del(&meta_line->list);
-		spin_unlock(&l_mg->close_lock);
-	}
+	spin_unlock(&l_mg->close_lock);
 
 	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
@@ -491,14 +490,15 @@ static struct pblk_line *pblk_should_sub
 	struct pblk_line *meta_line;
 
 	spin_lock(&l_mg->close_lock);
-retry:
 	if (list_empty(&l_mg->emeta_list)) {
 		spin_unlock(&l_mg->close_lock);
 		return NULL;
 	}
 	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
-	if (meta_line->emeta->mem >= lm->emeta_len[0])
-		goto retry;
+	if (meta_line->emeta->mem >= lm->emeta_len[0]) {
+		spin_unlock(&l_mg->close_lock);
+		return NULL;
+	}
 	spin_unlock(&l_mg->close_lock);
 
 	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))


