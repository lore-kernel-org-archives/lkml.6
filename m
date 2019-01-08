Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A100C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB83206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfAHTvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:51:53 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.164]:29609 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731059AbfAHTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:22 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 4F9C515F2FFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 13:19:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gwu4gixlsiQergwu4gkYha; Tue, 08 Jan 2019 13:19:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=56300 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ggwu3-003Vbx-A1; Tue, 08 Jan 2019 13:19:07 -0600
Date:   Tue, 8 Jan 2019 13:19:03 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ocfs2: Use zero-sized array and struct_size() in kzalloc()
Message-ID: <20190108191903.GA22056@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ggwu3-003Vbx-A1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:56300
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the code to use a zero-sized array instead of a pointer in
structure ocfs2_slot_info and use struct_size() in kzalloc().

Notice that one of the more common cases of allocation size calculations is
finding the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/ocfs2/slot_map.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index d7407994f308..ea0756d83250 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -55,7 +55,7 @@ struct ocfs2_slot_info {
 	unsigned int si_blocks;
 	struct buffer_head **si_bh;
 	unsigned int si_num_slots;
-	struct ocfs2_slot *si_slots;
+	struct ocfs2_slot si_slots[];
 };
 
 
@@ -420,9 +420,7 @@ int ocfs2_init_slot_info(struct ocfs2_super *osb)
 	struct inode *inode = NULL;
 	struct ocfs2_slot_info *si;
 
-	si = kzalloc(sizeof(struct ocfs2_slot_info) +
-		     (sizeof(struct ocfs2_slot) * osb->max_slots),
-		     GFP_KERNEL);
+	si = kzalloc(struct_size(si, si_slots, osb->max_slots), GFP_KERNEL);
 	if (!si) {
 		status = -ENOMEM;
 		mlog_errno(status);
@@ -431,8 +429,6 @@ int ocfs2_init_slot_info(struct ocfs2_super *osb)
 
 	si->si_extended = ocfs2_uses_extended_slot_map(osb);
 	si->si_num_slots = osb->max_slots;
-	si->si_slots = (struct ocfs2_slot *)((char *)si +
-					     sizeof(struct ocfs2_slot_info));
 
 	inode = ocfs2_get_system_file_inode(osb, SLOT_MAP_SYSTEM_INODE,
 					    OCFS2_INVALID_SLOT);
-- 
2.20.1

