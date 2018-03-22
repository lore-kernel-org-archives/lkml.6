Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELuyWwgwZ0gZz7nj2nSwHV8igVhtaR5DEtigHMHwqc33tkYIB76e7neV1IA/kqW9UUAi45S/
ARC-Seal: i=1; a=rsa-sha256; t=1521707998; cv=none;
        d=google.com; s=arc-20160816;
        b=X9qNj49YdkvNK3f9DLcYxbogKwYvIppK9sgIm2aB1qcHYIgirKvuDo3NISfn4fDUkW
         x5J7bEtV+QgyR6L+VVOLRPmhrFEiC/POFNkpoBupcAN8Rh1Cvb6z6hyguL8Z6m3fI18q
         k4SMFBO1qylf52OpFwjad1bkJiagYYpL7zgTfUAwnWiD2vfsMvwSc2Vy9YJPdhDuQm2t
         NOuXrzS6Y2zb2gey4wQddcPsbIFwOCDkC5ZY0UbhuE8ytka9FBXDtbwO4vjPhcdAKjf6
         D6SRA0dcigaHzUprMtnjbNEs12qe6BUVb2IFNd0MSqO4K+1ZWeuI2oPkU9i6/VKkJfSg
         bXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Eu/IbEmKWJwmq/7oTf6ri/YOmwEFHyKtxIqvjWCMqco=;
        b=YeNvTJ48Ro0CzyknBENNjyhPmdbD5zVV9lJ1FJA0zyn8ZolP5hiRZCcAPA1p36VM0i
         5Tu8XRTYE8FtzWkJ8XSSDbV6bh6oG59LdmQm3hQssMFZdg40WMpRX8LGc2VRVriAN5Qo
         +aWIqcIPfXs/eMWIl4InfuPTtNhCemKDOskq11ifUCSk62U24mTLqH+EpCFBVyQ68U7W
         Zar60RqbZ4jlTntJ9F+VLwQEBxXNu8MhVBJ776bTbVE4h3tDF4uvbWjPokuKINE6yw1h
         9VZdzFsNpac1aK6XF3AtDMMjszINKTMSPPh3ifIMUDNrXAxZhUKEIfvCA1IZTWOYWkFB
         pTNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 1f51a58fce9d4b1d828fa13d0601ee00-20180322
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Mathias Nyman <mathias.nyman@intel.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Roger
 Quadros <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of shared hcd
Date: Thu, 22 Mar 2018 16:39:20 +0800
Message-ID: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595526733993033305?=
X-GMAIL-MSGID: =?utf-8?q?1595626486235650340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The phys has already been initialized when add primary hcd,
including usb2 phys and usb3 phys also if exist, so needn't
re-parse "phys" property again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 5a92d8f..777036a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
-	if (!hcd->skip_phy_initialization) {
+	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
 		if (IS_ERR(hcd->phy_roothub)) {
 			retval = PTR_ERR(hcd->phy_roothub);
-- 
1.9.1
