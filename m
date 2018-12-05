Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52760C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CBE20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CBE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeLEEWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:22:11 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:49264 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeLEEWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:22:11 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A741AF0C777293CC9510;
        Wed,  5 Dec 2018 12:22:07 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB54M1PE014851;
        Wed, 5 Dec 2018 12:22:01 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120512222245-14831665 ;
          Wed, 5 Dec 2018 12:22:22 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] scsi: wd719x: Fix sleeping under a spinlock
Date:   Wed, 5 Dec 2018 12:21:44 +0800
Message-Id: <20181205042144.14174-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-05 12:22:22,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-05 12:21:54
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB54M1PE014851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dma=5Falloc=5Fcoherent is being called with a GFP=5FKERNEL
flag which allows it to sleep with a spinlock held.
The call tree is:
wd719x=5Fhost=5Freset() holds wd->sh->host=5Flock
    -> wd719x=5Fchip=5Finit()
        -> dma=5Falloc=5Fcoherent() uses GFP=5FKERNEL

This patch introduces a can=5Fsleep parameter into
the wd719x=5Fchip=5Finit() function. When we have spinlock and
can't sleep, we pass in 0; in other cases, we pass in 1.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/wd719x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 808ba8e952db..e1dac0115947 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -289,7 +289,7 @@ static int wd719x=5Fqueuecommand(struct Scsi=5FHost *sh=
, struct scsi=5Fcmnd *cmd)
 	return 0;
 }
=20
-static int wd719x=5Fchip=5Finit(struct wd719x *wd)
+static int wd719x=5Fchip=5Finit(struct wd719x *wd, int can=5Fsleep)
 {
 	int i, ret;
 	u32 risc=5Finit[3];
@@ -318,7 +318,8 @@ static int wd719x=5Fchip=5Finit(struct wd719x *wd)
=20
 	if (!wd->fw=5Fvirt)
 		wd->fw=5Fvirt =3D dma=5Falloc=5Fcoherent(&wd->pdev->dev, wd->fw=5Fsize,
-						 &wd->fw=5Fphys, GFP=5FKERNEL);
+						 &wd->fw=5Fphys, can=5Fsleep ?
+						 GFP=5FKERNEL : GFP=5FATOMIC);
 	if (!wd->fw=5Fvirt) {
 		ret =3D -ENOMEM;
 		goto wd719x=5Finit=5Fend;
@@ -510,7 +511,7 @@ static int wd719x=5Fhost=5Freset(struct scsi=5Fcmnd *cm=
d)
 	dev=5Finfo(&wd->pdev->dev, "host reset requested\n");
 	spin=5Flock=5Firqsave(wd->sh->host=5Flock, flags);
 	/* Try to reinit the RISC */
-	if (wd719x=5Fchip=5Finit(wd) =3D=3D 0)
+	if (wd719x=5Fchip=5Finit(wd, 0) =3D=3D 0)
 		result =3D SUCCESS;
 	else
 		result =3D FAILED;
@@ -834,7 +835,7 @@ static int wd719x=5Fboard=5Ffound(struct Scsi=5FHost *s=
h)
 	/* read parameters from EEPROM */
 	wd719x=5Fread=5Feeprom(wd);
=20
-	ret =3D wd719x=5Fchip=5Finit(wd);
+	ret =3D wd719x=5Fchip=5Finit(wd, 1);
 	if (ret)
 		goto fail=5Ffree=5Firq;
=20
--=20
2.19.1

