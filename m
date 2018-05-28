Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938165AbeE1LZk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938143AbeE1LZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:25:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Yufen Yu <yuyufen@huawei.com>, Shaohua Li <sh.li@alibaba-inc.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 099/496] md raid10: fix NULL deference in handle_write_completed()
Date: Mon, 28 May 2018 11:58:04 +0200
Message-Id: <20180528100324.030465170@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 01a69cab01c184d3786af09e9339311123d63d22 ]

In the case of 'recover', an r10bio with R10BIO_WriteError &
R10BIO_IsRecover will be progressed by handle_write_completed().
This function traverses all r10bio->devs[copies].
If devs[m].repl_bio != NULL, it thinks conf->mirrors[dev].replacement
is also not NULL. However, this is not always true.

When there is an rdev of raid10 has replacement, then each r10bio
->devs[m].repl_bio != NULL in conf->r10buf_pool. However, in 'recover',
even if corresponded replacement is NULL, it doesn't clear r10bio
->devs[m].repl_bio, resulting in replacement NULL deference.

This bug was introduced when replacement support for raid10 was
added in Linux 3.3.

As NeilBrown suggested:
	Elsewhere the determination of "is this device part of the
	resync/recovery" is made by resting bio->bi_end_io.
	If this is end_sync_write, then we tried to write here.
	If it is NULL, then we didn't try to write.

Fixes: 9ad1aefc8ae8 ("md/raid10:  Handle replacement devices during resync.")
Cc: stable (V3.3+)
Suggested-by: NeilBrown <neilb@suse.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2625,7 +2625,8 @@ static void handle_write_completed(struc
 		for (m = 0; m < conf->copies; m++) {
 			int dev = r10_bio->devs[m].devnum;
 			rdev = conf->mirrors[dev].rdev;
-			if (r10_bio->devs[m].bio == NULL)
+			if (r10_bio->devs[m].bio == NULL ||
+				r10_bio->devs[m].bio->bi_end_io == NULL)
 				continue;
 			if (!r10_bio->devs[m].bio->bi_status) {
 				rdev_clear_badblocks(
@@ -2640,7 +2641,8 @@ static void handle_write_completed(struc
 					md_error(conf->mddev, rdev);
 			}
 			rdev = conf->mirrors[dev].replacement;
-			if (r10_bio->devs[m].repl_bio == NULL)
+			if (r10_bio->devs[m].repl_bio == NULL ||
+				r10_bio->devs[m].repl_bio->bi_end_io == NULL)
 				continue;
 
 			if (!r10_bio->devs[m].repl_bio->bi_status) {
