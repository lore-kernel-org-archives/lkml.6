Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeEAUzg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:55:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:14537 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeEAUzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:55:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,352,1520924400";
   d="scan'208";a="51538956"
Subject: [PATCH 5/6] dax: use copy_to_iter_mcsafe() in dax_iomap_actor()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com
Date: Tue, 01 May 2018 13:45:35 -0700
Message-ID: <152520753501.36522.5856044229551545705.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect the dax read(2) path from media errors with
copy_to_iter_mcsafe(). If a machine check truncates a transfer we abort
the remainder of the transfer and communicate the number of bytes
successfully completed.

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index aaec72ded1b6..e7894ab791cb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -991,6 +991,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iov_iter *iter = data;
 	loff_t end = pos + length, done = 0;
 	ssize_t ret = 0;
+	size_t xfer;
 	int id;
 
 	if (iov_iter_rw(iter) == READ) {
@@ -1054,18 +1055,19 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		 * vfs_write(), depending on which operation we are doing.
 		 */
 		if (iov_iter_rw(iter) == WRITE)
-			map_len = dax_copy_from_iter(dax_dev, pgoff, kaddr,
+			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
-			map_len = copy_to_iter(kaddr, map_len, iter);
-		if (map_len <= 0) {
-			ret = map_len ? map_len : -EFAULT;
-			break;
-		}
+			xfer = copy_to_iter_mcsafe(kaddr, map_len, iter);
 
-		pos += map_len;
-		length -= map_len;
-		done += map_len;
+		pos += xfer;
+		length -= xfer;
+		done += xfer;
+
+		if (xfer == 0)
+			ret = -EFAULT;
+		if (xfer < map_len)
+			break;
 	}
 	dax_read_unlock(id);
 
