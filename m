Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EAEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DF720855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DF720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeIHG7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:06 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:36586
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbeIHG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:06 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlGfa5bsTEX4ySlGf1l8R; Fri, 07 Sep 2018 19:14:19 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlG-0005DX-2k; Fri, 07 Sep 2018 19:14:10 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 02/16] CIFS: Use offset when reading pages
Date:   Sat,  8 Sep 2018 02:13:34 +0000
Message-Id: <20180908021348.19956-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfJqy+5iG24CzfnCPxNSaHjaUBkur9CrCdYfcww1FU1IuXVCk2RJQ6s0In35BHNrgJPYYwK3jq1weVTgaF1SHlhhMRn6IQ0gl8H2QVVtKDj3zQQTgQrF5
 yg1/cesE3NIMgja5Pfjb0XC9owv/WU1LWEDaMEohHccDyZeLhYZeTR67QV5H1zQcVs2PkKCQw6E5v9NTW1c81TkmBVw4T0PKqAFSwmyuCCrfQvW/wqT63QcP
 NVk23bpe03sDWHyzpMgn4CFfbR7fyQmIbJKF/7qlFmMpWAh70g8rudCLVgjs28bEbSNU6GmGJjhnddzZ28GyjqAFOElRWH8oDMWRXsa+7q0A18QJ7IKePcEH
 gHxu3xfL6k+MUUEHbmzJ8T2gxWDnEsK33FAd3XyWMNDCQ6WThRr5aYRLDANAxVpyqEhWg15q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

With offset defined in rdata, transport functions need to look at this
offset when reading data into the correct places in pages.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsproto.h |  4 +++-
 fs/cifs/cifssmb.c   |  1 +
 fs/cifs/connect.c   |  5 +++--
 fs/cifs/file.c      | 52 +++++++++++++++++++++++++++++++++++++---------------
 fs/cifs/smb2ops.c   |  2 +-
 fs/cifs/smb2pdu.c   |  1 +
 6 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index dc80f84..1f27d8e 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -203,7 +203,9 @@ extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 			         unsigned int to_read);
 extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
-				      struct page *page, unsigned int to_read);
+					struct page *page,
+					unsigned int page_offset,
+					unsigned int to_read);
 extern int cifs_setup_cifs_sb(struct smb_vol *pvolume_info,
 			       struct cifs_sb_info *cifs_sb);
 extern int cifs_match_super(struct super_block *, void *);
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index c8e4278..a1af258 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1596,6 +1596,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
 				 .rq_pages = rdata->pages,
+				 .rq_offset = rdata->page_offset,
 				 .rq_npages = rdata->nr_pages,
 				 .rq_pagesz = rdata->pagesz,
 				 .rq_tailsz = rdata->tailsz };
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 83b0234..8501da0 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -594,10 +594,11 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 
 int
 cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
-		      unsigned int to_read)
+	unsigned int page_offset, unsigned int to_read)
 {
 	struct msghdr smb_msg;
-	struct bio_vec bv = {.bv_page = page, .bv_len = to_read};
+	struct bio_vec bv = {
+		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
 	iov_iter_bvec(&smb_msg.msg_iter, READ | ITER_BVEC, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 1c98293..87eece6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3026,12 +3026,20 @@ uncached_fill_pages(struct TCP_Server_Info *server,
 	int result = 0;
 	unsigned int i;
 	unsigned int nr_pages = rdata->nr_pages;
+	unsigned int page_offset = rdata->page_offset;
 
 	rdata->got_bytes = 0;
 	rdata->tailsz = PAGE_SIZE;
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page = rdata->pages[i];
 		size_t n;
+		unsigned int segment_size = rdata->pagesz;
+
+		if (i == 0)
+			segment_size -= page_offset;
+		else
+			page_offset = 0;
+
 
 		if (len <= 0) {
 			/* no need to hold page hostage */
@@ -3040,24 +3048,25 @@ uncached_fill_pages(struct TCP_Server_Info *server,
 			put_page(page);
 			continue;
 		}
+
 		n = len;
-		if (len >= PAGE_SIZE) {
+		if (len >= segment_size)
 			/* enough data to fill the page */
-			n = PAGE_SIZE;
-			len -= n;
-		} else {
-			zero_user(page, len, PAGE_SIZE - len);
+			n = segment_size;
+		else
 			rdata->tailsz = len;
-			len = 0;
-		}
+		len -= n;
+
 		if (iter)
-			result = copy_page_from_iter(page, 0, n, iter);
+			result = copy_page_from_iter(
+					page, page_offset, n, iter);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 		else if (rdata->mr)
 			result = n;
 #endif
 		else
-			result = cifs_read_page_from_socket(server, page, n);
+			result = cifs_read_page_from_socket(
+					server, page, page_offset, n);
 		if (result < 0)
 			break;
 
@@ -3130,6 +3139,7 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 		rdata->bytes = cur_len;
 		rdata->pid = pid;
 		rdata->pagesz = PAGE_SIZE;
+		rdata->tailsz = PAGE_SIZE;
 		rdata->read_into_pages = cifs_uncached_read_into_pages;
 		rdata->copy_into_pages = cifs_uncached_copy_into_pages;
 		rdata->credits = credits;
@@ -3574,6 +3584,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 	u64 eof;
 	pgoff_t eof_index;
 	unsigned int nr_pages = rdata->nr_pages;
+	unsigned int page_offset = rdata->page_offset;
 
 	/* determine the eof that the server (probably) has */
 	eof = CIFS_I(rdata->mapping->host)->server_eof;
@@ -3584,13 +3595,21 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 	rdata->tailsz = PAGE_SIZE;
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page = rdata->pages[i];
-		size_t n = PAGE_SIZE;
+		unsigned int to_read = rdata->pagesz;
+		size_t n;
+
+		if (i == 0)
+			to_read -= page_offset;
+		else
+			page_offset = 0;
+
+		n = to_read;
 
-		if (len >= PAGE_SIZE) {
-			len -= PAGE_SIZE;
+		if (len >= to_read) {
+			len -= to_read;
 		} else if (len > 0) {
 			/* enough for partial page, fill and zero the rest */
-			zero_user(page, len, PAGE_SIZE - len);
+			zero_user(page, len + page_offset, to_read - len);
 			n = rdata->tailsz = len;
 			len = 0;
 		} else if (page->index > eof_index) {
@@ -3622,13 +3641,15 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 		}
 
 		if (iter)
-			result = copy_page_from_iter(page, 0, n, iter);
+			result = copy_page_from_iter(
+					page, page_offset, n, iter);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 		else if (rdata->mr)
 			result = n;
 #endif
 		else
-			result = cifs_read_page_from_socket(server, page, n);
+			result = cifs_read_page_from_socket(
+					server, page, page_offset, n);
 		if (result < 0)
 			break;
 
@@ -3807,6 +3828,7 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		rdata->bytes = bytes;
 		rdata->pid = pid;
 		rdata->pagesz = PAGE_SIZE;
+		rdata->tailsz = PAGE_SIZE;
 		rdata->read_into_pages = cifs_readpages_read_into_pages;
 		rdata->copy_into_pages = cifs_readpages_copy_into_pages;
 		rdata->credits = credits;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 7c0edd2..1fa1c29 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2467,7 +2467,7 @@ read_data_into_pages(struct TCP_Server_Info *server, struct page **pages,
 			zero_user(page, len, PAGE_SIZE - len);
 			len = 0;
 		}
-		length = cifs_read_page_from_socket(server, page, n);
+		length = cifs_read_page_from_socket(server, page, 0, n);
 		if (length < 0)
 			return length;
 		server->total_read += length;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 47d5331..6c22da8 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2683,6 +2683,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
 				 .rq_pages = rdata->pages,
+				 .rq_offset = rdata->page_offset,
 				 .rq_npages = rdata->nr_pages,
 				 .rq_pagesz = rdata->pagesz,
 				 .rq_tailsz = rdata->tailsz };
-- 
2.7.4

