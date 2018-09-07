Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B76C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E32A20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1gwW2sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E32A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeIHCK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbeIHCKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:10:55 -0400
Received: from localhost (unknown [104.132.0.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D9A20645;
        Fri,  7 Sep 2018 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536355685;
        bh=tDE8oyB0XWByL00ozveYtwY+evClbELEl6+NyvTZ4xs=;
        h=From:To:Cc:Subject:Date:From;
        b=n1gwW2sfGhYpMdXzb5Slg1rr8dNKFPjwTZ5T5KWtTeFbVJ8eb4Mm/2s69DOsRbdR0
         WLryqdHMYD682qaftXj53EW876PlfxSckAee0IrhRQZUstoofebRoAM//FTsO2nuQY
         C4cLDxEF+J29vPJMHD0mJ7uJh1xLFp3UOmKm0btc=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: submit bio after shutdown
Date:   Fri,  7 Sep 2018 14:28:04 -0700
Message-Id: <20180907212804.91462-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, some merged IOs could get a chance to be submitted, resulting in
system hang in shutdown test. This issues IOs all the time after shutdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c204f896c22..26f38b224bb2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -533,6 +533,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (fio->in_list)
 		goto next;
 out:
+	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
+		__submit_merged_bio(io);
 	up_write(&io->io_rwsem);
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

