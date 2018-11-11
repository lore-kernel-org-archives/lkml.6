Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6013AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69420862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeKKUyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:54:44 -0500
Received: from mailoutvs53.siol.net ([185.57.226.244]:37309 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbeKKUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:54:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C790752373C;
        Sun, 11 Nov 2018 12:06:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mn1cl_yAPn0d; Sun, 11 Nov 2018 12:06:26 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 883C7523733;
        Sun, 11 Nov 2018 12:06:26 +0100 (CET)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 25F8852373C;
        Sun, 11 Nov 2018 12:06:26 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Subject: [PATCH] media: media-request: Add compat ioctl
Date:   Sun, 11 Nov 2018 12:06:21 +0100
Message-Id: <20181111110621.18683-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently media request ioctl operations fail on 64-bit kernel with
32-bit userspace due to missing .compat_ioctl callback.

Because no ioctl command uses any argument, just reuse existing ioctl
handler for compat_ioctl too.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/media/media-request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/media-request.c b/drivers/media/media-request.=
c
index 4e9db1fed697..c71a34ae6383 100644
--- a/drivers/media/media-request.c
+++ b/drivers/media/media-request.c
@@ -238,6 +238,9 @@ static const struct file_operations request_fops =3D =
{
 	.owner =3D THIS_MODULE,
 	.poll =3D media_request_poll,
 	.unlocked_ioctl =3D media_request_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =3D media_request_ioctl,
+#endif /* CONFIG_COMPAT */
 	.release =3D media_request_close,
 };
=20
--=20
2.19.1

