Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A82081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45A82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeK2XG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:06:27 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:7460 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbeK2XG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:06:27 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B640EC1CDF11E08AF480;
        Thu, 29 Nov 2018 20:01:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wATC14fH046438;
        Thu, 29 Nov 2018 20:01:04 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112920013614-13734234 ;
          Thu, 29 Nov 2018 20:01:36 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] pvcalls-front: Use GFP_ATOMIC under spin_lock
Date:   Thu, 29 Nov 2018 20:01:01 +0800
Message-Id: <20181129120101.19678-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-29 20:01:36,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-29 20:00:52
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wATC14fH046438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that we call this with a spin lock held.
The call tree is:
pvcalls=5Ffront=5Faccept() holds bedata->socket=5Flock.
    -> create=5Factive()
        -> =5F=5Fget=5Ffree=5Fpages() uses GFP=5FKERNEL

The create=5Factive() function is only called from pvcalls=5Ffront=5Faccept=
()
with a spin=5Flock held, The allocation is not allowed to sleep and
GFP=5FKERNEL is not sufficient, it has to be ATOMIC.

This issue was detected by using the Coccinelle software.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
---
 drivers/xen/pvcalls-front.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 2f11ca72a281..f2bbc06a0f7f 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -344,11 +344,11 @@ static int create=5Factive(struct sock=5Fmapping *map=
, int *evtchn)
 	init=5Fwaitqueue=5Fhead(&map->active.inflight=5Fconn=5Freq);
=20
 	map->active.ring =3D (struct pvcalls=5Fdata=5Fintf *)
-		=5F=5Fget=5Ffree=5Fpage(GFP=5FKERNEL | =5F=5FGFP=5FZERO);
+		=5F=5Fget=5Ffree=5Fpage(GFP=5FATOMIC | =5F=5FGFP=5FZERO);
 	if (map->active.ring =3D=3D NULL)
 		goto out=5Ferror;
 	map->active.ring->ring=5Forder =3D PVCALLS=5FRING=5FORDER;
-	bytes =3D (void *)=5F=5Fget=5Ffree=5Fpages(GFP=5FKERNEL | =5F=5FGFP=5FZER=
O,
+	bytes =3D (void *)=5F=5Fget=5Ffree=5Fpages(GFP=5FATOMIC | =5F=5FGFP=5FZER=
O,
 					PVCALLS=5FRING=5FORDER);
 	if (bytes =3D=3D NULL)
 		goto out=5Ferror;
--=20
2.19.1

