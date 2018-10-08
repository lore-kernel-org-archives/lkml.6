Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C0C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D5A2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRSxI9aZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D5A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbeJICEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeJICD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91816204FD;
        Mon,  8 Oct 2018 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024650;
        bh=WUyLizhGMYnGgJeu3NhnCvFcDhh9M6efxpNKY1bUqGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRSxI9aZ6EAYQ+wA5qyOwy/XM4Nkwjy40kAPAbp3o4pv5/BXgOPa19NBdxYdzvct9
         HENqCIOHl4GEFYVQ6yM+RJaESXaQq0gBOU2cWaYojs/b8dB4Bahd7ts9zHb3JoytAD
         GuEndFpHxpNO9Gu4bEAAcDjebNRRn0e70o+b8+4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 108/168] drm/nouveau: fix oops in client init failure path
Date:   Mon,  8 Oct 2018 20:31:28 +0200
Message-Id: <20181008175624.154890608@linuxfoundation.org>
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

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit a43b16dda2d7485f5c5aed075c1dc9785e339515 ]

The NV_ERROR macro requires drm->client to be initialised, which it may not
be at this stage of the init process.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -230,7 +230,7 @@ nouveau_cli_init(struct nouveau_drm *drm
 		mutex_unlock(&drm->master.lock);
 	}
 	if (ret) {
-		NV_ERROR(drm, "Client allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "Client allocation failed: %d\n", ret);
 		goto done;
 	}
 
@@ -240,37 +240,37 @@ nouveau_cli_init(struct nouveau_drm *drm
 			       }, sizeof(struct nv_device_v0),
 			       &cli->device);
 	if (ret) {
-		NV_ERROR(drm, "Device allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "Device allocation failed: %d\n", ret);
 		goto done;
 	}
 
 	ret = nvif_mclass(&cli->device.object, mmus);
 	if (ret < 0) {
-		NV_ERROR(drm, "No supported MMU class\n");
+		NV_PRINTK(err, cli, "No supported MMU class\n");
 		goto done;
 	}
 
 	ret = nvif_mmu_init(&cli->device.object, mmus[ret].oclass, &cli->mmu);
 	if (ret) {
-		NV_ERROR(drm, "MMU allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "MMU allocation failed: %d\n", ret);
 		goto done;
 	}
 
 	ret = nvif_mclass(&cli->mmu.object, vmms);
 	if (ret < 0) {
-		NV_ERROR(drm, "No supported VMM class\n");
+		NV_PRINTK(err, cli, "No supported VMM class\n");
 		goto done;
 	}
 
 	ret = nouveau_vmm_init(cli, vmms[ret].oclass, &cli->vmm);
 	if (ret) {
-		NV_ERROR(drm, "VMM allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "VMM allocation failed: %d\n", ret);
 		goto done;
 	}
 
 	ret = nvif_mclass(&cli->mmu.object, mems);
 	if (ret < 0) {
-		NV_ERROR(drm, "No supported MEM class\n");
+		NV_PRINTK(err, cli, "No supported MEM class\n");
 		goto done;
 	}
 


