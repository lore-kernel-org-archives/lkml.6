Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637BF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cF8sPaPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637BF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeK2OUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:20:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42435 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeK2OUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:20:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so272441pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 19:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FfEaTpIexbfNgh3WA2OcVxQfootPIVWg5nn9CpgLyKI=;
        b=cF8sPaPd3LzOZgGC0TgpjarH3LcnuzT+OH+UW20hnr3dVGkCPvaGO7/TCjUNNB7a0F
         N0s0Oi+VlRBCApTveTJH30/2eAabgKxm0SqgkljgpnEyDUG256ZTCii9XJSHlYEnQ4yW
         es9QzxAgQtq1cF5DrMsMRzok4CXaSXEEKZ3JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FfEaTpIexbfNgh3WA2OcVxQfootPIVWg5nn9CpgLyKI=;
        b=HCWy16tfodotq+/3Hv1JqSvG34HXOjEPi7LaH91KXurh5DSY4Y9p8mlncHgoHyMldY
         lm67w8hWrp4XS5OGfwYIw0dsMQP/Px3/mOs03+h1svJJa2SjXUBGzBON/grfWhjiPjKM
         NjjbZThmfielfH2BrKXvOF4nslm0CzzcSBOs5NYFsQUH9zWB76xVdhCw+65CYM+3ezMa
         LNnCKIzarY7t2y7xnq4HXX/xMoY8lmONWAk1xxPeGHizUoujWzrSgATSavEIUcBxiR5Y
         0E7SSisKzaeRSMdoKUk/g9l9IYNGKGNL94OMVouyzBcKzgaSCE5UTiyn46QM5aeMAuBY
         7DTQ==
X-Gm-Message-State: AA+aEWapDufcpbPFoP5BbRuFhrHvSFdgE2/YJnOK1+BdvVRJUYdNqigM
        poynrngGN76ja1nCT5ex9Agv0g==
X-Google-Smtp-Source: AFSGD/WWVh5yoCU3KyQUXD36gGUJZ09GN2NPvsKU0c6SJWSKUJRoV2L3noF9Rfh3VwruvTnRWy0QEQ==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr27947535plf.28.1543461393071;
        Wed, 28 Nov 2018 19:16:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z62sm555644pfi.4.2018.11.28.19.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 19:16:32 -0800 (PST)
From:   "Hsin-Yi, Wang" <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] usb/mtu3: power down device ip at setup
Date:   Thu, 29 Nov 2018 11:16:27 +0800
Message-Id: <20181129031627.45006-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181128095358.42498-1-hsinyi@chromium.org>
References: <20181128095358.42498-1-hsinyi@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
so host ip sleep will fail at ssusb_host_disable.

Power down device ip at ssusb_host_setup.

Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
ChangeLog:
V3->V4:
  *update comment
---
 drivers/usb/mtu3/mtu3_plat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 46551f6d16fd..e086630e41a9 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -200,6 +200,14 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
 	udelay(1);
 	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
+
+	/*
+	 * device ip may be powered on in firmware/BROM stage before entering
+	 * kernel stage;
+	 * power down device ip, otherwise ip-sleep will fail when working as
+	 * host only mode
+	 */
+	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
 /* ignore the error if the clock does not exist */
-- 
2.18.1

