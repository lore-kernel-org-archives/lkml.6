Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMM9vTIGHqj6FeqTS3NEkriI6Snts3dcJ5XjIyzVlTE9x2tAi9aydLzpqx6lH6Nfpc5tQb
ARC-Seal: i=1; a=rsa-sha256; t=1520641146; cv=none;
        d=google.com; s=arc-20160816;
        b=w3ZrL0I+DGRqEekyI8REgZub2J3Cmx8xatO400p422aUpr1vqJDbRfzEKzqEL7WhtF
         7xhpK8LHNYVrF5uhlqstJgbZyAF26y8JmF7mz5AGiJduUvnDhhC3H4j8wskZLNEh6ZDg
         +CBvz3iQieEaFC3iDcHa76uCI5TnfAI21/3u/Tu3Ppw80ZX4/Snh5GagStVwNDABL+py
         gPCWOLhyMG/vfHyuOOiP5NHF6GdDTI+MfgCDdlBqTWDtVm5MjAYoY8jrAt+HJriVJJDT
         E5T4y5Bm9tlhhOi0gCXaX7As3iBKEB40CdpSlPTnb624viG56/2P4BOWQtew7on9Z1Ir
         S1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yWH+ISqSKUYkN0oFJtXJ00MjCq0h2S4tpc08X/qNxHc=;
        b=Ec2IVYHZk7aQF4tJTow403HAZfmNWAW2DncGbTzRz+eywuNIcJikKNxQ5nLsfux+PA
         KKlYUZyzJ/ITQ40JP1yZnigc5v3KhXMtMrBu8CsuRl6n7vBlBxP+zmyV7j37hMLklimf
         nCuN30Zb+qm3I8NZk+IKFNsYyyHlxmOCa0CFvEVoFxiLZBEnqXCSQQOcEsoZrRUg1OA3
         46GOycef+kumAIERRw/SrZQXqU8aGo8VwWUbdcgBQRFr+Zy+utQIJmYrl7w+5Gn6leSu
         c/jDqyAyb1fbOxvic8oZigIeyO/OTZKg27A9MCpV0gjsHbBuk6wCHG8gk11lb7KQswd9
         E4DA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Fugang Duan <B38611@freescale.com>,
	"David S. Miller" <davem@davemloft.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 06/21] net: fec: introduce fec_ptp_stop and use in probe fail path
Date: Fri,  9 Mar 2018 16:18:28 -0800
Message-Id: <20180310001801.425145519@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507810742302524?=
X-GMAIL-MSGID: =?utf-8?q?1594507810742302524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

commit 32cba57ba74be58589aeb4cb6496183e46a5e3e5 upstream.

This function frees resources and cancels delayed work item that
have been initialized in fec_ptp_init().

Use this to do proper error handling if something goes wrong in
probe function after fec_ptp_init has been called.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[groeck: backport: context changes in .../fec_main.c]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/freescale/fec.h      |    1 +
 drivers/net/ethernet/freescale/fec_main.c |    5 ++---
 drivers/net/ethernet/freescale/fec_ptp.c  |   10 ++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -546,6 +546,7 @@ struct fec_enet_private {
 };
 
 void fec_ptp_init(struct platform_device *pdev);
+void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr);
 int fec_ptp_get(struct net_device *ndev, struct ifreq *ifr);
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3312,6 +3312,7 @@ failed_register:
 failed_mii_init:
 failed_irq:
 failed_init:
+	fec_ptp_stop(pdev);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
 failed_regulator:
@@ -3331,14 +3332,12 @@ fec_drv_remove(struct platform_device *p
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	cancel_delayed_work_sync(&fep->time_keep);
 	cancel_work_sync(&fep->tx_timeout_work);
+	fec_ptp_stop(pdev);
 	unregister_netdev(ndev);
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
-	if (fep->ptp_clock)
-		ptp_clock_unregister(fep->ptp_clock);
 	fec_enet_clk_enable(ndev, false);
 	of_node_put(fep->phy_node);
 	free_netdev(ndev);
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -620,6 +620,16 @@ void fec_ptp_init(struct platform_device
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
 
+void fec_ptp_stop(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	cancel_delayed_work_sync(&fep->time_keep);
+	if (fep->ptp_clock)
+		ptp_clock_unregister(fep->ptp_clock);
+}
+
 /**
  * fec_ptp_check_pps_event
  * @fep: the fec_enet_private structure handle
