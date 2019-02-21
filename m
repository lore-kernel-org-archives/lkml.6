Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E546AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9456207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfBUWEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfBUWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:04:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D14BBA77F;
        Thu, 21 Feb 2019 22:04:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6E211001DD3;
        Thu, 21 Feb 2019 22:04:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix manually set volume location server list
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Botsch <dwb7@cornell.edu>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 21 Feb 2019 22:04:32 +0000
Message-ID: <155078667296.18898.13427509562134997807.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 21 Feb 2019 22:04:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cell with a volume location server list is added manually by echoing
the details into /proc/net/afs/cells, a record is added but the flag saying
it has been looked up isn't set.  This causes the VL server rotation code
to wait forever, with the top of /proc/pid/stack looking like:

	[<0>] afs_select_vlserver+0x3a6/0x6f3
	[<0>] afs_vl_lookup_vldb+0x4b/0x92
	[<0>] afs_create_volume+0x25/0x1b9
	...

with the thread stuck in afs_start_vl_iteration() waiting for
AFS_CELL_FL_NO_LOOKUP_YET to be cleared.

Fix this by clearing AFS_CELL_FL_NO_LOOKUP_YET when setting up a record if
that record's details were supplied manually.

Fixes: 0a5143f2f89c ("afs: Implement VL server rotation")
Reported-by: Dave Botsch <dwb7@cornell.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index cf445dbd5f2e..9de46116c749 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -173,6 +173,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 
 		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_expiry = TIME64_MAX;
+		__clear_bit(AFS_CELL_FL_NO_LOOKUP_YET, &cell->flags);
 	} else {
 		cell->dns_expiry = ktime_get_real_seconds();
 	}

