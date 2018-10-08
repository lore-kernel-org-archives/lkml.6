Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5CEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7612A2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JurT3jdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7612A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbeJIB6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E132D204FD;
        Mon,  8 Oct 2018 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024318;
        bh=A4zRuzcQ+5pLUbL9S5Gn0szLii/LFP4Wre3gkMw3NmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JurT3jdySVt4rvKf9dgez94QHykuHXr/66YgnJhMjBS2svJzdBl2adsJ0AgAtTtTo
         Vn3K6H74ZqgLJVkl+7c1Cum0JO4W+QQeznbTHM3er9AE/ybcV8NWE7+A1Vfc8+55mj
         paVIPb3x3NGez1LHK4nFf4jJYnYnuBZvPx4xbf+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 81/94] ovl: fix format of setxattr debug
Date:   Mon,  8 Oct 2018 20:32:02 +0200
Message-Id: <20181008175610.380117639@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 1a8f8d2a443ef9ad9a3065ba8c8119df714240fa upstream.

Format has a typo: it was meant to be "%.*s", not "%*s".  But at some point
callers grew nonprintable values as well, so use "%*pE" instead with a
maximized length.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 3a1e819b4e80 ("ovl: store file handle of lower inode on copy up")
Cc: <stable@vger.kernel.org> # v4.12
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/overlayfs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -136,8 +136,8 @@ static inline int ovl_do_setxattr(struct
 				  const void *value, size_t size, int flags)
 {
 	int err = vfs_setxattr(dentry, name, value, size, flags);
-	pr_debug("setxattr(%pd2, \"%s\", \"%*s\", 0x%x) = %i\n",
-		 dentry, name, (int) size, (char *) value, flags, err);
+	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, 0x%x) = %i\n",
+		 dentry, name, min((int)size, 48), value, size, flags, err);
 	return err;
 }
 


