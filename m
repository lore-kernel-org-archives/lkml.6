Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B13C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2716A208C2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkvuF6q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2716A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeHUM7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbeHUM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:59:46 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0950F208C2;
        Tue, 21 Aug 2018 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534844421;
        bh=ZV9XKErW3tHvlI0e+o5r9FyzEpBk0dA3x0DhP3MmBZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkvuF6q4R/RIKIcrUUsm436P9cUA0gkyZPhLaCXex4RYVQTpHTgm9j+r4f1tkXdR5
         hTvyLeshsZv3TWOp20s8wZZ2zC0L4vd/UVSU5yqDEgYyQlyhR1Lz05vzfP05BezdTP
         e63wK27iz23UBgP50o4lV6+WyNqkUfW67xOkvyzc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip 5/5] kprobes: Don't call BUG_ON if there is a kprobe in use on free list
Date:   Tue, 21 Aug 2018 18:39:58 +0900
Message-Id: <153484439807.5385.8446592533176849097.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153484425558.5385.1484910606397784412.stgit@devbox>
References: <153484425558.5385.1484910606397784412.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling BUG_ON, if we find a kprobe in use on free kprobe
list, just remove it from the list and keep it on kprobe hash list
as same as other in-use kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 63c342e5e6c3..e3420364b415 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -546,8 +546,14 @@ static void do_free_cleaned_kprobes(void)
 	struct optimized_kprobe *op, *tmp;
 
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
-		BUG_ON(!kprobe_unused(&op->kp));
 		list_del_init(&op->list);
+		if (!kprobe_unused(&op->kp)) {
+			/*
+			 * This must not happen, but if there is a kprobe
+			 * still in use, keep it on kprobes hash list.
+			 */
+			continue;
+		}
 		free_aggr_kprobe(&op->kp);
 	}
 }

