Return-Path: <dougso@me.com>
X-Google-Smtp-Source: AB8JxZpjtQMe12Xwfr87gCZ/TFk1z6XqlUCWNumSOyR3DMtce1RFQuU1plavhdwfRfuIboqc8o/o
ARC-Seal: i=1; a=rsa-sha256; t=1525238557; cv=none;
        d=google.com; s=arc-20160816;
        b=harcXFuSaMTtp+jCTJ3baVKzspu7wbfV4fcgP4K9Ji+bEzWhqMRIIBRIo2wIVBdTTN
         OQjSs1Htlx/dnQlgWen7H2g7qBdI7RCJguZPKJXBDB5Xbemhx41ouEGzi+gBnKDJULGP
         865ROYAS/Row+E6Mq4o3VfplY9QG84akuZaZ/nGIbgeKvG+zeGfw3XR4dgD7yUjm4784
         Ke2jEl+N0nvw03AQtKCNgSJ+sE7A2/+qxmO2/GnPEa1OH4iLnitxbqiTSa8dZMY9Bk96
         J84rAqP3nlTUZwxbGenIjyZU+0dvNaey4bpaixCavaI+4Ig5J5qkcayCF+wTj9QZtZGU
         aRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bQ6xxOBfyhmW8Lo9xEhFC9PJ8D7TApBhoexeBlOmoIM=;
        b=dg9ID+Z/NEjNVZpy9khaatvq81y3xhrTgL95vXQ2w16Gqjg+Au3KBkJNOV09j2/DiV
         FWS8JCNrJ+LUzhtQRIVMtPDVO93Cswh4semVwEwaoVJyx+wnQfCoKTpVktaZExNbEaI8
         bFEd4cTHn7JttmFViDcMzehztV2acBlnf24dLWLNX0/8oomaImBoT8JrK2cA0oPUa+Rz
         eURsCfMi+818SZ+fI8VNMG838n9FDzbsH89DTGx6HGkv3Gk5N1HG/ZvovEPTjMuOMGB7
         vkF0Lzw3BT6yfVmOv++uLSd7glaLK6w+tE30uRrZHejhswcTHASdQW96Fys3KWSCgZBB
         Hcfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=FNO2/nad;
       spf=pass (google.com: domain of dougso@me.com designates 17.58.37.33 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=FNO2/nad;
       spf=pass (google.com: domain of dougso@me.com designates 17.58.37.33 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-02_02:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805020053
From: Doug Oucharek <dougso@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>,
 Doug Oucahrek <dougso@me.com>, Alexander Boyko <alexander.boyko@seagate.com>
Subject: [PATCH] staging: lustre: o2iblnd: fix race at kiblnd_connect_peer
Date: Tue, 01 May 2018 22:22:19 -0700
Message-id: <1525238539-12482-1-git-send-email-dougso@me.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599328545412707608?=
X-GMAIL-MSGID: =?utf-8?q?1599328545412707608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Oucahrek <dougso@me.com>

cmid will be destroyed at OFED if kiblnd_cm_callback return error.
if error happen before the end of kiblnd_connect_peer, it will touch
destroyed cmid and fail as
(o2iblnd_cb.c:1315:kiblnd_connect_peer())
            ASSERTION( cmid->device != ((void *)0) ) failed:

Signed-off-by: Alexander Boyko <alexander.boyko@seagate.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10015
Reviewed-by: Alexey Lyashkov <c17817@cray.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: John L. Hammond <john.hammond@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index b4a182d..a76c1f2 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1290,11 +1290,6 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 		goto failed2;
 	}
 
-	LASSERT(cmid->device);
-	CDEBUG(D_NET, "%s: connection bound to %s:%pI4h:%s\n",
-	       libcfs_nid2str(peer->ibp_nid), dev->ibd_ifname,
-	       &dev->ibd_ifip, cmid->device->name);
-
 	return;
 
  failed2:
@@ -2996,8 +2991,19 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 		} else {
 			rc = rdma_resolve_route(
 				cmid, *kiblnd_tunables.kib_timeout * 1000);
-			if (!rc)
+			if (!rc) {
+				struct kib_net *net = peer->ibp_ni->ni_data;
+				struct kib_dev *dev = net->ibn_dev;
+
+				CDEBUG(D_NET, "%s: connection bound to "\
+				       "%s:%pI4h:%s\n",
+				       libcfs_nid2str(peer->ibp_nid),
+				       dev->ibd_ifname,
+				       &dev->ibd_ifip, cmid->device->name);
+
 				return 0;
+			}
+
 			/* Can't initiate route resolution */
 			CERROR("Can't resolve route for %s: %d\n",
 			       libcfs_nid2str(peer->ibp_nid), rc);
-- 
1.8.3.1
