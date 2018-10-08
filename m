Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66760C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C922087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXYGyYFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C922087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeJICF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732339AbeJICF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61AAF20645;
        Mon,  8 Oct 2018 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024769;
        bh=8U+91JKWhuK4SIea4dod6WAZIGANUmL9bQGRjauZIXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXYGyYFQBPDs1nQXwmH8p1T451LsK7JoOlvz56PhogrMldmbsUwJCjsPiZ9i/vcRo
         OsT6HJJWua3GM3J87LXE6IFFdSXgHf/BImzqzawhFumzQw4FffpXH+WLLBenzeMXNu
         P0FmzwMFnxnC5omYQCN7aDa48RvV+wT06sFjQJ2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 148/168] ovl: fix memory leak on unlink of indexed file
Date:   Mon,  8 Oct 2018 20:32:08 +0200
Message-Id: <20181008175625.656311260@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 63e132528032ce937126aba591a7b37ec593a6bb upstream.

The memory leak was detected by kmemleak when running xfstests
overlay/051,053

Fixes: caf70cb2ba5d ("ovl: cleanup orphan index entries")
Cc: <stable@vger.kernel.org> # v4.13
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/util.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -531,7 +531,7 @@ static void ovl_cleanup_index(struct den
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *index = NULL;
 	struct inode *inode;
-	struct qstr name;
+	struct qstr name = { };
 	int err;
 
 	err = ovl_get_index_name(lowerdentry, &name);
@@ -574,6 +574,7 @@ static void ovl_cleanup_index(struct den
 		goto fail;
 
 out:
+	kfree(name.name);
 	dput(index);
 	return;
 


