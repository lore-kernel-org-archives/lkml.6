Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A0321873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151273;
	bh=9ocElY8LluPiM2E2mWx2DtTXBQvT5Y4W6ZaiMPnC9Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fsI3eWwBZyH3nwfInQhXu65h50aeuGxIh1QC1nsjvBiZOpgU2YsqLV/eOgva/XZ30
	 Q9H/3z0qo5rlZzHSE+u9W11AoN3SiYpodciQMRFJ7PlWg12UqpMViAhI7oR9rb0V6D
	 2nhfAWcVh4etSHqSn4X/H3BvYYXukKddAlCVUcVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeLRQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeLRQlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB8421873;
        Tue, 18 Dec 2018 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151270;
        bh=9ocElY8LluPiM2E2mWx2DtTXBQvT5Y4W6ZaiMPnC9Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQyzeddYZzs4Gz1nDJjWjKqzzaX975Q1qBFfZ3O3Ylt0gneROUDN/V791jJfz6AnZ
         hOW7l9jd6d48fKt/cx2tgdCJVgOAPEC1o/RN6xcO14H9udt8sx8RLIbC8TC/G39sd7
         v2H9eTZzzmp0ePG2+nCPD+GNE1pj163Su9W46m3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Theodore Y. Tso" <tytso@mit.edu>,
        =?UTF-8?q?Maciej=20Zi=C4=99ba?= <maciekz82@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 16/44] ovl: fix missing override creds in link of a metacopy upper
Date:   Tue, 18 Dec 2018 17:39:28 +0100
Message-Id: <20181218163929.431174234@linuxfoundation.org>
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

commit 91ff20f34e94424e586f57f4f593beae16504f86 upstream.

Theodore Ts'o reported a v4.19 regression with docker-dropbox:
https://marc.info/?l=linux-fsdevel&m=154070089431116&w=2

"I was rebuilding my dropbox Docker container, and it failed in 4.19
 with the following error:
 ...
 dpkg: error: error creating new backup file \
              '/var/lib/dpkg/status-old': Invalid cross-device link"

The problem did not reproduce with metacopy feature disabled.
The error was caused by insufficient credentials to set
"trusted.overlay.redirect" xattr on link of a metacopy file.

Reproducer:

 echo Y > /sys/module/overlay/parameters/redirect_dir
 echo Y > /sys/module/overlay/parameters/metacopy
 cd /tmp
 mkdir l u w m
 chmod 777 l u
 touch l/foo
 ln l/foo l/link
 chmod 666 l/foo
 mount -t overlay none -olowerdir=l,upperdir=u,workdir=w m
 su fsgqa
 ln m/foo m/bar
 [   21.455823] overlayfs: failed to set redirect (-1)
 ln: failed to create hard link 'm/bar' => 'm/foo':\
     Invalid cross-device link

Reported-by: Theodore Y. Ts'o <tytso@mit.edu>
Reported-by: Maciej Zięba <maciekz82@gmail.com>
Fixes: 4120fe64dce4 ("ovl: Set redirect on upper inode when it is linked")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/dir.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -652,6 +652,18 @@ static int ovl_symlink(struct inode *dir
 	return ovl_create_object(dentry, S_IFLNK, 0, link);
 }
 
+static int ovl_set_link_redirect(struct dentry *dentry)
+{
+	const struct cred *old_cred;
+	int err;
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	err = ovl_set_redirect(dentry, false);
+	revert_creds(old_cred);
+
+	return err;
+}
+
 static int ovl_link(struct dentry *old, struct inode *newdir,
 		    struct dentry *new)
 {
@@ -672,7 +684,7 @@ static int ovl_link(struct dentry *old,
 		goto out_drop_write;
 
 	if (ovl_is_metacopy_dentry(old)) {
-		err = ovl_set_redirect(old, false);
+		err = ovl_set_link_redirect(old);
 		if (err)
 			goto out_drop_write;
 	}


