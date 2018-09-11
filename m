Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDBC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3B22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KekXPlMJ";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KekXPlMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3B22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIKT70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:59:26 -0400
Received: from node.akkea.ca ([192.155.83.177]:54086 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeIKT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:59:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 989DF5420EF;
        Tue, 11 Sep 2018 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536677985; bh=m72XrVPEbnI9sQkL8cE43w0uTdLon6z2Qa/nWtjpraE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KekXPlMJ3svKRBmTPHQr8sdzDkHH6rZEZDQuOrJrRE7TBTGzzVN+PWXkmNje3W9Lb
         wVuL8/sXPZlhBqzSxVs+MMzW/5shZU1rVacpzBHDLF8PWjAF8HNNwnFEeZtCPka1Lr
         guADj4GLNOCE7lpVnc8XxWO2IlhF3ED/dloX1zPg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dfHNCLAbGn4Z; Tue, 11 Sep 2018 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (S0106b04e267b9d3e.cg.shawcable.net [68.147.232.7])
        by node.akkea.ca (Postfix) with ESMTPSA id BB6085420DB;
        Tue, 11 Sep 2018 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1536677985; bh=m72XrVPEbnI9sQkL8cE43w0uTdLon6z2Qa/nWtjpraE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KekXPlMJ3svKRBmTPHQr8sdzDkHH6rZEZDQuOrJrRE7TBTGzzVN+PWXkmNje3W9Lb
         wVuL8/sXPZlhBqzSxVs+MMzW/5shZU1rVacpzBHDLF8PWjAF8HNNwnFEeZtCPka1Lr
         guADj4GLNOCE7lpVnc8XxWO2IlhF3ED/dloX1zPg=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     groeck7@gmail.com
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3] usb: typec: get the vbus source and charge values from the devicetree
Date:   Tue, 11 Sep 2018 08:59:31 -0600
Message-Id: <20180911145931.32441-1-angus@akkea.ca>
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

Changed since V2:

Change the devicetree documentation.
Change the devicetree property names.

Changed since V1:

use devicetree values instead of hardcoded initialization.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/usb/typec-tcpci.txt        |  6 ++++++
 drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
index 0dd1469e7318..b07418ae6482 100644
--- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
+++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
@@ -15,6 +15,12 @@ Required sub-node:
   of connector node are specified in
   Documentation/devicetree/bindings/connector/usb-connector.txt
 
+Optional properties for usb-c-connector sub-node:
+- init-vbus-source: set the initalization value for vbus-source to true.
+  If this property is not present the initial value will be false.
+- init-vbus-sink: set the initalization value for vbus-sink to true.
+  If this property is not present the initial value will be false.
+
 Example:
 
 ptn5110@50 {
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index ca7bedb46f7f..10c14ece3858 100644
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
+	if (fwnode_property_present(fwnode, "init-vbus-sink"))
+	        port->vbus_charge = true;
+	else
+	        port->vbus_charge = false;
+
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
-- 
2.17.1

