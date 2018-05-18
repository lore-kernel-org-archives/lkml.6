Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeERAXg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:23:36 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:34646
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751543AbeERAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:23:34 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [RFC PATCH 01/09] Introduce offset for the 1st page in data transfer structures
Date: Thu, 17 May 2018 17:22:06 -0700
Message-Id: <20180518002214.5657-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518002214.5657-1-longli@linuxonhyperv.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfO8fZXtynARGtWqOPkeDrS6NM0lo4gYGp6bIh04vsq+9TnF/coRlOwVtuK8MPwQ0xdA+cZk+RALOKCuIpAgMvL4FiC0SNelO988/2pG837ivj7i7C7Bf
 QSty9VeeiLIt9LaiAtNow57C9YqIXKbASqruaOmQpH90xCf76RwxhGLsGFlProkAgaOlDb8NkdiO72JHC2koH2nxim2FWkU/T8rXJmMaLchSXYXzw7bLbNd0
 lBnZcc9giiG7m4uBFWuMOKzw4npL1TeSsITOhdeTCEmK9kARX7uC07thTHAsYY/puVK+5nvdOs3mPmTxr/P8leKUcKHaEkJXSZzBUvJEuszbdfRscRu20QqW
 csA4oYkuP5v7DSH6bctpPyAdyGqk8fTCoc/trd5JSiRsyf/TxW6Nrh6VwAdnpSXbwjY2OvmG
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Currently CIFS allocates its own pages for data transfer, they don't need offset
since it's always 0 in the 1st page.

Direct data transfer needs to define an offset because user-data may not start
on the page boundary

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsglob.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index cb950a5..a51855c 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -176,6 +176,7 @@ struct smb_rqst {
 	struct kvec	*rq_iov;	/* array of kvecs */
 	unsigned int	rq_nvec;	/* number of kvecs in array */
 	struct page	**rq_pages;	/* pointer to array of page ptrs */
+	unsigned int	rq_offset;	/* the offset to the 1st page */
 	unsigned int	rq_npages;	/* number pages in array */
 	unsigned int	rq_pagesz;	/* page size to use */
 	unsigned int	rq_tailsz;	/* length of last page */
@@ -1167,8 +1168,10 @@ struct cifs_readdata {
 	struct kvec			iov[2];
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
+	struct page			**direct_pages;
 #endif
 	unsigned int			pagesz;
+	unsigned int			page_offset;
 	unsigned int			tailsz;
 	unsigned int			credits;
 	unsigned int			nr_pages;
@@ -1192,8 +1195,10 @@ struct cifs_writedata {
 	int				result;
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
+	struct page			**direct_pages;
 #endif
 	unsigned int			pagesz;
+	unsigned int			page_offset;
 	unsigned int			tailsz;
 	unsigned int			credits;
 	unsigned int			nr_pages;
-- 
2.7.4
