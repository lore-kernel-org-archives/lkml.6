Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D69EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CB2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE57XVIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39CB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeJICCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672C9214C4;
        Mon,  8 Oct 2018 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024542;
        bh=D0UgKun6HLGWNIX1WN23TR9gVy4pCUK4zsKu2TWHsT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bE57XVIVarVvL0N4od41M+sgNuTiG2t/HyNzO1qjyW70uqMAhA/7REkIW/F6+mkC8
         /RukoBbGSLgi0/4zVT81C/jc11SdgUARWw7DlQfKNX0nbM6REFu6FjPSwqQLrwy1WQ
         FHkFXNkqb5zLkI0Xyw7MiXPvQ76Z1TZebykoAWuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8ab6f1042021b4eed062@syzkaller.appspotmail.com,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 074/168] ceph: avoid a use-after-free in ceph_destroy_options()
Date:   Mon,  8 Oct 2018 20:30:54 +0200
Message-Id: <20181008175622.886820917@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 8aaff15168cfbc7c8980fdb0e8a585f1afe56ec0 ]

syzbot reported a use-after-free in ceph_destroy_options(), called from
ceph_mount().  The problem was that create_fs_client() consumed the opt
pointer on some errors, but not on all of them.  Make sure it always
consumes both libceph and ceph options.

Reported-by: syzbot+8ab6f1042021b4eed062@syzkaller.appspotmail.com
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/super.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -603,6 +603,8 @@ static int extra_mon_dispatch(struct cep
 
 /*
  * create a new fs client
+ *
+ * Success or not, this function consumes @fsopt and @opt.
  */
 static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 					struct ceph_options *opt)
@@ -610,17 +612,20 @@ static struct ceph_fs_client *create_fs_
 	struct ceph_fs_client *fsc;
 	int page_count;
 	size_t size;
-	int err = -ENOMEM;
+	int err;
 
 	fsc = kzalloc(sizeof(*fsc), GFP_KERNEL);
-	if (!fsc)
-		return ERR_PTR(-ENOMEM);
+	if (!fsc) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	fsc->client = ceph_create_client(opt, fsc);
 	if (IS_ERR(fsc->client)) {
 		err = PTR_ERR(fsc->client);
 		goto fail;
 	}
+	opt = NULL; /* fsc->client now owns this */
 
 	fsc->client->extra_mon_dispatch = extra_mon_dispatch;
 	fsc->client->osdc.abort_on_full = true;
@@ -678,6 +683,9 @@ fail_client:
 	ceph_destroy_client(fsc->client);
 fail:
 	kfree(fsc);
+	if (opt)
+		ceph_destroy_options(opt);
+	destroy_mount_options(fsopt);
 	return ERR_PTR(err);
 }
 
@@ -1042,8 +1050,6 @@ static struct dentry *ceph_mount(struct
 	fsc = create_fs_client(fsopt, opt);
 	if (IS_ERR(fsc)) {
 		res = ERR_CAST(fsc);
-		destroy_mount_options(fsopt);
-		ceph_destroy_options(opt);
 		goto out_final;
 	}
 


