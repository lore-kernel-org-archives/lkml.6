Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1916C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B763C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACECHN3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeLQCsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:48:15 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:53568 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeLQCsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:48:13 -0500
Received: by mail-vs1-f74.google.com with SMTP id b203so6935203vsd.20
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 18:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KMSD3HZeH7+p+uIpf0LJMvP3U8jMEzBCD/6rZaSkLsc=;
        b=ACECHN3EpIjCSGZ9Itbm1Z9Q4Ms9qp56xEkrn13GjALavz+GyUkF5ay14GUP+9LwRR
         wFxRYCoik3buPZ+aas9oo8FmAhlt6TIHvVdzrsZJ3QN8SHQPkD3J5uuPtl6PHN5oNIk8
         IYX5pUiG/UGhQbqMSAzxGRYF+qwW7nJP5eyanC6aWRH4kC2qMuZ1NyiZkMfhDHBxeafT
         84zJZrG/aQ44ptjeCyIF+7Too/LNb0t3XuS/8DXcbncuZ5T46vyOHE0AtfFzojmgthDN
         lujGG80+1EXFYt8+jsv52eMtAcfYGruzg3hGW7Tk7FP2KGVbbgz8AB4+MZ2psesRAu0W
         qK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KMSD3HZeH7+p+uIpf0LJMvP3U8jMEzBCD/6rZaSkLsc=;
        b=tWz2Ve7GrjcM2oAgRk1JxuKFC+S/8KjeLytsel8XdIW/zlKG7+OlHe5X9OSkZW/Q+8
         ps5nQ4an21YA38OAVARudXuko9pJL6hTL5Fi8pNOM2Jxvl5ccpR0DjW3YWJPaJYqHzF+
         ml+cnM2mtJAxAh/0RRWHw6TEKmb5d8qfOCK4KPTpF+K5cpv0gBxIjy8gGmRmb7r5xoAj
         Ry48r8FOa9SLiziFIl5d2DYVC2jSn+U2LynTrvO9OkNJGJbHJp+bzMa437+oQ+juZo2o
         SfJNgvlUT8MJCQV94/fjK77/dpysYlyLrb+LZSw46LkmKVpsqzCVvwtVGVpYMCXOs4V8
         GT+Q==
X-Gm-Message-State: AA+aEWYXXCt9uC/1yJkVE037eql9CLEZnypQKQjJ2NY/jB6i9BWcVI8/
        EatSw5yoVl46TOzMxj/t6qFsGyE0XrNx
X-Google-Smtp-Source: AFSGD/WM24P+MZNYJA5pDG9voLLnGf0XW3KsR7meNfy8vJUGx8O6QzYj9g0U37rYPptZnaQNIEp5d8ODq/d9
X-Received: by 2002:ab0:61d2:: with SMTP id m18mr12132095uan.10.1545014892207;
 Sun, 16 Dec 2018 18:48:12 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:48:05 +0800
Message-Id: <20181217024805.122897-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
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
advertise its capabilities in raletively wider range. For example, a
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
---
 drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3620efee2688..3001df7bd602 100644
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
@@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 	}
 
 	if (src_pdo) {
-		pdo = port->source_caps[src_pdo];
-
-		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
-		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
-		port->pps_data.max_curr =
-			min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
+		src = port->source_caps[src_pdo];
+		snk = port->snk_pdo[snk_pdo];
+
+		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
+					      pdo_pps_apdo_min_voltage(snk));
+		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
+					      pdo_pps_apdo_max_voltage(snk));
+		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
 		port->pps_data.out_volt =
-			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
+			min(port->pps_data.max_volt, port->pps_data.out_volt);
 		port->pps_data.op_curr =
 			min(port->pps_data.max_curr, port->pps_data.op_curr);
 	}
-- 
2.20.0.405.gbc1bbc6f85-goog

