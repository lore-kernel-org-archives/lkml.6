Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B50C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA73218FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Q/FRTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfBLP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:58:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35143 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfBLP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:58:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1456455pgs.2;
        Tue, 12 Feb 2019 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oyv/ZkAJe4nSxbOi2lYYeF6GzshBE2yMeOf1hqT3IEY=;
        b=U6Q/FRTw4l6P/djMILqkCTEjZ4vMCbZxhNN8c7pDvn3FsSgEBg4bTvJFYEfJ47U1m3
         2J1uuQm338esTZfKr/3r+VcpQivrd+mqzqfJhVbpXEETomhSdmbwz5YfcnCack9FGI8n
         tZ7Vr5KJ+cHyIe9aDOeSTBMO+ffHIg5Rya4gz3fS2AOemKwU9yaXN6RGFf5fB29Z2eUg
         IspBOz9khWFLShAE7TpVdvYc4jQOAOpp3yo4qFpNaOsQp0BUe1QzTeWprlzDVScgJb+w
         d4THb5+WyehUcocjza7N+h3I0HULydw6uhIXubcK8iKumT41SlYcbfKrIlEtKrM7E48u
         x9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oyv/ZkAJe4nSxbOi2lYYeF6GzshBE2yMeOf1hqT3IEY=;
        b=p5ESQFG4Zha5TpO0bIVzPOTTqXnLupy5tpsy7DkSTOZDe6TRORAtFtcUg+m7JdFvv8
         BaqCFfrGEiFUNRf+6BMoiCBktyWozTaUBO9byGI3aWtlDmUKeoUw3qvJp3SGdAX+6mIP
         4BfB8geqoCHqyPoiSlMRSCHBwvzU+CajPnYZjjNQdN/EaBVrZj/8rDPBnF6GqBvLiFMP
         3JqC8qK3TciYzZjORbdw9bYCwwcCAL3mWZnEA2VFSQvk7yGgsSBv5Ls3rq65/v6Gof4W
         2o06nynEJnndfWzHidPSYgDD86zHnKclZkNrey+hV1TX5Sn5UwGL+RZJWO8qQrOycpRw
         Hz8Q==
X-Gm-Message-State: AHQUAuY7HkjPhmaNFzwOazV0vBNpPEaTzeG+TC6vyhY5vgI7wDA3a0Lj
        nbVy3NrbQTBu8G8nkpVqSo840ayY
X-Google-Smtp-Source: AHgI3IbdzVhGWLhI78ip2YHT9LuGPlw2x8fNQKmxu0ZwYAeyBqMNuKwD8jWHj+//mCdb4yTeUvwDfA==
X-Received: by 2002:a62:2044:: with SMTP id g65mr4567549pfg.127.1549987101476;
        Tue, 12 Feb 2019 07:58:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c13sm27123395pfe.93.2019.02.12.07.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 07:58:20 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Kyle Tso <kyletso@google.com>
Subject: [PATCH] usb: typec: tcpm: Remove unused functions
Date:   Tue, 12 Feb 2019 07:58:17 -0800
Message-Id: <1549987097-27937-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcpm_update_source_capabilities() and tcpm_update_sink_capabilities()
are not used anywhere, and I don't recall why I introduced those functions
in the first place. Effectively that means that we don't know if they even
work, or ever did. Lets remove them.

Reported-by: Kyle Tso <kyletso@google.com>
Cc: Kyle Tso <kyletso@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 60 -------------------------------------------
 include/linux/usb/tcpm.h      |  6 -----
 2 files changed, 66 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f1c39a3c7534..a6b2413c59a6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4435,66 +4435,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	return 0;
 }
 
-int tcpm_update_source_capabilities(struct tcpm_port *port, const u32 *pdo,
-				    unsigned int nr_pdo)
-{
-	if (tcpm_validate_caps(port, pdo, nr_pdo))
-		return -EINVAL;
-
-	mutex_lock(&port->lock);
-	port->nr_src_pdo = tcpm_copy_pdos(port->src_pdo, pdo, nr_pdo);
-	switch (port->state) {
-	case SRC_UNATTACHED:
-	case SRC_ATTACH_WAIT:
-	case SRC_TRYWAIT:
-		tcpm_set_cc(port, tcpm_rp_cc(port));
-		break;
-	case SRC_SEND_CAPABILITIES:
-	case SRC_NEGOTIATE_CAPABILITIES:
-	case SRC_READY:
-	case SRC_WAIT_NEW_CAPABILITIES:
-		tcpm_set_cc(port, tcpm_rp_cc(port));
-		tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
-		break;
-	default:
-		break;
-	}
-	mutex_unlock(&port->lock);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tcpm_update_source_capabilities);
-
-int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
-				  unsigned int nr_pdo,
-				  unsigned int operating_snk_mw)
-{
-	if (tcpm_validate_caps(port, pdo, nr_pdo))
-		return -EINVAL;
-
-	mutex_lock(&port->lock);
-	port->nr_snk_pdo = tcpm_copy_pdos(port->snk_pdo, pdo, nr_pdo);
-	port->operating_snk_mw = operating_snk_mw;
-	port->update_sink_caps = true;
-
-	switch (port->state) {
-	case SNK_NEGOTIATE_CAPABILITIES:
-	case SNK_NEGOTIATE_PPS_CAPABILITIES:
-	case SNK_READY:
-	case SNK_TRANSITION_SINK:
-	case SNK_TRANSITION_SINK_VBUS:
-		if (port->pps_data.active)
-			tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
-		else
-			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
-		break;
-	default:
-		break;
-	}
-	mutex_unlock(&port->lock);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
-
 /* Power Supply access to expose source power information */
 enum tcpm_psy_online_states {
 	TCPM_PSY_OFFLINE = 0,
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 50c74a77db55..0c532ca3f079 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -159,12 +159,6 @@ struct tcpm_port;
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc);
 void tcpm_unregister_port(struct tcpm_port *port);
 
-int tcpm_update_source_capabilities(struct tcpm_port *port, const u32 *pdo,
-				    unsigned int nr_pdo);
-int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
-				  unsigned int nr_pdo,
-				  unsigned int operating_snk_mw);
-
 void tcpm_vbus_change(struct tcpm_port *port);
 void tcpm_cc_change(struct tcpm_port *port);
 void tcpm_pd_receive(struct tcpm_port *port,
-- 
2.7.4

