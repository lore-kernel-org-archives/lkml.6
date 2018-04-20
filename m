Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754831AbeDTMfF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:35:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754752AbeDTMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:35:04 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY
 conversion
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Date: Fri, 20 Apr 2018 13:35:02 +0100
Message-ID: <152422770230.23067.14348897715991489250.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_mount() when the MS_* flags are being converted to MNT_* flags,
MS_RDONLY got accidentally convered to SB_RDONLY.

Undo this change.

Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e398f32d7541..6f720ebca133 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2814,7 +2814,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 		mnt_flags |= MNT_NODIRATIME;
 	if (flags & MS_STRICTATIME)
 		mnt_flags &= ~(MNT_RELATIME | MNT_NOATIME);
-	if (flags & SB_RDONLY)
+	if (flags & MS_RDONLY)
 		mnt_flags |= MNT_READONLY;
 
 	/* The default atime for remount is preservation */
