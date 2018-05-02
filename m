Return-Path: <dougso@me.com>
X-Google-Smtp-Source: AB8JxZoCqdhsQY9zOzGuvlkup3QMn3QHtZ/IIHc/dM7gnt39wHDBkaCOzbqI4eQTb26Qm6TDLrav
ARC-Seal: i=1; a=rsa-sha256; t=1525232974; cv=none;
        d=google.com; s=arc-20160816;
        b=UvZ7hzwXlpZ1Mhlpfj5Jbdzg202WkaM65cj/h2gW7B43cEGHNJbMN/VSRdoVcCTqO8
         PdE/YeDMXn1sehdhEnXWcs1N83Kw/3TqdaqJI2yXTgshPmGKXdE8NYAIGwIKRKlqMGSC
         AnMLfFBDbjMGpE+zzSykOWXPE4X0cXBOiR51osx+JNkscjVrw0RcPf0dgt+zr5Am81r4
         6pmgmDGnOfg71vEjH5veAR9D+WXLA/+zLbfr2NESSBjdRw/nBGwfAAPW55Qjb1dFSRva
         uPBxQVXbS4wVZmBIxEP19JhOOB2Jh5AbimSHr7qP0Ou1Dw3hwNKLEWwKQTEFOLXKvKqG
         jzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4iwriLVsJba5BasyzUM3yjgFEHy7gPteCRNbUHXDfyE=;
        b=QT37qrOGh4+XC5pUrLv0fFFqbZghsnHQtEdgRVJ5bheYSCg5DxY3Iyx9EEGwLolwPB
         I3S5lvqDatXiErkeIhK5Fep2Sbl3ZYndiaLJW/fIbVHFj/1ZzfdURL4hNx/c/90TVWSj
         349/AvLQz0Yh6VO/Xz5z8k67/UNfxpqkktOsus66Le5pfwmnl1UcmJuZTuaGPgXIwSez
         88mfvv+CgwKHpfLpKVHmIzlFD4ukPNExICXP9Qg1DmZQj7Ebs3X1OS4hxFtuFWJb/Qcx
         Z7GAICa6GLBbRs6czaDQhBH7k4eOzoQIMQBsTgRCeT+8QFFGhZL12FD8f6gkhz6g32KR
         3jzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=7uxSiLEd;
       spf=pass (google.com: domain of dougso@me.com designates 17.58.37.18 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=7uxSiLEd;
       spf=pass (google.com: domain of dougso@me.com designates 17.58.37.18 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-02_01:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805020037
From: Doug Oucharek <dougso@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>,
 Doug Oucharek <dougso@me.com>, Doug Oucharek <doug.s.oucharek@intel.com>
Subject: [PATCH] staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5
Date: Tue, 01 May 2018 23:49:18 -0400
Message-id: <1525232958-7410-1-git-send-email-dougso@me.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599322691617744489?=
X-GMAIL-MSGID: =?utf-8?q?1599322691617744489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The FastReg support in ko2iblnd was not unmapping pool items
causing the items to leak.  In addition, the mapping code
is not growing the pool like we do with FMR.

This patch makes sure we are unmapping FastReg pool elements
when we are done with them.  It also makes sure the pool
will grow when we depleat the pool.

Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9472
Reviewed-on: https://review.whamcloud.com/27015
Reviewed-by: Andrew Perepechko <andrew.perepechko@seagate.com>
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |  2 +-
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
index 959e119..cace9ba 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -1702,7 +1702,7 @@ int kiblnd_fmr_pool_map(struct kib_fmr_poolset *fps, struct kib_tx *tx,
 				return 0;
 			}
 			spin_unlock(&fps->fps_lock);
-			rc = -EBUSY;
+			rc = -EAGAIN;
 		}
 
 		spin_lock(&fps->fps_lock);
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index b4a182d..f245481 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -48,7 +48,7 @@ static int kiblnd_init_rdma(struct kib_conn *conn, struct kib_tx *tx, int type,
 			    __u64 dstcookie);
 static void kiblnd_queue_tx_locked(struct kib_tx *tx, struct kib_conn *conn);
 static void kiblnd_queue_tx(struct kib_tx *tx, struct kib_conn *conn);
-static void kiblnd_unmap_tx(struct lnet_ni *ni, struct kib_tx *tx);
+static void kiblnd_unmap_tx(struct kib_tx *tx);
 static void kiblnd_check_sends_locked(struct kib_conn *conn);
 
 static void
@@ -66,7 +66,7 @@ static int kiblnd_init_rdma(struct kib_conn *conn, struct kib_tx *tx, int type,
 	LASSERT(!tx->tx_waiting);	      /* mustn't be awaiting peer response */
 	LASSERT(tx->tx_pool);
 
-	kiblnd_unmap_tx(ni, tx);
+	kiblnd_unmap_tx(tx);
 
 	/* tx may have up to 2 lnet msgs to finalise */
 	lntmsg[0] = tx->tx_lntmsg[0]; tx->tx_lntmsg[0] = NULL;
@@ -591,13 +591,9 @@ static int kiblnd_init_rdma(struct kib_conn *conn, struct kib_tx *tx, int type,
 	return 0;
 }
 
-static void kiblnd_unmap_tx(struct lnet_ni *ni, struct kib_tx *tx)
+static void kiblnd_unmap_tx(struct kib_tx *tx)
 {
-	struct kib_net *net = ni->ni_data;
-
-	LASSERT(net);
-
-	if (net->ibn_fmr_ps)
+	if (tx->fmr.fmr_pfmr || tx->fmr.fmr_frd)
 		kiblnd_fmr_pool_unmap(&tx->fmr, tx->tx_status);
 
 	if (tx->tx_nfrags) {
-- 
1.8.3.1
