Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B4A222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899889;
	bh=tOZlFF/0WJTg0g3PjwW747psDpVoNb9V+2Am2T7KqIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIR/q6m3lt9koPwSTDXhnpuiykVWLh4DcJ7J3PKpHccwZ3OnJtMy+w+enDLubBq8M
	 /9oGbrWPWiB+56dDUnPUWseLGH5OVGNby8cQln6s+WUebSmPn/RMShbBgK6hkc5AkA
	 zRl4d975ukkN/VKt5HjSo2kNAji7P4DaapBYYldM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfBKPos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732766AbfBKOoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C8520844;
        Mon, 11 Feb 2019 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896248;
        bh=tOZlFF/0WJTg0g3PjwW747psDpVoNb9V+2Am2T7KqIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sx+vzvfNH2bkCTsDKmvWTJNuK5LQz99FDrcuF5UZyVnxF9DAVY49JUDJBh69F+so
         radqQE4xA17yje1jBjPWhJczdRgTp2MW8s5OX1zSkkxNELtMjBNQrd0ocW7ufvjsNc
         h21zIVNOHbcmsRZ35zd5G9CWuI63ggjiQr8ZrDm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/313] media: i2c: TDA1997x: select CONFIG_HDMI
Date:   Mon, 11 Feb 2019 15:16:11 +0100
Message-Id: <20190211141859.930875260@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 79e89e36dc8a47ef965a35b484d737a5227feed1 ]

Without CONFIG_HDMI, we get a link error for this driver:

drivers/media/i2c/tda1997x.o: In function `tda1997x_parse_infoframe':
tda1997x.c:(.text+0x2195): undefined reference to `hdmi_infoframe_unpack'
tda1997x.c:(.text+0x21b6): undefined reference to `hdmi_infoframe_log'
drivers/media/i2c/tda1997x.o: In function `tda1997x_log_infoframe':
tda1997x.c:(.text.unlikely+0x13d3): undefined reference to `hdmi_infoframe_unpack'
tda1997x.c:(.text.unlikely+0x1426): undefined reference to `hdmi_infoframe_log'

All other drivers in this directory that use HDMI select CONFIG_HDMI,
so do the same here:

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 82af97430e5b..041a777dfdee 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -61,6 +61,7 @@ config VIDEO_TDA1997X
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
 	depends on SND_SOC
 	select SND_PCM
+	select HDMI
 	---help---
 	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
 
-- 
2.19.1



