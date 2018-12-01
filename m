Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E51C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2EE20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2EE20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLARpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:45:09 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:36568 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLARpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:45:09 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BD8FEFF60750F2432B35;
        Sat,  1 Dec 2018 14:33:17 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB16XDHf096462;
        Sat, 1 Dec 2018 14:33:13 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120114335828-14091282 ;
          Sat, 1 Dec 2018 14:33:58 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v4] pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock
Date:   Sat, 1 Dec 2018 14:33:03 +0800
Message-Id: <20181201063303.45089-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-01 14:33:58,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-01 14:32:53
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB16XDHf096462
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
GFP=5FKERNEL is not sufficient.

This issue was detected by using the Coccinelle software.

v2: Add a function doing the allocations which is called
    outside the lock and passing the allocated data to
    create=5Factive().

v3: Use the matching deallocators i.e., free=5Fpage()
    and free=5Fpages(), respectively.

v4: It would be better to pre-populate map (struct sock=5Fmapping),
    rather than introducing one more new struct.

Suggested-by: Juergen Gross <jgross@suse.com>
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
---
 drivers/xen/pvcalls-front.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 77224d8f3e6f..555c9abdf58f 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -335,13 +335,18 @@ int pvcalls=5Ffront=5Fsocket(struct socket *sock)
 	return ret;
 }
=20
-static int create=5Factive(struct sock=5Fmapping *map, int *evtchn)
+static void free=5Factive=5Fring(struct sock=5Fmapping *map)
 {
-	void *bytes;
-	int ret =3D -ENOMEM, irq =3D -1, i;
+	if (!map)
+		return;
+	free=5Fpages((unsigned long)map->active.data.in,
+			map->active.ring->ring=5Forder);
+	free=5Fpage((unsigned long)map->active.ring);
+}
=20
-	*evtchn =3D -1;
-	init=5Fwaitqueue=5Fhead(&map->active.inflight=5Fconn=5Freq);
+static int alloc=5Factive=5Fring(struct sock=5Fmapping *map)
+{
+	void *bytes;
=20
 	map->active.ring =3D (struct pvcalls=5Fdata=5Fintf *)
 		=5F=5Fget=5Ffree=5Fpage(GFP=5FKERNEL | =5F=5FGFP=5FZERO);
@@ -352,6 +357,26 @@ static int create=5Factive(struct sock=5Fmapping *map,=
 int *evtchn)
 					PVCALLS=5FRING=5FORDER);
 	if (bytes =3D=3D NULL)
 		goto out=5Ferror;
+	map->active.data.in =3D bytes;
+	map->active.data.out =3D bytes +
+		XEN=5FFLEX=5FRING=5FSIZE(PVCALLS=5FRING=5FORDER);
+
+	return 0;
+
+out=5Ferror:
+	free=5Factive=5Fring(map);
+	return -ENOMEM;
+}
+
+static int create=5Factive(struct sock=5Fmapping *map, int *evtchn)
+{
+	void *bytes;
+	int ret =3D -ENOMEM, irq =3D -1, i;
+
+	*evtchn =3D -1;
+	init=5Fwaitqueue=5Fhead(&map->active.inflight=5Fconn=5Freq);
+
+	bytes =3D map->active.data.in;
 	for (i =3D 0; i < (1 << PVCALLS=5FRING=5FORDER); i++)
 		map->active.ring->ref[i] =3D gnttab=5Fgrant=5Fforeign=5Faccess(
 			pvcalls=5Ffront=5Fdev->otherend=5Fid,
@@ -361,10 +386,6 @@ static int create=5Factive(struct sock=5Fmapping *map,=
 int *evtchn)
 		pvcalls=5Ffront=5Fdev->otherend=5Fid,
 		pfn=5Fto=5Fgfn(virt=5Fto=5Fpfn((void *)map->active.ring)), 0);
=20
-	map->active.data.in =3D bytes;
-	map->active.data.out =3D bytes +
-		XEN=5FFLEX=5FRING=5FSIZE(PVCALLS=5FRING=5FORDER);
-
 	ret =3D xenbus=5Falloc=5Fevtchn(pvcalls=5Ffront=5Fdev, evtchn);
 	if (ret)
 		goto out=5Ferror;
@@ -385,8 +406,7 @@ static int create=5Factive(struct sock=5Fmapping *map, =
int *evtchn)
 out=5Ferror:
 	if (*evtchn >=3D 0)
 		xenbus=5Ffree=5Fevtchn(pvcalls=5Ffront=5Fdev, *evtchn);
-	free=5Fpages((unsigned long)map->active.data.in, PVCALLS=5FRING=5FORDER);
-	free=5Fpage((unsigned long)map->active.ring);
+	free=5Factive=5Fring(map);
 	return ret;
 }
=20
@@ -406,11 +426,17 @@ int pvcalls=5Ffront=5Fconnect(struct socket *sock, st=
ruct sockaddr *addr,
 		return PTR=5FERR(map);
=20
 	bedata =3D dev=5Fget=5Fdrvdata(&pvcalls=5Ffront=5Fdev->dev);
+	ret =3D alloc=5Factive=5Fring(map);
+	if (ret < 0) {
+		pvcalls=5Fexit=5Fsock(sock);
+		return ret;
+	}
=20
 	spin=5Flock(&bedata->socket=5Flock);
 	ret =3D get=5Frequest(bedata, &req=5Fid);
 	if (ret < 0) {
 		spin=5Funlock(&bedata->socket=5Flock);
+		free=5Factive=5Fring(map);
 		pvcalls=5Fexit=5Fsock(sock);
 		return ret;
 	}
@@ -780,12 +806,20 @@ int pvcalls=5Ffront=5Faccept(struct socket *sock, str=
uct socket *newsock, int flags)
 		}
 	}
=20
+	ret =3D alloc=5Factive=5Fring(map);
+	if (ret < 0) {
+		clear=5Fbit(PVCALLS=5FFLAG=5FACCEPT=5FINFLIGHT,
+				(void *)&map->passive.flags);
+		pvcalls=5Fexit=5Fsock(sock);
+		return ret;
+	}
 	spin=5Flock(&bedata->socket=5Flock);
 	ret =3D get=5Frequest(bedata, &req=5Fid);
 	if (ret < 0) {
 		clear=5Fbit(PVCALLS=5FFLAG=5FACCEPT=5FINFLIGHT,
 			  (void *)&map->passive.flags);
 		spin=5Funlock(&bedata->socket=5Flock);
+		free=5Factive=5Fring(map);
 		pvcalls=5Fexit=5Fsock(sock);
 		return ret;
 	}
@@ -794,6 +828,7 @@ int pvcalls=5Ffront=5Faccept(struct socket *sock, struc=
t socket *newsock, int flags)
 		clear=5Fbit(PVCALLS=5FFLAG=5FACCEPT=5FINFLIGHT,
 			  (void *)&map->passive.flags);
 		spin=5Funlock(&bedata->socket=5Flock);
+		free=5Factive=5Fring(map);
 		pvcalls=5Fexit=5Fsock(sock);
 		return -ENOMEM;
 	}
--=20
2.19.1

