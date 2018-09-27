Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0702159B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0702159B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeI0P0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:26:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0P0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:26:04 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F026410A4;
        Thu, 27 Sep 2018 09:08:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 27/88] ASoC: tas6424: Save last fault register even when clear
Date:   Thu, 27 Sep 2018 11:03:08 +0200
Message-Id: <20180927090303.827448741@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Andrew F. Davis <afd@ti.com>

commit d40e3e9e44db4b3c8777f3b515ba6097ba26e3b2 upstream.

When there is no fault bit set in a fault register we skip the fault
reporting section for that register. This also skips over saving that
registers value. We save the value so we will not double report an
error, but if an error clears then returns we will also not report it
as we did not save the all cleared register value. Fix this by saving
the fault register value in the all clear path.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/tas6424.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -424,8 +424,10 @@ static void tas6424_fault_check_work(str
 	       TAS6424_FAULT_PVDD_UV |
 	       TAS6424_FAULT_VBAT_UV;
 
-	if (reg)
+	if (!reg) {
+		tas6424->last_fault1 = reg;
 		goto check_global_fault2_reg;
+	}
 
 	/*
 	 * Only flag errors once for a given occurrence. This is needed as
@@ -461,8 +463,10 @@ check_global_fault2_reg:
 	       TAS6424_FAULT_OTSD_CH3 |
 	       TAS6424_FAULT_OTSD_CH4;
 
-	if (!reg)
+	if (!reg) {
+		tas6424->last_fault2 = reg;
 		goto check_warn_reg;
+	}
 
 	if ((reg & TAS6424_FAULT_OTSD) && !(tas6424->last_fault2 & TAS6424_FAULT_OTSD))
 		dev_crit(dev, "experienced a global overtemp shutdown\n");
@@ -497,8 +501,10 @@ check_warn_reg:
 	       TAS6424_WARN_VDD_OTW_CH3 |
 	       TAS6424_WARN_VDD_OTW_CH4;
 
-	if (!reg)
+	if (!reg) {
+		tas6424->last_warn = reg;
 		goto out;
+	}
 
 	if ((reg & TAS6424_WARN_VDD_UV) && !(tas6424->last_warn & TAS6424_WARN_VDD_UV))
 		dev_warn(dev, "experienced a VDD under voltage condition\n");


