Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF82C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC3D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeLFEih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:38:37 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:34774 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbeLFEig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:38:36 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 99F2E50A97BE1DD2860C;
        Thu,  6 Dec 2018 12:38:34 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB64cVeg097842;
        Thu, 6 Dec 2018 12:38:31 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120612390057-15051261 ;
          Thu, 6 Dec 2018 12:39:00 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Hannes Reinecke <hare@suse.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] scsi: aic7xxx: Remove unnecessary NULL check before kfree
Date:   Thu, 6 Dec 2018 12:37:49 +0800
Message-Id: <20181206043749.34535-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 12:39:00,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 12:38:20
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB64cVeg097842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(NULL) is safe, so removes NULL check before freeing the mem.
This patch also fix the ifnullfree.cocci warnings.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Alex Deucher <alexander.deucher@amd.com>
CC: Hannes Reinecke <hare@suse.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/aic7xxx/aic79xx=5Fcore.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx=5Fcore.c b/drivers/scsi/aic7xxx/a=
ic79xx=5Fcore.c
index 9ee75c9a9aa1..090440f2ebed 100644
--- a/drivers/scsi/aic7xxx/aic79xx=5Fcore.c
+++ b/drivers/scsi/aic7xxx/aic79xx=5Fcore.c
@@ -3673,8 +3673,7 @@ ahd=5Ffree=5Ftstate(struct ahd=5Fsoftc *ahd, u=5Fint =
scsi=5Fid, char channel, int force)
 		return;
=20
 	tstate =3D ahd->enabled=5Ftargets[scsi=5Fid];
-	if (tstate !=3D NULL)
-		kfree(tstate);
+	kfree(tstate);
 	ahd->enabled=5Ftargets[scsi=5Fid] =3D NULL;
 }
 #endif
@@ -6136,8 +6135,7 @@ ahd=5Fset=5Funit(struct ahd=5Fsoftc *ahd, int unit)
 void
 ahd=5Fset=5Fname(struct ahd=5Fsoftc *ahd, char *name)
 {
-	if (ahd->name !=3D NULL)
-		kfree(ahd->name);
+	kfree(ahd->name);
 	ahd->name =3D name;
 }
=20
@@ -6198,12 +6196,9 @@ ahd=5Ffree(struct ahd=5Fsoftc *ahd)
 		kfree(ahd->black=5Fhole);
 	}
 #endif
-	if (ahd->name !=3D NULL)
-		kfree(ahd->name);
-	if (ahd->seep=5Fconfig !=3D NULL)
-		kfree(ahd->seep=5Fconfig);
-	if (ahd->saved=5Fstack !=3D NULL)
-		kfree(ahd->saved=5Fstack);
+	kfree(ahd->name);
+	kfree(ahd->seep=5Fconfig);
+	kfree(ahd->saved=5Fstack);
 #ifndef =5F=5FFreeBSD=5F=5F
 	kfree(ahd);
 #endif
--=20
2.19.1

