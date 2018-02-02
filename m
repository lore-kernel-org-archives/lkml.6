Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2844860-1517590881-2-13236343628956736992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590880; b=IgPtGYuwGvKFLHe6sOr23izJjQSGlvupejCqO2cYFS7Hl2O
    CG88NxYNBV0IFMfxZvn5l4Z2GdGNw3cZMwJ3nOeB0uEU3xM6mcqsBcZm69rKrxw+
    m2b4uk4j5nqBQJ194H6h9+bEMaQ/NEfUzHVn9E8KNYL5t+HxLYW41irIjXEqMeZG
    0eRDDaoUxQF4YTASiWKAxFf8BSiE0Zq6MN9e7+Nwv/Fj5+tJZD7EKLnnbFo53AZk
    d4Ul5Ok9HXtGzkpZGgVTl/9bw6ubDHytrcsQWduGPfB4oeypQON5y9bsJ1h1gOI5
    3PubevZCROxhC6i7y6G0SZhPgHm+t1MIbpk1rYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590880; bh=cuXjsfoKMvVvY5RZjsrEBV0xFW
    M6HiopWgpPsSmUzYA=; b=Yai2LMOEDyCKzvUQClOVfOyWMU898MV0zGLp3gScH9
    Wd98UGYpZG+Ztu49BNKVxLvpy3HlHdr8+FVmPZJEbcWwPZa3PRLLEaFyu55/EfHH
    kGUBEGtso5xdfezDxKARNQjaikm3P6043CeGXsdiHfL559qzd+Aet+Ly/RJx/X0A
    3Jx3ZTmXhk6RjX/J0O1+TeN/sRx7LwahJqAb6m3WWdyXOdFd8b2W4w0LxRhodfI1
    CQ94Dt3LXYyEXnipl2Te3906KSkzjJwx/YFTNCyIknIuZo+0/HKFptHLzAynxVOd
    OuaWHSYtxNnoxe0foXAB17+bhbw2T5gXBUnezolx3OMw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeBBRBR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:01:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbeBBRBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:01:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 42/67] lockd: fix "list_add double add" caused by legacy signal interface
Date: Fri,  2 Feb 2018 17:58:11 +0100
Message-Id: <20180202140820.125721591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6792,6 +6792,10 @@ static int nfs4_state_create_net(struct
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
@@ -6846,9 +6850,6 @@ nfs4_state_start_net(struct net *net)
 	ret = nfs4_state_create_net(net);
 	if (ret)
 		return ret;
-	nn->boot_time = get_seconds();
-	nn->grace_ended = false;
-	nn->nfsd4_manager.block_opens = true;
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
 	printk(KERN_INFO "NFSD: starting %ld-second grace period (net %p)\n",
