Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A3D2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D1IamjTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A3D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeK1REq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:04:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34049 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeK1REp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:04:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so9654877pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CP0ZZK7SqB43zKSvumuMlYKiaZyMxI0xBVfIYtC5CkA=;
        b=D1IamjTXkEXtalGe/CAe5Tfj4HAw4u1TftWQ5QZru+RLNmGqft2uZo1f0MgRbgfBUU
         EHsdzo7ncC0DiUQouXjCN47aXgiNGi//IvzoH/NnXY+Rvl40q3aPLVXBr352jojKWZ5j
         JhydCMxHTvi/hFhwVV8gNTw4O0qLxq1ve6G7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CP0ZZK7SqB43zKSvumuMlYKiaZyMxI0xBVfIYtC5CkA=;
        b=J1shaFHGQNXgGh2Lgs26mFXtJqla6BFsgZR3OywScBLZ93JcZxyobQFRkARRe702cq
         MKxNu4yacWCV293YauMDbeLF0vK/uKC8O12MpARQS1jBkTw0cFdGZnY+I1YlmOoL0foN
         Ew/U9RPsGSxarnKMxyEQymU8HJvhOn30JSDmfFwk+qkvoeR8OtAwS3k5W13bMxWQ8aSe
         ddnACk6eNBiUS42+zSKFfZRR4lTz7UEgPziWnOdJo0y0XepTEagj8QyntRMXsD/Rdn4D
         YdrlUF9JNuI6btCduJbcMpVmDsmaH7xjLoWeW3FQhUYRvgkg2dovF3oyyVdzP13xodBo
         5+TA==
X-Gm-Message-State: AA+aEWZ9PAb55lip7w68u/nHgfJE9lWjlBCqlOTb2myF6d4w8l8FzmL/
        DCwL3rIH/8Cga7pXW0CXXkU+3w==
X-Google-Smtp-Source: AFSGD/Upc7VGPqDgAmd1BSZnB+zR3FOjHi3jqz/rHjnH4jQsb3qI8+/8eR6N0Aa3KQdfamknOC7YQw==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr30798324pgd.49.1543385057493;
        Tue, 27 Nov 2018 22:04:17 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id l85sm6598368pfg.161.2018.11.27.22.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 22:04:17 -0800 (PST)
From:   "Hsin-Yi, Wang" <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb/mtu3: power down device ip at setup
Date:   Wed, 28 Nov 2018 14:04:12 +0800
Message-Id: <20181128060412.630-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
so host ip sleep will fail at ssusb_host_disable.

Power down device ip at ssusb_host_setup.

Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
 drivers/usb/mtu3/mtu3_host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index c871b94f3e6f..d17cf43305db 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -192,9 +192,17 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
 static void ssusb_host_setup(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+	void __iomem *ibase = ssusb->ippc_base;
 
 	host_ports_num_get(ssusb);
 
+	/*
+	 * device ip is default power-on in fact
+	 * power down device ip, otherwise ip-sleep will fail
+	 */
+	if (ssusb->dr_mode == USB_DR_MODE_HOST)
+		mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
+
 	/*
 	 * power on host and power on/enable all ports
 	 * if support OTG, gadget driver will switch port0 to device mode
-- 
2.18.1

