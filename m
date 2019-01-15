Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B517C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540A320645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571180;
	bh=HfYJFEVVlvTpKImXtygTSn3bH2ziY7RHeXZOmtBnIXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfEh9yPbr5+qVG1Vxe45EH+1FSC7Eoc/xLgD//lPmVvz8lR6Fl7gX4qWQVvqG31do
	 mmgJGzqwW1Flvcq/4dlfZaRptcIsaqbMLk7vClRZa3ifj9n6Tgazcb0pTY3viDWif9
	 rh4Jvw0TNjGPQemGeUzqRIOohAgyoYZfYWgM2sus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfAOQoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfAOQn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DFF20645;
        Tue, 15 Jan 2019 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570637;
        bh=HfYJFEVVlvTpKImXtygTSn3bH2ziY7RHeXZOmtBnIXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fodX3Y3c2RmUd2odUUp6gCqigpotG5II5/pvPNVem8tKXBjib0lWg8h3FoHuQv9wM
         f7s3EkCdk2P8+B/DZzFFokGi3CXgWNMgZqdajKpiaPWu6vBZj/Th5J41DRZEBigfC4
         pGJgwp6yqhvZRNsHV+ALKbpOEhsBTR2x5/vhnKqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 17/57] cifs: check kzalloc return
Date:   Tue, 15 Jan 2019 17:35:58 +0100
Message-Id: <20190115154911.673475852@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Perches <joe@perches.com>

commit 0544b324e62c177c3a9e9c3bdce22e6db9f34588 upstream.

kzalloc can return NULL so an additional check is needed. While there
is a check for ret_buf there is no check for the allocation of
ret_buf->crfid.fid - this check is thus added. Both call-sites
of tconInfoAlloc() check for NULL return of tconInfoAlloc()
so returning NULL on failure of kzalloc() here seems appropriate.
As the kzalloc() is the only thing here that can fail it is
moved to the beginning so as not to initialize other resources
on failure of kzalloc.

Fixes: 3d4ef9a15343 ("smb3: fix redundant opens on root")

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/misc.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -111,21 +111,27 @@ struct cifs_tcon *
 tconInfoAlloc(void)
 {
 	struct cifs_tcon *ret_buf;
-	ret_buf = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
-	if (ret_buf) {
-		atomic_inc(&tconInfoAllocCount);
-		ret_buf->tidStatus = CifsNew;
-		++ret_buf->tc_count;
-		INIT_LIST_HEAD(&ret_buf->openFileList);
-		INIT_LIST_HEAD(&ret_buf->tcon_list);
-		spin_lock_init(&ret_buf->open_file_lock);
-		mutex_init(&ret_buf->crfid.fid_mutex);
-		ret_buf->crfid.fid = kzalloc(sizeof(struct cifs_fid),
-					     GFP_KERNEL);
-		spin_lock_init(&ret_buf->stat_lock);
-		atomic_set(&ret_buf->num_local_opens, 0);
-		atomic_set(&ret_buf->num_remote_opens, 0);
+
+	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
+	if (!ret_buf)
+		return NULL;
+	ret_buf->crfid.fid = kzalloc(sizeof(*ret_buf->crfid.fid), GFP_KERNEL);
+	if (!ret_buf->crfid.fid) {
+		kfree(ret_buf);
+		return NULL;
 	}
+
+	atomic_inc(&tconInfoAllocCount);
+	ret_buf->tidStatus = CifsNew;
+	++ret_buf->tc_count;
+	INIT_LIST_HEAD(&ret_buf->openFileList);
+	INIT_LIST_HEAD(&ret_buf->tcon_list);
+	spin_lock_init(&ret_buf->open_file_lock);
+	mutex_init(&ret_buf->crfid.fid_mutex);
+	spin_lock_init(&ret_buf->stat_lock);
+	atomic_set(&ret_buf->num_local_opens, 0);
+	atomic_set(&ret_buf->num_remote_opens, 0);
+
 	return ret_buf;
 }
 


