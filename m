Return-Path: <amelie.delaunay@st.com>
X-Google-Smtp-Source: AH8x226ge4jeOFu6UHZahJsvxgpU5vZy7LysdXcDW3xrBpZGz4mWQiJQX9YnSn7Wao/ioB2LsxRV
ARC-Seal: i=1; a=rsa-sha256; t=1519117914; cv=none;
        d=google.com; s=arc-20160816;
        b=NTKS1/jQnnu3hfhmmCn0s54k+rO0pnynF3+IDTkfX7g9qyTsKo/Q21y32XbKYh9kqr
         Q1oCWSIKGwn4AgK54Q/IVKmxNIHKsMvdCUW8Fy8q6OCWzsUQCI04Rz5EAX6lmhfDU4ts
         4jffX1jW0dfrNrW+CwKQJfwy7stjhIfGyUNS6vIBLzo/uHGB4PFLd7SHhnDbv4kLv45X
         nzzb2Oi02BxeKRR9XuYH2WlQUUi33ZSHtOZV0rKIJtu6Cbbemgtia/8UvXO5iIXgBpn1
         a18cNBNc5C1xPnO+Ljpren9tAOmldnWybV/CnkMslq30Kl+x0wCtE1N9zlijWDMvMD40
         WHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=EftVRuibKs/4TDBPG0N5bEwqIx38b0R/Ug83zkTITXU=;
        b=AYkX3gXNZCNwy8aI/VzOAnFe4FJQHMkaEXysoBf/k68JeixrAE+ajBlmLi8oh4CcWE
         n0g6X/gk/l8XS5rJQnAp+6ckx/dpdhffbfIxCh0viKgBh1IrJd//HO+pbEeGiIp14kuK
         u7hCcS6pwLYZIzBOdTjy1Q9N7clBJdolpjbhzzSeRVBmIv3yoOv9AcpxsvOeIrd4mVXJ
         ppj5oeCX0+MxQHJeXOyOWxWuRM+PdI14HNedo6vxR3DoZ9si1CnZkNKBkijwtrpIwEB+
         NSw5cD1PpHQ3ha7i388VJMcUaSfdRgaZIt6GO+i7tthFwV5nEMdkwMDlKUsP9rHJ94sK
         ZazA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amelie.delaunay@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=amelie.delaunay@st.com
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk
	<linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] usb: host: ehci-platform: add support for optional external vbus supply
Date: Tue, 20 Feb 2018 10:11:45 +0100
Message-ID: <1519117905-12095-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_02:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592910586052663664?=
X-GMAIL-MSGID: =?utf-8?q?1592910586052663664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
may be used.
Add support for this optional external vbus supply in ehci-platform.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 drivers/usb/host/ehci-platform.c                   | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 3efde12..fc480cd 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -19,6 +19,7 @@ Optional properties:
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
  - resets : phandle + reset specifier pair
+ - vbus-supply : phandle of regulator supplying vbus
 
 Example (Sequoia 440EPx):
     ehci@e0000300 {
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b065a96..76cc781 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -46,6 +47,7 @@ struct ehci_platform_priv {
 	struct reset_control *rsts;
 	struct phy **phys;
 	int num_phys;
+	struct regulator *vbus_supply;
 	bool reset_on_resume;
 };
 
@@ -99,6 +101,15 @@ static int ehci_platform_power_on(struct platform_device *dev)
 		}
 	}
 
+	if (priv->vbus_supply) {
+		ret = regulator_enable(priv->vbus_supply);
+		if (ret) {
+			dev_err(&dev->dev,
+				"failed to enable vbus supply: %d\n", ret);
+			goto err_exit_phy;
+		}
+	}
+
 	return 0;
 
 err_exit_phy:
@@ -119,6 +130,9 @@ static void ehci_platform_power_off(struct platform_device *dev)
 	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
 	int clk, phy_num;
 
+	if (priv->vbus_supply)
+		regulator_disable(priv->vbus_supply);
+
 	for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
 		phy_power_off(priv->phys[phy_num]);
 		phy_exit(priv->phys[phy_num]);
@@ -247,6 +261,15 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (err)
 		goto err_put_clks;
 
+	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
+	if (IS_ERR(priv->vbus_supply)) {
+		err = PTR_ERR(priv->vbus_supply);
+		if (err == -ENODEV)
+			priv->vbus_supply = NULL;
+		else
+			goto err_reset;
+	}
+
 	if (pdata->big_endian_desc)
 		ehci->big_endian_desc = 1;
 	if (pdata->big_endian_mmio)
-- 
2.7.4
