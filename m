Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227S0cCNqmuqQx6j3T5+5WCZjB7AAbh4JnaMcqpbh3a05Ky9TDvHQG/COdqlGhxy3N1AgAn6
ARC-Seal: i=1; a=rsa-sha256; t=1519093522; cv=none;
        d=google.com; s=arc-20160816;
        b=lA4fTLvB+VVlnlSZD3WNKPb/Ct0PKULobG1XEaVCbtG53xdgUdVktnmxrtisjJ9wA/
         84I7grBdw3sKnt3MFTQFOgrZVkD4xqD1pV5SpnOzwJdrunSHA1IqskmOM6SzFFpeaHBV
         hW810NzkMn18jR8FX1J5OTfHK+O68YlxaDFJnkFVXJwV5qu71r1aCPd/N//xZF04jsVz
         RrXsyGyrsJvAYxVZargKRP0ta7nmVgHtYh37igzui5kLrQJfNNpXvyyGgMKBRLazRGc1
         7RKUepEJ5MxpBnZMHxcbTarssQFwhqcX4MD1Z4nStOVbIAYF/qj9O90QvwzsB5f2cmrj
         83ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=un2eBtGOiKtmjutCvPFeYqFSn6Ns60BXC3beTGXk+rc=;
        b=eZByOgAMkXjY+DwQmfum3wWfSW3kdl3pedygHpK37W060l9cgB9OTjXaVB1DcUn3F3
         r7zVwWql2zAitUf1Qu3OLKbley1SgIf7AUmhLQXCv5XcoIDm2yXOQZ5qOPwWC9Jo48s0
         XcJzgL1IygdvmFG+TQAj2xkcHfRZOZpdDgPb9eP5WdoUhgsSDSJF1fxU6XLEVcoaTKnp
         AriwjJkMoDFlHZtJM9IhZBh5kdAkGX66NbZIG5l+7QOegzDsN8f25Tp1Jf2PfKNT9u5c
         kpvroOkVa9FLZVHwYS7+bJghwjnB8+DvfPH5imII5vOE/rMOdhngSE9xkYhqD4eveixP
         S47A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:37 +1100
Subject: [PATCH 09/21] staging: lustre: discard libcfs_kvzalloc_cpt()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341783.25814.12309771139592565643.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885009379681902?=
X-GMAIL-MSGID: =?utf-8?q?1592885009379681902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This function is used precisely once, and is sufficiently
trivial that it may as well be open-coded.

Doing so helpfully highlights the similarity
between the new kvzalloc_node() call and the already existing
kzalloc_node() call in the same function.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    2 --
 .../staging/lustre/lnet/libcfs/linux/linux-mem.c   |    7 -------
 drivers/staging/lustre/lustre/ptlrpc/service.c     |    8 ++++----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 4f8c65e6d883..039205763021 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -113,8 +113,6 @@ static inline void *__container_of(void *ptr, unsigned long shift)
 #define _LIBCFS_H
 
 void *libcfs_kvzalloc(size_t size, gfp_t flags);
-void *libcfs_kvzalloc_cpt(struct cfs_cpt_table *cptab, int cpt, size_t size,
-			  gfp_t flags);
 
 extern struct miscdevice libcfs_dev;
 /**
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c
index 963df0ef4afb..f2c001bac303 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c
@@ -42,10 +42,3 @@ void *libcfs_kvzalloc(size_t size, gfp_t flags)
 	return ret;
 }
 EXPORT_SYMBOL(libcfs_kvzalloc);
-
-void *libcfs_kvzalloc_cpt(struct cfs_cpt_table *cptab, int cpt, size_t size,
-			  gfp_t flags)
-{
-	return kvzalloc_node(size, flags, cfs_cpt_spread_node(cptab, cpt));
-}
-EXPORT_SYMBOL(libcfs_kvzalloc_cpt);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/staging/lustre/lustre/ptlrpc/service.c
index 29fdb54f16ca..57e41e2cd30a 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/service.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
@@ -83,10 +83,10 @@ ptlrpc_alloc_rqbd(struct ptlrpc_service_part *svcpt)
 	rqbd->rqbd_cbid.cbid_fn = request_in_callback;
 	rqbd->rqbd_cbid.cbid_arg = rqbd;
 	INIT_LIST_HEAD(&rqbd->rqbd_reqs);
-	rqbd->rqbd_buffer = libcfs_kvzalloc_cpt(svc->srv_cptable,
-						svcpt->scp_cpt,
-						svc->srv_buf_size,
-						GFP_KERNEL);
+	rqbd->rqbd_buffer = kvzalloc_node(svc->srv_buf_size, GFP_KERNEL,
+					  cfs_cpt_spread_node(svc->srv_cptable,
+							      svcpt->scp_cpt));
+
 	if (!rqbd->rqbd_buffer) {
 		kfree(rqbd);
 		return NULL;
