Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78B6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C572083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C572083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeIGSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:00:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:59152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbeIGSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:00:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E100AB019;
        Fri,  7 Sep 2018 13:19:06 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] TTY: tty_buffer, warn on leaks
Date:   Fri,  7 Sep 2018 15:19:06 +0200
Message-Id: <20180907131906.12709-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we leak some tty buffer, warn about that. For that we need to
account the memory used also in the tty_buffer_free_all function. On
other locations, the accounting is handled correctly.

Note that we do not account the free list, as that was accounted in
tty_buffer_free before put on the free list.

I have been using this patch for ages, so let's see if anybody else
encounters any issues.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..76151c002858 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -118,9 +118,12 @@ void tty_buffer_free_all(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 	struct tty_buffer *p, *next;
 	struct llist_node *llist;
+	unsigned int freed = 0;
+	int still_used;
 
 	while ((p = buf->head) != NULL) {
 		buf->head = p->next;
+		freed += p->size;
 		if (p->size > 0)
 			kfree(p);
 	}
@@ -132,7 +135,9 @@ void tty_buffer_free_all(struct tty_port *port)
 	buf->head = &buf->sentinel;
 	buf->tail = &buf->sentinel;
 
-	atomic_set(&buf->mem_used, 0);
+	still_used = atomic_xchg(&buf->mem_used, 0);
+	WARN(still_used != freed, "we still have not freed %d bytes!",
+			still_used - freed);
 }
 
 /**
-- 
2.18.0

