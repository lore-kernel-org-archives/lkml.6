Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvF4t2mTMaKb2pyOsyMTxEtph3h5lxG7PnFUnpAXwAzreBZ6L3z6H3CexCoAP/xKItOTVjN
ARC-Seal: i=1; a=rsa-sha256; t=1519981219; cv=none;
        d=google.com; s=arc-20160816;
        b=d2pZdWLeKBfZ58QxtMSLhOm1QQIUAQy4/0bxuVTtUvpJpQ5azlIiNatZge3fzVIXTM
         TY7/onRQpMhLSUX+3qF4ONYdnC4GrKXBb8Ps8WhgMCXMBIqv4UGxJmT0fNzBo8VEK12c
         vE/RKcEWF1MXS5bwc8Y7h1PvXx4bRwWirxfy09TLZ8c4Lbkl7vCl5OoqFcvnoxG0hSJW
         XGrl5eeU3+ozA40IlPb9KqH3ol8l92IFmOriWlOuTbecTnMVgbtI//yZGxrnHR4yDkfp
         CCqOdlDSPfQbQQpITPdvHeopZAeLTK8C4QQv40gfaGnU/OFm4XJDEESMyGkn4m1b8wpV
         7bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DlimYbz/kKezNb540XtadN6wFMUTLw+mR7VSgdyjZUU=;
        b=MzyueILOQZZZKU4gDehMy7WluihYHqKc8zSLe5Ni+diZ63XiKSnkxt2kmZ4D3bKfj+
         0fhcVf6DeszIgBCwN8DQ5nNAY/Us1YyC1xppnrN6USA/nCv4gYecDwuKEkSxnEsJcQRI
         cAIGhA9eCbiTLa2lRDv1PC0bayETILFLLsLtUvhQe8kf46nDHeMJE+rlVJyQMDsJVMeH
         KEDfPhgaApP7VK5daKH6DYPlpQxmCPnSFE5EY6ucRmQE8TSebIvEuTsPP5Pysrj0hvsX
         a57/BG0kNjrC7P42f7uwUDe4QUAaKigmcU/XiqletgA9XLJ5J+W0nZvo8sdoxUf9u9Pd
         Q/lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Igor Russkikh <igor.russkikh@aquantia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 009/115] net: aquantia: Fix actual speed capabilities reporting
Date: Fri,  2 Mar 2018 09:50:12 +0100
Message-Id: <20180302084504.233882851@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815827424644920?=
X-GMAIL-MSGID: =?utf-8?q?1593815827424644920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <igor.russkikh@aquantia.com>


[ Upstream commit e4d02ca04c6d48ab2226342a1c4ed54f1dbb72bd ]

Different hardware device Ids correspond to different maximum speed
available. Extra checks were added for devices D108 and D109 to
remove unsupported speeds from these device capabilities list.

Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h            |    4 +++-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |    7 ++++---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h           |    2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c      |    5 +++--
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c |   13 ++++++++++++-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |   13 ++++++++++++-
 6 files changed, 35 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -85,7 +85,9 @@ struct aq_hw_ops {
 	void (*destroy)(struct aq_hw_s *self);
 
 	int (*get_hw_caps)(struct aq_hw_s *self,
-			   struct aq_hw_caps_s *aq_hw_caps);
+			   struct aq_hw_caps_s *aq_hw_caps,
+			   unsigned short device,
+			   unsigned short subsystem_device);
 
 	int (*hw_ring_tx_xmit)(struct aq_hw_s *self, struct aq_ring_s *aq_ring,
 			       unsigned int frags);
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -222,7 +222,7 @@ static struct net_device *aq_nic_ndev_al
 
 struct aq_nic_s *aq_nic_alloc_cold(const struct net_device_ops *ndev_ops,
 				   const struct ethtool_ops *et_ops,
-				   struct device *dev,
+				   struct pci_dev *pdev,
 				   struct aq_pci_func_s *aq_pci_func,
 				   unsigned int port,
 				   const struct aq_hw_ops *aq_hw_ops)
@@ -242,7 +242,7 @@ struct aq_nic_s *aq_nic_alloc_cold(const
 	ndev->netdev_ops = ndev_ops;
 	ndev->ethtool_ops = et_ops;
 
-	SET_NETDEV_DEV(ndev, dev);
+	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	ndev->if_port = port;
 	self->ndev = ndev;
@@ -254,7 +254,8 @@ struct aq_nic_s *aq_nic_alloc_cold(const
 
 	self->aq_hw = self->aq_hw_ops.create(aq_pci_func, self->port,
 						&self->aq_hw_ops);
-	err = self->aq_hw_ops.get_hw_caps(self->aq_hw, &self->aq_hw_caps);
+	err = self->aq_hw_ops.get_hw_caps(self->aq_hw, &self->aq_hw_caps,
+					  pdev->device, pdev->subsystem_device);
 	if (err < 0)
 		goto err_exit;
 
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
@@ -71,7 +71,7 @@ struct aq_nic_cfg_s {
 
 struct aq_nic_s *aq_nic_alloc_cold(const struct net_device_ops *ndev_ops,
 				   const struct ethtool_ops *et_ops,
-				   struct device *dev,
+				   struct pci_dev *pdev,
 				   struct aq_pci_func_s *aq_pci_func,
 				   unsigned int port,
 				   const struct aq_hw_ops *aq_hw_ops);
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -51,7 +51,8 @@ struct aq_pci_func_s *aq_pci_func_alloc(
 	pci_set_drvdata(pdev, self);
 	self->pdev = pdev;
 
-	err = aq_hw_ops->get_hw_caps(NULL, &self->aq_hw_caps);
+	err = aq_hw_ops->get_hw_caps(NULL, &self->aq_hw_caps, pdev->device,
+				     pdev->subsystem_device);
 	if (err < 0)
 		goto err_exit;
 
@@ -59,7 +60,7 @@ struct aq_pci_func_s *aq_pci_func_alloc(
 
 	for (port = 0; port < self->ports; ++port) {
 		struct aq_nic_s *aq_nic = aq_nic_alloc_cold(ndev_ops, eth_ops,
-							    &pdev->dev, self,
+							    pdev, self,
 							    port, aq_hw_ops);
 
 		if (!aq_nic) {
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -18,9 +18,20 @@
 #include "hw_atl_a0_internal.h"
 
 static int hw_atl_a0_get_hw_caps(struct aq_hw_s *self,
-				 struct aq_hw_caps_s *aq_hw_caps)
+				 struct aq_hw_caps_s *aq_hw_caps,
+				 unsigned short device,
+				 unsigned short subsystem_device)
 {
 	memcpy(aq_hw_caps, &hw_atl_a0_hw_caps_, sizeof(*aq_hw_caps));
+
+	if (device == HW_ATL_DEVICE_ID_D108 && subsystem_device == 0x0001)
+		aq_hw_caps->link_speed_msk &= ~HW_ATL_A0_RATE_10G;
+
+	if (device == HW_ATL_DEVICE_ID_D109 && subsystem_device == 0x0001) {
+		aq_hw_caps->link_speed_msk &= ~HW_ATL_A0_RATE_10G;
+		aq_hw_caps->link_speed_msk &= ~HW_ATL_A0_RATE_5G;
+	}
+
 	return 0;
 }
 
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -18,9 +18,20 @@
 #include "hw_atl_b0_internal.h"
 
 static int hw_atl_b0_get_hw_caps(struct aq_hw_s *self,
-				 struct aq_hw_caps_s *aq_hw_caps)
+				 struct aq_hw_caps_s *aq_hw_caps,
+				 unsigned short device,
+				 unsigned short subsystem_device)
 {
 	memcpy(aq_hw_caps, &hw_atl_b0_hw_caps_, sizeof(*aq_hw_caps));
+
+	if (device == HW_ATL_DEVICE_ID_D108 && subsystem_device == 0x0001)
+		aq_hw_caps->link_speed_msk &= ~HW_ATL_B0_RATE_10G;
+
+	if (device == HW_ATL_DEVICE_ID_D109 && subsystem_device == 0x0001) {
+		aq_hw_caps->link_speed_msk &= ~HW_ATL_B0_RATE_10G;
+		aq_hw_caps->link_speed_msk &= ~HW_ATL_B0_RATE_5G;
+	}
+
 	return 0;
 }
 
