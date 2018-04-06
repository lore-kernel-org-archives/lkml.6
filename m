Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Dx5wgNiAUbDxz+wB6KFfDXYXjcCpkCwVgl+JoTSPdI0H/gnzBUIYOfd8mMrC7sxGYst1g
ARC-Seal: i=1; a=rsa-sha256; t=1523021605; cv=none;
        d=google.com; s=arc-20160816;
        b=wlooaEEVxLvdLbyoaNhIs+SWJfwDteUuGvfjzAYuEAR0vJygmTDkQQhsiQ8Jz/Ghqg
         KEv2vJ5wCQjeg5Jf1tqhj3P0WtKgk83GtW1w09UVcnR3XGccqV8sDlNYo9d/haBD868s
         gdYN81AH82eqKd6VK5cotyGDxporlUpynunRmNzszy5pdI5H3UkcL2Ov2zBbjbNL/GQo
         NLw+jXOBboUPbMPfkD0q4kIbjGIITPBUEXGf+rEQyJJnQLLEURkB4YJn9a6UR+RaHXu3
         M1jSLqvxJTFthFmetkGNltc/lTFaW6p+b56/X4+YM7APh+jW56NljLncqTCXnxU8SdLp
         Bbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ae7d461QEPMkbOw3CmL8emao7EJeIt95HGunOnmvuTc=;
        b=ANQOQnqVN3vXlqj/MCBJNsI2P0Zb1kj93eHBspOrSXt+v2oRhfu3NOO6wVbOyPv2Mi
         zPjhEPq/SBsZ8zWOOzoLXRp4/5LQLrkCJfJpzcVmYko4ecQOJquSE1cUARPxLgJLwGrp
         v3QIg5anc/cika0qV30k8edKHbR7tclgUBl6jOjYB++raLozlAAqXeG4CqkyG06uiTu3
         X2BFzKLelx8egf/UZoNYosF8ru7Zehz8XPJ+ghdKOe4ku9PPZy1/5wWOMWbisFxeKfxS
         6NmSRxLafztlVAlO1D0u+xI/rUMREyrZk9zlKmceaijzw1zQLilsniF+G4VDR/glVHlA
         1zag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 024/102] xgene_enet: remove bogus forward declarations
Date: Fri,  6 Apr 2018 15:23:05 +0200
Message-Id: <20180406084335.061726018@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003903161730352?=
X-GMAIL-MSGID: =?utf-8?q?1597003903161730352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1f3d62090d3ba4d0c14e5271be87812fc577b197 upstream.

The device match tables for both the xgene_enet driver and its phy driver
have forward declarations that declare an array without a length, leading
to a clang warning when they are not followed by an actual defitinition:

drivers/net/ethernet/apm/xgene/../../../phy/mdio-xgene.h:135:34: warning: tentative array definition assumed to have one element
drivers/net/ethernet/apm/xgene/xgene_enet_main.c:33:36: warning: tentative array definition assumed to have one element

The declarations for the mdio driver are even in a header file, so they
cause duplicate definitions of the tables for each file that includes
them.

This removes all four forward declarations and moves the actual
definitions up a little, so they are in front of their first user. For
the OF match tables, this means having to remove the #ifdef around them,
and passing the actual structure into of_match_device(). This has no
effect on the generated object code though, as the of_match_device
function has an empty stub that does not evaluate its argument, and
the symbol gets dropped either way.

Fixes: 43b3cf6634a4 ("drivers: net: phy: xgene: Add MDIO driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c |   50 +++++++++++------------
 drivers/net/phy/mdio-xgene.c                     |   50 +++++++++++------------
 drivers/net/phy/mdio-xgene.h                     |    4 -
 3 files changed, 48 insertions(+), 56 deletions(-)

--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1680,6 +1680,30 @@ static void xgene_enet_napi_add(struct x
 	}
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_enet_acpi_match[] = {
+	{ "APMC0D05", XGENE_ENET1},
+	{ "APMC0D30", XGENE_ENET1},
+	{ "APMC0D31", XGENE_ENET1},
+	{ "APMC0D3F", XGENE_ENET1},
+	{ "APMC0D26", XGENE_ENET2},
+	{ "APMC0D25", XGENE_ENET2},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, xgene_enet_acpi_match);
+#endif
+
+static const struct of_device_id xgene_enet_of_match[] = {
+	{.compatible = "apm,xgene-enet",    .data = (void *)XGENE_ENET1},
+	{.compatible = "apm,xgene1-sgenet", .data = (void *)XGENE_ENET1},
+	{.compatible = "apm,xgene1-xgenet", .data = (void *)XGENE_ENET1},
+	{.compatible = "apm,xgene2-sgenet", .data = (void *)XGENE_ENET2},
+	{.compatible = "apm,xgene2-xgenet", .data = (void *)XGENE_ENET2},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, xgene_enet_of_match);
+
 static int xgene_enet_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev;
@@ -1826,32 +1850,6 @@ static void xgene_enet_shutdown(struct p
 	xgene_enet_remove(pdev);
 }
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id xgene_enet_acpi_match[] = {
-	{ "APMC0D05", XGENE_ENET1},
-	{ "APMC0D30", XGENE_ENET1},
-	{ "APMC0D31", XGENE_ENET1},
-	{ "APMC0D3F", XGENE_ENET1},
-	{ "APMC0D26", XGENE_ENET2},
-	{ "APMC0D25", XGENE_ENET2},
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, xgene_enet_acpi_match);
-#endif
-
-#ifdef CONFIG_OF
-static const struct of_device_id xgene_enet_of_match[] = {
-	{.compatible = "apm,xgene-enet",    .data = (void *)XGENE_ENET1},
-	{.compatible = "apm,xgene1-sgenet", .data = (void *)XGENE_ENET1},
-	{.compatible = "apm,xgene1-xgenet", .data = (void *)XGENE_ENET1},
-	{.compatible = "apm,xgene2-sgenet", .data = (void *)XGENE_ENET2},
-	{.compatible = "apm,xgene2-xgenet", .data = (void *)XGENE_ENET2},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, xgene_enet_of_match);
-#endif
-
 static struct platform_driver xgene_enet_driver = {
 	.driver = {
 		   .name = "xgene-enet",
--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -314,6 +314,30 @@ static acpi_status acpi_register_phy(acp
 }
 #endif
 
+static const struct of_device_id xgene_mdio_of_match[] = {
+	{
+		.compatible = "apm,xgene-mdio-rgmii",
+		.data = (void *)XGENE_MDIO_RGMII
+	},
+	{
+		.compatible = "apm,xgene-mdio-xfi",
+		.data = (void *)XGENE_MDIO_XFI
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, xgene_mdio_of_match);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_mdio_acpi_match[] = {
+	{ "APMC0D65", XGENE_MDIO_RGMII },
+	{ "APMC0D66", XGENE_MDIO_XFI },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, xgene_mdio_acpi_match);
+#endif
+
+
 static int xgene_mdio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -439,32 +463,6 @@ static int xgene_mdio_remove(struct plat
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id xgene_mdio_of_match[] = {
-	{
-		.compatible = "apm,xgene-mdio-rgmii",
-		.data = (void *)XGENE_MDIO_RGMII
-	},
-	{
-		.compatible = "apm,xgene-mdio-xfi",
-		.data = (void *)XGENE_MDIO_XFI
-	},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, xgene_mdio_of_match);
-#endif
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id xgene_mdio_acpi_match[] = {
-	{ "APMC0D65", XGENE_MDIO_RGMII },
-	{ "APMC0D66", XGENE_MDIO_XFI },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(acpi, xgene_mdio_acpi_match);
-#endif
-
 static struct platform_driver xgene_mdio_driver = {
 	.driver = {
 		.name = "xgene-mdio",
--- a/drivers/net/phy/mdio-xgene.h
+++ b/drivers/net/phy/mdio-xgene.h
@@ -132,10 +132,6 @@ static inline u64 xgene_enet_get_field_v
 #define GET_BIT(field, src) \
 		xgene_enet_get_field_value(field ## _POS, 1, src)
 
-static const struct of_device_id xgene_mdio_of_match[];
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id xgene_mdio_acpi_match[];
-#endif
 int xgene_mdio_rgmii_read(struct mii_bus *bus, int phy_id, int reg);
 int xgene_mdio_rgmii_write(struct mii_bus *bus, int phy_id, int reg, u16 data);
 struct phy_device *xgene_enet_phy_register(struct mii_bus *bus, int phy_addr);
