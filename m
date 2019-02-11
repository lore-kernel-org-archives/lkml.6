Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A29C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF7D20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901515;
	bh=yb+7OU8AjDwtALOAyPqJSf3XJnC2ddy3gXsdSEkW/Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STwoIa1O4JJdqeV0ZTkHPEnCQkkBKI7tzM1GxxGjO1xN1+LGfLKDymG2PMuaueNxm
	 SDwOP1i1b/Aw5JcGPvsKd7QqMzXnBUn/Ob+KXHJrjFoYscIvWMcayHofGEIAv1fyE6
	 dlJO7apSgdmSZOr4YxIIj59mb5j9qtHv6Ah6JkFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfBKOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfBKOXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D176222AA;
        Mon, 11 Feb 2019 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895017;
        bh=yb+7OU8AjDwtALOAyPqJSf3XJnC2ddy3gXsdSEkW/Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vs9kKFSyvJc5Mr+ZENgzJZTka2qAbnk9NOarCoFHYKQVceeNunUAhFq6JtVtIYXNy
         GTbtvVY9jTp/qebd6bxhaQTPmmGxzGbkp9SJwZRgAuXUHxHgwAuzfyvBtFoJB6xQFk
         RtmjJ05mkInYw7qlcaHrNWzCL45z6nLpD0FkTV0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 063/352] media: vivid: fill in media_device bus_info
Date:   Mon, 11 Feb 2019 15:14:50 +0100
Message-Id: <20190211141850.142407576@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e10b40f3304360d3a2d07d690ff12197f828f2c8 ]

If you create multiple vivid instances, each with their own media
device, then there was no way to tell them apart.

Fill in the bus_info so each instance has a unique bus_info string.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vivid/vivid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/vivid/vivid-core.c b/drivers/media/platform/vivid/vivid-core.c
index 626e2b24a403..ec1b1a8ea775 100644
--- a/drivers/media/platform/vivid/vivid-core.c
+++ b/drivers/media/platform/vivid/vivid-core.c
@@ -669,6 +669,8 @@ static int vivid_create_instance(struct platform_device *pdev, int inst)
 
 	/* Initialize media device */
 	strlcpy(dev->mdev.model, VIVID_MODULE_NAME, sizeof(dev->mdev.model));
+	snprintf(dev->mdev.bus_info, sizeof(dev->mdev.bus_info),
+		 "platform:%s-%03d", VIVID_MODULE_NAME, inst);
 	dev->mdev.dev = &pdev->dev;
 	media_device_init(&dev->mdev);
 	dev->mdev.ops = &vivid_media_ops;
-- 
2.19.1



