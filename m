Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD53C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A209C2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0DUEvItW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A209C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeKAIJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbeKAIJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CB920843;
        Wed, 31 Oct 2018 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027357;
        bh=rJUwVyxf1GmbfVWzsF27heT/w/B7B899yQdjSVJC2iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DUEvItWdwX/5VDNsg3l8E/NBjxukeRbWtK/QdQvCBH5/4KUeP7XvxXYFLLdv1N0o
         Xb7Ns6FNhpDlKDr2HQV8YvcIcHk6Xvzq/K2Kdu8NS0G8A48UE+YGGDXe8ZCeq0iRHT
         Gk9Dr/qqBo8qscAyEXDXZ08mw0Hp2t3313Ha+00k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 091/126] usb: typec: tcpm: Report back negotiated PPS voltage and current
Date:   Wed, 31 Oct 2018 19:07:19 -0400
Message-Id: <20181031230754.29029-91-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

[ Upstream commit 554fab6dbf20ee7298ed2d4e8398b85e6058abb7 ]

Currently when requesting a specific voltage or current through
the psy interface, for PPS, when reading back from that interface
the values will always be the same as previously given, if the
request was successful. However PPS only allows for 20mV voltage
steps and 50mA current steps, and the psy class expects microvolt
and micro amp requests, so inbetween values can be provided through
this interface. Really when reading back the true values negotiated
should be given, and not the ones originally asked for.

To report the actual values negotiated with the Source, the values
stored are now rounded down to the relevant step units prior to
building the PPS request, so that those values are later correctly
reported through the psy interface. In addition this improves the
adjustments made to meet the operating power requirements of the
platform, which previously could have been slightly out due to not
using valid PPS units of voltage and current.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index d1d20252bad8..0a3c41a91cba 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -4018,6 +4018,9 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 		goto port_unlock;
 	}
 
+	/* Round down operating current to align with PPS valid steps */
+	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
+
 	reinit_completion(&port->pps_complete);
 	port->pps_data.op_curr = op_curr;
 	port->pps_status = 0;
@@ -4071,6 +4074,9 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 		goto port_unlock;
 	}
 
+	/* Round down output voltage to align with PPS valid steps */
+	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
+
 	reinit_completion(&port->pps_complete);
 	port->pps_data.out_volt = out_volt;
 	port->pps_status = 0;
-- 
2.17.1

