Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24314C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73B4204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498914;
	bh=fMa151jteBhDx6yIqm2yaPxv9r5fVyj4U1kXQaqWKGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vqkeW2l0ByqQzrgy+V+w4EEl7pS4nOxmg/7V+qBy3cDDxOHCG5b3yK19S5UIi5jEL
	 dqwA6IyISOmA/5lRralC+4vEfsh58uxKbVAnBIPwSDcFkOuOtn1RDPzzgx2X6CzINO
	 /lWDsQ0lwu164W+vLGBBzr7LKSave/XZEGuTjShU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbfBROIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389506AbfBROI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59A6204FD;
        Mon, 18 Feb 2019 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498909;
        bh=fMa151jteBhDx6yIqm2yaPxv9r5fVyj4U1kXQaqWKGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEmYcUSUMe3RqLLDnzE9CKpZQ35dGPztmObeIkX1scyPn2ViU+86vEQDwEHYczKzR
         zacVKVHbWA1ra4Kpb4uCHXHGYgJQvs84uvOsT2PnQgpgBf8RTP5zOOoDgfwx2ehlR/
         dVLNt5A8VJ6CzoE6oz35cwTGen2fOGKJ2jh9Fq0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 016/108] media: DaVinci-VPBE: fix error handling in vpbe_initialize()
Date:   Mon, 18 Feb 2019 14:43:12 +0100
Message-Id: <20190218133520.262102150@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aa35dc3c71950e3fec3e230c06c27c0fbd0067f8 ]

If vpbe_set_default_output() or vpbe_set_default_mode() fails,
vpbe_initialize() returns error code without releasing resources.

The patch adds error handling for that case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpbe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/davinci/vpbe.c
index 33b9660b7f77..40d462cac5ec 100644
--- a/drivers/media/platform/davinci/vpbe.c
+++ b/drivers/media/platform/davinci/vpbe.c
@@ -740,7 +740,7 @@ static int vpbe_initialize(struct device *dev, struct vpbe_device *vpbe_dev)
 	if (ret) {
 		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to set default output %s",
 			 def_output);
-		return ret;
+		goto fail_kfree_amp;
 	}
 
 	printk(KERN_NOTICE "Setting default mode to %s\n", def_mode);
@@ -748,12 +748,15 @@ static int vpbe_initialize(struct device *dev, struct vpbe_device *vpbe_dev)
 	if (ret) {
 		v4l2_err(&vpbe_dev->v4l2_dev, "Failed to set default mode %s",
 			 def_mode);
-		return ret;
+		goto fail_kfree_amp;
 	}
 	vpbe_dev->initialized = 1;
 	/* TBD handling of bootargs for default output and mode */
 	return 0;
 
+fail_kfree_amp:
+	mutex_lock(&vpbe_dev->lock);
+	kfree(vpbe_dev->amp);
 fail_kfree_encoders:
 	kfree(vpbe_dev->encoders);
 fail_dev_unregister:
-- 
2.19.1



