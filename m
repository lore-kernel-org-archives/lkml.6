Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E8320C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXMpafL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E8320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbeJIB6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F28204FD;
        Mon,  8 Oct 2018 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024315;
        bh=xoNv7LXMnN0Ps0rhzBqtkpuS+SYP/FdntC+mK/RXZdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXMpafL5MY1sSubFxy9sQph0/+iFkmo6a2VkK/sikUcyB/wKdsXNTqm91aUwTbtvh
         VGgrM5y74KB7qGwmpmY8j0NuI+E0hlcWT4GHvepMlhbAJIxHEI90AYWDt5cFrCndQ4
         DfKuBGXuc7NXdfTYaNRNlPmHALEsJHGHhyA/556g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 80/94] ovl: fix memory leak on unlink of indexed file
Date:   Mon,  8 Oct 2018 20:32:01 +0200
Message-Id: <20181008175610.337490405@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -438,7 +438,7 @@ static void ovl_cleanup_index(struct den
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *index = NULL;
 	struct inode *inode;
-	struct qstr name;
+	struct qstr name = { };
 	int err;
 
 	err = ovl_get_index_name(lowerdentry, &name);
@@ -477,6 +477,7 @@ static void ovl_cleanup_index(struct den
 		goto fail;
 
 out:
+	kfree(name.name);
 	dput(index);
 	return;
 


