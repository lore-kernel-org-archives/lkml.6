Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B2FC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8439D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8439D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeKTWAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:00:41 -0500
Received: from www.osadl.org ([62.245.132.105]:60976 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbeKTWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:00:40 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wAKBSGST017739;
        Tue, 20 Nov 2018 12:28:17 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ioannis Valasakis <code@wizofe.uk>,
        Irenge Jules Bashizi <jbi.octave@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Michelle Darcy <mdarcy137@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] media: davinci_vpfe: bail out if kmalloc failed
Date:   Tue, 20 Nov 2018 12:25:29 +0100
Message-Id: <1542713129-14110-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The kmalloc is passed indirectly to  from  but with an offset
which if not 0 will cause the null check if (to && from && size) 
to succeed. An explicit !NULL check is thus added for params here.

 ipipe_s_config and ipipe_g_config - both fail to check kmalloc
are called from ipipe_ioctl where a negative return is a valid
indication of error so simply setting rval = -ENOMEM seems ok.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: da43b6ccadcf ("[media] davinci: vpfe: dm365: add IPIPE support for media controller driver")
---

Problem located with experimental coccinelle patch

Patch was compile tested with: davinci_all_defconfig + SAGING=y,
STAGING_MEDIA=y, MEDIA_SUPPORT=m, MEDIA_CONTROLLER=y,
VIDEO_V4L2_SUBDEV_API=y, VIDEO_DAVINCI_VPBE_DISPLAY=m,
VIDEO_DM365_VPFE=m
(with some coccicheck findings unrelated to the proposed change)

Patch is against 4.20-rc3 (localversion-next is next-20181120)

 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index 3d910b8..0150aed 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
@@ -1266,6 +1266,11 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 		params = kmalloc(sizeof(struct ipipe_module_params),
 				 GFP_KERNEL);
+		if (!params) {
+			rval = -ENOMEM;
+			goto error;
+		}
+
 		to = (void *)params + module_if->param_offset;
 		size = module_if->param_size;
 
@@ -1308,6 +1313,11 @@ static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 		params = kmalloc(sizeof(struct ipipe_module_params),
 				 GFP_KERNEL);
+		if (!params) {
+			rval = -ENOMEM;
+			goto error;
+		}
+
 		from = (void *)params + module_if->param_offset;
 		size = module_if->param_size;
 
-- 
2.1.4

