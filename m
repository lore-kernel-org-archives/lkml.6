Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC261C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70BE2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8TjODhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfA3DOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:14:35 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34342 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfA3DOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:14:33 -0500
Received: by mail-qt1-f202.google.com with SMTP id u32so27469509qte.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 19:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O3pIKEgprI/dyamSyKpdbIBNGvXWdN0U7O3IxM7kDl0=;
        b=l8TjODhzqqskj+pg62gWaQkMtEoyx0eQSL9NvHv+2xOAvhhaPe6gQV8Vf80vbjwcxP
         4Uff2rV87tAhUEMNaGw9WlMPv5FglxhJ9hmLcCUg3SCFyHIin5jNSYTc9bEjYHNhxnfS
         UdWhwbB8iH2rB/GemV//6TaSyjUIR/TKGwqkIeCGHtdYZbQIX9PKieeHsxCMxuVvWDYH
         zC2jyOw3t1tJe0vLRnA+LHEKiSHEGO4U8ZDkuH82wJSQ6E8rsy9wsuPY0SCgnDb68fu5
         Jo9q5mfVvR5zXGwpHi7qcalwFEOIF1K8b5W0ijdkqsgWOw5jODry6wMMcYuxKzGd+h6N
         Tojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O3pIKEgprI/dyamSyKpdbIBNGvXWdN0U7O3IxM7kDl0=;
        b=XXFcSh4g8DKLnfF1kiR92Cr/rnFkPGGzEhKbWP6lfvHs5s/jo3yLWacp1gknK8j84I
         AHqlXiJTQxMGgIqB7oX5+OdDSkWkTzmsYNhwE5AWp4bYgFhE7SxvNPr/L+OxeRDTHQbv
         5VUEUMCFhLYLWs/C4TxttdY9iN4jXuJHwYltFMRBwkr9aDvKNvpZGsKtArFm3QsgnE1U
         x5/nrc65HQyBC3C/1LzBxpPVGtVoaY6HpnJhrjvw505onWSk6N/Mo1VgsBL5oX0MJDXo
         Ouz1i0X3rqyIytvCosConrDeT574xZWkDATcWwdxnV5UyBa2th0Xe7kW6zSa84FU21hZ
         lwig==
X-Gm-Message-State: AHQUAuaxyqRtn3DGPLs45XLsmyMLdub4u5/PeSJbDlZ/xD++6/FYAd3q
        SbrKp787S9RTFLbFjlFb4WIbEGqEkETE
X-Google-Smtp-Source: AHgI3IaaaRkX4e9Fh9I7UTUwoKS6/qooIGNA7zRQa4s7o8HZD2Qifx11EXx+SCK+/+SABgsWd9rol4khEkbp
X-Received: by 2002:a37:e40e:: with SMTP id y14mr4837145qkf.38.1548818072686;
 Tue, 29 Jan 2019 19:14:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:13:53 +0800
Message-Id: <20190130031353.100228-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] usb: typec: tcpm: Correct the PPS out_volt calculation
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, Adam.Thomson.Opensource@diasemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Sink negotiates PPS, the voltage range of selected PPS APDO might
not cover the previous voltage (out_volt). If the previous out_volt is
lower than the new min_volt, the output voltage in RDO might be set to
an invalid value. For instance, supposed that the previous voltage is
5V, and the new voltage range in the APDO is 7V-12V. Then the output
voltage in the RDO should not be set to 5V which is lower than the
possible min_volt 7V.

Fix this by choosing the maximal value between the previous voltage and
the new min_volt first. And ensure that this value will not exceed the
new max_volt. The new out_volt will fall within the new voltage range
while being the closest value compared to the previous out_volt.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f1d3e54210df..8f2af348bda5 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2297,7 +2297,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 					      pdo_pps_apdo_max_voltage(snk));
 		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
 		port->pps_data.out_volt = min(port->pps_data.max_volt,
-					      port->pps_data.out_volt);
+					      max(port->pps_data.min_volt,
+						  port->pps_data.out_volt));
 		port->pps_data.op_curr = min(port->pps_data.max_curr,
 					     port->pps_data.op_curr);
 	}
-- 
2.20.1.495.gaa96b0ce6b-goog

