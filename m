Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCEEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1D21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1D21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeJSVoJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeJSVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:44:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 769CD3002F71;
        Fri, 19 Oct 2018 13:37:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6E431077D48;
        Fri, 19 Oct 2018 13:37:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
References: <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6517.1539956277.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 19 Oct 2018 14:37:57 +0100
Message-ID: <6518.1539956277@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 19 Oct 2018 13:37:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> If I close() the mount FD "mfd", and then do "mount --move . /mnt", my
> printk() shows MNT_UMOUNT has been set. ( I guess fchdir() works more like
> openat(... , O_PATH) than dup() ). Then unmounting /mnt hangs, as I would
> expect from my previous test.

Okay, I think the attached should fix it.

The issue being that do_move_mount() calls attach_recursive_mnt() with a NULL
parent_path, which means that the moved-mount doesn't get its refcount
incremented.

David
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 6370bfabec99..ce9fff980549 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1935,7 +1935,8 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 static int attach_recursive_mnt(struct mount *source_mnt,
 			struct mount *dest_mnt,
 			struct mountpoint *dest_mp,
-			struct path *parent_path)
+			struct path *parent_path,
+			bool moving)
 {
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
@@ -1976,6 +1977,8 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
+		if (moving)
+			mnt_add_count(source_mnt, 1);
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		commit_tree(source_mnt);
 	}
@@ -2062,7 +2065,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp, NULL);
+	return attach_recursive_mnt(mnt, p, mp, NULL, false);
 }
 
 /*
@@ -2522,7 +2525,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 			goto out1;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   attached ? &parent_path : NULL);
+				   attached ? &parent_path : NULL, true);
 	if (err)
 		goto out1;
 
