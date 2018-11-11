Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E313C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05993216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC+H3qfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05993216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbeKLJPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389079AbeKLIUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C6C223CB;
        Sun, 11 Nov 2018 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975452;
        bh=sFRm2KlND2SVtw9bL04HHUwUHFBMClRFKQgd8xSZ92I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lC+H3qfh9r8vpnTWlAi3qafcwqqayG71Be5zwrYqfYxIzDxRmH1N1Na1WSS4y0zXb
         DJAXworuoYMPh8Ekm0IgF7sI+suzzEymWGwdHuBeEzMIY5xKT+kJHPYWbvmER+AdyF
         moDFaNVrje5zgcf0PtmTQFRcxoZuVHGH3hqTjTAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.18 219/350] gfs2_meta: ->mount() can get NULL dev_name
Date:   Sun, 11 Nov 2018 14:21:23 -0800
Message-Id: <20181111221717.185777987@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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
@@ -1333,6 +1333,9 @@ static struct dentry *gfs2_mount_meta(st
 	struct path path;
 	int error;
 
+	if (!dev_name || !*dev_name)
+		return ERR_PTR(-EINVAL);
+
 	error = kern_path(dev_name, LOOKUP_FOLLOW, &path);
 	if (error) {
 		pr_warn("path_lookup on %s returned error %d\n",


