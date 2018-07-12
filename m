Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E408C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA512147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA512147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeGLLL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:26 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58388 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeGLLLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 1821518188FB8;
        Thu, 12 Jul 2018 13:02:21 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] ubifs: Set default assert action to read-only
Date:   Thu, 12 Jul 2018 13:02:00 +0200
Message-Id: <20180712110200.13054-6-richard@nod.at>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110200.13054-1-richard@nod.at>
References: <20180712110200.13054-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally UBIFS just reported a failed assertion and moved on. The
drawback is that users will notice UBIFS bugs when it is too late, most
of the time when it is no longer about to mount. This makes bug hunting
problematic since valuable information from failing asserts is long gone
when UBIFS is dead. The other extreme, panic'ing on a failing assert is
also not worthwhile, we want users and developers give a chance to
collect as much debugging information as possible if UBIFS hits an
assert. Therefore go for the third option, switch to read-only mode when
an assert fails. That way UBIFS will not write possible bad data to the
MTD and gives users the chance to collect debugging information.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 524122da7868..4b9890e54a78 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2027,6 +2027,7 @@ static struct ubifs_info *alloc_ubifs_info(struct ubi_volume_desc *ubi)
 		INIT_LIST_HEAD(&c->orph_list);
 		INIT_LIST_HEAD(&c->orph_new);
 		c->no_chk_data_crc = 1;
+		c->assert_action = ASSACT_RO;
 
 		c->highest_inum = UBIFS_FIRST_INO;
 		c->lhead_lnum = c->ltail_lnum = UBIFS_LOG_LNUM;
-- 
2.18.0

