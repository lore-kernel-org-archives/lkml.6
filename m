Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A684C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1151217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="T3Umq4M4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeLRLkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:40:35 -0500
Received: from mail-eopbgr680106.outbound.protection.outlook.com ([40.107.68.106]:10416
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeLRLkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKL7UEvjPZE1pOXWS4d+1UWf5UtPEFA3cDaVAB0O3nQ=;
 b=T3Umq4M42WarUnT1IbTMepZVA2mmABTTZOrRs3VRO5RuCBczxVdCgIy5gXEKzRP42CpInAZ3DJcXEAow67iijtY2YTZP3OtVdef8A9857h868vRVNywEx8OjI69s7YHHE3rKfAQothmE7KcE5WEG1BVqyuVbObaeOIYbT8bnK8Y=
Received: from SN6PR16MB2542.namprd16.prod.outlook.com (52.135.125.202) by
 SN6PR16MB2671.namprd16.prod.outlook.com (52.135.127.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 11:40:29 +0000
Received: from SN6PR16MB2542.namprd16.prod.outlook.com
 ([fe80::8820:cbd3:3b2a:c3b2]) by SN6PR16MB2542.namprd16.prod.outlook.com
 ([fe80::8820:cbd3:3b2a:c3b2%3]) with mapi id 15.20.1425.021; Tue, 18 Dec 2018
 11:40:29 +0000
From:   "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Andy Dai (WH)" <andy.dai@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "Mike Li (WH)" <mike.li@bayhubtech.com>,
        "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V2 1/2] mmc: sdhci: Fix O2 Host PLL and card detect issue
Thread-Topic: [PATCH V2 1/2] mmc: sdhci: Fix O2 Host PLL and card detect issue
Thread-Index: AQHUlsZ5DrLY9x9skUmM//0fQzYb+Q==
Date:   Tue, 18 Dec 2018 11:40:29 +0000
Message-ID: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To SN6PR16MB2542.namprd16.prod.outlook.com
 (2603:10b6:805:d3::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [240e:b5:4028:7276:3c98:20f4:6f5e:78ce]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR16MB2671;6:LvFFQPSqaveen58XGXRhhyh4hIu+E78XkYnCZxRRuEuR7UcVQoTu4OW3W2a26TwXDhRfxGTjwfVFj26V2vOpI8Iqpe9JwVc4pena1N7I1GBz0yjcwv8KqewWPKcs8OxAU5aa9faMF4R3VZWank7rf5uZaplGzbxByPLZ9so+LBijx4IVOul+/32sdZhkn8kF6SDUOap0zTiDnQ0ATXLdDdwf5m8e9+nEYlEfjPrNyWi8uCwmVrdLNfN5PTLq08QAQhJLk632/87vfoIq8SrTYlh4OcyS1iAcjK508nnNkSwf+t/CgJjgn3O+aQWF3abVdAlEgPEVGd/yWsQC3VQKzcefU4rqZgai8EL5531+sE9wev87jE2AOb/X8XSSq/IsUGE1dP+eYeQA92X9zCUD73u2An1gzaj3jtdvcbyo14p/ikipc0IXnzQA5xcc3dy11TiIKoy8vQkogek+xFmMCg==;5:EAErRz3SbJDot/0WaEe6HsZ+V4DWC5w5xu6AmtPp8yEZNEmfiobueOhGAnoBJH8tPHxD5rSKrbHVXxtobKVk3EkYyGwQoDMlme+siwLmf71izqfatfFUJjuFPb2bYF1tSEmWS5UNORODENyKOJgg+r8OhgqpShfbKSrZo28uCU4=;7:6Hdu0THP7v0OqrfJ42zwuPcWeSbNGfpNapbLvwr+WYQnKuSXQvfTz9aYObWqCJRzfYUTcSHXI1i/4A3LzMU/1etvA5rh2D6aSY8oO+dYQ+arHM1kpAvfQ7jSn0mmGWEngn6sUy0gy6oVhY6xzDvd1A==
x-ms-office365-filtering-correlation-id: d956342a-6233-47ec-e0c4-08d664dd9bbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR16MB2671;
x-ms-traffictypediagnostic: SN6PR16MB2671:
x-microsoft-antispam-prvs: <SN6PR16MB2671ABF6456A5D347C6AC152E5BD0@SN6PR16MB2671.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:SN6PR16MB2671;BCL:0;PCL:0;RULEID:;SRVR:SN6PR16MB2671;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(39830400003)(396003)(199004)(189003)(386003)(6486002)(106356001)(6506007)(486006)(107886003)(6512007)(105586002)(68736007)(71190400001)(71200400001)(4326008)(81156014)(6116002)(7736002)(52116002)(2906002)(2501003)(53936002)(8676002)(5660300001)(46003)(14454004)(2616005)(1076003)(110136005)(508600001)(54906003)(97736004)(99286004)(8936002)(14444005)(256004)(36756003)(575784001)(86362001)(305945005)(2201001)(102836004)(6436002)(25786009)(81166006)(476003)(186003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR16MB2671;H:SN6PR16MB2542.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2KBSLRKpjKAHmeOk/6WYP7TeaPiA3Rm50fgsjZlDe5ReuHVeFxGx1b+OTVjcLRUcOg8JD4BXjCgy7AsFns2xTLksPyGayJAzj8Yx/JKeFZ7X2t5DYTGKcA+0D1EonLqalN4UHelJTcD+StuYuTUS9iL6XRSudozM9Mz9wzfFwCkNXhgBBv/rZcynfxX5ignxuIBUPxDUazJOb59CCbACiFnu6waNsvvqvqt7oKoLPca6qEJl3SzuSnx8vyz4yfht3oCKpLlFLqofCgSExqMJANGFyybUw2JsS25d0JOw9KsRMkcOafViRqtXEqXD27X1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d956342a-6233-47ec-e0c4-08d664dd9bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 11:40:29.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR16MB2671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ernest Zhang" <ernest.zhang@bayhubtech.com>

1. O2 Host Controller PLL lock status is not in compliance with
CLOCK_CONTROL register bit 1
2. O2 Host Controller card detect function only work when PLL is
enabled and locked

Signed-off-by: Ernest Zhang <ernest.zhang@bayhubtech.com>
---
Change in V2:
	1. Remove unused sdhci_ops function pointer
	2. Change kind of timeout check, get the time first
	3. Rename CARD PRESENT register bit16 and bit 18 macro

Change in V1:
	N/A
---
 drivers/mmc/host/sdhci-pci-core.c    |   9 +++
 drivers/mmc/host/sdhci-pci-o2micro.c | 121 +++++++++++++++++++++++++++++++=
+++-
 drivers/mmc/host/sdhci-pci.h         |   1 +
 drivers/mmc/host/sdhci.h             |   4 ++
 4 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci=
-core.c
index 2a6eba74b94e..fc4f35653602 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1257,6 +1257,14 @@ static int jmicron_resume(struct sdhci_pci_chip *chi=
p)
 }
 #endif
=20
+static const struct sdhci_ops sdhci_pci_o2_ops =3D {
+	.set_clock =3D sdhci_pci_o2_set_clock,
+	.enable_dma =3D sdhci_pci_enable_dma,
+	.set_bus_width =3D sdhci_set_bus_width,
+	.reset =3D sdhci_reset,
+	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
+};
+
 static const struct sdhci_pci_fixes sdhci_o2 =3D {
 	.probe =3D sdhci_pci_o2_probe,
 	.quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
@@ -1265,6 +1273,7 @@ static const struct sdhci_pci_fixes sdhci_o2 =3D {
 #ifdef CONFIG_PM_SLEEP
 	.resume =3D sdhci_pci_o2_resume,
 #endif
+	.ops =3D &sdhci_pci_o2_ops,
 };
=20
 static const struct sdhci_pci_fixes sdhci_jmicron =3D {
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index cc3ffeffd7a2..506b93e5dcd8 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -60,6 +60,13 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
+#define O2_PLL_WDT_CONTROL1	0x1CC
+#define  O2_PLL_FORCE_ACTIVE	BIT(18)
+#define  O2_PLL_LOCK_STATUS	BIT(14)
+#define  O2_PLL_SOFT_RESET	BIT(12)
+
+#define O2_SD_DETECT_SETTING 0x324
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -283,6 +290,113 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_=
chip *chip,
 	host->irq =3D pci_irq_vector(chip->pdev, 0);
 }
=20
+static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 scratch32;
+
+	/* Wait max 50 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 50);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
+		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
+			break;
+
+		if (timedout) {
+			pr_err("%s: Card Detect debounce never finished.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+
+static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u16 scratch;
+	u32 scratch32;
+
+	/* PLL software reset */
+	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 |=3D O2_PLL_SOFT_RESET;
+	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	udelay(1);
+	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
+	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+
+	/* PLL force active */
+	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+
+	/* Wait max 20 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch =3D sdhci_readw(host, O2_PLL_WDT_CONTROL1);
+		if (scratch & O2_PLL_LOCK_STATUS)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			goto out;
+		}
+		udelay(10);
+	}
+
+	/* Wait for card detect finish */
+	udelay(1);
+	sdhci_o2_wait_card_detect_stable(host);
+
+out:
+	/* Cancel PLL force active */
+	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+}
+
+static int sdhci_o2_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host =3D mmc_priv(mmc);
+
+	sdhci_o2_enable_internal_clock(host);
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
+{
+	/* Enable internal clock */
+	clk |=3D SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (sdhci_o2_get_cd(host->mmc)) {
+		clk |=3D SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	host->mmc->actual_clock =3D 0;
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (clock =3D=3D 0)
+		return;
+
+	clk =3D sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+	sdhci_o2_enable_clk(host, clk);
+}
+
 int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -316,7 +430,11 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slo=
t)
 				host->flags |=3D SDHCI_SIGNALING_180;
 				host->mmc->caps2 |=3D MMC_CAP2_NO_SD;
 				host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
+				pci_write_config_dword(chip->pdev,
+						       O2_SD_DETECT_SETTING, 3);
 			}
+
+			slot->host->mmc_host_ops.get_cd =3D sdhci_o2_get_cd;
 		}
=20
 		host->mmc_host_ops.execute_tuning =3D sdhci_o2_execute_tuning;
@@ -490,9 +608,6 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
 	case PCI_DEVICE_ID_O2_SEABIRD0:
-		if (chip->pdev->revision =3D=3D 0x01)
-			chip->quirks |=3D SDHCI_QUIRK_DELAY_AFTER_POWER;
-		/* fall through */
 	case PCI_DEVICE_ID_O2_SEABIRD1:
 		/* UnLock WP */
 		ret =3D pci_read_config_byte(chip->pdev,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 2ef0bdca9197..e41a85f0b40a 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -184,6 +184,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
 #endif
+void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock);
=20
 extern const struct sdhci_pci_fixes sdhci_arasan;
 extern const struct sdhci_pci_fixes sdhci_snps;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..924e03332cf7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -73,6 +73,10 @@
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
 #define  SDHCI_DATA_AVAILABLE	0x00000800
 #define  SDHCI_CARD_PRESENT	0x00010000
+#define   SDHCI_CARD_PRES_SHIFT	16
+#define  SDHCI_CD_STABLE	0x00020000
+#define  SDHCI_CD_LVL		0x00040000
+#define   SDHCI_CD_LVL_SHIFT	18
 #define  SDHCI_WRITE_PROTECT	0x00080000
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
--=20
2.16.4

