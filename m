Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeERPyR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:54:17 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:54935 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:54:16 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
CC: "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: [PATCH] kernfs: fix dentry unexpected skip
Thread-Topic: [PATCH] kernfs: fix dentry unexpected skip
Thread-Index: AdPuvebs2fEv/eaSRfWTwq90/56eXQ==
Date: Fri, 18 May 2018 15:42:58 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B5E150F@G01JPEXMBYT03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: 57d448c65dfa492c9c8c514099097a95
x-originating-ip: [10.124.136.24]
Content-Type: text/plain; charset="iso-2022-jp"
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
object has a hash value equal to or smaller than the original one.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Suggested-by: Toshiyuki Okajima <toshi.okajima@jp.fujitsu.com>
Cc: Eric W. Biederman <ebiederm@aristanetworks.com>
---
 fs/kernfs/dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc1..8a2f49c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1622,7 +1622,7 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
 {
 	pos = kernfs_dir_pos(ns, parent, ino, pos);
-	if (pos) {
+	if (pos && pos->hash <= ino) {
 		do {
 			struct rb_node *node = rb_next(&pos->rb);
 			if (!node)
-- 
1.7.1
