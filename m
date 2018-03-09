Return-Path: <doucharek@localhost.localdomain>
X-Google-Smtp-Source: AG47ELtFJzknrhHR28KX21s9tsQ7JRaKSU/Omi+iXhCMp2pGipbXsn87bmXsf4HQbW7vkaGHFIJj
ARC-Seal: i=1; a=rsa-sha256; t=1520582256; cv=none;
        d=google.com; s=arc-20160816;
        b=fgVS1dX53w9cWKi9THScdoaXHrwfmr/y+PclX8ZYqkXPyh1co9e2eD3LiTO+D6yq4v
         MG+v+aAo72/eMUGRuelPyLbQP96jl0GBt1UTNjW+F5Z/NpHc71zpZ19TPQ3WEqV/Zsiz
         qvSKvhvm3DVMP5bbPsW4SFyqn1JhNw+NcEmKPCmpIcF0V3FxwRj6s/qQEuZ+oDoiJQ0b
         ZpFYxzG21Zx6xC9VE+WbeQKaLtUafMAqHUNZTCqGXwrAcu5n6BfoUsqhZCqm+Wb9qWE5
         MGB0fRGt/k78+pLWi1x4gPogs0eIFtilHL9fmNoIO57TynYpza87BYc+ZDNsAqTXN9YR
         W/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=7WhEmhm98JmczSXaJzlDTpsszybBzzXY4uos+fdNb/E=;
        b=kBya5OGFEaHdc0iBzkM55B+Ms2V7eed+CH0kYVB1QxPv1wyoFiKopxkWju0WsBcIIg
         gsov+1zkrX31/sLbY7tbC32PfP3J1z2uGlwH4JL65ovXCC5pxtjcwCBiGiu65LvNjLST
         WKkJkarTHEHMfXLHpaEpg5/VmzrS91DIlnp1KBaNuDYGcUmeLCeMmtkgRRXzWkH1S07L
         KeZVaoYd+SINyNNDgbR+uOF0oXyr64SQbXEX6CqBmXQBIApkxVd/JgJnHTlnvgUK3fNz
         9LHiJYy5+8doqHrNYxftNu2HsrUnxNCkp/t5RbdwAHUsyd3uZ+iDANiAQKvRA6u4MgmN
         jHeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.70.224.226 is neither permitted nor denied by best guess record for domain of doucharek@localhost.localdomain) smtp.mailfrom=doucharek@localhost.localdomain
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.70.224.226 is neither permitted nor denied by best guess record for domain of doucharek@localhost.localdomain) smtp.mailfrom=doucharek@localhost.localdomain
From: Doug Oucharek <doug@cadentcomputing.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org,
	Oleg Drokin <oleg.drokin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lustre Development List <lustre-devel@lists.lustre.org>,
	Alexander Boyko <alexander.boyko@seagate.com>,
	Doug Oucharek <dougso@me.com>
Subject: [PATCH] staging: lustre: o2iblnd: fix race at kiblnd_connect_peer
Date: Fri,  9 Mar 2018 02:49:18 -0500
Message-Id: <1520581758-4410-1-git-send-email-doug@cadentcomputing.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594446060474438725?=
X-GMAIL-MSGID: =?utf-8?q?1594446060474438725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Boyko <alexander.boyko@seagate.com>

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
index 6690a6c..080c2a1 100644
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
+				kib_net_t *net = peer_ni->ibp_ni->ni_data;
+				kib_dev_t *dev = net->ibn_dev;
+
+				CDEBUG(D_NET, "%s: connection bound to "\
+				       "%s:%pI4h:%s\n",
+				       libcfs_nid2str(peer_ni->ibp_nid),
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
