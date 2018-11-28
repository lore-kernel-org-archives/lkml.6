Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E710CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D13F2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D13F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeK1S0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:26:30 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:35128 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbeK1S0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:26:30 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EC2D8CA31E0A67F0E80E;
        Wed, 28 Nov 2018 15:25:37 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAS7P3fv006036;
        Wed, 28 Nov 2018 15:25:03 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112815252505-13460545 ;
          Wed, 28 Nov 2018 15:25:25 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     ccaulfie@redhat.com, teigland@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] dlm: NULL check before kmem_cache_destroy is not needed
Date:   Wed, 28 Nov 2018 15:25:00 +0800
Message-Id: <20181128072500.61269-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-28 15:25:25,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-28 15:24:55
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAS7P3fv006036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem=5Fcache=5Fdestroy(NULL) is safe, so removes NULL check before
freeing the mem. This patch also fix ifnullfree.cocci warnings.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Christine Caulfield <ccaulfie@redhat.com>
CC: David Teigland <teigland@redhat.com>
CC: cluster-devel@redhat.com
CC: linux-kernel@vger.kernel.org
---
 fs/dlm/memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 7cd24bccd4fe..37be29f21d04 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -38,10 +38,8 @@ int =5F=5Finit dlm=5Fmemory=5Finit(void)
=20
 void dlm=5Fmemory=5Fexit(void)
 {
-	if (lkb=5Fcache)
-		kmem=5Fcache=5Fdestroy(lkb=5Fcache);
-	if (rsb=5Fcache)
-		kmem=5Fcache=5Fdestroy(rsb=5Fcache);
+	kmem=5Fcache=5Fdestroy(lkb=5Fcache);
+	kmem=5Fcache=5Fdestroy(rsb=5Fcache);
 }
=20
 char *dlm=5Fallocate=5Flvb(struct dlm=5Fls *ls)
@@ -86,8 +84,7 @@ void dlm=5Ffree=5Flkb(struct dlm=5Flkb *lkb)
 		struct dlm=5Fuser=5Fargs *ua;
 		ua =3D lkb->lkb=5Fua;
 		if (ua) {
-			if (ua->lksb.sb=5Flvbptr)
-				kfree(ua->lksb.sb=5Flvbptr);
+			kfree(ua->lksb.sb=5Flvbptr);
 			kfree(ua);
 		}
 	}
--=20
2.19.1

