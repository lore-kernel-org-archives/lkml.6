Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3EAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682E2222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895011;
	bh=b1IP5Ot1yceWBUc1lu2PwEGWl8UgeOe2aY3Rb1ZYoVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfotNET6KA4U64zE+/9siCiTpDWrdGs/hlqQNMkgAhZXAI7uJCpvUM4gqt/v13m46
	 73lLG2/ngpZLBXdVhgJljyrlsMocEqgEBAYAPe1p8Ll5cK7blte00kCvlVp8GuQqbR
	 O42EHGI+n7cuDRuMZwESz5F6uTeLB3bsww3pPK/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfBKOXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbfBKOX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59D720844;
        Mon, 11 Feb 2019 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895005;
        bh=b1IP5Ot1yceWBUc1lu2PwEGWl8UgeOe2aY3Rb1ZYoVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktBJcyYQXQxsyhN46Zb7+kArNYRRSg9O+Z+f47+3FXjNecw0MxEBOj3Cbiqsq3rzn
         DE9DHHD+50qyO4YcQdz7P6DfI6DqM1XkImSSJ6zKO21oYlt2/E7QTuSDX5wKju4np0
         JXGJ/Zvl8dMn09hyD9mhIVzIwEW6m5vmiwubN71M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 060/352] staging: erofs: fix the definition of DBG_BUGON
Date:   Mon, 11 Feb 2019 15:14:47 +0100
Message-Id: <20190211141849.951127858@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit eef168789866514e5d4316f030131c9fe65b643f ]

It's better not to positively BUG_ON the kernel, however developers
need a way to locate issues as soon as possible.

DBG_BUGON is introduced and it could only crash when EROFS_FS_DEBUG
(EROFS developping feature) is on. It is helpful for developers
to find and solve bugs quickly by eng builds.

Previously, DBG_BUGON is defined as ((void)0) if EROFS_FS_DEBUG is off,
but some unused variable warnings as follows could occur:

drivers/staging/erofs/unzip_vle.c: In function `init_alway:':
drivers/staging/erofs/unzip_vle.c:61:33: warning: unused variable `work' [-Wunused-variable]
  struct z_erofs_vle_work *const work =
                                 ^~~~

Fix it to #define DBG_BUGON(x) ((void)(x)).

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 57575c7f5635..048fb034b5aa 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -39,7 +39,7 @@
 #define debugln(x, ...)         ((void)0)
 
 #define dbg_might_sleep()       ((void)0)
-#define DBG_BUGON(...)          ((void)0)
+#define DBG_BUGON(x)            ((void)(x))
 #endif
 
 enum {
-- 
2.19.1



