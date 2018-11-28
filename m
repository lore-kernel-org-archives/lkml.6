Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C7AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212B220832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbgq0hX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212B220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeK1UzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:55:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36569 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeK1UzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:55:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so9276029pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phuOQIHhtaiR8GKkWxLxlxfb87tGYPgu+E8hPrCYdbs=;
        b=jbgq0hX/OBEwP9H7k7pO2RwzvNfpvBVKnjj80CGRXEdMwt9Y/1vhBdGPxhL292ua2g
         LKTgHYfYER+ZLzOMfQhCwfA40Q82Q+c4Y9knDBVM15zD/b7Ol2jlfAqLs0a2LdRps/v9
         jzMGR9cyccdeJ+hp2/k4XzzBVqqZJSBJQduCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=phuOQIHhtaiR8GKkWxLxlxfb87tGYPgu+E8hPrCYdbs=;
        b=WAwaGh5V6jgpXZXTin3UelNqG2sjClx1mot69ZC9pzaqfswNdYwch2vBrEmyX3Eguy
         TTcts4Sy55vRjUu3No8ePPA/vJfiMLIedFro4+749/bFivu+pw7cB5K3fc0ALyUX0heQ
         OupLPPKTWS80Kge8CPFuCEuFNqNTWFq5CElgHS183VbpvnYugptfcSC88BAHK82QJlMB
         efaE3CVo5hCQWQ0LouCpPrcDeM4dhAIiR3wqYYTJAz4ftidNs6cELkQrbCG86mxApkOb
         hr2f8hPPhPo1RmU171wbYMfc2Ng1T8zRM/gKSlUX9fFgyrhYgQI7ei0S4d1AitedaCVf
         jJUg==
X-Gm-Message-State: AA+aEWY+6l9XobKFlew7RNJL9k5F1eqkNoMF1LlJPBXrstnENJ7XcxIR
        eOqhCIuu8/lsd9aRQ3SRhDByGQ==
X-Google-Smtp-Source: AFSGD/U6fm79MyS8kX8LQgobST9zhr3DlMly+JetZVc4psrEkCAiLkRG75+VGUt+EtDzk64sNRfl7g==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr20472163pfc.135.1543398842768;
        Wed, 28 Nov 2018 01:54:02 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id r130sm11223806pfr.48.2018.11.28.01.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 01:54:02 -0800 (PST)
From:   "Hsin-Yi, Wang" <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [V3] usb/mtu3: power down device ip at setup
Date:   Wed, 28 Nov 2018 17:53:58 +0800
Message-Id: <20181128095358.42498-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181128092953.41541-1-hsinyi@chromium.org>
References: <20181128092953.41541-1-hsinyi@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
so host ip sleep will fail at ssusb_host_disable.

Power down device ip at ssusb_host_setup.

Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
 drivers/usb/mtu3/mtu3_plat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 46551f6d16fd..792c420fd4ad 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -200,6 +200,13 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
 	udelay(1);
 	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
+
+	/*
+	 * device ip maybe poweron in LK/BROM stage before enter kernel stage;
+	 * power down device ip, otherwise ip-sleep will fail when works as host
+	 * only mode
+	 */
+	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
 /* ignore the error if the clock does not exist */
-- 
2.18.1

