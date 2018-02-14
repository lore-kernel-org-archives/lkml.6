Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966817AbeBNDu0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:50:26 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37697 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966671AbeBNDuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:50:22 -0500
X-Google-Smtp-Source: AH8x225PPAbYPnwhkVfOCqs/gi3vxQ4JAT+GBfTXgwO+Vr9LUkAd3mYY267GW1XC3ELqX3LSl46xKw==
From: Leo Yan <leo.yan@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH RESEND v5 1/3] dt-bindings: mailbox: Introduce Hi3660 controller binding
Date: Wed, 14 Feb 2018 11:49:49 +0800
Message-Id: <1518580191-26451-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
References: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a binding for the Hi3660 mailbox controller, the mailbox is
used within application processor (AP), communication processor (CP),
HIFI and MCU, etc.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
new file mode 100644
index 0000000..3e5b453
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
@@ -0,0 +1,51 @@
+Hisilicon Hi3660 Mailbox Controller
+
+Hisilicon Hi3660 mailbox controller supports up to 32 channels.  Messages
+are passed between processors, including application & communication
+processors, MCU, HIFI, etc.  Each channel is unidirectional and accessed
+by using MMIO registers; it supports maximum to 8 words message.
+
+Controller
+----------
+
+Required properties:
+- compatible:		: Shall be "hisilicon,hi3660-mbox"
+- reg:			: Offset and length of the device's register set
+- #mbox-cells:		: Must be 3
+			  <&phandle channel dst_irq ack_irq>
+			    phandle	: Label name of controller
+			    channel	: Channel number
+			    dst_irq	: Remote interrupt vector
+			    ack_irq	: Local interrupt vector
+
+- interrupts:		: Contains the two IRQ lines for mailbox.
+
+Example:
+
+mailbox: mailbox@e896b000 {
+	compatible = "hisilicon,hi3660-mbox";
+	reg = <0x0 0xe896b000 0x0 0x1000>;
+	interrupts = <0x0 0xc0 0x4>,
+		     <0x0 0xc1 0x4>;
+	#mbox-cells = <3>;
+};
+
+Client
+------
+
+Required properties:
+- compatible		: See the client docs
+- mboxes		: Standard property to specify a Mailbox (See ./mailbox.txt)
+			  Cells must match 'mbox-cells' (See Controller docs above)
+
+Optional properties
+- mbox-names		: Name given to channels seen in the 'mboxes' property.
+
+Example:
+
+stub_clock: stub_clock@e896b500 {
+	compatible = "hisilicon,hi3660-stub-clk";
+	reg = <0x0 0xe896b500 0x0 0x0100>;
+	#clock-cells = <1>;
+	mboxes = <&mailbox 13 3 0>;
+};
-- 
1.9.1
