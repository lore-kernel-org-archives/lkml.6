Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E98C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DDA2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUdoSEWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DDA2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeGJOCE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933501AbeGJOBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:01:33 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BC0208E6;
        Tue, 10 Jul 2018 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531231293;
        bh=CrAZ1Nd7UOYLzou0pR5gkpc/2SacGmBjzGXjvBfMpx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUdoSEWDHeToWF7u27wCe+PRlV/Sc04X/yqIVJ8QkwJ1AiyTzusUN/4Hd0ORBGooA
         NB1779LWfgC+R4lK/dcBd9SFy3hHoAkWIbBduhDCah1eBhPE6Aub+J+i6pGt+pFQGY
         Veo1eDuPJEycleG2ZSWfwM1rKpcueY5BnvENvnKQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc:     willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] vfs: allow fsinfo to fetch the current state of s_wb_err
Date:   Tue, 10 Jul 2018 10:01:26 -0400
Message-Id: <20180710140127.20739-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710140127.20739-1-jlayton@kernel.org>
References: <20180710140127.20739-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add a new "error_state" struct to fsinfo, and teach the kernel to fill
that out from sb->s_wb_info. There are two fields:

wb_error_last: the most recently recorded errno for the filesystem

wb_error_cookie: this value will change vs. the previously fetched
                 value if a new error was recorded since it was last
		 checked

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/statfs.c                 |  9 +++++++++
 include/uapi/linux/fsinfo.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/statfs.c b/fs/statfs.c
index fa6be965dce1..fb1f48eb381a 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -576,6 +576,14 @@ static int fsinfo_generic_io_size(struct dentry *dentry,
 	return sizeof(*c);
 }
 
+static int fsinfo_generic_error_state(struct dentry *dentry,
+				  struct fsinfo_error_state *c)
+{
+	c->wb_error_cookie = errseq_scrape(&dentry->d_sb->s_wb_err);
+	c->wb_error_last = c->wb_error_cookie & MAX_ERRNO;
+	return sizeof(*c);
+}
+
 /*
  * Implement some queries generically from stuff in the superblock.
  */
@@ -594,6 +602,7 @@ int generic_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 	case _gen(volume_id);
 	case _gen(name_encoding);
 	case _gen(io_size);
+	case _gen(error_state);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index f2bc5130544d..fbc5d840ea4e 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -35,6 +35,7 @@ enum fsinfo_attribute {
 	fsinfo_attr_name_encoding	= 17,	/* Filename encoding (string) */
 	fsinfo_attr_name_codepage	= 18,	/* Filename codepage (string) */
 	fsinfo_attr_io_size		= 19,	/* Optimal I/O sizes */
+	fsinfo_attr_error_state		= 20,	/* Error state */
 	fsinfo_attr__nr
 };
 
@@ -211,6 +212,16 @@ struct fsinfo_server_address {
 	struct __kernel_sockaddr_storage address;
 };
 
+/*
+ * Information struct for fsinfo(fsinfo_attr_error_state).
+ *
+ * Retrieve the error state for a filesystem.
+ */
+struct fsinfo_error_state {
+	__u32		wb_error_cookie;	/* writeback error cookie */
+	__u32		wb_error_last;		/* latest writeback error */
+};
+
 /*
  * Information struct for fsinfo(fsinfo_attr_io_size).
  *
-- 
2.17.1

