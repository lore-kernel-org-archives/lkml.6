Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeE3Tv2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:51:28 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:60182
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932256AbeE3Ttz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:55 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 06/15] CIFS: Introduce helper function to get page offset and length in smb_rqst
Date: Wed, 30 May 2018 12:47:58 -0700
Message-Id: <20180530194807.31657-7-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfE2En6LZZmxVtn5WKUvfoKAOIZvu+60DXJGDbf1f8+6++sqxIEmMRhgezaWWXCvpGXnmTXOQuTPDJE2kZeCFY2BD8wyxuA2Vf6TmbqxQJ251u1oJ83B4
 e9Jx9UR2v7un3wLbFfsZdGQ8EkJTEJx4gjb9NjVKMdoeUCppyTtFCG8T3CHIVNP8Drxwit4oUMlbYqPE1SOYBt+J51G/w9/3oUDAJONxDd7eonmAXozEy5Bp
 zRSG34UPEPICL0oARu5ukGvaw5AFKCqcD72VC7GJnw9i255KSW+WOAdq8ZlLewgTdLjy5XTegDI/6hZMxwEpg/Yb50YivHXiUVKw47W4F/+dcvEQ19FwmjT6
 8tRKz/oOQ9UWFv+25N7Ei9GYitZVmfcjw2aAiPfpvxZMmo6y+BC++kOUljFYLMpMlB03lW1l
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Introduce a function rqst_page_get_length to return the page offset and
length for a given page in smb_rqst. This function is to be used by
following patches.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsproto.h |  3 +++
 fs/cifs/misc.c      | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 7933c5f..89dda14 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -557,4 +557,7 @@ int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
 		    struct sdesc **sdesc);
 void cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc);
 
+extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
+				unsigned int *len, unsigned int *offset);
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 96849b5..e951417 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -905,3 +905,20 @@ cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc)
 		crypto_free_shash(*shash);
 	*shash = NULL;
 }
+
+/**
+ * rqst_page_get_length - obtain the length and offset for a page in smb_rqst
+ * Input: rqst - a smb_rqst, page - a page index for rqst
+ * Output: *len - the length for this page, *offset - the offset for this page
+ */
+void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
+				unsigned int *len, unsigned int *offset)
+{
+	*len = rqst->rq_pagesz;
+	*offset = (page == 0) ? rqst->rq_offset : 0;
+
+	if (rqst->rq_npages == 1 || page == rqst->rq_npages-1)
+		*len = rqst->rq_tailsz;
+	else if (page == 0)
+		*len = rqst->rq_pagesz - rqst->rq_offset;
+}
-- 
2.7.4
