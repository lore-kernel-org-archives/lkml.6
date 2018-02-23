Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeBWH1J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:27:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:21962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeBWH1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:27:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="33526933"
Subject: [PATCH v2 4/5] dax: short circuit vma_is_fsdax() in the
 CONFIG_FS_DAX=n case
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date: Thu, 22 Feb 2018 23:18:01 -0800
Message-ID: <151937028128.18973.18029610933124841542.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index b2fa9b4c1e51..8f80d9fff86d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3195,6 +3195,8 @@ static inline bool vma_is_fsdax(struct vm_area_struct *vma)
 
 	if (!vma->vm_file)
 		return false;
+	if (!IS_ENABLED(CONFIG_FS_DAX))
+		return false;
 	if (!vma_is_dax(vma))
 		return false;
 	inode = file_inode(vma->vm_file);
