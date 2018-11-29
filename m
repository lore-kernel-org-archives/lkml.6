Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FCA20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y9u6lvqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FCA20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeK2M4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbeK2M4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:56:38 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3612B206B6;
        Thu, 29 Nov 2018 01:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543456379;
        bh=/MnhzpHjDQy2pJldxemyVOun48bZLsUU1nFqgNISfy4=;
        h=From:To:Cc:Subject:Date:From;
        b=y9u6lvqx/RyaJuKNnUXKDYsqWqCX0qFW0qXhRi2NMX2DJQ6+QpfSZe3oaEZkusLtB
         2XtVhMK/7GO6DSaHz88J6n6bifiMXilb3Aa2e65Ah6r1MUu+YKwhLRZpxwhBjhA2pU
         ha53meie//70rrHWnrOXFXnupqmdWVhk6u4UuPyo=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add an ioctl() to explicitly trigger fsck later
Date:   Wed, 28 Nov 2018 17:52:57 -0800
Message-Id: <20181129015257.95036-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
setting a NEED_FSCK flag.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/file.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aa500239baf2..7cec897146a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -417,6 +417,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
 #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
 #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
+#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ff82350a2c55..ca9bdbb8651b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1966,6 +1966,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		f2fs_stop_checkpoint(sbi, false);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
+	case F2FS_GOING_DOWN_NEED_FSCK:
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		/* do checkpoint only */
+		ret = f2fs_sync_fs(sb, 1);
+		if (ret)
+			goto out;
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
2.19.0.605.g01d371f741-goog

