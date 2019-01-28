Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE28217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719249;
	bh=zUuOtI+Del2uu5VYzfUqOE11gveyD1HlqXa37CIY8TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YpJIji8aTx8l6Nw0WWi70exFihSk5HNETqPh9l1VDq0sHPjMPjyZYEJ3Lflck+LLI
	 qEOB3F0RZCq9YRQj7k+XxOUKoA7xwLxWFEJR4wIOMbGd7D/1IbhvyQ3cNNI7RfUfFi
	 kJFvWYNrGdm4cVXkdL3FYVX9+6qECMnmDgAexPhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfA1Xr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfA1Xr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:26 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6E821783;
        Mon, 28 Jan 2019 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719246;
        bh=zUuOtI+Del2uu5VYzfUqOE11gveyD1HlqXa37CIY8TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3MrECaocuO/hv5//cfavrkC6LAYHqB3Rj36E2B+Zn8wlOwOyLrCNSt9sNcwlWIPC
         67RiugTENIYNPpw/bYoTfJ5UzAnTiuMaYFaFIYVXLCzTod6z8lvU3Zh+gk3YCs80G0
         f/c7cPoOTImsTB667lxmRkDGbEXNL2d7A9PLvJXI=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] f2fs: try to keep CP_TRIMMED_FLAG after successful umount
Date:   Tue, 29 Jan 2019 07:47:13 +0800
Message-Id: <20190128234717.77225-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If every discard were issued successfully, we can avoid further discard.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 342b720fb4db..fdd8cd21522f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1063,6 +1063,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	} else if (discard_type == DPOLICY_UMOUNT) {
 		dpolicy->max_requests = UINT_MAX;
 		dpolicy->io_aware = false;
+		/* we need to issue all to keep CP_TRIMMED_FLAG */
+		dpolicy->granularity = 1;
 	}
 }
 
-- 
2.19.0.605.g01d371f741-goog

