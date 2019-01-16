Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D11C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAD720840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ME/UHrqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfAPVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:18:53 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55534 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfAPVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ODKVwioI1OjspNMWnexaPX78Xq+7wuCKuu9zTO60uOQ=; b=ME/UHrqdvocww4Khy6voq0QkD
        FX1KKZ5BRucne9Ex9+xBBD3J2rdAt3W7JxzC3ASQtbasBCFcycajQifzGatvyOa1oOs2XRlSjp2+D
        vAA/SIh5XR4RrVae0EdZJjfDEdAnqy4UFA717ErwaJikDV3nNMWSYlUZqn5epykUYBY4g=;
Received: from p200300ccfbcc8e007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsaD-0006Il-Ce; Wed, 16 Jan 2019 22:18:45 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsaB-0001f7-UR; Wed, 16 Jan 2019 22:18:44 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/6] gnss: sirf: set power state initially off
Date:   Wed, 16 Jan 2019 22:18:08 +0100
Message-Id: <20190116211812.6337-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190116211812.6337-1-andreas@kemnade.info>
References: <20190116211812.6337-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the GTA04 mobile phone, it was observed that the gps was powered
on sometimes intially. Generally a reboot without powering the device
off (direct reset of the processor, reboot from a system where gps
power toggle was done in userspace) or glitches on the gpio pin during
power on could cause this problem.
This has the drawback that probing takes some seconds on
systems without wakeup signal. On systems with wakeup signal
this penalty is much lower.
But if the chip is initially on and that is not fixed, the suspend
current will be multiple times higher, so this sacrifice should
be justified

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
- was part of 2/5 in v2

 drivers/gnss/sirf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index b21e14351b82..c7706b91f6f0 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -367,6 +367,13 @@ static int sirf_probe(struct serdev_device *serdev)
 	if (IS_ENABLED(CONFIG_PM)) {
 		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
 		pm_runtime_enable(dev);
+		/*
+		 * Device might be enabled at boot, so ensure it is off.
+		 * This was observed in practice on GTA04.
+		 */
+		ret = sirf_set_active(data, false);
+		if (ret < 0)
+			goto err_disable_rpm;
 	} else {
 		ret = sirf_runtime_resume(dev);
 		if (ret < 0)
-- 
2.11.0

