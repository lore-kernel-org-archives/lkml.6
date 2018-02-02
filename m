Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2243jExu81P5x0v5B+8H60Dw7y+QpJm4lvZsNFaP5GJgg3C1k3ofPpWQMNyo3+U1N36lMXY9
ARC-Seal: i=1; a=rsa-sha256; t=1517591470; cv=none;
        d=google.com; s=arc-20160816;
        b=SgfjgmTarlhQl9B+rsIHok3amYIOragYObopETOfqRktU4oJF0rRNRScMkWXxwVcsd
         B91XqBZx2gma94EXgoMTks7yhOBiPwxx+u9AwZD77gEkbZn+WR00nWl1U7Si+llUePMr
         uDPEjxM+nadxEgmU6dZW7Du+VnNUVMaznAfaK40A1e0IhYHfG269EOfUpV7VXQsVV1FC
         YuX5qnLhZ99GjezqIRrwlDtJNKzD7IAhIEJLxPkNknGNrWZVGzW2WWJMNtTeL/OCPB1A
         5aP7q9uiVRemmrsceboWOp/ZLH5iTMg0aZjV04pcaX5fuvuipf2SaOHJC21G5foMgJ3I
         XOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IEksBJMuhkkavryFyp/v3Ni0C0VEr3lYc1DAJ4i5D3g=;
        b=cS810NOHeKN3cZfhq39gAVZUqftlsKxQg5GX5S1SfwAdncG86B873y4SI6pWTk7SFv
         zHglOlMP6Ls1mli4qWToUncW2As4H0RBV3Akscwd2Zl8WASoO26ph3nF3l3KsOqqzYFL
         htM8C/Zu9xTRhlPi71x8PBSwvl3sM/3faR0tyuXj65kuPvP0SQ/iFf4G/21WmgNoBtCo
         l7rAPkis1Wx6MXbZuLXhjPsgeoCkER9OikH/4PkJMqXZPHguPIDVNR4I5qWebEyumC5F
         /n0gPMnEYSiY/qaysuPd1IrAK+xcyhDTGhtCI+Ig6lYdOq9sUPfkKeVSnDsEVIJoCOeg
         yZgQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 090/156] lockd: fix "list_add double add" caused by legacy signal interface
Date: Fri,  2 Feb 2018 17:57:51 +0100
Message-Id: <20180202140844.318445757@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309364374629787?=
X-GMAIL-MSGID: =?utf-8?q?1591309993372930329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
@@ -7021,6 +7021,10 @@ static int nfs4_state_create_net(struct
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
@@ -7078,9 +7082,6 @@ nfs4_state_start_net(struct net *net)
 	ret = nfs4_state_create_net(net);
 	if (ret)
 		return ret;
-	nn->boot_time = get_seconds();
-	nn->grace_ended = false;
-	nn->nfsd4_manager.block_opens = true;
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
 	printk(KERN_INFO "NFSD: starting %ld-second grace period (net %p)\n",
