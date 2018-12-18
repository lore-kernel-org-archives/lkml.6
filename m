Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C237C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B83521871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2l+xbob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeLRVxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:53:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeLRVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1XlbSivowHq+m0NDfWSX1i1ZxOJt4UdRhFmuJBj0RXg=; b=B2l+xbobAQ2EFCVDJCsXQfuN6O
        /o47tKXYpuICxfvkew5tycCV+JXLCshXpczjScRxVvyEkZ3PAGsiM8firM8fq4QK8BCUQzUv24ZNF
        q0oeBb1N3gviQt3pFRt46xelw8ARakwwC3dW0S73guzlJARYkkQKZz3wGiI9FDRSzc8O4uGvRMc5D
        2Y1qC1CLCErhDN3HIpAr6inIxOd55DYPNrMpk1zB9DF2XwM+uKcZ0xEZMo9QpGR/reRHJXPTCtQNX
        9Sxz5zU6Xdhi4SZlQz2X6vAwvQlRKgyqVPpe8gl4lGATJuRd2WieymevTNIwifsOxrMTx3weQOF29
        /wpvQ6uQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZNIn-0003cg-HB; Tue, 18 Dec 2018 21:53:21 +0000
Date:   Tue, 18 Dec 2018 13:53:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC] Fix failure path in alloc_pid()
Message-ID: <20181218215321.GW10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The failure path removes the allocated PIDs from the wrong namespace.
I believe this is correct, but have not tested it.  Spotted by inspection,
do we have a test suite for PID namespaces?  Some error injection,
perhaps?

Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR API")

diff --git a/kernel/pid.c b/kernel/pid.c
index b2f6c506035da..75264e0d1e71d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -233,8 +233,11 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 
 out_free:
 	spin_lock_irq(&pidmap_lock);
-	while (++i <= ns->level)
-		idr_remove(&ns->idr, (pid->numbers + i)->nr);
+	upid = pid->numbers + i;
+	while (++i <= ns->level) {
+		upid++;
+		idr_remove(&upid->ns->idr, upid->nr);
+	}
 
 	/* On failure to allocate the first pid, reset the state */
 	if (ns->pid_allocated == PIDNS_ADDING)
