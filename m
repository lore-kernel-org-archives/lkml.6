Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235AC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0B420833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="UkHIAU5J";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="UkHIAU5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0B420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIIW4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 18:56:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:53384 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeIIW4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 18:56:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 696F95420EF;
        Sun,  9 Sep 2018 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536516343; bh=wekhRXdFbphLFc0yBKbSQzPg1Qv8tK/sgqcd5cX5TZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UkHIAU5JyEqvWvYv/YJvZStTMFknPQriqNiPNcMF1/v+N6QClbluCTBXJVXlNCPnF
         5h1pFZw+TmhEc2ugVUKQqzMDdyGMtoldTurN6T+NwU+c/2bNhPoprGmWhdh/jzoF0V
         Ut0rnHLEHSB7LA9IUz8VzXke/GpkJ5tuaqYyYI4E=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sWtfs2cLgFry; Sun,  9 Sep 2018 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (S010614dae980e3b8.cg.shawcable.net [68.147.236.72])
        by node.akkea.ca (Postfix) with ESMTPSA id A73CF5420DB;
        Sun,  9 Sep 2018 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536516343; bh=wekhRXdFbphLFc0yBKbSQzPg1Qv8tK/sgqcd5cX5TZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UkHIAU5JyEqvWvYv/YJvZStTMFknPQriqNiPNcMF1/v+N6QClbluCTBXJVXlNCPnF
         5h1pFZw+TmhEc2ugVUKQqzMDdyGMtoldTurN6T+NwU+c/2bNhPoprGmWhdh/jzoF0V
         Ut0rnHLEHSB7LA9IUz8VzXke/GpkJ5tuaqYyYI4E=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     groeck7@gmail.com
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2] usb: typec: get the vbus source and charge values from the devicetree
Date:   Sun,  9 Sep 2018 12:05:31 -0600
Message-Id: <20180909180531.28092-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906192644.24587-1-angus@akkea.ca>
References: <20180906192644.24587-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the board is being powered by USB disabling the source and sink
can remove power from the board. Allow the source and sink to be
initallized based on devicetree values.

Changed since V1:

use devicetree values instead of hardcoded initialization.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../bindings/connector/usb-connector.txt           |  4 ++++
 drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index 8855bfcfd778..afe851a713c3 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -22,6 +22,10 @@ Optional properties for usb-c-connector:
   or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
 - data-role: should be one of "host", "device", "dual"(DRD) if typec
   connector supports USB data.
+- init-vbus-source: set the initalization value for vbus-source to true.
+  If this property is not present the initial value will be false.
+- init-vbus-charge: set the initalization value for vbus-charge to true.
+  If this property is not present the initial value will be false.
 
 Required properties for usb-c-connector with power delivery support:
 - source-pdos: An array of u32 with each entry providing supported power
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index ca7bedb46f7f..7f5d4f209e07 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port *port)
 {
 	int ret;
 
-	ret = port->tcpc->set_vbus(port->tcpc, false, false);
-	port->vbus_source = false;
-	port->vbus_charge = false;
+	ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, port->vbus_charge);
 	return ret;
 }
 
@@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return -EINVAL;
 	port->port_type = port->typec_caps.type;
 
+	if (fwnode_property_present(fwnode, "init-vbus-source"))
+		port->vbus_source = true;
+	else
+		port->vbus_source = false;
+
+	if (fwnode_property_present(fwnode, "init-vbus-charge"))
+	        port->vbus_charge = true;
+	else
+	        port->vbus_charge = false;
+
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
-- 
2.17.1

