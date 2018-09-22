Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BDBECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448612157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448612157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392271AbeIVGMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:12:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44323 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392092AbeIVGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Ve1-0008BT-2I; Sat, 22 Sep 2018 01:19:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rA-ME; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dave Kleikamp" <dave.kleikamp@oracle.com>,
        "Shankara Pailoor" <shankarapailoor@gmail.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.305835109@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 19/63] jfs: Fix inconsistency between memory
 allocation and ea_buf->max_size
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

From: Shankara Pailoor <shankarapailoor@gmail.com>

commit 92d34134193e5b129dc24f8d79cb9196626e8d7a upstream.

The code is assuming the buffer is max_size length, but we weren't
allocating enough space for it.

Signed-off-by: Shankara Pailoor <shankarapailoor@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/jfs/xattr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -493,15 +493,17 @@ static int ea_get(struct inode *inode, s
 	if (size > PSIZE) {
 		/*
 		 * To keep the rest of the code simple.  Allocate a
-		 * contiguous buffer to work with
+		 * contiguous buffer to work with. Make the buffer large
+		 * enough to make use of the whole extent.
 		 */
-		ea_buf->xattr = kmalloc(size, GFP_KERNEL);
+		ea_buf->max_size = (size + sb->s_blocksize - 1) &
+		    ~(sb->s_blocksize - 1);
+
+		ea_buf->xattr = kmalloc(ea_buf->max_size, GFP_KERNEL);
 		if (ea_buf->xattr == NULL)
 			return -ENOMEM;
 
 		ea_buf->flag = EA_MALLOC;
-		ea_buf->max_size = (size + sb->s_blocksize - 1) &
-		    ~(sb->s_blocksize - 1);
 
 		if (ea_size == 0)
 			return 0;

