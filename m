Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9FB2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9FB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeIXSoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:44:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeIXSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:44:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E92E5109F;
        Mon, 24 Sep 2018 12:42:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karol Herbst <karolherbst@gmail.com>,
        Martin Peres <martin.peres@free.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 185/235] drm/nouveau/debugfs: Wake up GPU before doing any reclocking
Date:   Mon, 24 Sep 2018 13:52:51 +0200
Message-Id: <20180924113123.053899722@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Karol Herbst <karolherbst@gmail.com>

[ Upstream commit eaeb9010bb4bcdc20e58254fa42f3fe730a7f908 ]

Fixes various reclocking related issues on prime systems.

Signed-off-by: Karol Herbst <karolherbst@gmail.com>
Signed-off-by: Martin Peres <martin.peres@free.fr>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -160,7 +160,11 @@ nouveau_debugfs_pstate_set(struct file *
 		args.ustate = value;
 	}
 
+	ret = pm_runtime_get_sync(drm->dev);
+	if (IS_ERR_VALUE(ret) && ret != -EACCES)
+		return ret;
 	ret = nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_USER, &args, sizeof(args));
+	pm_runtime_put_autosuspend(drm->dev);
 	if (ret < 0)
 		return ret;
 


