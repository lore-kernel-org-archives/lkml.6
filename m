Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B69C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9651A2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9651A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK3WKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:10:17 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:40302 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeK3WKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:10:16 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 899304AC50F8961A0747;
        Fri, 30 Nov 2018 19:01:19 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAUB1A8N024240;
        Fri, 30 Nov 2018 19:01:10 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018113019014935-13968263 ;
          Fri, 30 Nov 2018 19:01:49 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v3] pvcalls-front: Avoid __get_free_pages(GFP_KERNEL) under spinlock
Date:   Fri, 30 Nov 2018 19:01:07 +0800
Message-Id: <20181130110107.31468-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-30 19:01:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-30 19:00:54
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAUB1A8N024240
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

Suggested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
---
 drivers/xen/pvcalls-front.c | 71 ++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 2f11ca72a281..a26f416daf46 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -335,7 +335,43 @@ int pvcalls=5Ffront=5Fsocket(struct socket *sock)
 	return ret;
 }
=20
-static int create=5Factive(struct sock=5Fmapping *map, int *evtchn)
+struct sock=5Fmapping=5Factive=5Fring {
+	struct pvcalls=5Fdata=5Fintf *ring;
+	RING=5FIDX ring=5Forder;
+	void *bytes;
+};
+
+static int alloc=5Factive=5Fring(struct sock=5Fmapping=5Factive=5Fring *ac=
tive=5Fring)
+{
+	active=5Fring->ring =3D NULL;
+	active=5Fring->bytes =3D NULL;
+
+	active=5Fring->ring =3D (struct pvcalls=5Fdata=5Fintf *)
+		=5F=5Fget=5Ffree=5Fpage(GFP=5FKERNEL | =5F=5FGFP=5FZERO);
+	if (active=5Fring->ring =3D=3D NULL)
+		goto out=5Ferror;
+	active=5Fring->ring=5Forder =3D PVCALLS=5FRING=5FORDER;
+	active=5Fring->bytes =3D (void *)=5F=5Fget=5Ffree=5Fpages(GFP=5FKERNEL | =
=5F=5FGFP=5FZERO,
+			PVCALLS=5FRING=5FORDER);
+	if (active=5Fring->bytes =3D=3D NULL)
+		goto out=5Ferror;
+
+	return 0;
+
+out=5Ferror:
+	free=5Fpages((unsigned long)active=5Fring->bytes, active=5Fring->ring=5Fo=
rder);
+	free=5Fpage((unsigned long)active=5Fring->ring);
+	return -ENOMEM;
+}
+
+static void free=5Factive=5Fring(struct sock=5Fmapping=5Factive=5Fring *ac=
tive=5Fring)
+{
+	free=5Fpages((unsigned long)active=5Fring->bytes, active=5Fring->ring=5Fo=
rder);
+	free=5Fpage((unsigned long)active=5Fring->ring);
+}
+
+static int create=5Factive(struct sock=5Fmapping *map, int *evtchn,
+		struct sock=5Fmapping=5Factive=5Fring *active=5Fring)
 {
 	void *bytes;
 	int ret =3D -ENOMEM, irq =3D -1, i;
@@ -343,15 +379,9 @@ static int create=5Factive(struct sock=5Fmapping *map,=
 int *evtchn)
 	*evtchn =3D -1;
 	init=5Fwaitqueue=5Fhead(&map->active.inflight=5Fconn=5Freq);
=20
-	map->active.ring =3D (struct pvcalls=5Fdata=5Fintf *)
-		=5F=5Fget=5Ffree=5Fpage(GFP=5FKERNEL | =5F=5FGFP=5FZERO);
-	if (map->active.ring =3D=3D NULL)
-		goto out=5Ferror;
-	map->active.ring->ring=5Forder =3D PVCALLS=5FRING=5FORDER;
-	bytes =3D (void *)=5F=5Fget=5Ffree=5Fpages(GFP=5FKERNEL | =5F=5FGFP=5FZER=
O,
-					PVCALLS=5FRING=5FORDER);
-	if (bytes =3D=3D NULL)
-		goto out=5Ferror;
+	map->active.ring =3D active=5Fring->ring;
+	map->active.ring->ring=5Forder =3D active=5Fring->ring=5Forder;
+	bytes =3D active=5Fring->bytes;
 	for (i =3D 0; i < (1 << PVCALLS=5FRING=5FORDER); i++)
 		map->active.ring->ref[i] =3D gnttab=5Fgrant=5Fforeign=5Faccess(
 			pvcalls=5Ffront=5Fdev->otherend=5Fid,
@@ -397,6 +427,7 @@ int pvcalls=5Ffront=5Fconnect(struct socket *sock, stru=
ct sockaddr *addr,
 	struct sock=5Fmapping *map =3D NULL;
 	struct xen=5Fpvcalls=5Frequest *req;
 	int notify, req=5Fid, ret, evtchn;
+	struct sock=5Fmapping=5Factive=5Fring active=5Fring;
=20
 	if (addr->sa=5Ffamily !=3D AF=5FINET || sock->type !=3D SOCK=5FSTREAM)
 		return -EOPNOTSUPP;
@@ -406,15 +437,21 @@ int pvcalls=5Ffront=5Fconnect(struct socket *sock, st=
ruct sockaddr *addr,
 		return PTR=5FERR(map);
=20
 	bedata =3D dev=5Fget=5Fdrvdata(&pvcalls=5Ffront=5Fdev->dev);
+	ret =3D alloc=5Factive=5Fring(&active=5Fring);
+	if (ret < 0) {
+		pvcalls=5Fexit=5Fsock(sock);
+		return ret;
+	}
=20
 	spin=5Flock(&bedata->socket=5Flock);
 	ret =3D get=5Frequest(bedata, &req=5Fid);
 	if (ret < 0) {
 		spin=5Funlock(&bedata->socket=5Flock);
+		free=5Factive=5Fring(&active=5Fring);
 		pvcalls=5Fexit=5Fsock(sock);
 		return ret;
 	}
-	ret =3D create=5Factive(map, &evtchn);
+	ret =3D create=5Factive(map, &evtchn, &active=5Fring);
 	if (ret < 0) {
 		spin=5Funlock(&bedata->socket=5Flock);
 		pvcalls=5Fexit=5Fsock(sock);
@@ -744,6 +781,7 @@ int pvcalls=5Ffront=5Faccept(struct socket *sock, struc=
t socket *newsock, int flags)
 	struct sock=5Fmapping *map2 =3D NULL;
 	struct xen=5Fpvcalls=5Frequest *req;
 	int notify, req=5Fid, ret, evtchn, nonblock;
+	struct sock=5Fmapping=5Factive=5Fring active=5Fring;
=20
 	map =3D pvcalls=5Fenter=5Fsock(sock);
 	if (IS=5FERR(map))
@@ -780,12 +818,20 @@ int pvcalls=5Ffront=5Faccept(struct socket *sock, str=
uct socket *newsock, int flags)
 		}
 	}
=20
+	ret =3D alloc=5Factive=5Fring(&active=5Fring);
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
+		free=5Factive=5Fring(&active=5Fring);
 		pvcalls=5Fexit=5Fsock(sock);
 		return ret;
 	}
@@ -794,10 +840,11 @@ int pvcalls=5Ffront=5Faccept(struct socket *sock, str=
uct socket *newsock, int flags)
 		clear=5Fbit(PVCALLS=5FFLAG=5FACCEPT=5FINFLIGHT,
 			  (void *)&map->passive.flags);
 		spin=5Funlock(&bedata->socket=5Flock);
+		free=5Factive=5Fring(&active=5Fring);
 		pvcalls=5Fexit=5Fsock(sock);
 		return -ENOMEM;
 	}
-	ret =3D create=5Factive(map2, &evtchn);
+	ret =3D create=5Factive(map2, &evtchn, &active=5Fring);
 	if (ret < 0) {
 		kfree(map2);
 		clear=5Fbit(PVCALLS=5FFLAG=5FACCEPT=5FINFLIGHT,
--=20
2.19.1

