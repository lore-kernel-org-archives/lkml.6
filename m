Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165076AbeE1My2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:54:28 -0400
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:60843 "EHLO
        mgwym03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeE1MyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:54:12 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj@kernel.org'" <tj@kernel.org>
CC: "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Topic: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Index: AdP2gtQcFftKX6rKRguW2o+iRXsAXg==
Date: Mon, 28 May 2018 12:54:03 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: 8ec5e13069344ac1a10b2c754d90523a
x-originating-ip: [10.124.136.24]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <609F33E5C543104D8C3B28D054A93B0A@fujitsu.local>
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs_dir_next_pos() overlooks the situation that the dentry
corresponding to a given pos object has already been inactive. Hence,
when kernfs_dir_pos() returns the dentry with a hash value larger than
the original one, kernfs_dir_next_pos() returns the dentry next to the
one returned by kernfs_dir_pos(). As a result, the dentry returned by
kernfs_dir_pos() is skipped.

To fix this issue, try to find a next node only when the returned
object is less than or equal to the original one.

Note that this implementation focuses on getting guarantee that the
existing nodes are never skipped, not interested in the other nodes
that are added or removed during the process.

We found this issue during a stress test that repeatedly reads
/sys/module directory to get a list of the currently loaded kernel
modules while repeatedly loading and unloading kernel modules
simultaneously.

v2: Fix the case where nodes with the same hash but with the name
    larger than the original node could still be skipped. Use
    kernfs_sd_compare() to compare kernfs_node objects. Imporove patch
    description.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Suggested-by: Toshiyuki Okajima <toshi.okajima@jp.fujitsu.com>
Cc: Eric W. Biederman <ebiederm@aristanetworks.com>
---
 fs/kernfs/dir.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc1..3aeeb7a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1621,8 +1621,10 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
 	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
 {
+	struct kernfs_node *orig = pos;
+
 	pos = kernfs_dir_pos(ns, parent, ino, pos);
-	if (pos) {
+	if (pos && kernfs_sd_compare(pos, orig) <= 0) {
 		do {
 			struct rb_node *node = rb_next(&pos->rb);
 			if (!node)
-- 
1.7.1
