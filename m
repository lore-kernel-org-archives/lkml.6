Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbeE3TuY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:50:24 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:57164
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753556AbeE3TuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:50:09 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 15/15] CIFS: Add direct I/O functions to file_operations
Date: Wed, 30 May 2018 12:48:07 -0700
Message-Id: <20180530194807.31657-16-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfHt0u8uYpgPH52yJw+53ktd7A7jZoCV+8C7XONbp+Z5jrUDW4a6UXVB0q24EItuHqvhY6bxHSs01KrRGknmzeuUzv7wMb9MSk2yKPEGqZ8an2qjbhHDk
 kMndfLr5Jq2J6vfKeuyYCR+wCeSS+4tdZI/U0n+57FX6yNvJlXHqkIbHWCrt80sIAvVwQD7plDCncP7l8BQAr/e2ACQNJd5h94giFeRq9K8jr8L72moAcmgn
 jne6lFst7AWNFGOCeOexOtV/was8bIRgTZEQXmIBi5h6V4KHVA3LLQufoR/MwGeBWFNk4+8itWD2E1/Xbfy9Sn1jGJeq0dSPtmQvK4e3jZqGH60r/zK5z0Fp
 b3wJVZ+1uoiXu3uNUoV4T/INYZE8+qWTgF3Nzoiu2OJPSNaF9uzbSPp7Jus73psWGEvUR10Z
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

With direct read/write functions implemented, add them to file_operations.
When mounting with "cache=none", CIFS uses direct I/O.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 62f1662..e84f8c2 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1113,9 +1113,8 @@ const struct file_operations cifs_file_strict_ops = {
 };
 
 const struct file_operations cifs_file_direct_ops = {
-	/* BB reevaluate whether they can be done with directio, no cache */
-	.read_iter = cifs_user_readv,
-	.write_iter = cifs_user_writev,
+	.read_iter = cifs_direct_readv,
+	.write_iter = cifs_direct_writev,
 	.open = cifs_open,
 	.release = cifs_close,
 	.lock = cifs_lock,
-- 
2.7.4
