Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoMk4JGYuOf7wQLjqepVmwPOlS3ONAgm7LJtecVpA7Ht8VFpuhDKADeDcZ7BCUgpCUXEnr7
ARC-Seal: i=1; a=rsa-sha256; t=1524838296; cv=none;
        d=google.com; s=arc-20160816;
        b=cZzaqC4b3SPUIi4jQg42c0bfNJpR0L4vZXQCvkdz1/lcY2zLGsQliGblfz844MMFmn
         wWRIUjqTUnRP4tFrJMR3Ru+8muLMd2rS48/QMKtGhVcgceBkzsP/dnq8N1gtrkSyspwi
         6MgK03L5xrGCPaKIYXY14nzvzg5NMj/2wZffY0LFnmT4JxLGb6HxIzIzR/mzlMwTWHr5
         xMP69TeGYf7ZVb2xsBNpMVHMMYuuuF+S0X7RP8LfP4ZLokQfZbPZX6M9tfn/fF/9QOWf
         OVh2jW8GFbm00eW+oaWQOkRXOGyAX1GHP/FSs1MOoc71c0BAC1iRA+lvGhrxW6VhYnSf
         Nbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=8zdOqj+hBv/UaJQOkBhbMJCA4zRiGw7eKb1KtUo0i4E=;
        b=QaoAsbwZFyWLVu+Ilx8OVye3othHShwm6m2YsjJGLrq/jeoqnx5OM8zrk8Egp0O8vm
         Wcz1HNxazRx4Oz8zLr0ybmU4HvhGsd8PxoDYdzcuyYJxLl9HJtBbCB8pSdO4W9htj3Y1
         UbZYd6L7QhpSB7Y8m0jFf3AP1nJkBA06T8fEx3Soo+f0cKvH+YjmSzFpoGTEO9otQMc0
         75XLJ/Ft/LbJS/BWiEMZD1rzLFytKPEf+KIeVO8+WoRPqbnGUWuNEBv8C102Ck3pXEr1
         qLN4G2ciD0CqO7iJ1mNX5eFqOIvS88PnjcFDSijBrmwDZ/IPb5dSwe2mfdXsslbJtTMB
         6EoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FA721892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 35/81] amd-xgbe: Add pre/post auto-negotiation phy hooks
Date: Fri, 27 Apr 2018 15:58:37 +0200
Message-Id: <20180427135745.031028636@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908541426249678?=
X-GMAIL-MSGID: =?utf-8?q?1598908842013619073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>


[ Upstream commit 4d945663a6a0acf3cbe45940503f2eb9584bfee7 ]

Add hooks to the driver auto-negotiation (AN) flow to allow the different
phy implementations to perform any steps necessary to improve AN.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c |   16 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h      |    5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -437,6 +437,9 @@ static void xgbe_an73_disable(struct xgb
 
 static void xgbe_an_restart(struct xgbe_prv_data *pdata)
 {
+	if (pdata->phy_if.phy_impl.an_pre)
+		pdata->phy_if.phy_impl.an_pre(pdata);
+
 	switch (pdata->an_mode) {
 	case XGBE_AN_MODE_CL73:
 	case XGBE_AN_MODE_CL73_REDRV:
@@ -453,6 +456,9 @@ static void xgbe_an_restart(struct xgbe_
 
 static void xgbe_an_disable(struct xgbe_prv_data *pdata)
 {
+	if (pdata->phy_if.phy_impl.an_post)
+		pdata->phy_if.phy_impl.an_post(pdata);
+
 	switch (pdata->an_mode) {
 	case XGBE_AN_MODE_CL73:
 	case XGBE_AN_MODE_CL73_REDRV:
@@ -637,11 +643,11 @@ static enum xgbe_an xgbe_an73_incompat_l
 			return XGBE_AN_NO_LINK;
 	}
 
-	xgbe_an73_disable(pdata);
+	xgbe_an_disable(pdata);
 
 	xgbe_switch_mode(pdata);
 
-	xgbe_an73_restart(pdata);
+	xgbe_an_restart(pdata);
 
 	return XGBE_AN_INCOMPAT_LINK;
 }
@@ -820,6 +826,9 @@ static void xgbe_an37_state_machine(stru
 		pdata->an_result = pdata->an_state;
 		pdata->an_state = XGBE_AN_READY;
 
+		if (pdata->phy_if.phy_impl.an_post)
+			pdata->phy_if.phy_impl.an_post(pdata);
+
 		netif_dbg(pdata, link, pdata->netdev, "CL37 AN result: %s\n",
 			  xgbe_state_as_string(pdata->an_result));
 	}
@@ -903,6 +912,9 @@ again:
 		pdata->kx_state = XGBE_RX_BPA;
 		pdata->an_start = 0;
 
+		if (pdata->phy_if.phy_impl.an_post)
+			pdata->phy_if.phy_impl.an_post(pdata);
+
 		netif_dbg(pdata, link, pdata->netdev, "CL73 AN result: %s\n",
 			  xgbe_state_as_string(pdata->an_result));
 	}
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -833,6 +833,7 @@ struct xgbe_hw_if {
 /* This structure represents implementation specific routines for an
  * implementation of a PHY. All routines are required unless noted below.
  *   Optional routines:
+ *     an_pre, an_post
  *     kr_training_pre, kr_training_post
  */
 struct xgbe_phy_impl_if {
@@ -875,6 +876,10 @@ struct xgbe_phy_impl_if {
 	/* Process results of auto-negotiation */
 	enum xgbe_mode (*an_outcome)(struct xgbe_prv_data *);
 
+	/* Pre/Post auto-negotiation support */
+	void (*an_pre)(struct xgbe_prv_data *);
+	void (*an_post)(struct xgbe_prv_data *);
+
 	/* Pre/Post KR training enablement support */
 	void (*kr_training_pre)(struct xgbe_prv_data *);
 	void (*kr_training_post)(struct xgbe_prv_data *);
