Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC749ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A628C2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="voB6pNjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A628C2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeJSCHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbeJSCHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:07:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5490321476;
        Thu, 18 Oct 2018 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885911;
        bh=HT78kggpkgZyK93rkE3pvXdR6J7JBCt9GRb6MeRJn5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=voB6pNjKosUqX3C5KUeY5uBbx3OC0/p/UEWFAHHAypfgy0sc80vgxHfomz20zMISg
         WLauvj7mLIs9ejaAuApv5f5Zsd04afx799NDAxiw04Q/QIvXPy+hNnp6fTZT0p5kbO
         CUOufaKbATsCsthOi6rpvm/MghGzV/vFb6EzQ5zA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 4.4 16/48] jffs2: return -ERANGE when xattr buffer is too small
Date:   Thu, 18 Oct 2018 19:54:51 +0200
Message-Id: <20181018175428.883959029@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

When a file have multiple xattrs and the passed buffer is
smaller than the required size, jffs2_listxattr() should
return -ERANGE instead of continue, else Oops may occur
due to memory corruption.

Also remove the unnecessary check ("rc < 0"), because
xhandle->list(...) will not return an error number.

Spotted by generic/377 in xfstests-dev.

NB: The problem had been fixed by commit 764a5c6b1fa4 ("xattr
handlers: Simplify list operation") in v4.5-rc1, but the
modification in that commit may be too much because it modifies
all file-systems which implement xattr, so I create a single
patch for jffs2 to fix the problem.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jffs2/xattr.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -1004,12 +1004,14 @@ ssize_t jffs2_listxattr(struct dentry *d
 			rc = xhandle->list(xhandle, dentry, buffer + len,
 					   size - len, xd->xname,
 					   xd->name_len);
+			if (rc > size - len) {
+				rc = -ERANGE;
+				goto out;
+			}
 		} else {
 			rc = xhandle->list(xhandle, dentry, NULL, 0,
 					   xd->xname, xd->name_len);
 		}
-		if (rc < 0)
-			goto out;
 		len += rc;
 	}
 	rc = len;


