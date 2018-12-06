Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C76C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D36220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D36220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeLFNT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:19:28 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:28106 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbeLFNT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:19:27 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D4173234A907709FA5C5;
        Thu,  6 Dec 2018 21:19:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB6DJJ62089930;
        Thu, 6 Dec 2018 21:19:19 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120621195244-15154913 ;
          Thu, 6 Dec 2018 21:19:52 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Hannes Reinecke <hare@suse.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH v2] scsi: aic7xxx: Use kmemdup instead of duplicating its function
Date:   Thu, 6 Dec 2018 21:19:18 +0800
Message-Id: <20181206131918.37433-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 21:19:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 21:19:08
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB6DJJ62089930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup has implemented the function that kmalloc() + memcpy().
We prefer to kmemdup rather than code opened implementation.

This issue was detected with the help of coccinelle.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Hannes Reinecke <hare@suse.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/aic7xxx/aic79xx=5Fcore.c | 4 ++--
 drivers/scsi/aic7xxx/aic7xxx=5Fcore.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx=5Fcore.c b/drivers/scsi/aic7xxx/a=
ic79xx=5Fcore.c
index 9ee75c9a9aa1..3e72fac6d248 100644
--- a/drivers/scsi/aic7xxx/aic79xx=5Fcore.c
+++ b/drivers/scsi/aic7xxx/aic79xx=5Fcore.c
@@ -9438,10 +9438,10 @@ ahd=5Floadseq(struct ahd=5Fsoftc *ahd)
 	if (cs=5Fcount !=3D 0) {
=20
 		cs=5Fcount *=3D sizeof(struct cs);
-		ahd->critical=5Fsections =3D kmalloc(cs=5Fcount, GFP=5FATOMIC);
+		ahd->critical=5Fsections =3D kmemdup(cs=5Ftable, cs=5Fcount,
+						GFP=5FATOMIC);
 		if (ahd->critical=5Fsections =3D=3D NULL)
 			panic("ahd=5Floadseq: Could not malloc");
-		memcpy(ahd->critical=5Fsections, cs=5Ftable, cs=5Fcount);
 	}
 	ahd=5Foutb(ahd, SEQCTL0, PERRORDIS|FAILDIS|FASTMODE);
=20
diff --git a/drivers/scsi/aic7xxx/aic7xxx=5Fcore.c b/drivers/scsi/aic7xxx/a=
ic7xxx=5Fcore.c
index f3362f4ab16e..8ea055a81ee8 100644
--- a/drivers/scsi/aic7xxx/aic7xxx=5Fcore.c
+++ b/drivers/scsi/aic7xxx/aic7xxx=5Fcore.c
@@ -6901,10 +6901,10 @@ ahc=5Floadseq(struct ahc=5Fsoftc *ahc)
 	if (cs=5Fcount !=3D 0) {
=20
 		cs=5Fcount *=3D sizeof(struct cs);
-		ahc->critical=5Fsections =3D kmalloc(cs=5Fcount, GFP=5FATOMIC);
+		ahc->critical=5Fsections =3D kmemdup(cs=5Ftable, cs=5Fcount,
+						GFP=5FATOMIC);
 		if (ahc->critical=5Fsections =3D=3D NULL)
 			panic("ahc=5Floadseq: Could not malloc");
-		memcpy(ahc->critical=5Fsections, cs=5Ftable, cs=5Fcount);
 	}
 	ahc=5Foutb(ahc, SEQCTL, PERRORDIS|FAILDIS|FASTMODE);
=20
--=20
2.19.1

