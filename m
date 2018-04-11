Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499VumkGU4Bu8KAbTetd8+GOzzxyYYDcIi6mkbAslJjlakGG2U+TYzbMzD+40AmfmV92Gk+
ARC-Seal: i=1; a=rsa-sha256; t=1523473430; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbRc2077EpEHxrxbkj+cZ8ILcDjsx0Gmo2TfvYVab63bKyhGVQmrDeI7w7UwDFUWG1
         pxwcwOqNhZi6zVcwWfwKzptaPIwhUYEyd3AGGERRrN1EJHQM4g1oQn5PMiokynot1yCH
         wbV5+fPACophnyez1LajjqnaG2L5gM3iVbVjiEeSNqfi3xNCAidvYd0Q6tk2D1jsl7gK
         wdaJ85X558W/rACSAmH90/aYWvN6aEbbswE8IZrr9Qh9hP8sOiH/QW3pdDbsDHqijZYP
         oz0Cc2kFe24VkkYehQwLnESWMaWSVEw5ln1Pc13L4RtL2jLIvw1KGC2L7ONvJ9eVAuPR
         bfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=teOty0dDcWZn/GXLML+YBu0xcC24AZ2JYKG36ue8UX8=;
        b=hyUtiE1Li4bb0GB6HQ47+ZYJNlx+ckVKsQfOMu6MtcmUsHTWMoXJ4e7ZJTWn9RVlua
         zG7pvxRFOWCxM55y7ryzHyVf54jdm1xIp8r/CAPUXUvZbaCOdopYe/QZcObvY5f4GmtK
         q0nlSpvzLsLosicn3IQ2sshgeZJvAmR16IewwpiOP78as0pP9kqTCb/4zD2pi56cRc0D
         Lw1A9yiX0APO+YJyeh9QxyN5AXGgiN56211Wg/n9woZPS7DUIyOVrGMgU0BN4qNqNJ7f
         3DnQz/tv9O2haSAfeyBMoIhQsquPOcBq+ZxhU90HV6ibL6VoM3JWjmVDtjq/CBxRaZlR
         zAxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Netanel Belgazal <netanel@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 244/310] net: ena: add missing unmap bars on device removal
Date: Wed, 11 Apr 2018 20:36:23 +0200
Message-Id: <20180411183632.970279589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477676198810154?=
X-GMAIL-MSGID: =?utf-8?q?1597477676198810154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>


[ Upstream commit 0857d92f71b6cb75281fde913554b2d5436c394b ]

This patch also change the mapping functions to devm_ functions

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2808,6 +2808,11 @@ static void ena_release_bars(struct ena_
 {
 	int release_bars;
 
+	if (ena_dev->mem_bar)
+		devm_iounmap(&pdev->dev, ena_dev->mem_bar);
+
+	devm_iounmap(&pdev->dev, ena_dev->reg_bar);
+
 	release_bars = pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 	pci_release_selected_regions(pdev, release_bars);
 }
@@ -2895,8 +2900,9 @@ static int ena_probe(struct pci_dev *pde
 		goto err_free_ena_dev;
 	}
 
-	ena_dev->reg_bar = ioremap(pci_resource_start(pdev, ENA_REG_BAR),
-				   pci_resource_len(pdev, ENA_REG_BAR));
+	ena_dev->reg_bar = devm_ioremap(&pdev->dev,
+					pci_resource_start(pdev, ENA_REG_BAR),
+					pci_resource_len(pdev, ENA_REG_BAR));
 	if (!ena_dev->reg_bar) {
 		dev_err(&pdev->dev, "failed to remap regs bar\n");
 		rc = -EFAULT;
@@ -2916,8 +2922,9 @@ static int ena_probe(struct pci_dev *pde
 	ena_set_push_mode(pdev, ena_dev, &get_feat_ctx);
 
 	if (ena_dev->tx_mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV) {
-		ena_dev->mem_bar = ioremap_wc(pci_resource_start(pdev, ENA_MEM_BAR),
-					      pci_resource_len(pdev, ENA_MEM_BAR));
+		ena_dev->mem_bar = devm_ioremap_wc(&pdev->dev,
+						   pci_resource_start(pdev, ENA_MEM_BAR),
+						   pci_resource_len(pdev, ENA_MEM_BAR));
 		if (!ena_dev->mem_bar) {
 			rc = -EFAULT;
 			goto err_device_destroy;
