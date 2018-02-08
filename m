Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBHQQP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeBHQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:12 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/7] afs: Add missing afs_put_cell()
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:11 +0000
Message-ID: <151810657110.20070.1125726424389861264.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_alloc_volume() needs to release the cell ref it obtained in the case of
an error.  Fix this by adding an afs_put_cell() call into the error path.

This can triggered when a lookup for a cell in a dynamic root or an
autocell mount returns an error whilst trying to look up the server (such
as ENOMEDIUM).  This results in an assertion failure oops when the module
is unloaded due to outstanding refs on a cell record.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: stable@vger.kernel.org
---

 fs/afs/volume.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 684c48293353..79db9021f140 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -102,6 +102,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_mount_params *params,
 error_2:
 	afs_put_serverlist(params->net, slist);
 error_1:
+	afs_put_cell(params->net, volume->cell);
 	kfree(volume);
 error_0:
 	return ERR_PTR(ret);
