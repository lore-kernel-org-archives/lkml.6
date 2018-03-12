Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELsmDRRzkLjdKKXAr9LpkmNRxXbmfDGuYJ/wGDL7tm8DhkmWBVAw4OHx7a3p/QTxZBZGYeqY
ARC-Seal: i=1; a=rsa-sha256; t=1520868317; cv=none;
        d=google.com; s=arc-20160816;
        b=ZIvhfvclLrJJxKai8JgqnCemNJQW7Fyd2yKpGc9Qq8aQ4i/t0Vucr4z4LapLBf8kYt
         REuO9fGtDhoXl6z8XSRzZubMYhOSzdrPElYmCMeuPVFAtYDL4hsnQZaNm1x9ue5EnWbS
         7dMxvdMy2XHSYh5UZBLp90oeRTPMjxFfaYrg5QdTs5h7n+K32WjRHv68oju1fgmTycmC
         Miy13nGUAl6sba4EUvKY6y0+YJV52MHql60z9OKLvkBbOKL6pfKyBHRqNIa2smG9seCk
         S8nunCjgw0DVko7rghj3b1FiTXvRVYJA8Y+HvsWHFQbY6DR45JqXARycJ97SemseUOqh
         loEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lcoZnY2sUtS/7tlN9o+x9F4UY5IhIAo8YJphpCYvyWs=;
        b=h5I+aRMWvg3PLldMZGLhYJZTfRgeZBzBcLK098Pz2V4sZr4jUKUra64uhvCSY6L5v3
         GzdftV0lubG708C6Yh3Ci5zWvzeEcuRnpSqfRG+3W1nrAU4I2Wbi6Hg5WkZ5uTGroIXb
         zpdrZg9/46RYK/oN19j1zlE/d0uQdz6K21Of+Ca6hwe2y/KwlwyRCqwMpeT0LUIRlxnO
         9mjxamhqEesyFkzUA4kdfZfb94yls2GfokrMngJJUlYPuXZLBaVKlp25fNHcuBYea19a
         aiG9g5kTFGt8vTam8RSMObuYFBJzmc5fsOvc4IjoErq38Cy8AC5hqsuetQAvCtMrX1JM
         +MBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=RTMWS2Us;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.55 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=RTMWS2Us;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.55 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: hch@lst.de,
	robin.murphy@arm.com,
	linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com,
	bhelgaas@google.com
Cc: dmitry.torokhov@gmail.com,
	rafael.j.wysocki@intel.com,
	jarkko.sakkinen@linux.intel.com,
	linus.walleij@linaro.org,
	johan@kernel.org,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Date: Mon, 12 Mar 2018 20:54:52 +0530
Message-Id: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BMXPR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::20) To HE1PR0401MB2428.eurprd04.prod.outlook.com
 (2603:10a6:3:25::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31707004-1d6c-427a-cab6-08d5882d7389
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2428;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2428;3:sZxwBqaR+fo3EN83ufy0hE0MIXdMXJ20gCIMgu0SdVHRLmFFg/xK6prc1pYZyjfQs5fkhg9QyA4Xg33epJHcDh1yldOWU+uvgazZVnOnQ6rVt2LqxY3Yp3G+u19uCk/PPUBg2RoowcROav51Yhg7u3hvY/ZxP4jB5Ei8j6mXJdAe57Pysxs/OFNuP4THeBtTH4zOlb8HYhjd3hNTStF9Znt9ERO2ttcEqDR22xMmBtoWWbj6wU5U5H10KLW8fAu8;25:LB4PABMhTiGkxaf8izhp5x/xCiPp1ByoNU59CnDsebary9BgiVPdVHYzJldpIJHn23F4gDd74ALVzjFv7fRH2K/sEX6bPWqVBXcfldg4TMZOMatut/X/UtT2DcBf9Y7fRTeIQXrq3ps9DgzNxNeFCUt2qGHqNwh6RXViumpVyJ+e9x0tVsB3GkNBdmFkEJylbUGv4NmyybHVxNAOkp9xFufC+8KhOMngkKVEKYVo+ITwkjeTJzEyKEuNpo0R66MkhPSFGXe6nUR3M63yYycYw7K/apN4uLCCx9aCay4UjqlLBMVhHWV5t7mSglSadDgCfKc4UqZa5thQRE21Cl6esw==;31:WFY/2I/LlYcF4/6dow6gD+HyOJ3Z5WKpVQHuIWukIIeZknloXexX4JmWJRnmGesoVtsoP2sGiV1y58TDe6qhygEO2aYcZoWxMQhHic21e7fDBrHIPmwC+jnUHiScVk8j0QHJzWRVW4PaTZ9JzYnlRDFSQEXf6pGQ1kOrL8luOVc7lebD2eOJxOOswZRqEkn2wD0SSDS+wJ7aeghNLX63lcG7KMAEDArcEL0d+E7Uma0=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2428:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2428;20:at5xJuRX4NtqG1bgMame2xz1OFxvd4WfAKYg3woFGxy+DMeR/sQO8s6aORH+qYXalnC6rtECFGxr3xCbo2y1c66lYRGGsmr79sR4tdTGQ5Jy2wNlY+SlAwjoBze2NpXXz4teGEskhrmXsdAlYd9RDRvnYsOQmsbepgjeFpuQ0r+jv0lqANAU/7aODF/WqxmHA8CBaZL8XfcY8B7vH03UaV4TiR54dhial+oe+oVbKLMIRAK1PRMiEWSFJhsbYxHvY0/XH9joFPQSd7pgVmjrhEmxu7HeO3ulq/DSP8P3io5tFBK58vPJacGOHZvlVrKxNYwluMN9BXkmp2+9PDKslgJPgr7do+mLxp4kzwhfcQzcuaBwONK9oLHqvmsFJW35ht/SBtBIRix4jQigr4+9abBB36au6CZyuGvLZuLqVqZ5tQaWEDtyvmpapHcT1idb/HZ1EaNpdS6OWo1a0PuvoJa9UFYlk8UG6EKEbvht6Lkkwoby7+rzR1QswnorXpcD;4:XI+9a4NSvxsMD98Dh24+8ClJNco5PB+S+OHDino6E5kJtAxHTsWusbuucihNu7GO0b7kTStxo2LeISPaGLYbSf8k95lzNmvjMP/Owo8W3EJdLASlkAS6uCUatf2UIxLL8z7iY5wIlWP7CqeIxiNvsC7lMIcHRjLyrh8lpz3z62jLhvWXwikUC2gZlgHI62Id81CzY57nAeqI+nYvJ13JSuQi5CVpNxQcOCTFb3akEAQvIkBLEETj9p1e/c+naQN9rjODshbJDrlkwwf3tfuiRAV1gK4y/YoK6PyQ9JHyWsjEVYLybclGcbn022uG03oo
X-Microsoft-Antispam-PRVS: <HE1PR0401MB24284E1EB025D94E7C05D723E6D30@HE1PR0401MB2428.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0401MB2428;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2428;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(366004)(396003)(376002)(199004)(189003)(86362001)(386003)(6666003)(4326008)(55236004)(26005)(2906002)(16526019)(186003)(25786009)(97736004)(106356001)(316002)(39060400002)(5009440100003)(16586007)(6506007)(52116002)(1857600001)(51416003)(53936002)(36756003)(47776003)(66066001)(68736007)(105586002)(50226002)(50466002)(8936002)(81166006)(48376002)(6306002)(6512007)(81156014)(3846002)(7736002)(6486002)(7416002)(8676002)(966005)(5660300001)(5890100001)(6116002)(305945005)(59450400001)(478600001)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2428;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2428;23:VvMUnDa5n+wvjl9mScL8MXh91v7Uze25KiISO1t?=
 =?us-ascii?Q?Dh7PUIXWQXDTISnpV/XJXfAPEf5HrPN8GwD+fQluc635b4zpg/Z/t5JOY6UQ?=
 =?us-ascii?Q?MeZJ72waTmBUkOaxlkMdViPtNjYS4j0EyA7ktLF3V3gzIEtuhgT5eZB23MYf?=
 =?us-ascii?Q?9kXxxh5ndTMXDaOXE2NK7FSStR3QSKvTFySDsj7tt5b3X4VdNHIu0+j7lci0?=
 =?us-ascii?Q?J0jepxB27Vfn01Vrv+SczJhzp36bv5mC32VP34AemIEupWDpl3nkUsNBeZye?=
 =?us-ascii?Q?HWd7KPZ4xhSxOVRdRAUsq0/OokvTHnRVzZLeC4hZi2TMrh3wUzVliB6oxSeE?=
 =?us-ascii?Q?ifw0Eaq1JZSKHjo3a14d/A2uGdF/ojauCfVAMBkt6e9L3pdbM+aVxVuykF0W?=
 =?us-ascii?Q?Un2Wdsuy41kNTw9HRO/2rixDgQf9xNWJxeeJFHhp+jpN9tZ0KRUg4ectGOmL?=
 =?us-ascii?Q?4IphNbftwCM5BZvhKudBOYPOf+dwtn/mVmvRG4WcF/SD0cF6qQ79pebvzRsn?=
 =?us-ascii?Q?cjOHvKgzo38LfafJQgqmU+9dssByLcA/lrhHnX1Zl8v/if5f4mQ6hpSpiyTH?=
 =?us-ascii?Q?9evS0S8F5/baS2qMUf86dS5lDWHt04w1niEk5kdyce6nEKxdBBio6Qz1OoRS?=
 =?us-ascii?Q?fH1U7OE/S5YNxWi87U2pAqmKLAtRSip6+gwFECmmML4lMKbQ0lq9YcbASVkp?=
 =?us-ascii?Q?fHq/Y2xIM4xvU1oeLxu8rvFkOZHZ44cbRcgrmQV3s01WilMeoG7kOUOnEMFH?=
 =?us-ascii?Q?cFQgtHRd57fLd71lbkSNK1Du9bAHSTXfaaqszHRgWICM3Sr/f0fRMjpL/gDT?=
 =?us-ascii?Q?74Dh3J07myd3+lsz/Extww8WS/nV0uSzvrPlYoQ5MT9blsEeSjFdn4KpPo+/?=
 =?us-ascii?Q?/n56vBKFvid83T2U4gsXv/bnbqURPq6x5ZicQvp13RazXaMyzbDI3H7E/m7c?=
 =?us-ascii?Q?TUnwFmWwBOZpSOWsOQ/23b2IHsLe7RK84dhvNWVklCFe1xqyogvYXRlc4rBr?=
 =?us-ascii?Q?p2q2l0sDBqWcEQnJD5BxqXNbhKg2JYTw+bzFAlyaNwpdH3ooQHbDNSBqs9WL?=
 =?us-ascii?Q?G/IMSHNUUZG3y2a8blyN5PD8Jt0XCjJLhAMm9iRfqKm1x6QlnHZ2PttVedx4?=
 =?us-ascii?Q?m2dfzwlWEBJZBf2qjTIuHIl/YeCGsl59HMSSkq/v6w/ewS8E1pg99USuXM3D?=
 =?us-ascii?Q?ToAbIh8eLO6ub760g5JLFqqF4hZ9DJgbafxVmw/3mCtiSC9ZMCjhiZCUXvvs?=
 =?us-ascii?Q?1KvqIuZn/x0mNAohyhI6Wg8SKzgkuZFJab9fHAkS2?=
X-Microsoft-Antispam-Message-Info: VOSSpdPJdLNXsXjJqIrvhDyD26Hn6oY5y5UWtlXoc57csqXsGNu53++au4JtKYdmApV0sGMBdaL9Y8AXal66hfY3Rq0oEASR+e4F08BAliCSbrd2VvvvLXV61f1YoP1rtqYKSXBkp3wDDA/LBDItg9+xeC8LMIMJOB5SgUHD7Lks/JZX5hbAOmEm/zLuudED
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2428;6:fEbKu0iBk6d8GhYgWg9N3OBA9PFC8Bo00ZHEtioEZ9sRwhTc+3/W6XKgMx6Y3u6/euHI4bkZHLYcVqZ32eOjBtmAl9L06O+5X9oK64x3Cqv38zxrOvUtDABwlPjHawYBtS/uwWp+EIUEV7p4o8AYLw1cV0AZYh4T7erkiBTLany4gDVCCoakFXflwfHYiKf/CAxbeK1LM17yJt5fhms1LPgaXaVa+9+Vy1UEKal8vwjbzk8ZQbZ/CBKLvrk/j80dHTR3wTkl31JcbooIGDvdIE1GY8AzWooAW9SWVKAv8EByevZIWPLYO/pOL7p1sPBN4NhhDhfXDIHZOI6pfT9w4vaRTAvmWi3CEhDCEAaepUs=;5:gt6jJGzJUyxqwP/mO9YHom6o7c80ILGysR95sB8pITiC8yC+iwYB8inymM1XaKhax3yOoLNUfa7tWOaN4QcZjwzWTsADKY2A7iwNuFIECUpA819W+QSVXS96gDJB2DspEftsb6gZN9W+475CW/5Vf9fMLIbW2c1caPlQ+exDv/U=;24:51dyUzLWc6/rgntIoQX96e1A+vFnTYZvXHSjTn6eGslGI5VajFj9Ex4nFTARzcxkl39qD8YWFXBUNx7EvCn+Yps0BI8eKAzg+Qce6l5f0jQ=;7:WsXR/lQRT1ETQU/nk++Ycc3rjXdu9XiQtqO5hglI1MiG1hIiAeDWsTizbPNJ6x7/6QWPag0plTCISPAeGRPfjAo2bHKl5m8XTDJbxM2X4RlOFftiXj5WdVq+UtBKc4uQE7027ks2AeGlyZqPLUB5j8Vyhi84u3mmtntq9bVZFtfyIEGbazmbfQIgoPsxY2/eu6Vkq1zrHY+VE/IQgul9NLm0Iu2Kfkvc82nUj6ofYmaulKJiC4VVCsqUUuoy2TbU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 15:25:10.4702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31707004-1d6c-427a-cab6-08d5882d7389
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2428
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594746017210545974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The change introduces 'dma_configure' & 'dma_deconfigure'as
bus callback functions so each bus can choose to implement
its own dma configuration function.
This eases the addition of new busses w.r.t. adding the dma
configuration functionality.

The change also updates the PCI, Platform and ACPI bus to use
new introduced callbacks.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 - This patch is based on the comments on:
   https://patchwork.kernel.org/patch/10259087/
 - I have validated for PCI and platform, but not for AMBA as I
   do not have infrastructure to validate it.
   Can anyone please validate them on AMBA?

 drivers/amba/bus.c          | 38 ++++++++++++++++++++++++-----
 drivers/base/dd.c           | 14 +++++++----
 drivers/base/dma-mapping.c  | 41 -------------------------------
 drivers/base/platform.c     | 36 ++++++++++++++++++++++-----
 drivers/pci/pci-driver.c    | 59 ++++++++++++++++++++++++++++++++++++---------
 include/linux/device.h      |  6 +++++
 include/linux/dma-mapping.h | 12 ---------
 7 files changed, 124 insertions(+), 82 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228..58241d2 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,6 +20,8 @@
 #include <linux/sizes.h>
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/acpi.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 
@@ -171,6 +173,28 @@ static int amba_pm_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+int amba_dma_configure(struct device *dev)
+{
+	enum dev_dma_attr attr;
+	int ret = 0;
+
+	if (dev->of_node) {
+		ret = of_dma_configure(dev, dev->of_node);
+	} else if (has_acpi_companion(dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			ret = acpi_dma_configure(dev, attr);
+	}
+
+	return ret;
+}
+
+void amba_dma_deconfigure(struct device *dev)
+{
+	of_dma_deconfigure(dev);
+	acpi_dma_deconfigure(dev);
+}
+
 static const struct dev_pm_ops amba_pm = {
 	.suspend	= pm_generic_suspend,
 	.resume		= pm_generic_resume,
@@ -190,12 +214,14 @@ static int amba_pm_runtime_resume(struct device *dev)
  * so we call the bus "amba".
  */
 struct bus_type amba_bustype = {
-	.name		= "amba",
-	.dev_groups	= amba_dev_groups,
-	.match		= amba_match,
-	.uevent		= amba_uevent,
-	.pm		= &amba_pm,
-	.force_dma	= true,
+	.name			= "amba",
+	.dev_groups		= amba_dev_groups,
+	.match			= amba_match,
+	.uevent			= amba_uevent,
+	.pm			= &amba_pm,
+	.dma_configure		= amba_dma_configure,
+	.dma_deconfigure	= amba_dma_deconfigure,
+	.force_dma		= true,
 };
 
 static int __init amba_init(void)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd09..f124f3f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -421,9 +421,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
-	ret = dma_configure(dev);
-	if (ret)
-		goto dma_failed;
+	if (dev->bus->dma_configure) {
+		ret = dev->bus->dma_configure(dev);
+		if (ret)
+			goto dma_failed;
+	}
 
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
@@ -486,7 +488,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 probe_failed:
-	dma_deconfigure(dev);
+	if (dev->bus->dma_deconfigure)
+		dev->bus->dma_deconfigure(dev);
 dma_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
@@ -895,7 +898,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			drv->remove(dev);
 
 		device_links_driver_cleanup(dev);
-		dma_deconfigure(dev);
+		if (dev->bus->dma_deconfigure)
+			dev->bus->dma_deconfigure(dev);
 
 		devres_release_all(dev);
 		dev->driver = NULL;
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..f16bd49 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -6,11 +6,9 @@
  * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
  */
 
-#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -329,42 +327,3 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 	vunmap(cpu_addr);
 }
 #endif
-
-/*
- * Common configuration to enable DMA API use for a device
- */
-#include <linux/pci.h>
-
-int dma_configure(struct device *dev)
-{
-	struct device *bridge = NULL, *dma_dev = dev;
-	enum dev_dma_attr attr;
-	int ret = 0;
-
-	if (dev_is_pci(dev)) {
-		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
-		dma_dev = bridge;
-		if (IS_ENABLED(CONFIG_OF) && dma_dev->parent &&
-		    dma_dev->parent->of_node)
-			dma_dev = dma_dev->parent;
-	}
-
-	if (dma_dev->of_node) {
-		ret = of_dma_configure(dev, dma_dev->of_node);
-	} else if (has_acpi_companion(dma_dev)) {
-		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
-		if (attr != DEV_DMA_NOT_SUPPORTED)
-			ret = acpi_dma_configure(dev, attr);
-	}
-
-	if (bridge)
-		pci_put_host_bridge_device(bridge);
-
-	return ret;
-}
-
-void dma_deconfigure(struct device *dev)
-{
-	of_dma_deconfigure(dev);
-	acpi_dma_deconfigure(dev);
-}
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f1bf7b3..adf94eb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1130,6 +1130,28 @@ int platform_pm_restore(struct device *dev)
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
+int platform_dma_configure(struct device *dev)
+{
+	enum dev_dma_attr attr;
+	int ret = 0;
+
+	if (dev->of_node) {
+		ret = of_dma_configure(dev, dev->of_node);
+	} else if (has_acpi_companion(dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			ret = acpi_dma_configure(dev, attr);
+	}
+
+	return ret;
+}
+
+void platform_dma_deconfigure(struct device *dev)
+{
+	of_dma_deconfigure(dev);
+	acpi_dma_deconfigure(dev);
+}
+
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	.runtime_suspend = pm_generic_runtime_suspend,
 	.runtime_resume = pm_generic_runtime_resume,
@@ -1137,12 +1159,14 @@ int platform_pm_restore(struct device *dev)
 };
 
 struct bus_type platform_bus_type = {
-	.name		= "platform",
-	.dev_groups	= platform_dev_groups,
-	.match		= platform_match,
-	.uevent		= platform_uevent,
-	.pm		= &platform_dev_pm_ops,
-	.force_dma	= true,
+	.name			= "platform",
+	.dev_groups		= platform_dev_groups,
+	.match			= platform_match,
+	.uevent			= platform_uevent,
+	.pm			= &platform_dev_pm_ops,
+	.dma_configure		= platform_dma_configure,
+	.dma_deconfigure	= platform_dma_deconfigure,
+	.force_dma		= true,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6be..4a77814 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/kexec.h>
+#include <linux/acpi.h>
+#include <linux/of_device.h>
 #include "pci.h"
 
 struct pci_dynid {
@@ -1522,19 +1524,52 @@ static int pci_bus_num_vf(struct device *dev)
 	return pci_num_vf(to_pci_dev(dev));
 }
 
+int pci_dma_configure(struct device *dev)
+{
+	struct device *bridge, *dma_dev;
+	enum dev_dma_attr attr;
+	int ret = 0;
+
+	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+	dma_dev = bridge;
+	if (IS_ENABLED(CONFIG_OF) && dma_dev->parent &&
+	    dma_dev->parent->of_node)
+		dma_dev = dma_dev->parent;
+
+	if (dma_dev->of_node) {
+		ret = of_dma_configure(dev, dma_dev->of_node);
+	} else if (has_acpi_companion(dma_dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			ret = acpi_dma_configure(dev, attr);
+	}
+
+	pci_put_host_bridge_device(bridge);
+
+	return ret;
+}
+
+void pci_dma_deconfigure(struct device *dev)
+{
+	of_dma_deconfigure(dev);
+	acpi_dma_deconfigure(dev);
+}
+
 struct bus_type pci_bus_type = {
-	.name		= "pci",
-	.match		= pci_bus_match,
-	.uevent		= pci_uevent,
-	.probe		= pci_device_probe,
-	.remove		= pci_device_remove,
-	.shutdown	= pci_device_shutdown,
-	.dev_groups	= pci_dev_groups,
-	.bus_groups	= pci_bus_groups,
-	.drv_groups	= pci_drv_groups,
-	.pm		= PCI_PM_OPS_PTR,
-	.num_vf		= pci_bus_num_vf,
-	.force_dma	= true,
+	.name			= "pci",
+	.match			= pci_bus_match,
+	.uevent			= pci_uevent,
+	.probe			= pci_device_probe,
+	.remove			= pci_device_remove,
+	.shutdown		= pci_device_shutdown,
+	.dev_groups		= pci_dev_groups,
+	.bus_groups		= pci_bus_groups,
+	.drv_groups		= pci_drv_groups,
+	.pm			= PCI_PM_OPS_PTR,
+	.num_vf			= pci_bus_num_vf,
+	.dma_configure		= pci_dma_configure,
+	.dma_deconfigure	= pci_dma_deconfigure,
+	.force_dma		= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405..9b2dcf6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -88,6 +88,9 @@ extern int __must_check bus_create_file(struct bus_type *,
  * @resume:	Called to bring a device on this bus out of sleep mode.
  * @num_vf:	Called to find out how many virtual functions a device on this
  *		bus supports.
+ * @dma_configure:	Called to setup DMA configuration on a device on
+			this bus.
+ * @dma_deconfigure:	Called to tear down the DMA configuration.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -130,6 +133,9 @@ struct bus_type {
 
 	int (*num_vf)(struct device *dev);
 
+	int (*dma_configure)(struct device *dev);
+	void (*dma_deconfigure)(struct device *dev);
+
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4..039224b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -761,18 +761,6 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
-#ifdef CONFIG_HAS_DMA
-int dma_configure(struct device *dev);
-void dma_deconfigure(struct device *dev);
-#else
-static inline int dma_configure(struct device *dev)
-{
-	return 0;
-}
-
-static inline void dma_deconfigure(struct device *dev) {}
-#endif
-
 /*
  * Managed DMA API
  */
-- 
1.9.1
