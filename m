Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeEDARR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:17:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:31806 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeEDAQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="196586659"
Subject: [PATCH v3 7/9] dax: report bytes remaining in dax_iomap_actor()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:42 -0700
Message-ID: <152539240242.31796.4162676712193177396.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for protecting the dax read(2) path from media errors
with copy_to_iter_mcsafe() (via dax_copy_to_iter()), convert the
implementation to report the bytes successfully transferred.

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
index a64afdf7ec0d..34a2d435ae4b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -991,6 +991,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iov_iter *iter = data;
 	loff_t end = pos + length, done = 0;
 	ssize_t ret = 0;
+	size_t xfer;
 	int id;
 
 	if (iov_iter_rw(iter) == READ) {
@@ -1054,19 +1055,20 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		 * vfs_write(), depending on which operation we are doing.
 		 */
 		if (iov_iter_rw(iter) == WRITE)
-			map_len = dax_copy_from_iter(dax_dev, pgoff, kaddr,
+			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
-			map_len = dax_copy_to_iter(dax_dev, pgoff, kaddr,
+			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
-		if (map_len <= 0) {
-			ret = map_len ? map_len : -EFAULT;
-			break;
-		}
 
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
 
