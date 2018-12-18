Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6BEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9A1218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151347;
	bh=k9Zljw3dkLZio+3P9DMHXBmm7mTmsiP6q/RkQlc8T+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTm0tyto6FDw/baLb7RGOX+GArQmxZpKy0ag91C0aZOIHtflIP4DFt/WknyfvL+2E
	 rubkWWOaG2jQkKPipy/cZs4carHw0khwufYMptODFBQhCpGpFLA9Ygi7dT/yly1b+Y
	 uY4tEP7A1+OKLwRkAoA5YkIrOqe/RnNL+R3802M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeLRQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeLRQmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:42:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A39C21873;
        Tue, 18 Dec 2018 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151343;
        bh=k9Zljw3dkLZio+3P9DMHXBmm7mTmsiP6q/RkQlc8T+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lzwq7BQ8KLrp9UmfR7w0BhT62p/BZc43+avXPLo/VFvlvy7r+jdru5QGNu2d+aKhr
         kO+JUy16l/vAp6S7Jh1v2L7p4+Q2Uo9Vv3BoGYtFcqUeUQaqrgtJFCQm5yAGOYGJoL
         ys0j9x9gnjjuQFGvqx1Bu+rayyra8TKzSAEPMShY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 15/44] ovl: fix decode of dir file handle with multi lower layers
Date:   Tue, 18 Dec 2018 17:39:27 +0100
Message-Id: <20181218163929.344397789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 155b8a0492a90a4c6e22f046a3568b92a6bc48da upstream.

When decoding a lower file handle, we first call ovl_check_origin_fh()
with connected=false to get any real lower dentry for overlay inode
cache lookup.

If the real dentry is a disconnected dir dentry, ovl_check_origin_fh()
is called again with connected=true to get a connected real dentry
and find the lower layer the real dentry belongs to.

If the first call returned a connected real dentry, we use it to
lookup an overlay connected dentry, but the first ovl_check_origin_fh()
call with connected=false did not check that the found dentry is under
the root of the layer (see ovl_acceptable()), it only checked that
the found dentry super block matches the uuid of the lower file handle.

In case there are multiple lower layers on the same fs and the found
dentry is not from the top most lower layer, using the layer index
returned from the first ovl_check_origin_fh() is wrong and we end
up failing to decode the file handle.

Fix this by always calling ovl_check_origin_fh() with connected=true
if we got a directory dentry in the first call.

Fixes: 8b58924ad55c ("ovl: lookup in inode cache first when decoding...")
Cc: <stable@vger.kernel.org> # v4.17
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/export.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -754,9 +754,8 @@ static struct dentry *ovl_lower_fh_to_d(
 		goto out;
 	}
 
-	/* Otherwise, get a connected non-upper dir or disconnected non-dir */
-	if (d_is_dir(origin.dentry) &&
-	    (origin.dentry->d_flags & DCACHE_DISCONNECTED)) {
+	/* Find origin.dentry again with ovl_acceptable() layer check */
+	if (d_is_dir(origin.dentry)) {
 		dput(origin.dentry);
 		origin.dentry = NULL;
 		err = ovl_check_origin_fh(ofs, fh, true, NULL, &stack);
@@ -769,6 +768,7 @@ static struct dentry *ovl_lower_fh_to_d(
 			goto out_err;
 	}
 
+	/* Get a connected non-upper dir or disconnected non-dir */
 	dentry = ovl_get_dentry(sb, NULL, &origin, index);
 
 out:


