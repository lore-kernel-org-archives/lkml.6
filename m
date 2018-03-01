Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELt+YjWFazpsJoZk7J2LAq/pSczYJ6ieu4t2GoB+SI7YSbSM0MLEU8ngQD1u4s/hXiV9ToVl
ARC-Seal: i=1; a=rsa-sha256; t=1519947176; cv=none;
        d=google.com; s=arc-20160816;
        b=fNE0NwGJ5X07z53qwoKdeVOGsJ7ntrt6rEvZq5WHVaH8KivhlnON7TRhOiu+QrEd9j
         Lt7HT+g+10TcXL+QiQBSP7RzFdifdf714tNh4SmfC268Hh1N8+DQBq3NlVP5N+v048ly
         iuTcC9TLDi4lGn2JR/dGltnU7VBL9qu0Ru7+QQqPxTicJ3B2DPC9ftmeYsIIE3sCIgAX
         KDej9UtyRqy9WQPeTVSWeS+AbN7qx9V80lvWOuICHJFs/LnJh0daHKqG6kWdChEiptw9
         7eW8H+4iXI/laFocrbfWzgKuulGD7pjqC9ebWMNjsR775v3WRaF+dXyngl1GMdWhwjd3
         6iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=mxLM93VhIfqoY2QEm1ryNNMOcZtDnfofk3CVcudLKeo=;
        b=BVVybY/MvQ2BCryxcvWHb/trr4SJb+XAqLl7QtEhg5BsqgQzgbEWFEqyq5f6v3NE3Z
         j82vhVxtqCXKZULVlCsORBgsSISoH8u19x+2RQjVnif3igNs/kEwjVudAH8r7SxDfZQZ
         nznzv5Ivamy4if8XGuA2+wpJPNjJxezxaxw1RWpO+GoGYh09K0sY9cwXUawqsRT7YJW+
         Gp1mhXEQcq2QHYle2D9CCXzaqJCTrAVz2Ps/C5rFq8dveh2eLy9AN9M+Hj8t28aJIw3L
         B6hDgoXDaQH/XT50tH1rgSX6NOR3x0ONUhtvXmpqXbWSMtXGwEHEVPQGKelVA4hcW+mG
         9FPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 06/17] staging: lustre: get entropy from nid when nid set.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708524.7628.17942703834112140684.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780130364339190?=
X-GMAIL-MSGID: =?utf-8?q?1593780130364339190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the 'lustre' module is loaded, it gets a list of
net devices and uses the node ids to  add entropy
to the prng.  This means that the network interfaces need
to be configured before the module is loaded, which prevents
the module from being compiled into a monolithic kernel.

So move this entropy addition to the moment when
the interface is imported to LNet and the node id is first known.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lnet/lnet/api-ni.c     |    7 +++++++
 drivers/staging/lustre/lustre/llite/super25.c |   17 +----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/lustre/lnet/lnet/api-ni.c b/drivers/staging/lustre/lnet/lnet/api-ni.c
index 48d25ccadbb3..90266be0132d 100644
--- a/drivers/staging/lustre/lnet/lnet/api-ni.c
+++ b/drivers/staging/lustre/lnet/lnet/api-ni.c
@@ -1214,6 +1214,7 @@ lnet_startup_lndni(struct lnet_ni *ni, struct lnet_ioctl_config_data *conf)
 	struct lnet_lnd *lnd;
 	struct lnet_tx_queue *tq;
 	int i;
+	u32 seed;
 
 	lnd_type = LNET_NETTYP(LNET_NIDNET(ni->ni_nid));
 
@@ -1352,6 +1353,12 @@ lnet_startup_lndni(struct lnet_ni *ni, struct lnet_ioctl_config_data *conf)
 		tq->tq_credits = lnet_ni_tq_credits(ni);
 	}
 
+	/* Nodes with small feet have little entropy. The NID for this
+	 * node gives the most entropy in the low bits.
+	 */
+	seed = LNET_NIDADDR(ni->ni_nid);
+	add_device_randomness(&seed, sizeof(seed));
+
 	CDEBUG(D_LNI, "Added LNI %s [%d/%d/%d/%d]\n",
 	       libcfs_nid2str(ni->ni_nid), ni->ni_peertxcredits,
 	       lnet_ni_tq_credits(ni) * LNET_CPT_NUMBER,
diff --git a/drivers/staging/lustre/lustre/llite/super25.c b/drivers/staging/lustre/lustre/llite/super25.c
index 9b0bb3541a84..861e7a60f408 100644
--- a/drivers/staging/lustre/lustre/llite/super25.c
+++ b/drivers/staging/lustre/lustre/llite/super25.c
@@ -85,8 +85,7 @@ MODULE_ALIAS_FS("lustre");
 
 static int __init lustre_init(void)
 {
-	struct lnet_process_id lnet_id;
-	int i, rc;
+	int rc;
 
 	BUILD_BUG_ON(sizeof(LUSTRE_VOLATILE_HDR) !=
 		     LUSTRE_VOLATILE_HDR_LEN + 1);
@@ -125,20 +124,6 @@ static int __init lustre_init(void)
 		goto out_debugfs;
 	}
 
-	/* Nodes with small feet have little entropy. The NID for this
-	 * node gives the most entropy in the low bits
-	 */
-	for (i = 0;; i++) {
-		u32 seed;
-
-		if (LNetGetId(i, &lnet_id) == -ENOENT)
-			break;
-		if (LNET_NETTYP(LNET_NIDNET(lnet_id.nid)) != LOLND) {
-			 seed = LNET_NIDADDR(lnet_id.nid);
-			 add_device_randomness(&seed, sizeof(seed));
-		}
-	}
-
 	rc = vvp_global_init();
 	if (rc != 0)
 		goto out_sysfs;
