Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5B4C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E35521841
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719261;
	bh=PJhpyfWwqUUiBoIPUNdXrgZtj1nrT/5e3ecmyKNH4z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBE4aQLEiCTAmzBnIKa7oPVVNa8xL+5vnrQinxlF29PN1IEgWj0FwUMPUaw0I8UiY
	 0eoAyXx3y2BsfU6wgfz3ZhfhWqz+du2bNb93WgWjdrQDEFWweTGwcJr9gSvOc1j183
	 /vJu0g6B7AarolIxXyz5kwkR8h8hpMv9KgPZWNhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfA1Xri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfA1Xrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:35 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99FD217F5;
        Mon, 28 Jan 2019 23:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719255;
        bh=PJhpyfWwqUUiBoIPUNdXrgZtj1nrT/5e3ecmyKNH4z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OY+VQsVBmRVJeTTXvlSRlmhRGDtoNLYDRAReN/Tg6jrNZbzZBaWol3iMEbT9TPobI
         RA4gRPzh9za+H5uUiGS5vxeEZAsKmVGBVX1kFzvQHBGsndKVnahSpmEZM7SJ9D7xZn
         AdrNknPltCUKgNwM+BuhH8gmgdFtlrbTzSCSk0Gk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/7] f2fs: flush quota blocks after turnning it off
Date:   Tue, 29 Jan 2019 07:47:16 +0800
Message-Id: <20190128234717.77225-6-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After quota_off, we'll get some dirty blocks. If put_super don't have a chance
to flush them by checkpoint, it causes NULL pointer exception in end_io after
iput(node_inode). (e.g., by checkpoint=disable)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5e1f8573a17f..7694cb350734 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2026,6 +2026,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 		}
 	}
+	/*
+	 * In case of checkpoint=disable, we must flush quota blocks.
+	 * This can cause NULL exception for node_inode in end_io, since
+	 * put_super already dropped it.
+	 */
+	sync_filesystem(sb);
 }
 
 static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
-- 
2.19.0.605.g01d371f741-goog

