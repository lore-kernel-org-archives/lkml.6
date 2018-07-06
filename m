Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7623C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBED2402E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBED2402E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGFGMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:12:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932625AbeGFFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:47:43 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0CC39C7F;
        Fri,  6 Jul 2018 05:47:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.17 08/46] usb: typec: ucsi: Fix for incorrect status data issue
Date:   Fri,  6 Jul 2018 07:46:29 +0200
Message-Id: <20180706054525.000194329@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 68816e16b4789f2d05e77b6dcb77564cf5d6a8d8 upstream.

According to UCSI Specification, Connector Change Event only
means a change in the Connector Status and Operation Mode
fields of the STATUS data structure. So any other change
should create another event.

Unfortunately on some platforms the firmware acting as PPM
(platform policy manager - usually embedded controller
firmware) still does not report any other status changes if
there is a connector change event. So if the connector power
or data role was changed when a device was plugged to the
connector, the driver does not get any indication about
that. The port will show wrong roles if that happens.

To fix the issue, always checking the data and power role
together with a connector change event.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/ucsi/ucsi.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -350,6 +350,19 @@ static void ucsi_connector_change(struct
 	}
 
 	if (con->status.change & UCSI_CONSTAT_CONNECT_CHANGE) {
+		typec_set_pwr_role(con->port, con->status.pwr_dir);
+
+		switch (con->status.partner_type) {
+		case UCSI_CONSTAT_PARTNER_TYPE_UFP:
+			typec_set_data_role(con->port, TYPEC_HOST);
+			break;
+		case UCSI_CONSTAT_PARTNER_TYPE_DFP:
+			typec_set_data_role(con->port, TYPEC_DEVICE);
+			break;
+		default:
+			break;
+		}
+
 		if (con->status.connected)
 			ucsi_register_partner(con);
 		else


