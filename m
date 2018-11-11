Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93EBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B1B2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B1B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbeKLGFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53050 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731042AbeKLGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsx-0000oJ-03; Sun, 11 Nov 2018 19:59:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001dj-GD; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jann Horn" <jannh@google.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.678488403@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 200/366] netfilter: nf_log: don't hold nf_log_mutex
 during user access
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nf_log.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -273,15 +273,18 @@ static int nf_log_proc_dostring(struct c
 		rcu_assign_pointer(net->nf.nf_loggers[tindex], logger);
 		mutex_unlock(&nf_log_mutex);
 	} else {
+		struct ctl_table tmp = *table;
+
+		tmp.data = buf;
 		mutex_lock(&nf_log_mutex);
 		logger = rcu_dereference_protected(net->nf.nf_loggers[tindex],
 						   lockdep_is_held(&nf_log_mutex));
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

