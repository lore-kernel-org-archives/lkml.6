Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D967ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5DC21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5DC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeJQVP5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeJQVP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54BE9BCD2C;
        Wed, 17 Oct 2018 13:20:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 233268B946;
        Wed, 17 Oct 2018 13:20:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <19866.1539782101@warthog.procyon.org.uk>
References: <19866.1539782101@warthog.procyon.org.uk> <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk> <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com> <20181013061141.GR32577@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock for reconfiguration [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28709.1539782412.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 17 Oct 2018 14:20:12 +0100
Message-ID: <28710.1539782412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 17 Oct 2018 13:20:17 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I should probably check that the picked point is actually a mountpoint.

The root of the mount object at the path specified, that is, perhaps with
something like the attached.

David
---
diff --git a/fs/fsopen.c b/fs/fsopen.c
index f673e93ac456..aaaaa17a233c 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -186,6 +186,10 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	if (ret < 0)
 		goto err;
 
+	ret = -EINVAL;
+	if (target.mnt->mnt_root != target.dentry)
+		goto err_path;
+
 	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
 				0, 0, FS_CONTEXT_FOR_RECONFIGURE);
 	if (IS_ERR(fc)) {

