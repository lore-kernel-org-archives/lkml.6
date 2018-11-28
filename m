Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B4CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B6B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B6B20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeK1TGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:06:55 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:21396 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeK1TGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:06:55 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BE33EA9FA9DC72687B50;
        Wed, 28 Nov 2018 16:06:08 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAS85uAt074619;
        Wed, 28 Nov 2018 16:05:56 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112816061913-13470182 ;
          Wed, 28 Nov 2018 16:06:19 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] scsi: megaraid_sas: NULL check before some freeing functions is not needed
Date:   Wed, 28 Nov 2018 16:05:53 +0800
Message-Id: <20181128080553.37658-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-28 16:06:19,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-28 16:05:48
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAS85uAt074619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma=5Fpool=5Fdestroy(NULL) is safe, so removes NULL check before freeing
the mem. This patch also fix the ifnullfree.cocci warnings.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Kashyap Desai <kashyap.desai@broadcom.com>
CC: Sumit Saxena <sumit.saxena@broadcom.com>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/megaraid/megaraid=5Fsas=5Ffusion.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid=5Fsas=5Ffusion.c b/drivers/scsi=
/megaraid/megaraid=5Fsas=5Ffusion.c
index f74b5ea24f0f..aa477f09a7a5 100644
--- a/drivers/scsi/megaraid/megaraid=5Fsas=5Ffusion.c
+++ b/drivers/scsi/megaraid/megaraid=5Fsas=5Ffusion.c
@@ -807,10 +807,8 @@ megasas=5Ffree=5Frdpq=5Ffusion(struct megasas=5Finstan=
ce *instance) {
=20
 	}
=20
-	if (fusion->reply=5Fframes=5Fdesc=5Fpool)
-		dma=5Fpool=5Fdestroy(fusion->reply=5Fframes=5Fdesc=5Fpool);
-	if (fusion->reply=5Fframes=5Fdesc=5Fpool=5Falign)
-		dma=5Fpool=5Fdestroy(fusion->reply=5Fframes=5Fdesc=5Fpool=5Falign);
+	dma=5Fpool=5Fdestroy(fusion->reply=5Fframes=5Fdesc=5Fpool);
+	dma=5Fpool=5Fdestroy(fusion->reply=5Fframes=5Fdesc=5Fpool=5Falign);
=20
 	if (fusion->rdpq=5Fvirt)
 		dma=5Ffree=5Fcoherent(&instance->pdev->dev,
@@ -830,8 +828,7 @@ megasas=5Ffree=5Freply=5Ffusion(struct megasas=5Finstan=
ce *instance) {
 			fusion->reply=5Fframes=5Fdesc[0],
 			fusion->reply=5Fframes=5Fdesc=5Fphys[0]);
=20
-	if (fusion->reply=5Fframes=5Fdesc=5Fpool)
-		dma=5Fpool=5Fdestroy(fusion->reply=5Fframes=5Fdesc=5Fpool);
+	dma=5Fpool=5Fdestroy(fusion->reply=5Fframes=5Fdesc=5Fpool);
=20
 }
=20
@@ -1627,8 +1624,7 @@ static inline void megasas=5Ffree=5Fioc=5Finit=5Fcmd(=
struct megasas=5Finstance *instance)
 				  fusion->ioc=5Finit=5Fcmd->frame,
 				  fusion->ioc=5Finit=5Fcmd->frame=5Fphys=5Faddr);
=20
-	if (fusion->ioc=5Finit=5Fcmd)
-		kfree(fusion->ioc=5Finit=5Fcmd);
+	kfree(fusion->ioc=5Finit=5Fcmd);
 }
=20
 /**
--=20
2.19.1

