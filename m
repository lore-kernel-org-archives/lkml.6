Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28398214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28398214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeHUNOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:14:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeHUNOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:14:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13E25402178A;
        Tue, 21 Aug 2018 09:55:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8289D10CD63A;
        Tue, 21 Aug 2018 09:55:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] vfs: Fix fs_context logging when there's no log
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:55:12 +0100
Message-ID: <153484531201.1183.24087901695718354.stgit@warthog.procyon.org.uk>
In-Reply-To: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
References: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 21 Aug 2018 09:55:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 21 Aug 2018 09:55:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an fs_context-based mount is called from mount(2) or some other place
that doesn't set up the logging-through-fd, then under some circumstances
an oops will occur due to the log being unconditionally accessed in
logfc().

Fix this by checking whether there is a log structure before attempting to
access it

Fixes: 06b830edff9f ("vfs: Implement logging through fs_context")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_context.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 14921b2c1e42..053b8d0f11ea 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -416,7 +416,7 @@ void logfc(struct fs_context *fc, const char *fmt, ...)
 	if ((unsigned long)p >= (unsigned long)__start_rodata &&
 	    (unsigned long)p <  (unsigned long)__end_rodata)
 		goto const_string;
-	if (within_module_core((unsigned long)p, log->owner))
+	if (log && within_module_core((unsigned long)p, log->owner))
 		goto const_string;
 	q = kstrdup(p, GFP_KERNEL);
 	goto copied_string;

