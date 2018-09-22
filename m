Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F84C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4506520870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4506520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392376AbeIVGPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:15:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44155 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391739AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BZ-CL; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000ti-SJ; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wen Xu" <wen.xu@gatech.edu>,
        "=?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        "Viacheslav Dubeyko" <slava@dubeyko.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.241545612@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 50/63] hfsplus: fix NULL dereference in hfsplus_lookup()
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ernesto A. Fernández
 <ernesto.mnd.fernandez@gmail.com>

commit a7ec7a4193a2eb3b5341243fc0b621c1ac9e4ec4 upstream.

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
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reported-by: Wen Xu <wen.xu@gatech.edu>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/hfsplus/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -74,13 +74,13 @@ again:
 				cpu_to_be32(HFSP_HARDLINK_TYPE) &&
 				entry.file.user_info.fdCreator ==
 				cpu_to_be32(HFSP_HFSPLUS_CREATOR) &&
+				HFSPLUS_SB(sb)->hidden_dir &&
 				(entry.file.create_date ==
 					HFSPLUS_I(HFSPLUS_SB(sb)->hidden_dir)->
 						create_date ||
 				entry.file.create_date ==
 					HFSPLUS_I(sb->s_root->d_inode)->
-						create_date) &&
-				HFSPLUS_SB(sb)->hidden_dir) {
+						create_date)) {
 			struct qstr str;
 			char name[32];
 

