Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4395CECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D2720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D2720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeGSBEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:04:31 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:49460 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727009AbeGSBEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:04:30 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 19 Jul 2018 09:24:04 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.225.35)
        by 156.147.1.121 with ESMTP; 19 Jul 2018 09:24:04 +0900
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From:   Hyunchul Lee <hyc.lee@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Hyunchul Lee <cheol.lee@lge.com>
Subject: [PATCH] f2fs: avoid duplicated permission check for "trusted." xattrs
Date:   Thu, 19 Jul 2018 09:23:57 +0900
Message-Id: <20180719002357.9882-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <cheol.lee@lge.com>

Because xattr_permission already checks CAP_SYS_ADMIN
capability, we don't need to check it.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 fs/f2fs/xattr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 708271871f94..4b34244dcc69 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -37,9 +37,6 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case F2FS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		break;
 	case F2FS_XATTR_INDEX_SECURITY:
 		break;
 	default:
@@ -62,9 +59,6 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case F2FS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		break;
 	case F2FS_XATTR_INDEX_SECURITY:
 		break;
 	default:
-- 
2.17.1

