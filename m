Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECC5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C9A2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C9A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbeGJSb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:31:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGJSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:31:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7AA0EEC7;
        Tue, 10 Jul 2018 18:31:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 51/52] netfilter: nf_log: dont hold nf_log_mutex during user access
Date:   Tue, 10 Jul 2018 20:25:19 +0200
Message-Id: <20180710182454.060336361@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit ce00bf07cc95a57cd20b208e02b3c2604e532ae8 upstream.

The old code would indefinitely block other users of nf_log_mutex if
a userspace access in proc_dostring() blocked e.g. due to a userfaultfd
region. Fix it by moving proc_dostring() out of the locked region.

This is a followup to commit 266d07cb1c9a ("netfilter: nf_log: fix
sleeping function called from invalid context"), which changed this code
from using rcu_read_lock() to taking nf_log_mutex.

Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_log.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -444,14 +444,17 @@ static int nf_log_proc_dostring(struct c
 		rcu_assign_pointer(net->nf.nf_loggers[tindex], logger);
 		mutex_unlock(&nf_log_mutex);
 	} else {
+		struct ctl_table tmp = *table;
+
+		tmp.data = buf;
 		mutex_lock(&nf_log_mutex);
 		logger = nft_log_dereference(net->nf.nf_loggers[tindex]);
 		if (!logger)
-			table->data = "NONE";
+			strlcpy(buf, "NONE", sizeof(buf));
 		else
-			table->data = logger->name;
-		r = proc_dostring(table, write, buffer, lenp, ppos);
+			strlcpy(buf, logger->name, sizeof(buf));
 		mutex_unlock(&nf_log_mutex);
+		r = proc_dostring(&tmp, write, buffer, lenp, ppos);
 	}
 
 	return r;


