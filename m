Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047EC20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047EC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeIHDib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:38:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeIHDib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:38:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E04DF401EF3F;
        Fri,  7 Sep 2018 22:55:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D544A9E8A;
        Fri,  7 Sep 2018 22:55:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix cell specification to permit an empty address list
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Sep 2018 23:55:17 +0100
Message-ID: <153636091769.18957.14379129624965539718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 22:55:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 22:55:18 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the cell specification mechanism to allow cells to be pre-created
without having to specify at least one address (the addresses will be
upcalled for).

This allows the cell information preload service to avoid the need to issue
loads of DNS lookups during boot to get the addresses for each cell (500+
lookups for the 'standard' cell list[*]).  The lookups can be done later as
each cell is accessed through the filesystem.

Also remove the print statement that prints a line every time a new cell is
added.

[*] There are 144 cells in the list.  Each cell is first looked up for an
    SRV record, and if that fails, for an AFSDB record.  These get a list
    of server names, each of which then has to be looked up to get the
    addresses for that server.  E.g.:

	dig srv _afs3-vlserver._udp.grand.central.org

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 0c3285c8db95..476dcbb79713 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -98,13 +98,13 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 		goto inval;
 
 	args = strchr(name, ' ');
-	if (!args)
-		goto inval;
-	do {
-		*args++ = 0;
-	} while(*args == ' ');
-	if (!*args)
-		goto inval;
+	if (args) {
+		do {
+			*args++ = 0;
+		} while(*args == ' ');
+		if (!*args)
+			goto inval;
+	}
 
 	/* determine command to perform */
 	_debug("cmd=%s name=%s args=%s", buf, name, args);
@@ -120,7 +120,6 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 
 		if (test_and_set_bit(AFS_CELL_FL_NO_GC, &cell->flags))
 			afs_put_cell(net, cell);
-		printk("kAFS: Added new cell '%s'\n", name);
 	} else {
 		goto inval;
 	}

