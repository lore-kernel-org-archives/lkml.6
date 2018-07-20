Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAB3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD65E20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD65E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbeGTNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbeGTNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:09 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 013DCBBD;
        Fri, 20 Jul 2018 12:26:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2b43f681169a2a0d306a@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 26/29] netfilter: ebtables: reject non-bridge targets
Date:   Fri, 20 Jul 2018 14:11:21 +0200
Message-Id: <20180720115159.913538479@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 11ff7288beb2b7da889a014aff0a7b80bf8efcf3 upstream.

the ebtables evaluation loop expects targets to return
positive values (jumps), or negative values (absolute verdicts).

This is completely different from what xtables does.
In xtables, targets are expected to return the standard netfilter
verdicts, i.e. NF_DROP, NF_ACCEPT, etc.

ebtables will consider these as jumps.

Therefore reject any target found due to unspec fallback.
v2: also reject watchers.  ebtables ignores their return value, so
a target that assumes skb ownership (and returns NF_STOLEN) causes
use-after-free.

The only watchers in the 'ebtables' front-end are log and nflog;
both have AF_BRIDGE specific wrappers on kernel side.

Reported-by: syzbot+2b43f681169a2a0d306a@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -402,6 +402,12 @@ ebt_check_watcher(struct ebt_entry_watch
 	watcher = xt_request_find_target(NFPROTO_BRIDGE, w->u.name, 0);
 	if (IS_ERR(watcher))
 		return PTR_ERR(watcher);
+
+	if (watcher->family != NFPROTO_BRIDGE) {
+		module_put(watcher->me);
+		return -ENOENT;
+	}
+
 	w->u.watcher = watcher;
 
 	par->target   = watcher;
@@ -722,6 +728,13 @@ ebt_check_entry(struct ebt_entry *e, str
 		goto cleanup_watchers;
 	}
 
+	/* Reject UNSPEC, xtables verdicts/return values are incompatible */
+	if (target->family != NFPROTO_BRIDGE) {
+		module_put(target->me);
+		ret = -ENOENT;
+		goto cleanup_watchers;
+	}
+
 	t->u.target = target;
 	if (t->u.target == &ebt_standard_target) {
 		if (gap < sizeof(struct ebt_standard_target)) {


