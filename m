Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78164C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5AC2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMySgBV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeL1PWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:22:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeL1PWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H2t6kpv/7ELC6g+0Aj56ZGQgYu7+R4jpQaq2RmwH740=; b=TMySgBV6duFY+A4vJA2Dq/Sb2
        1H3W+iln2j1Uz4YaHoe/G6NQG1BbmrAGJuML96xR6eAXLJyed2cipltN6MsQSOIo3ysxVBcwaujOk
        dczF0j2LxAyrR5LBbKEBqanw6ECcabBw/ihTmgdbfzob/Sjx64x/uPgxjNd6zWSoqrRX2xGv/m2zZ
        gLwRRy8P/PE7Ixcm7fapLFk8rgA6UtYAK2kY21BfZIz9pDalsvGOz0nAgqZV+kmTvJUm7IhsfrWQm
        LItqQZonOM2pZ3cVc7JekjE1Z+viqAuRYNFh30dobEIQEtsyPcq9bmW94DzBKz1XFsWBnu1AXTIdr
        let7XV84A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcty9-0002bM-OD; Fri, 28 Dec 2018 15:22:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: [PATCH] Fix failure path in alloc_pid()
Date:   Fri, 28 Dec 2018 07:22:26 -0800
Message-Id: <20181228152226.9897-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The failure path removes the allocated PIDs from the wrong namespace.
This could lead to us inadvertently reusing PIDs in the leaf namespace
and leaking PIDs in parent namespaces.

Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index b2f6c506035da..20881598bdfac 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -233,8 +233,10 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 
 out_free:
 	spin_lock_irq(&pidmap_lock);
-	while (++i <= ns->level)
-		idr_remove(&ns->idr, (pid->numbers + i)->nr);
+	while (++i <= ns->level) {
+		upid = pid->numbers + i;
+		idr_remove(&upid->ns->idr, upid->nr);
+	}
 
 	/* On failure to allocate the first pid, reset the state */
 	if (ns->pid_allocated == PIDNS_ADDING)
-- 
2.19.2

