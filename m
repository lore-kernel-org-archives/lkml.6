Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FF1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25811213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25811213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeK2EWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:22:01 -0500
Received: from shell.v3.sk ([90.176.6.54]:39069 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbeK2EWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:22:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B68E5996A0;
        Wed, 28 Nov 2018 18:19:35 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z4zLtW5ehbw0; Wed, 28 Nov 2018 18:19:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 890329978D;
        Wed, 28 Nov 2018 18:19:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CpC3tVJxRvaH; Wed, 28 Nov 2018 18:19:25 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9372B996A0;
        Wed, 28 Nov 2018 18:19:25 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wenyou Yang <wenyou.yang@microchip.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/6] media: v4l2-subdev: stub v4l2_subdev_get_try_format()
Date:   Wed, 28 Nov 2018 18:19:13 +0100
Message-Id: <20181128171918.160643-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128171918.160643-1-lkundrak@v3.sk>
References: <20181128171918.160643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a dummy implementation when configured without
CONFIG_VIDEO_V4L2_SUBDEV_API to avoid ifdef dance in the drivers that can
be built either with or without the option.

Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/media/v4l2-subdev.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 9102d6ca566e..906e28011bb4 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -967,6 +967,17 @@ static inline struct v4l2_rect
 		pad =3D 0;
 	return &cfg[pad].try_compose;
 }
+
+#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
+
+static inline struct v4l2_mbus_framefmt
+*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_pad_config *cfg,
+			    unsigned int pad)
+{
+	return ERR_PTR(-ENOTTY);
+}
+
 #endif
=20
 extern const struct v4l2_file_operations v4l2_subdev_fops;
--=20
2.19.1

