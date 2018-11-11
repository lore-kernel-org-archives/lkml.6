Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893A9C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F72821780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIWC9leM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F72821780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404764AbeKLIYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbeKLIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:35 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614AC2154B;
        Sun, 11 Nov 2018 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975677;
        bh=uio8UGOfDCMRyySO7+weTg2TvwBXucTm6ZKfezjWgNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIWC9leMquZ9kju/X6U9gikySG7K0ys/mc4VtBQCQ17fPIYhrRvU3s1YOoXidm8sV
         Afx0Ow5IUa+2qMTRTrNIpoHFfVi0aV4dEWXj6gjNWB/VxwMYeNFXjkD6nVrlhjLah1
         g/EA37OnwDwaPCnMYjzW+VcukeWLW3x9uqKfRBrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 088/141] gfs2_meta: ->mount() can get NULL dev_name
Date:   Sun, 11 Nov 2018 14:25:47 -0800
Message-Id: <20181111221640.390936488@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 3df629d873f8683af6f0d34dfc743f637966d483 upstream.

get in sync with mount_bdev() handling of the same

Reported-by: syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/ops_fstype.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1355,6 +1355,9 @@ static struct dentry *gfs2_mount_meta(st
 	struct path path;
 	int error;
 
+	if (!dev_name || !*dev_name)
+		return ERR_PTR(-EINVAL);
+
 	error = kern_path(dev_name, LOOKUP_FOLLOW, &path);
 	if (error) {
 		pr_warn("path_lookup on %s returned error %d\n",


