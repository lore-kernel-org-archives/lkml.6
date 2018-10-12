Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF3BC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F05D20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F05D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeJLUdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeJLUdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFA9D356F3;
        Fri, 12 Oct 2018 13:00:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF4242E623;
        Fri, 12 Oct 2018 13:00:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_server struct leak
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Fri, 12 Oct 2018 14:00:57 +0100
Message-ID: <153934925704.24054.3222195700321846862.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 12 Oct 2018 13:01:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a leak of afs_server structs.  The routine that installs them in the
various lookup lists and trees gets a ref on leaving the function, whether
it added the server or a server already exists.  It shouldn't increment
the refcount if it added the server.

The effect of this that "rmmod kafs" will hang waiting for the leaked
server to become unused.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/server.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1d329e6981d5..2f306c0cc4ee 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -199,9 +199,11 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 
 	write_sequnlock(&net->fs_addr_lock);
 	ret = 0;
+	goto out;
 
 exists:
 	afs_get_server(server);
+out:
 	write_sequnlock(&net->fs_lock);
 	return server;
 }

