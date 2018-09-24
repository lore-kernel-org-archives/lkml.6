Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE608ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F3B21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F3B21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbeIXSgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbeIXSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4D6B1018;
        Mon, 24 Sep 2018 12:34:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 4.18 116/235] usb: mtu3: fix error of xhci port id when enable U3 dual role
Date:   Mon, 24 Sep 2018 13:51:42 +0200
Message-Id: <20180924113117.616351333@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

commit 78af87b8bbbbcaa613f1a7d8f14472fe9a7dc622 upstream.

If dual role mode is enabled, when switch u3port0 to device mode,
it will affect port id calculation of host(xHCI), specially when
host supports multi U2 ports or U3 ports, so need enable its dual
role mode, and fix it here.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mtu3/mtu3_core.c    |    6 +++++-
 drivers/usb/mtu3/mtu3_hw_regs.h |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -107,8 +107,12 @@ static int mtu3_device_enable(struct mtu
 		(SSUSB_U2_PORT_DIS | SSUSB_U2_PORT_PDN |
 		SSUSB_U2_PORT_HOST_SEL));
 
-	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG)
+	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG) {
 		mtu3_setbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
+		if (mtu->is_u3_ip)
+			mtu3_setbits(ibase, SSUSB_U3_CTRL(0),
+				     SSUSB_U3_PORT_DUAL_MODE);
+	}
 
 	return ssusb_check_clocks(mtu->ssusb, check_clk);
 }
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -459,6 +459,7 @@
 
 /* U3D_SSUSB_U3_CTRL_0P */
 #define SSUSB_U3_PORT_SSP_SPEED	BIT(9)
+#define SSUSB_U3_PORT_DUAL_MODE	BIT(7)
 #define SSUSB_U3_PORT_HOST_SEL		BIT(2)
 #define SSUSB_U3_PORT_PDN		BIT(1)
 #define SSUSB_U3_PORT_DIS		BIT(0)


