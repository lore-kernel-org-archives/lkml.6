Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E87C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBAC2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBELvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:51:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfBELvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:51:45 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 06:51:44 EST
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 975A540200A8;
        Tue,  5 Feb 2019 11:46:06 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7BF2026DE4;
        Tue,  5 Feb 2019 11:46:05 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, yamato@redhat.com
Subject: [PATCH RESEND] eventfd: prepare id to userspace via fdinfo
Date:   Tue,  5 Feb 2019 20:46:00 +0900
Message-Id: <20190205114600.3182-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 05 Feb 2019 11:46:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 05 Feb 2019 11:46:06 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding endpoints of an IPC channel is one of essential task to
understand how a user program works. Procfs and netlink socket provide
enough hints to find endpoints for IPC channels like pipes, unix
sockets, and pseudo terminals. However, there is no simple way to find
endpoints for an eventfd file from userland. An inode number doesn't
hint. Unlike pipe, all eventfd files share the same inode object.

To provide the way to find endpoints of an eventfd file, this patch
adds "eventfd-id" field to fdinfo of eventfd as identifier. Address
for eventfd context is used as id. Typical applicaiton utilizing
the information is lsof.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 fs/eventfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 08d3bd602f73..fc63ad43d962 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -297,6 +297,7 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 	seq_printf(m, "eventfd-count: %16llx\n",
 		   (unsigned long long)ctx->count);
 	spin_unlock_irq(&ctx->wqh.lock);
+	seq_printf(m, "eventfd-id: %p\n", ctx);
 }
 #endif
 
-- 
2.17.2

