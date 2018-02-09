Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184246-2-17353342523574998228
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
    t=1518184246; b=mAQQauPbbx47fLQx5nJfJS/WcNOLt7YPs4jb7wTMGzXcVZg
    xDNF91m5mOxtAMV13tDtPfvwS9SXh/2u9FSK51VLL4mldOitUnrDPdtU+zDECO2s
    dt9tx9QHVhTXc/f5hzZUNb80YJodRrJfoGjRwifeGIN5mORL+hpSLnTk+nUEbwV0
    5+Cpbuk7+NEgUakNs5Ri7xGomqWV954ljhpiPZGqHWIJkSxVXw1yylPNPIuxrfwg
    PwG6Rod3FnyJlny/Rqg7TM3KHg0QHrjNnSjQ/LqT5BSlcW3OyXHqirI8KbBeeANn
    c+lDfLlWETiSVAJF35QuX4/10Em/H0BdWODGL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184246; bh=oPudeEDLzGc6jJctn6y4X+cjPS
    3ReDRekb892P5ZZWw=; b=wlAa8eqzOw/cL7/xomOrW0v1aAa30dB+aRC9hPyk2S
    vS4xhc0ZEzEdpKiqWV1PQif23thsknVXDRLJ+xqQnvpSYu+kcQXRUhaS3NMtMKS3
    SPLVM+z4cMZ3vLD7BmmpgtNfLlww75fMHiypsZe+4XczPwHB9X+1YL8N/l+pkLD+
    0fxjQdRv0BVqZ82gYtTto/r9GUoRzrC+qzR2nCrx55MxxzuEQ/+sQPgwJPKZroiv
    0k59Q+8YIDxgck2MZEpCgiil+aZV1dHvfALbwgguGVFX9vQwGZoujtlXzUFsAzln
    7zOX1gonImecQWHF94l105J68CX0V3yMmhnb0uLyYemA==
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
        id S1752210AbeBINu2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:50:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeBINqd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 17/23] net_sched: get rid of rcu_barrier() in tcf_block_put_ext()
Date: Fri,  9 Feb 2018 14:40:15 +0100
Message-Id: <20180209133939.183041389@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit efbf78973978b0d25af59bc26c8013a942af6e64 ]

Both Eric and Paolo noticed the rcu_barrier() we use in
tcf_block_put_ext() could be a performance bottleneck when
we have a lot of tc classes.

Paolo provided the following to demonstrate the issue:

tc qdisc add dev lo root htb
for I in `seq 1 1000`; do
        tc class add dev lo parent 1: classid 1:$I htb rate 100kbit
        tc qdisc add dev lo parent 1:$I handle $((I + 1)): htb
        for J in `seq 1 10`; do
                tc filter add dev lo parent $((I + 1)): u32 match ip src 1.1.1.$J
        done
done
time tc qdisc del dev root

real    0m54.764s
user    0m0.023s
sys     0m0.000s

The rcu_barrier() there is to ensure we free the block after all chains
are gone, that is, to queue tcf_block_put_final() at the tail of workqueue.
We can achieve this ordering requirement by refcnt'ing tcf block instead,
that is, the tcf block is freed only when the last chain in this block is
gone. This also simplifies the code.

Paolo reported after this patch we get:

real    0m0.017s
user    0m0.000s
sys     0m0.017s

Tested-by: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sch_generic.h |    1 -
 net/sched/cls_api.c       |   30 +++++++++---------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -280,7 +280,6 @@ struct tcf_block {
 	struct net *net;
 	struct Qdisc *q;
 	struct list_head cb_list;
-	struct work_struct work;
 };
 
 static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -217,8 +217,12 @@ static void tcf_chain_flush(struct tcf_c
 
 static void tcf_chain_destroy(struct tcf_chain *chain)
 {
+	struct tcf_block *block = chain->block;
+
 	list_del(&chain->list);
 	kfree(chain);
+	if (list_empty(&block->chain_list))
+		kfree(block);
 }
 
 static void tcf_chain_hold(struct tcf_chain *chain)
@@ -329,27 +333,13 @@ int tcf_block_get(struct tcf_block **p_b
 }
 EXPORT_SYMBOL(tcf_block_get);
 
-static void tcf_block_put_final(struct work_struct *work)
-{
-	struct tcf_block *block = container_of(work, struct tcf_block, work);
-	struct tcf_chain *chain, *tmp;
-
-	rtnl_lock();
-
-	/* At this point, all the chains should have refcnt == 1. */
-	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
-		tcf_chain_put(chain);
-	rtnl_unlock();
-	kfree(block);
-}
-
 /* XXX: Standalone actions are not allowed to jump to any chain, and bound
  * actions should be all removed after flushing.
  */
 void tcf_block_put_ext(struct tcf_block *block, struct Qdisc *q,
 		       struct tcf_block_ext_info *ei)
 {
-	struct tcf_chain *chain;
+	struct tcf_chain *chain, *tmp;
 
 	if (!block)
 		return;
@@ -365,13 +355,11 @@ void tcf_block_put_ext(struct tcf_block
 
 	tcf_block_offload_unbind(block, q, ei);
 
-	INIT_WORK(&block->work, tcf_block_put_final);
-	/* Wait for existing RCU callbacks to cool down, make sure their works
-	 * have been queued before this. We can not flush pending works here
-	 * because we are holding the RTNL lock.
+	/* At this point, all the chains should have refcnt >= 1. Block will be
+	 * freed after all chains are gone.
 	 */
-	rcu_barrier();
-	tcf_queue_work(&block->work);
+	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
+		tcf_chain_put(chain);
 }
 EXPORT_SYMBOL(tcf_block_put_ext);
 
