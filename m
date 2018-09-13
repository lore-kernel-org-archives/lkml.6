Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAD_ENC_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F3C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755CD20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755CD20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeIMSpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:45:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:45:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31D3ACF3;
        Thu, 13 Sep 2018 13:35:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>, Wen Xu <wen.xu@gatech.edu>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 22/78] hfsplus: fix NULL dereference in hfsplus_lookup()
Date:   Thu, 13 Sep 2018 15:31:09 +0200
Message-Id: <20180913131807.212479490@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ernesto A. Fern·ndez" <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit a7ec7a4193a2eb3b5341243fc0b621c1ac9e4ec4 ]

An HFS+ filesystem can be mounted read-only without having a metadata
directory, which is needed to support hardlinks.  But if the catalog
data is corrupted, a directory lookup may still find dentries claiming
to be hardlinks.

hfsplus_lookup() does check that ->hidden_dir is not NULL in such a
situation, but mistakenly does so after dereferencing it for the first
time.  Reorder this check to prevent a crash.

This happens when looking up corrupted catalog data (dentry) on a
filesystem with no metadata directory (this could only ever happen on a
read-only mount).  Wen Xu sent the replication steps in detail to the
fsdevel list: https://bugzilla.kernel.org/show_bug.cgi?id=200297

Link: http://lkml.kernel.org/r/20180712215344.q44dyrhymm4ajkao@eaf
Signed-off-by: Ernesto A. Fern√°ndez <ernesto.mnd.fernandez@gmail.com>
Reported-by: Wen Xu <wen.xu@gatech.edu>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hfsplus/dir.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -77,13 +77,13 @@ again:
 				cpu_to_be32(HFSP_HARDLINK_TYPE) &&
 				entry.file.user_info.fdCreator ==
 				cpu_to_be32(HFSP_HFSPLUS_CREATOR) &&
+				HFSPLUS_SB(sb)->hidden_dir &&
 				(entry.file.create_date ==
 					HFSPLUS_I(HFSPLUS_SB(sb)->hidden_dir)->
 						create_date ||
 				entry.file.create_date ==
 					HFSPLUS_I(d_inode(sb->s_root))->
-						create_date) &&
-				HFSPLUS_SB(sb)->hidden_dir) {
+						create_date)) {
 			struct qstr str;
 			char name[32];
 


