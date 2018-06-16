Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01565C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EC1208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EC1208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756864AbeFPPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:44:33 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:55962 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754159AbeFPPoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:44:32 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8F65B40FC9;
        Sat, 16 Jun 2018 17:44:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id UWPQQc8WqTqG; Sat, 16 Jun 2018 17:44:28 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] freevxfs: Do not inline vxfs_put_page()
Date:   Sat, 16 Jun 2018 17:44:09 +0200
Message-Id: <20180616154409.26271-1-hauke@hauke-m.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vxfs_put_page() is not implemented in a header file, but in a normal c
file and used in multiple functions in different c files. Remove the
inline attribute as it does not make sense here and causes a link error
when LTO is activated.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 fs/freevxfs/vxfs_subr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index e806694d4145..8e213cce586f 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -46,7 +46,7 @@ const struct address_space_operations vxfs_aops = {
 	.bmap =			vxfs_bmap,
 };
 
-inline void
+void
 vxfs_put_page(struct page *pp)
 {
 	kunmap(pp);
-- 
2.11.0

