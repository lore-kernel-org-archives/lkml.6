Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9DD2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeLXIjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:39:43 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:54448 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeLXIjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:39:42 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 67BB73A2477A3A97C7A2;
        Mon, 24 Dec 2018 16:39:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBO8dXe7061956;
        Mon, 24 Dec 2018 16:39:33 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122416393936-18426553 ;
          Mon, 24 Dec 2018 16:39:39 +0800 
From:   "huang.zijiang" <huang.zijiang@zte.com.cn>
To:     perex@perex.cz
Cc:     tiwai@suse.com, keescook@chromium.org, colin.king@canonical.com,
        w@1wt.eu, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, "huang.zijiang" <huang.zijiang@zte.com.cn>
Subject: [PATCH] sound:emu10k1:Use kmemdup instead of duplicating its function
Date:   Mon, 24 Dec 2018 16:42:48 +0800
Message-Id: <1545640968-42357-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-24 16:39:39,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-24 16:39:33,
        Serialize complete at 2018-12-24 16:39:33
X-MAIL: mse01.zte.com.cn wBO8dXe7061956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huang.zijiang" <huang.zijiang@zte.com.cn>

kmemdup has implemented the function that kmalloc() and memcpy().

Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>
---
 sound/pci/emu10k1/emufx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 6ebe817..b4fe4c5 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -671,10 +671,9 @@ static unsigned int *copy_tlv(const unsigned int __user *_tlv, bool in_kernel)
 		return NULL;
 	if (data[1] >= MAX_TLV_SIZE)
 		return NULL;
-	tlv = kmalloc(data[1] + sizeof(data), GFP_KERNEL);
+	tlv =  kmemdup(data, data[1] + sizeof(data), GFP_KERNEL);
 	if (!tlv)
 		return NULL;
-	memcpy(tlv, data, sizeof(data));
 	if (in_kernel) {
 		memcpy(tlv + 2, (__force void *)(_tlv + 2),  data[1]);
 	} else if (copy_from_user(tlv + 2, _tlv + 2, data[1])) {
-- 
1.8.3.1

