Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EEB20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EEB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbeGCWGw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:06:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932361AbeGCWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DCF9DFDE;
        Tue,  3 Jul 2018 22:06:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-203.rdu2.redhat.com [10.10.123.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5959FF5B;
        Tue,  3 Jul 2018 22:06:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180703215825.GX30522@ZenIV.linux.org.uk>
References: <20180703215825.GX30522@ZenIV.linux.org.uk> <20180703183325.GA210265@gmail.com> <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk> <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk> <14124.1530654802@warthog.procyon.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers3@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 10/32] VFS: Implement a filesystem superblock creation/configuration context [ver #8]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19906.1530655609.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 03 Jul 2018 23:06:49 +0100
Message-ID: <19907.1530655609@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 22:06:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 22:06:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> IOW, all of those should be unconditional.

Fair point.  How about the attached, then?

David
---
commit 1aa76514c426150af429d111cec256e81729fa6f
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jul 3 22:35:28 2018 +0100

    vfs: Locking fix for sget_fc()
    
    In sget_fc(), don't drop the s_umount lock before calling
    destroy_unused_super() as that will drop the lock.
    
    Fixes: 8a2e54b8af88 ("vfs: Implement a filesystem superblock creation/configuration context")
    Reported-by: Eric Biggers <ebiggers3@gmail.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/super.c b/fs/super.c
index 43400f5fa33a..dccd397751b1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -516,19 +516,12 @@ struct super_block *sget_fc(struct fs_context *fc,
 				continue;
 			if (fc->user_ns != old->s_user_ns) {
 				spin_unlock(&sb_lock);
-				if (s) {
-					up_write(&s->s_umount);
-					destroy_unused_super(s);
-				}
+				destroy_unused_super(s);
 				return ERR_PTR(-EBUSY);
 			}
 			if (!grab_super(old))
 				goto retry;
-			if (s) {
-				up_write(&s->s_umount);
-				destroy_unused_super(s);
-				s = NULL;
-			}
+			destroy_unused_super(s);
 			return old;
 		}
 	}
@@ -545,7 +538,6 @@ struct super_block *sget_fc(struct fs_context *fc,
 	if (err) {
 		s->s_fs_info = NULL;
 		spin_unlock(&sb_lock);
-		up_write(&s->s_umount);
 		destroy_unused_super(s);
 		return ERR_PTR(err);
 	}
