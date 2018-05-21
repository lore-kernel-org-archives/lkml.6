Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeEUJ0z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:26:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43565 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbeEUJ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:26:51 -0400
From: Luis Henriques <lhenriques@suse.com>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: fix st_nlink stat for directories
Date: Mon, 21 May 2018 10:27:29 +0100
Message-Id: <20180521092729.17470-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, calling stat on a cephfs directory returns 1 for st_nlink.
This behaviour has recently changed in the fuse client, as some
applications seem to expect this value to be either 0 (if it's
unlinked) or 2 + number of subdirectories.  This behaviour was changed
in the fuse client with commit 67c7e4619188 ("client: use common
interp of st_nlink for dirs").

This patch modifies the kernel client to have a similar behaviour.

Link: https://tracker.ceph.com/issues/23873
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index aa7c5a4ff137..6ad66ef8fd66 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2288,6 +2288,14 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
 				stat->size = ci->i_files + ci->i_subdirs;
 			stat->blocks = 0;
 			stat->blksize = 65536;
+			/*
+			 * Some applications rely on the number of st_nlink
+			 * value on directories to be either 0 (if unlinked)
+			 * or 2 + number of subdirectories.
+			 */
+			if (stat->nlink == 1)
+				/* '.' + '..' + subdirs */
+				stat->nlink = 1 + 1 + ci->i_subdirs;
 		}
 	}
 	return err;
