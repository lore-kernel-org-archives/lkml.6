Return-Path: <dougso@me.com>
X-Google-Smtp-Source: AG47ELvmr2Eo97nyCmkQ49N6X80xjsGcK+Msuwntq0IVeMObC1ZSet7bCaoFn6/fGsbZ0au38rYA
ARC-Seal: i=1; a=rsa-sha256; t=1520638186; cv=none;
        d=google.com; s=arc-20160816;
        b=kN2HBo7THAHfg1Kdl5esatqBTQG+W6CXu2R4MTC2n4PXYpryevSQVU3MOnoDPcTQ6w
         wFq4M9unCRhWxM586ZzKJGpP6GEwvdOWDesaT+xsyV9YzSMjDOwvrA/zI/gMksW1Tf4e
         Qvcfy6s775G5da6X++pyv6EoSS+NFr85uMEl8+2T0lObsH3H9lSg7aefp84jqiYgQ2Bp
         /lgnvNP99qlOyvCRu2DCyKYzudMlSSnnVE842ZaGHuQn3rNvwBH/gq7FLGt2drUT4Z1I
         jE2v4e/hR20qAJc8lKxSenjaswNaI+PQ6xJqBJysAvqln67DlYY8yOoSLPxaRWPbwp6+
         kSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:dkim-signature
         :arc-authentication-results;
        bh=6fTtO4e/wGkhb6PjU23TJCZErvZ9shIPEA8GDkVuVAc=;
        b=jgwyN/Bw+GNnnqYwxKEdCFEewFe2xaqICgN7drub8RZ/vdQcZzoBVeEGC6z6ZsdbDq
         4RW3e6FnwM729hklvTm+uQ6qv+FOf1pF9sSkto5dguv1/GRBnv0FFJeFstjVkpPBkJww
         tZf+Lu6YybjwOyPjXwqh/4kAb28T7J9ZBEN1Ide9tv4FOMk7+e85c682ML/tHlldQL4c
         e9W7lAb7NpkT9h1Fn2zOtfVj36/i8YgqzcX1pDdFnAEaKi9wEX3zYIUGNzsTBhPGMhtT
         Z4iFvSSP7vacrwBeWiYCbsBgSTNyr3BDADiKuE0SsxZO7H22LJRIRpO+chPcWbuwaCcG
         GvMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=TPZfTofn;
       spf=pass (google.com: domain of dougso@me.com designates 17.139.148.156 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=TPZfTofn;
       spf=pass (google.com: domain of dougso@me.com designates 17.139.148.156 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-03-09_11:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1803090274
From: Doug Oucharek <dougso@me.com>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [PATCH] staging: lustre: o2iblnd: fix race at kiblnd_connect_peer
Message-id: <8D09A62F-69B3-48CF-BE9B-D3C1ABB70910@me.com>
Date: Fri, 09 Mar 2018 15:29:40 -0800
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>,
 Doug Oucharek <dougso@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, "Drokin, Oleg" <oleg.drokin@intel.com>,
 "Dilger, Andreas" <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>, alexander.boyko@seagate.com
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594504706762517213?=
X-GMAIL-MSGID: =?utf-8?q?1594504706762517213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cmid will be destroyed at OFED if kiblnd_cm_callback return error.
if error happen before the end of kiblnd_connect_peer, it will touch
destroyed cmid and fail as
(o2iblnd_cb.c:1315:kiblnd_connect_peer())
           ASSERTION( cmid->device !=3D ((void *)0) ) failed:

Signed-off-by: Alexander Boyko <alexander.boyko@seagate.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10015
Reviewed-by: Alexey Lyashkov <c17817@cray.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: John L. Hammond <john.hammond@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
---
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 18 =
++++++++++++------
1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c =
b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 6690a6c..080c2a1 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1290,11 +1290,6 @@ static int kiblnd_resolve_addr(struct rdma_cm_id =
*cmid,
		goto failed2;
	}

-	LASSERT(cmid->device);
-	CDEBUG(D_NET, "%s: connection bound to %s:%pI4h:%s\n",
-	       libcfs_nid2str(peer->ibp_nid), dev->ibd_ifname,
-	       &dev->ibd_ifip, cmid->device->name);
-
	return;

 failed2:
@@ -2996,8 +2991,19 @@ static int kiblnd_resolve_addr(struct rdma_cm_id =
*cmid,
		} else {
			rc =3D rdma_resolve_route(
				cmid, *kiblnd_tunables.kib_timeout * =
1000);
-			if (!rc)
+			if (!rc) {
+				kib_net_t *net =3D =
peer_ni->ibp_ni->ni_data;
+				kib_dev_t *dev =3D net->ibn_dev;
+
+				CDEBUG(D_NET, "%s: connection bound to =
"\
+				       "%s:%pI4h:%s\n",
+				       libcfs_nid2str(peer_ni->ibp_nid),
+				       dev->ibd_ifname,
+				       &dev->ibd_ifip, =
cmid->device->name);
+
				return 0;
+			}
+
			/* Can't initiate route resolution */
			CERROR("Can't resolve route for %s: %d\n",
			       libcfs_nid2str(peer->ibp_nid), rc);
--=20
1.8.3.1
