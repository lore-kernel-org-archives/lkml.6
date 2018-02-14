Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3258100-1518626126-2-10753298788278235762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518626125; b=EaIxL1BIAXWpWYzAe93GQBr2TVwGjAvEH/HQaKx95VHiua6
    N4bdMpEKCy0qi2YL4WGQtMMU6Dry+eUooklpMBokfp1JAoSsKAAnTxyT8LnnLr6Y
    CGtfJmSNB81N86RdpmePgFilobJlBDwyouWm0jRbahzRl/uer62eUsqshcXwYI73
    UVPuz/QqpX7y43dGl0y+EUxRRC8bCLiZnJZ66/hABTy41W3kmtgdcL0rODlO9V5Y
    2a5Oox18P544mdGo66thA/Y5IKtVHJK7eDjm/iRZZaEU2Vsef9fptQYxzDYmz4po
    Vfl7IVfDdhMyRCqbvDFu4FWyklYLA7bYPWJldcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518626125; bh=aYcSyWCJfAoO1b0j8X6XPd3U09
    87W6v/o1jyFoj9HD4=; b=nwwFO6g2d4wj4fOr/5vF59y4QPrQFBOHqH5eiYeRyP
    oIWHSyD+OUa9KEaFEjdWZT7CxXUg/EjAL0NCt6KqS2T2Ihallfs396CQK5CJVj4J
    UFnE3PA9u0REcbA1t1tx7YAOpszTnmGO09mqdULjgDO39yJ3l/KuEjs0TzJRUKNP
    pOiOE1JPCTjeLUhqWSx5JFxg3B//nKnZfrhDTVCqanmdis6QshkR9KBdL9lg3KVb
    1c7BWybTUGhGv8g7QwuFcHs9W/Tq7eqq8slf45nXUkpmgk74YrBgsVpP/Hd5hxXI
    BHSD26PFVBI0XOqvlr43vEasjL3feXZqUXUX8Z9okxug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032671AbeBNQfI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:35:08 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4810 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032583AbeBNQfF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Feb 2018 11:35:05 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 14 Feb 2018 08:35:45 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 3/3] usb: xhci: tegra: Add support for managing powergates
Date: Wed, 14 Feb 2018 16:34:45 +0000
Message-ID: <1518626085-29102-3-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
References: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Tegra XHCI controller requires that the XUSBA (for superspeed) and
XUSBC (for host) power-domains are enabled. Commit 8df127456f29
("soc/tegra: pmc: Enable XUSB partitions on boot") was added to force
on these power-domains if the XHCI driver is enabled while proper
power-domain support is added, to ensure the device did not hang on
boot. However, rather than forcing on these power-domains in the PMC
driver we can use the legacy Tegra powergate APIs to turn on these
power-domains during the probe of the Tegra XHCI driver.

In the near future we plan to move the Tegra XHCI driver to use the
generic PM domain framework for power-domains and so to prepare for
this only use the legacy Tegra powergate API if there is not PM
domain associated with device (ie. dev.pm_domain is NULL). Please
note that in the future the superspeed and host resets will be handled
by the generic PM domain provider and so these are only these are only
needed in the case where there is no generic PM domain.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 68 +++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 42aa67858b53..f69e5edfd604 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <soc/tegra/pmc.h>
 
 #include "xhci.h"
 
@@ -931,20 +932,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->padctl))
 		return PTR_ERR(tegra->padctl);
 
-	tegra->host_rst = devm_reset_control_get(&pdev->dev, "xusb_host");
-	if (IS_ERR(tegra->host_rst)) {
-		err = PTR_ERR(tegra->host_rst);
-		dev_err(&pdev->dev, "failed to get xusb_host reset: %d\n", err);
-		goto put_padctl;
-	}
-
-	tegra->ss_rst = devm_reset_control_get(&pdev->dev, "xusb_ss");
-	if (IS_ERR(tegra->ss_rst)) {
-		err = PTR_ERR(tegra->ss_rst);
-		dev_err(&pdev->dev, "failed to get xusb_ss reset: %d\n", err);
-		goto put_padctl;
-	}
-
 	tegra->host_clk = devm_clk_get(&pdev->dev, "xusb_host");
 	if (IS_ERR(tegra->host_clk)) {
 		err = PTR_ERR(tegra->host_clk);
@@ -1008,11 +995,48 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto put_padctl;
 	}
 
+	if (!pdev->dev.pm_domain) {
+		tegra->host_rst = devm_reset_control_get(&pdev->dev,
+							 "xusb_host");
+		if (IS_ERR(tegra->host_rst)) {
+			err = PTR_ERR(tegra->host_rst);
+			dev_err(&pdev->dev,
+				"failed to get xusb_host reset: %d\n", err);
+			goto put_padctl;
+		}
+
+		tegra->ss_rst = devm_reset_control_get(&pdev->dev, "xusb_ss");
+		if (IS_ERR(tegra->ss_rst)) {
+			err = PTR_ERR(tegra->ss_rst);
+			dev_err(&pdev->dev, "failed to get xusb_ss reset: %d\n",
+				err);
+			goto put_padctl;
+		}
+
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBA,
+							tegra->ss_clk,
+							tegra->ss_rst);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable XUSBA domain: %d\n", err);
+			goto put_padctl;
+		}
+
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
+							tegra->host_clk,
+							tegra->host_rst);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable XUSBC domain: %d\n", err);
+			goto disable_xusba;
+		}
+	}
+
 	tegra->supplies = devm_kcalloc(&pdev->dev, tegra->soc->num_supplies,
 				       sizeof(*tegra->supplies), GFP_KERNEL);
 	if (!tegra->supplies) {
 		err = -ENOMEM;
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	for (i = 0; i < tegra->soc->num_supplies; i++)
@@ -1022,7 +1046,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				      tegra->supplies);
 	if (err) {
 		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	for (i = 0; i < tegra->soc->num_types; i++)
@@ -1032,7 +1056,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				   sizeof(*tegra->phys), GFP_KERNEL);
 	if (!tegra->phys) {
 		err = -ENOMEM;
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	for (i = 0, k = 0; i < tegra->soc->num_types; i++) {
@@ -1048,7 +1072,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 					"failed to get PHY %s: %ld\n", prop,
 					PTR_ERR(phy));
 				err = PTR_ERR(phy);
-				goto put_padctl;
+				goto disable_xusbc;
 			}
 
 			tegra->phys[k++] = phy;
@@ -1059,7 +1083,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				    dev_name(&pdev->dev));
 	if (!tegra->hcd) {
 		err = -ENOMEM;
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	/*
@@ -1151,6 +1175,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 	usb_put_hcd(tegra->hcd);
+disable_xusbc:
+	if (!&pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
+disable_xusba:
+	if (!&pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
 	return err;
-- 
2.7.4

