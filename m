Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4313BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2A20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeLJLgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:36:24 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:11638 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJLgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:36:23 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 172E8F9031B527D552F7;
        Mon, 10 Dec 2018 19:36:20 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBABaBGX063831;
        Mon, 10 Dec 2018 19:36:11 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018121019361911-15858711 ;
          Mon, 10 Dec 2018 19:36:19 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] VMCI: Use memdup_user() rather than duplicating its implementation
Date:   Mon, 10 Dec 2018 19:36:07 +0800
Message-Id: <20181210113607.46154-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-10 19:36:19,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-10 19:36:11
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wBABaBGX063831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse existing functionality from memdup=5Fuser() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-kernel@vger.kernel.org
---
 drivers/misc/vmw=5Fvmci/vmci=5Fhost.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/vmw=5Fvmci/vmci=5Fhost.c b/drivers/misc/vmw=5Fvmc=
i/vmci=5Fhost.c
index edfffc9699ba..5da1f3e3f997 100644
--- a/drivers/misc/vmw=5Fvmci/vmci=5Fhost.c
+++ b/drivers/misc/vmw=5Fvmci/vmci=5Fhost.c
@@ -750,19 +750,10 @@ static int vmci=5Fhost=5Fdo=5Fctx=5Fset=5Fcpt=5Fstate=
(struct vmci=5Fhost=5Fdev *vmci=5Fhost=5Fdev,
 	if (copy=5Ffrom=5Fuser(&set=5Finfo, uptr, sizeof(set=5Finfo)))
 		return -EFAULT;
=20
-	cpt=5Fbuf =3D kmalloc(set=5Finfo.buf=5Fsize, GFP=5FKERNEL);
-	if (!cpt=5Fbuf) {
-		vmci=5Fioctl=5Ferr(
-			"cannot allocate memory to set cpt state (type=3D%d)\n",
-			set=5Finfo.cpt=5Ftype);
-		return -ENOMEM;
-	}
-
-	if (copy=5Ffrom=5Fuser(cpt=5Fbuf, (void =5F=5Fuser *)(uintptr=5Ft)set=5Fi=
nfo.cpt=5Fbuf,
-			   set=5Finfo.buf=5Fsize)) {
-		retval =3D -EFAULT;
-		goto out;
-	}
+	cpt=5Fbuf =3D memdup=5Fuser((void =5F=5Fuser *)(uintptr=5Ft)set=5Finfo.cp=
t=5Fbuf,
+				set=5Finfo.buf=5Fsize);
+	if (IS=5FERR(cpt=5Fbuf))
+		return PTR=5FERR(cpt=5Fbuf);
=20
 	cid =3D vmci=5Fctx=5Fget=5Fid(vmci=5Fhost=5Fdev->context);
 	set=5Finfo.result =3D vmci=5Fctx=5Fset=5Fchkpt=5Fstate(cid, set=5Finfo.cp=
t=5Ftype,
@@ -770,7 +761,6 @@ static int vmci=5Fhost=5Fdo=5Fctx=5Fset=5Fcpt=5Fstate(s=
truct vmci=5Fhost=5Fdev *vmci=5Fhost=5Fdev,
=20
 	retval =3D copy=5Fto=5Fuser(uptr, &set=5Finfo, sizeof(set=5Finfo)) ? -EFA=
ULT : 0;
=20
-out:
 	kfree(cpt=5Fbuf);
 	return retval;
 }
--=20
2.19.1

