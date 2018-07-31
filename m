Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE53C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0896320870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0896320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbeGaVxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:53:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732659AbeGaVxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:53:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B8887DAC2;
        Tue, 31 Jul 2018 20:11:49 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 795AC2026D7E;
        Tue, 31 Jul 2018 20:11:46 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     luto@kernel.org, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 (was ghak32) V4 09/10] audit: NETFILTER_PKT: record each container ID associated with a netNS
Date:   Tue, 31 Jul 2018 16:07:44 -0400
Message-Id: <3f5edfb0d530d7f0061fe11b817b315b350b9d86.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 20:11:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 20:11:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audit container identifier auxiliary record(s) to NETFILTER_PKT
event standalone records.  Iterate through all potential audit container
identifiers associated with a network namespace.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h    |  5 +++++
 kernel/audit.c           | 26 ++++++++++++++++++++++++++
 net/netfilter/xt_AUDIT.c | 12 ++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 9a02095..8755f4d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -169,6 +169,8 @@ extern int audit_log_contid(struct audit_context *context,
 extern void audit_netns_contid_add(struct net *net, u64 contid);
 extern void audit_netns_contid_del(struct net *net, u64 contid);
 extern void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p);
+extern void audit_log_netns_contid_list(struct net *net,
+				 struct audit_context *context);
 
 extern int		    audit_update_lsm_rules(void);
 
@@ -228,6 +230,9 @@ static inline void audit_netns_contid_del(struct net *net, u64 contid)
 { }
 static inline void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
 { }
+static inline void audit_log_netns_contid_list(struct net *net,
+					struct audit_context *context)
+{ }
 
 #define audit_enabled AUDIT_OFF
 #endif /* CONFIG_AUDIT */
diff --git a/kernel/audit.c b/kernel/audit.c
index c5fed3b..b23711c 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -392,6 +392,32 @@ void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
 		audit_netns_contid_add(new->net_ns, contid);
 }
 
+void audit_log_netns_contid_list(struct net *net, struct audit_context *context)
+{
+	spinlock_t *lock = audit_get_netns_contid_list_lock(net);
+	struct audit_buffer *ab;
+	struct audit_contid *cont;
+	bool first = true;
+
+	/* Generate AUDIT_CONTAINER record with container ID CSV list */
+	ab = audit_log_start(context, GFP_ATOMIC, AUDIT_CONTAINER);
+	if (!ab) {
+		audit_log_lost("out of memory in audit_log_netns_contid_list");
+		return;
+	}
+	audit_log_format(ab, "contid=");
+	spin_lock(lock);
+	list_for_each_entry(cont, audit_get_netns_contid_list(net), list) {
+		if (!first)
+			audit_log_format(ab, ",");
+		audit_log_format(ab, "%llu", cont->id);
+		first = false;
+	}
+	spin_unlock(lock);
+	audit_log_end(ab);
+}
+EXPORT_SYMBOL(audit_log_netns_contid_list);
+
 void audit_panic(const char *message)
 {
 	switch (audit_failure) {
diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
index af883f1..44fac3f 100644
--- a/net/netfilter/xt_AUDIT.c
+++ b/net/netfilter/xt_AUDIT.c
@@ -71,10 +71,13 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 {
 	struct audit_buffer *ab;
 	int fam = -1;
+	struct audit_context *context;
+	struct net *net;
 
 	if (audit_enabled == AUDIT_OFF)
-		goto errout;
-	ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
+		goto out;
+	context = audit_alloc_local(GFP_ATOMIC);
+	ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
 	if (ab == NULL)
 		goto errout;
 
@@ -104,7 +107,12 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 
 	audit_log_end(ab);
 
+	net = xt_net(par);
+	audit_log_netns_contid_list(net, context);
+
 errout:
+	audit_free_context(context);
+out:
 	return XT_CONTINUE;
 }
 
-- 
1.8.3.1

