Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeBDXOs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 18:14:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:17693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbeBDXOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 18:14:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,462,1511856000";
   d="scan'208";a="24654557"
Subject: [PATCH 2/3] dax: short circuit vma_is_fsdax() in the
 CONFIG_FS_DAX=n case
From: Dan Williams <dan.j.williams@intel.com>
To: alex.williamson@redhat.com
Cc: jack@suse.cz, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Date: Sun, 04 Feb 2018 15:05:25 -0800
Message-ID: <151778552571.7139.13956395885168306089.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not bother looking up the file type in the case when Filesystem-DAX
is disabled at build time.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a3329258ff5c..31aeb0b86d85 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3201,6 +3201,8 @@ static inline bool vma_is_fsdax(struct vm_area_struct *vma)
 
 	if (!vma->vm_file)
 		return false;
+	if (!IS_ENABLED(CONFIG_FS_DAX))
+		return false;
 	if (!vma_is_dax(vma))
 		return false;
 	inode = file_inode(vma->vm_file);
