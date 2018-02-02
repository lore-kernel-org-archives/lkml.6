Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225KgiE41B8ZxxulVz6N9vlIZ8II4uibQu5eb/7IiEsz2mtZvNXGelKzCiFwEcl3na6T9jL6
ARC-Seal: i=1; a=rsa-sha256; t=1517591085; cv=none;
        d=google.com; s=arc-20160816;
        b=fV4sC3LZIkKRMBM4ClTwwcsXxDp8ZkrLiVere9hA7Hz+nzZYLAvXdDcTfT336nYBe2
         5TSXUM4/+J8hQyV+ughVSbmjA/2iZDagMer6F8MfFN8BKz7OxMvoLNQCUqZlI/vaU1Mv
         pDNGDUCOlstQv+oX1COAZWmz0kdfg/+vJCzivPGOXh4z9u4bMPRUWernhO8Yb9ztlsro
         K3hT3jAUvKVv6DurUM+6nifkb6//hbjo5T9b3Kkm/KwIcl/cLlU8AD4Il5Wj7JnTzj38
         BZDTT1ERtjpdEsW/L/BTnh8daWNAEvPJaj41Q09E7NFICG79pPU8f9XEc6fHx4LiezPm
         Evig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eg4noRI637hcK+yx8QzGzGSlOzw7HvcLrf9PuOwPIL0=;
        b=CPcILndQU9xoRL6hr6zkth0LqZtF4lzL3rC8E5FlI2Oi1n7Hf0ILkeBdueizRsT5cc
         S7gTUBaNPzex5YeVEvY+4kzGW41ZJEdfH2pS6Ir794cswGCFE78r2js3coBmDZG1jsQ7
         hkck18JcbCJVDGF0CXq7eoWdp/hx633ZBX2gOutaOGgAWu6zZhS2yxWUjZ0wF8uR7Opd
         dCIdRjxgkS4/zMakZgCRkgV1ucQICy3hviIAUauQnIvXCwTJi8tILVC9gkYexSwaOwai
         y4a2YQR+o2AKeuoNjDY65ooVQEkAjnUkGdFgBK0is1M1a0rneXF6ZgVDLPw7o4F1ATMv
         E49A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeff Layton <jlayton@redhat.com>,
	Vasily Averin <vvs@virtuozzo.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 45/86] lockd: fix "list_add double add" caused by legacy signal interface
Date: Fri,  2 Feb 2018 17:58:05 +0100
Message-Id: <20180202140826.475645847@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309364374629787?=
X-GMAIL-MSGID: =?utf-8?q?1591309589739147004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>


[ Upstream commit 81833de1a46edce9ca20cfe079872ac1c20ef359 ]

restart_grace() uses hardcoded init_net.
It can cause to "list_add double add" in following scenario:

1) nfsd and lockd was started in several net namespaces
2) nfsd in init_net was stopped (lockd was not stopped because
 it have users from another net namespaces)
3) lockd got signal, called restart_grace() -> set_grace_period()
 and enabled lock_manager in hardcoded init_net.
4) nfsd in init_net is started again,
 its lockd_up() calls set_grace_period() and tries to add
 lock_manager into init_net 2nd time.

Jeff Layton suggest:
"Make it safe to call locks_start_grace multiple times on the same
lock_manager. If it's already on the global grace_list, then don't try
to add it again.  (But we don't intentionally add twice, so for now we
WARN about that case.)

With this change, we also need to ensure that the nfsd4 lock manager
initializes the list before we call locks_start_grace. While we're at
it, move the rest of the nfsd_net initialization into
nfs4_state_create_net. I see no reason to have it spread over two
functions like it is today."

Suggested patch was updated to generate warning in described situation.

Suggested-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs_common/grace.c |    6 +++++-
 fs/nfsd/nfs4state.c   |    7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -30,7 +30,11 @@ locks_start_grace(struct net *net, struc
 	struct list_head *grace_list = net_generic(net, grace_net_id);
 
 	spin_lock(&grace_lock);
-	list_add(&lm->list, grace_list);
+	if (list_empty(&lm->list))
+		list_add(&lm->list, grace_list);
+	else
+		WARN(1, "double list_add attempt detected in net %x %s\n",
+		     net->ns.inum, (net == &init_net) ? "(init_net)" : "");
 	spin_unlock(&grace_lock);
 }
 EXPORT_SYMBOL_GPL(locks_start_grace);
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7012,6 +7012,10 @@ static int nfs4_state_create_net(struct
 		INIT_LIST_HEAD(&nn->sessionid_hashtbl[i]);
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
+	nn->boot_time = get_seconds();
+	nn->grace_ended = false;
+	nn->nfsd4_manager.block_opens = true;
+	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
 	INIT_LIST_HEAD(&nn->close_lru);
 	INIT_LIST_HEAD(&nn->del_recall_lru);
@@ -7069,9 +7073,6 @@ nfs4_state_start_net(struct net *net)
 	ret = nfs4_state_create_net(net);
 	if (ret)
 		return ret;
-	nn->boot_time = get_seconds();
-	nn->grace_ended = false;
-	nn->nfsd4_manager.block_opens = true;
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
 	printk(KERN_INFO "NFSD: starting %ld-second grace period (net %p)\n",
