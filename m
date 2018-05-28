Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165178AbeE1NFh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163777AbeE1Kwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bich Hemon <bich.hemon@st.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 244/496] can: m_can: select pinctrl state in each suspend/resume function
Date: Mon, 28 May 2018 12:00:29 +0200
Message-Id: <20180528100330.187652000@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bich HEMON <bich.hemon@st.com>

[ Upstream commit c9b3bce18da4a0aebc27853052dea39aa64b7d75 ]

Make sure to apply the correct pin state in suspend/resume callbacks.
Putting pins in sleep state saves power.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/m_can/m_can.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
+#include <linux/pinctrl/consumer.h>
 
 /* napi related */
 #define M_CAN_NAPI_WEIGHT	64
@@ -1682,6 +1683,8 @@ static __maybe_unused int m_can_suspend(
 		m_can_clk_stop(priv);
 	}
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
@@ -1692,6 +1695,8 @@ static __maybe_unused int m_can_resume(s
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	m_can_init_ram(priv);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
