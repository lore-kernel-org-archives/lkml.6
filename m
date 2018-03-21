Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELuIU1YmtjFCp1iYYXB8KFEcbOYgajuaF7tOHgENhkBTXAA2anl7XgZJjyMfXsWF/sGki9p0
ARC-Seal: i=1; a=rsa-sha256; t=1521612867; cv=none;
        d=google.com; s=arc-20160816;
        b=0qFXfzhhlwvYUcS8yfUDCyv2oButVQLUaOZYiu7s5e7bOlheK1adtyaa+rAONeHjEe
         1c391ARbxd+Uay82kRuBrn8xtmS7VZICvL5nDaG51F5vS/YK/1zIp9mZ8Xu5eXV9HLT8
         7eG1k6sJUdDQQiOAVLu8cr3jkEu2XzenT+Xl1TS5J0qnnltVDn8QEoh5BP10NtqVeNAG
         9zj/Fb3SzMIIlwQBVx86U/uKOP6h3hNNhhy7hGyxfnE9g8fZhHuICypq82y0acYwKjae
         ASel3ypMHPJJISpW/hDjMQDzQu9Z0mojvryB6sVPAJr/U0Q5M3voWD9awUFNZrplKpSm
         hXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=quC353kPRdudvizLfNgfj/FF8apnNGPH1vCSXa2mXjU=;
        b=eMTsHQ1n911dXkSgFw65A0G4V4oLdwsS3IrqjLa0PoIvidtO73Kn0YqrL100Ghq/KK
         g/B6+7cTYfCTmteYJ6UOkwT0tN2dI8EIxekPIclzqhTPzClaXEAc0iQ56Joxhn256MUN
         hBTBEaGTOIgVpdtdPuiD/3tHjS6jS/2Koz8oWTOw3bMY5x1ZJeFRD+duhQtLZ4UNJcoE
         bdOYAMsyz/ECbuGu1a4hFPdouCAHTyD3n8BwjPbSRRtj7n4Lu1J6W6WZgZfEuwJBU0y2
         n6SZvMsG0X3ZIyzY2E4s28x1DrvZhqcQ6FS2QPwSDWBp2wRuqsHaCS6MaceMGVElR0Su
         uEbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 632af50fab734c4e99d8da91b46fbba9-20180321
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, Roger Quadros <rogerq@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [usb-next PATCH] usb: xhci: skip phys initialization of shared hcd
Date: Wed, 21 Mar 2018 14:12:38 +0800
Message-ID: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595526733993033305?=
X-GMAIL-MSGID: =?utf-8?q?1595526733993033305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The phys has already been initialized when add primary hcd,
including usb2 phys and usb3 phys also if exist, so needn't
re-parse "phys" property again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c  | 1 +
 drivers/usb/host/xhci-plat.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 7334da9..6bb23fb 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
+	xhci->shared_hcd->skip_phy_initialization = 1;
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto dealloc_usb2_hcd;
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6700e5e..65a4294 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
+	xhci->shared_hcd->skip_phy_initialization = 1;
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto dealloc_usb2_hcd;
-- 
1.9.1
