Return-Path: <gregory.clement@bootlin.com>
X-Google-Smtp-Source: AIpwx4+mHp+ZX+mqkWfrsNqsWM0cYJuCcCHbqysHAWkb0/pTDzJ5NtBixpHgqpa69RtHPVtNwor7
ARC-Seal: i=1; a=rsa-sha256; t=1524144671; cv=none;
        d=google.com; s=arc-20160816;
        b=XWQ5fsiw1OaqSni3kqsd0YjiN0HpEnx/JCi/9R8wiz3S+uxn/us1uM8WAbqbyg++WR
         2vgAV302rqPtaJPjUDVjZSdNw3x1HVUoyzyuuYttD9k1AfkdfySE7kDw/7iliVBfdqxN
         oM1W3Q4HpHFTnnLFzFBqA6hSvCSIQwb21rAe3HnSbH7hQJxaAbzKdn9QaQnggG0KJrnF
         EH9hRiWhvgu2l5qGXOCDs8ODb8S3mhbHSSs8W6rSvWaLsCKp7Spx+3R5EPi+pCZHM6IL
         2rgJ6LDnwLM2dbla7l7PQQsUTlLnOF7KEVb7WP9eGf443SZhx350J7i/tKxb1EtiFZOD
         Viag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1qDHU6xIIWR+WWnzIJp/tQBFfeqQH/1QMo7rTR+4dzU=;
        b=BXd/bkQwCx7lZ7uqrH7k0iLWik5pWJHabZ0f1D3Iqgko4DxCjbRTV0b0kfJN73kKGB
         6JYs/NxI9xXIeM1ledsfVq0HmdtFCtjGuVUkcRFQysV8uUMFcnLvX1VF73PM6u3UpPot
         jHkUPtCTSfg9hfSyINJk/+UlytzjxPnS7sDDp5k7MvsbShe0Td+FrJpq+HErJJK1Ry25
         mCuDvgKQclrgP3W+GNI3SeLxN8+vQwYv1ybbM6Trj8H6Cy/ZPCe+cn119HhUgHRosl8/
         EvBsq8yWj+xfMxib731hjMq00X48p/Hikn+W+r2CzYrWQkNSwyHsmH55uCWaHT3DvVT8
         8Tzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gregory.clement@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=gregory.clement@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gregory.clement@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=gregory.clement@bootlin.com
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Omri Itach <omrii@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Igal Liberman <igall@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 1/2] usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
Date: Thu, 19 Apr 2018 15:30:52 +0200
Message-Id: <20180419133053.11894-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180419133053.11894-1-gregory.clement@bootlin.com>
References: <20180419133053.11894-1-gregory.clement@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598181523783849966?=
X-GMAIL-MSGID: =?utf-8?q?1598181523783849966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df327dcc2bac..f0231fea524e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -320,8 +320,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 
 disable_clk:
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 
 put_hcd:
 	usb_put_hcd(hcd);
@@ -347,8 +346,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	usb_put_hcd(xhci->shared_hcd);
 
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
+	clk_disable_unprepare(clk);
 	usb_put_hcd(hcd);
 
 	pm_runtime_set_suspended(&dev->dev);
-- 
2.16.3
