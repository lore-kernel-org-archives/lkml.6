Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08DD0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B276F208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i48posBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B276F208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeFNOqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965156AbeFNOIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:08:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BB4208CB;
        Thu, 14 Jun 2018 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985282;
        bh=+B7mUMwhHJTKVjzGSTbhgOsg79YBL/D4wfGF7Y+8Uwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i48posBbbY57UDbXph1K8GidIwS3EKyjhO1sBIq/KxSlxwOQtfeo7XmyJ5uPFL82F
         wgj7ybYoGQy7W+J9TxytVk+/yG7n99tBmYd1OjXUw9DuqG+UkqT9/cEMUbEX21787K
         LD0LxvJ934vt+2xJ9XydIm4bUuayyDKEUP0m/V3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.16 17/43] usb: typec: wcove: Remove dependency on HW FSM
Date:   Thu, 14 Jun 2018 16:04:21 +0200
Message-Id: <20180614132135.990644938@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 05826ff135ee083d28c006fbde6e810f17437166 upstream.

The USB Type-C PHY in Intel WhiskeyCove PMIC has build-in
USB Type-C state machine which we were relying on to
configure the CC lines correctly. This patch removes that
dependency and configures the CC line according to commands
from the port manager (tcpm.c) in wcove_set_cc().

This fixes an issue where USB devices attached to the USB
Type-C port do not get enumerated. When acting as
source/host, the HW FSM sometimes fails to configure the PHY
correctly.

Fixes: 3c4fb9f16921 ("usb: typec: wcove: start using tcpm for USB PD support")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/typec_wcove.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/typec_wcove.c
+++ b/drivers/usb/typec/typec_wcove.c
@@ -202,6 +202,10 @@ static int wcove_init(struct tcpc_dev *t
 	struct wcove_typec *wcove = tcpc_to_wcove(tcpc);
 	int ret;
 
+	ret = regmap_write(wcove->regmap, USBC_CONTROL1, 0);
+	if (ret)
+		return ret;
+
 	/* Unmask everything */
 	ret = regmap_write(wcove->regmap, USBC_IRQMASK1, 0);
 	if (ret)
@@ -285,8 +289,30 @@ static int wcove_get_cc(struct tcpc_dev
 
 static int wcove_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
 {
-	/* XXX: Relying on the HW FSM to configure things correctly for now */
-	return 0;
+	struct wcove_typec *wcove = tcpc_to_wcove(tcpc);
+	unsigned int ctrl;
+
+	switch (cc) {
+	case TYPEC_CC_RD:
+		ctrl = USBC_CONTROL1_MODE_SNK;
+		break;
+	case TYPEC_CC_RP_DEF:
+		ctrl = USBC_CONTROL1_CURSRC_UA_80 | USBC_CONTROL1_MODE_SRC;
+		break;
+	case TYPEC_CC_RP_1_5:
+		ctrl = USBC_CONTROL1_CURSRC_UA_180 | USBC_CONTROL1_MODE_SRC;
+		break;
+	case TYPEC_CC_RP_3_0:
+		ctrl = USBC_CONTROL1_CURSRC_UA_330 | USBC_CONTROL1_MODE_SRC;
+		break;
+	case TYPEC_CC_OPEN:
+		ctrl = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_write(wcove->regmap, USBC_CONTROL1, ctrl);
 }
 
 static int wcove_set_polarity(struct tcpc_dev *tcpc, enum typec_cc_polarity pol)


