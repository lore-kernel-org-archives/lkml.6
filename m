Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B931206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977359;
	bh=DH+N8ymfUrratbaFEHYDD5Ndk8pa2UewWMcXljbvWFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a1dFHzpiZcmwfiR455V8Enn3M4n/yjBYrsxwGS75V1P33F/EtrhMWDlAeDW9deio5
	 oE8ihKuxhbBfsoYoF5Otr3isfCQd0qcuWlziP5mN54cg4uAmQ70+nqk9tggMz5YsPJ
	 4yPHDMCivYcByPd9DVeJmplynwAifhMugEeJ28fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfAHTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbfAHTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A865420665;
        Tue,  8 Jan 2019 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975801;
        bh=DH+N8ymfUrratbaFEHYDD5Ndk8pa2UewWMcXljbvWFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlsH9t6W2QD5aoQ9QekVXE+gOA1Pm605AGSxn/UbKZGs9oaZM/ZLA2bs62NKwJF6M
         xlJ3upoWy1e4BRSKI26GoqNr1ie3xtGbia6witbgNwnjcdwWg7WO9MySCmSV4XDpw4
         z4bB+1m1PnX7n722kACEgUvD9OmBrfrkkxyoh21o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/97] usb: typec: tcpm: Do not disconnect link for self powered devices
Date:   Tue,  8 Jan 2019 14:28:17 -0500
Message-Id: <20190108192949.122407-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Badhri Jagan Sridharan <badhri@google.com>

[ Upstream commit 23b5f73266e59a598c1e5dd435d87651b5a7626b ]

During HARD_RESET the data link is disconnected.
For self powered device, the spec is advising against doing that.

>From USB_PD_R3_0
7.1.5 Response to Hard Resets
Device operation during and after a Hard Reset is defined as follows:
Self-powered devices Should Not disconnect from USB during a Hard Reset
(see Section 9.1.2).
Bus powered devices will disconnect from USB during a Hard Reset due to the
loss of their power source.

Tackle this by letting TCPM know whether the device is self or bus powered.

This overcomes unnecessary port disconnections from hard reset.
Also, speeds up the enumeration time when connected to Type-A ports.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---------
Version history:
V3:
Rebase on top of usb-next

V2:
Based on feedback from heikki.krogerus@linux.intel.com
- self_powered added to the struct tcpm_port which is populated from
  a. "connector" node of the device tree in tcpm_fw_get_caps()
  b. "self_powered" node of the tcpc_config in tcpm_copy_caps

Based on feedbase from linux@roeck-us.net
- Code was refactored
- SRC_HARD_RESET_VBUS_OFF sets the link state to false based
  on self_powered flag

V1 located here:
https://lkml.org/lkml/2018/9/13/94
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm.c | 12 ++++++++++--
 include/linux/usb/tcpm.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index c74cc9c309b1..3457c1fdebd1 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -317,6 +317,9 @@ struct tcpm_port {
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
 
+	/* port belongs to a self powered device */
+	bool self_powered;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -3257,7 +3260,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case SRC_HARD_RESET_VBUS_OFF:
 		tcpm_set_vconn(port, true);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, false, TYPEC_SOURCE, TYPEC_HOST);
+		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+			       TYPEC_HOST);
 		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
@@ -3270,7 +3274,8 @@ static void run_state_machine(struct tcpm_port *port)
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		tcpm_set_charge(port, false);
-		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
+		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+			       TYPEC_DEVICE);
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
 		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
@@ -4415,6 +4420,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return -EINVAL;
 	port->operating_snk_mw = mw / 1000;
 
+	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
+
 	return 0;
 }
 
@@ -4723,6 +4730,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
 	port->typec_caps.prefer_role = tcfg->default_role;
 	port->typec_caps.type = tcfg->type;
 	port->typec_caps.data = tcfg->data;
+	port->self_powered = port->tcpc->config->self_powered;
 
 	return 0;
 }
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 7e7fbfb84e8e..50c74a77db55 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -89,6 +89,7 @@ struct tcpc_config {
 	enum typec_port_data data;
 	enum typec_role default_role;
 	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
+	bool self_powered;	/* port belongs to a self powered device */
 
 	const struct typec_altmode_desc *alt_modes;
 };
-- 
2.19.1

