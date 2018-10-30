Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B0ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2EF20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2EF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJ3S6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:58:13 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:33376 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeJ3S6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:58:12 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.73])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1587FA4C;
        Tue, 30 Oct 2018 18:05:16 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 40562390;
        Tue, 30 Oct 2018 18:05:11 +0800 (CST)
X-RL-SENDER: tony.xie@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: tony.xie@rock-chips.com
X-UNIQUE-TAG: <522ef8704b132ace1c41bb00a457b503>
X-ATTACHMENT-NUM: 0
X-SENDER: xxx@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 11686XWSHB9;
        Tue, 30 Oct 2018 18:05:15 +0800 (CST)
From:   Tony Xie <tony.xie@rock-chips.com>
To:     heiko@sntech.de
Cc:     broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: [PATCH v6 1/6] regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)
Date:   Tue, 30 Oct 2018 18:07:56 +0800
Message-Id: <1540894081-31270-2-git-send-email-tony.xie@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540894081-31270-1-git-send-email-tony.xie@rock-chips.com>
References: <1540894081-31270-1-git-send-email-tony.xie@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if there are lots of irqs for a device and the register addresses for these
irqs is continuous, we can use this macro to initialize regmap_irq value.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
---
 include/linux/regmap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..a468b81 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1047,6 +1047,12 @@ struct regmap_irq {
 #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
 	[_irq] = { .reg_offset = (_off), .mask = (_mask) }
 
+#define REGMAP_IRQ_REG_LINE(_id, _reg_bits) \
+	[_id] = {				\
+		.mask = BIT((_id) % (_reg_bits)),	\
+		.reg_offset = (_id) / (_reg_bits),	\
+	}
+
 /**
  * struct regmap_irq_chip - Description of a generic regmap irq_chip.
  *
-- 
1.9.1


