Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B032DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D297204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYroXTS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbeLQNW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:22:27 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54727 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbeLQNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:22:26 -0500
Received: by mail-qk1-f201.google.com with SMTP id i37so15200036qkh.21
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eChXhE6DxIh/we37Q5Zla+fn+L5z5gFtFhFXKWl5OP4=;
        b=qYroXTS4U9VE5GtX3yTaETPEPsrB/JqejYfiuxSBDtEPYKsN6G8NJf4LVIBSl9rV5Y
         j6y+KZSHdcbUkcHJwxrVHBMGFveC5Iu4i+dt6vST5firRTY2lqdzIgK16UMBtGmU9FI5
         CyAuj8NKRArRrKlYOtDE9CbiyVdrGfbiGCt2hkqWyJkzs800IfG/wDubeUheWJawaznJ
         7pxTQoX8XOXd8hYPjEh6lxEC7X8gFmxPO+MVwMvlC1iOPARkpRzb8Q2H8dfx2xJ5zi1r
         GDWpkjChDjG8qShJMb8Fn5zVBrV369FmKlUOoouzuW7APCcO7c+12jQPU2JeOP69J5N5
         Hd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eChXhE6DxIh/we37Q5Zla+fn+L5z5gFtFhFXKWl5OP4=;
        b=If7+SpDvOpAAF+3kcJ5pXCZws0rZO11eu+JGVr6mGD7M7J5aCvtOZYc2qQnJ3NxREM
         Ea17XoDmXwoowwNhyH8eqfcX9+KVJmT/hMnylf/cqoZEn+rgq3sI440GF6nMbqp+gPnP
         Iz1O/jTyN9CgS7Cxzb4kPeZzjsRBQahqijePvwU3bG0VDkH/KUFhFT1AqCj4BTYx7k/I
         vXkyobVLT2QpXsCvhXKLR/klXkOLbiaarSVFFgXuregLAqPKV+gPWOo4huBHIOQ9/VeF
         mcfMewN3XHwXF1xCnwHK7jM/Nqvcg8W6p/tr2AxlIXhaZHHr51F5iJH+ODssJu/wVFkR
         Xzsw==
X-Gm-Message-State: AA+aEWZFczmrlWE6R7ifJjV5WIa3mNBnws22yFbJf39jMuyhP0UoImFV
        Vx1uySCFmqs5MpAor+DAfWbf0BOcL3qM
X-Google-Smtp-Source: AFSGD/VRcKqvreslmIyjADA2vxaI3O882z6uuoupOfvu7A8JPlat6sTdatMJ/fD7wz66ms2m985+uhS6KeST
X-Received: by 2002:a37:a315:: with SMTP id m21mr14143142qke.30.1545052945663;
 Mon, 17 Dec 2018 05:22:25 -0800 (PST)
Date:   Mon, 17 Dec 2018 21:22:13 +0800
Message-Id: <20181217132213.91566-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH v3] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, Adam.Thomson.Opensource@diasemi.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current matching rules ensure that the voltage range of selected Source
Capability is entirely within the range defined in one of the Sink
Capabilities. This is reasonable but not practical because Sink may not
support wide range of voltage when sinking power while Source could
advertise its capabilities in relatively wider range. For example, a
Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed Nominal Voltage)
will not be selected if the Sink requires 5V-12V@3A PPS power. However,
the Sink could work well if the requested voltage range in RDOs is
5V-11V@3A.

Currently accepted:
		|--------- source -----|
	|----------- sink ---------------|

Currently not accepted:
			|--------- source -----|
	|----------- sink ---------------|

	|--------- source -----|
		|----------- sink ---------------|

	|--------- source -----------------|
		|------ sink -------|

To improve the usability, change the matching rules to what listed
below:
a. The Source PDO is selectable if any portion of the voltage range
   overlaps one of the Sink PDO's voltage range.
b. The maximum operational voltage will be the lower one between the
   selected Source PDO and the matching Sink PDO.
c. The maximum power will be the maximum operational voltage times the
   maximum current defined in the selected Source PDO
d. Select the Source PDO with the highest maximum power

Signed-off-by: Kyle Tso <kyletso@google.com>

---
Changelog since v1:
- updated the commit message as suggested by Guenter Roeck <linux@roeck-us.net>

Changelog since v2:
- fixed the coding style problems as suggested by Heikki Krogerus
  <heikki.krogerus@linux.intel.com>
- Corrected a wrong word in the commit message as suggested by Adam Thomson
  <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3620efee2688..4bc29b586698 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 	unsigned int i, j, max_mw = 0, max_mv = 0;
 	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
 	unsigned int min_snk_mv, max_snk_mv;
-	u32 pdo;
+	unsigned int max_op_mv;
+	u32 pdo, src, snk;
 	unsigned int src_pdo = 0, snk_pdo = 0;
 
 	/*
@@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 					continue;
 				}
 
-				if (max_src_mv <= max_snk_mv &&
-				    min_src_mv >= min_snk_mv) {
+				if (min_src_mv <= max_snk_mv &&
+				    max_src_mv >= min_snk_mv) {
+					max_op_mv = min(max_src_mv, max_snk_mv);
+					src_mw = (max_op_mv * src_ma) / 1000;
 					/* Prefer higher voltages if available */
 					if ((src_mw == max_mw &&
-					     min_src_mv > max_mv) ||
+					     max_op_mv > max_mv) ||
 					    src_mw > max_mw) {
 						src_pdo = i;
 						snk_pdo = j;
 						max_mw = src_mw;
-						max_mv = max_src_mv;
+						max_mv = max_op_mv;
 					}
 				}
 			}
@@ -2285,16 +2288,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 	}
 
 	if (src_pdo) {
-		pdo = port->source_caps[src_pdo];
-
-		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
-		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
-		port->pps_data.max_curr =
-			min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
-		port->pps_data.out_volt =
-			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
-		port->pps_data.op_curr =
-			min(port->pps_data.max_curr, port->pps_data.op_curr);
+		src = port->source_caps[src_pdo];
+		snk = port->snk_pdo[snk_pdo];
+
+		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
+					      pdo_pps_apdo_min_voltage(snk));
+		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
+					      pdo_pps_apdo_max_voltage(snk));
+		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
+		port->pps_data.out_volt = min(port->pps_data.max_volt,
+					      port->pps_data.out_volt);
+		port->pps_data.op_curr = min(port->pps_data.max_curr,
+					     port->pps_data.op_curr);
 	}
 
 	return src_pdo;
-- 
2.20.0.405.gbc1bbc6f85-goog

