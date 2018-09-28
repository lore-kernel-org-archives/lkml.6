Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC985C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C4F2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWlpM/rR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C4F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeI2ANt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeI2ANt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:13:49 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3AB206B7;
        Fri, 28 Sep 2018 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538156936;
        bh=9IVPwP5iELqqRzOfAGjGs3hO2oXtp+wPW+nfjgJecuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWlpM/rRzYrGU38E8ru/3k9hO9chotoXke3EshZ7M65j+I9eO4e16VHvZ1cLE55N0
         3Lq4qi5kzXtSBEvpFxQsQ+EW4wUnawuB43n4UqOYXFyEwsTuUXFKYFqoD1e+ptuKmA
         GTtZWI2PiU80vuuzAJdXIgFrz0jcIRH3F+LgK7G0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: keep lazytime on remount
Date:   Fri, 28 Sep 2018 10:48:54 -0700
Message-Id: <20180928174854.65978-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180928174854.65978-1-jaegeuk@kernel.org>
References: <20180928174854.65978-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes losing lazytime when remounting f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 603386525336..74056fa064ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1655,6 +1655,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	limit_reserve_root(sbi);
 	clear_sbi_flag(sbi, SBI_IS_MOUNT);
+	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
-- 
2.19.0.605.g01d371f741-goog

