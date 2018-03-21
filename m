Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELss118nxVz2rPONFoWmAWfFRNUEr2d9IbPn8BQ422mHIfREmfCksuvcDXh9wtW8ynXodvRk
ARC-Seal: i=1; a=rsa-sha256; t=1521615369; cv=none;
        d=google.com; s=arc-20160816;
        b=MlBGvg2okAAKJaT4AHinrx9e0NZryQxuMKgrx5BmwOxsFNiJrfjnZ3hwVOneV3tMEh
         zixTjytNzhO0QK5IxHzcO2kyc7oRJMWQF5ACVtFDH7dnIapuXEDzlK4aP68IlttW4uiG
         Ct8xUbDvDa32ydVKwZlVTQ8bT0RBkJ8kjBfMGN5bQuKkfJw9oqco1u7dGdAFcG48bNKC
         ISBFl0ez/lrmbzrROyXUbAu0t1AKFWnQD9ejF/gX4lHF2iXHHYbpGHt1orcmR3Jxn0W7
         Il/7ln3HnduD734wWspicrTUtdLFttjRRwUEE3NJZAWXofmwzP7cXX3w1W9EczDuBhFp
         kMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=pTU/o7/+sYzd7Ei++D/McuII5JcM/Vo5HlDTK3Oy7GQ=;
        b=QzH+An1RgsQnd33kbhRXHx9Yr7HMxp8xKmKHFU7NoA+kCcLJ2FjZM6Wh+awg5QJ8LT
         DJ6qN4mN7qsUIdrylnyurV3WL6wJ/lXsImLMhEXlLn/qvRY4RdwS3hp5J9K1sAXtkCTo
         iul7vlSND6i+pfWkYRWB90oxkdR62DdI9KXJBP29bQL0SSkYKxOrkxYc9j7x8gaeP4A3
         UJcj41c+9/AQPvLsTVmH5oFtEmo4C3WEozXDeUxvYllKTs68G+t9onJS4tOj7kaL1nuV
         FdsuNlPB0up/aKbPWEv4XXRTvdz9jEzZh2T832IhgZgyos40vDYRe1bg7ujRy6wFpEiu
         Qjog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UPyFy4Kx;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UPyFy4Kx;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	hch@lst.de,
	linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com
Cc: bhelgaas@google.com,
	zajec5@gmail.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	dan.j.williams@intel.com,
	vinod.koul@intel.com,
	thierry.reding@gmail.com,
	robh+dt@kernel.org,
	frowand.list@gmail.com,
	jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com,
	dmitry.torokhov@gmail.com,
	johan@kernel.org,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH v2 1/2] dma-mapping: move dma configuration to bus infrastructure
Date: Wed, 21 Mar 2018 12:25:22 +0530
Message-Id: <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::30) To VI1PR0401MB2431.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c035eef-e2f5-45c4-84cc-08d58ef8d059
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2431;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2431;3:5Vn0cNTwmbYoXPXVq2J4O5diJq/ZbkIcKJw8Orj4OWt9VSVJB1YJrnDq31yEPN97w+sVLN1s61Z/mInqaLne+RA3VRd6AXd95pjZh2K5r7j2L640TNbJOgPPJGLkmnnKoIVGQtjJ9c1nbd5cHjoTJEF5WcnGZte6Zx67nZ8df4gj+Mo9ReIYBVMpk5/AIPwxHD2QtX+1mTnbiJmpUgjDOcdb3CYk4vUBUn92pnSPYRyVPa1z3UMCQU6XFpFhdjy3;25:qUz1z1YVT/jSAdb2tcv4bXoUtpqrZBeqd6UwvsgFNPyRJ8hgS+hE/tevP6/DrLXRqFe2OVCfYqgA/z5MQY9bCfRj1P1dlhOIrVObEABnozy8Qk37+IABc3MLxT4jcQj6OzKNemjf+5bF/WZgHPLbZHi9gyLE2vytejhUQvg6+PKpsPmifeA+peYxtILQL4+Q2D/J9d3vE4D8W+Hs8EpsxL17IbUVTlI5bpzM8bguiSU81u+2E5OqvtYA+S5R95EC+BrjXa99iAY2nRDeXuuneASYJ3AQLfcmu3/UjjhSxhtwPxuYACq/z8NHIy9Vuymib2sr9UVNzSj9gb8fSwBHmA==;31:mCG7BwaZ9PVhZ3VADlmne7eR9Fd66qIhPYtKEfvfotQJlcptpVOzZHi7dNU5zF7Q/zb+yYYXw/YorZn3k1mLQhxmRK6MGHYMvlcmDJqj+yXNZl7MGf+Hm1wAMNsnWMAfZ2b4vlSsLfatgVFNL84alOm6Pyd1M1VNZbzsZ38ZNUeLQRkTXf/8rH98pQkKrieofpqzstD1dOdTq8jCotOlNtcpUdOKBcVAuTJFCNyM2jU=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2431:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2431;20:zUXEj6RYUGWXMk6fATyz9dNJRvfc8uEcrV3kTUtNNPCGh6iSkK1+Y1efbcaxi8MvSnyrlQOpMiqtXvTsqC7cYpRnA0rbdO7h856D1x313OFeziauU9ylOlR6owJ8KWxfByQR7hGP807RnK/f/m/B8QVfC5TXD0Se/F+yLdm2/+06dAe58ILZtVGlfTRPHpq72+QL5N0RxUKWbSnzsTRqNg1lt0DrhBhbu5DDLGZLTF98tzMyvlz86iS6d8BbfqlPZNIPflvK9ozUyOYKK638axL++pRSuzrxIKRNb4cYoHUSLUKIh2w773ZWX7y4nnK/FPObyaHIKtNVsaUP7cG5eAIPdG9HB4HwrAORUhamyuVVhWZ3gTJih2nxzw3e1m2me2D4ClyRjUX8a+koLwJJt8GW25AuzUOqkrBhwDU2fr3CpmJnX8VFQXmck6WXcV3QlERuDsSs7a1mmg6KL3BJLHejDhWyKTWyKYyt63n2lTfckwbuoTPSy+pXBJZ5YhjH;4:KaVWg1xJDVGTSYHg2JsXvPdy2Azg/ShilX2MKwuhkqU98U7cszh08mg80SB5xeiPJN7DNM+77TM3ZalgnTIQu3pAJf9xtcOrEmzF97+MHwASvdxVgOAR8F78ckcNiZq2Aj5SvctQAcF6YEioxvfjWy3mq3XtgIKHSpiuXkyPoTAS8CU/7CSVmyVK4vkK1XKlYQottH2sXV38JtnjVSqEZptTcbg1gULsIY93du6RgI4A3JjSbrYKTMJnpv3/zvAwOQyMHyw+HiptVPAF1/AJ68FS+B+YniR/byegb2CXxLYqTqiF5lvOQUiWG71J0J/a
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24312152FB75AC45FC2F8AB9E6AA0@VI1PR0401MB2431.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB2431;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2431;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(50226002)(2950100002)(7736002)(966005)(4326008)(86362001)(36756003)(8676002)(81166006)(478600001)(6486002)(316002)(81156014)(66066001)(305945005)(47776003)(6666003)(2906002)(8936002)(5009440100003)(6116002)(97736004)(16586007)(3846002)(186003)(52116002)(51416003)(76176011)(5890100001)(105586002)(39060400002)(53936002)(106356001)(48376002)(59450400001)(6512007)(5660300001)(16526019)(25786009)(68736007)(386003)(55236004)(6506007)(26005)(6306002)(7416002)(50466002)(110426004)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2431;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2431;23:l7aYbUVgCn7K/eSx4mDbqPcBjv4i1YOyvhKnrRB?=
 =?us-ascii?Q?SMRoDP0yKWiTle3jt0dZDl10v/XQmc01BFTN7NCmgGLf+hmGENkIb2XsYU6e?=
 =?us-ascii?Q?LkSeAeONueUxk+mrZ3pJRlqX1PlfT5DVqX/1sRuQQymwlym7ZKrTOWAzM7Ve?=
 =?us-ascii?Q?dgWGkJrh13oSDxzg9QMQt6YU4Bj0RpOaYgU9kq1rAKNmMoDhvMmHjx32DqZe?=
 =?us-ascii?Q?mbiZfMqRZ3Ywy6bDWsdhcITPfM7xJJ8isZ8OZsK8E+32SuiFs8ZLawRDcpDF?=
 =?us-ascii?Q?vyRuXMXYL2VxTPVt053tmRQxvXOcBKY++/wzgWJ2FmHsuWxrAGQNf2uI+tQg?=
 =?us-ascii?Q?FvutnU5yT41QjASHLxjRpPLoZsSxryoUM2SW01jvpPd8aMSiuy3ScxuJxyq6?=
 =?us-ascii?Q?ko/3209VAZXJMb0d2b2HbEcY4Z6mhhtXLEL8Ap81XKNoqhh+i3rdLjMgJETj?=
 =?us-ascii?Q?LLZmzGJTk3qYy1BEjlPv9pIirxE7gHbqoF/o0Uh0dehXTo4OmNWRFsAYQRo2?=
 =?us-ascii?Q?xF2TvhzmM3rvu9oIqG2UckKML/V8uCon+/o6XG5/A2vc6VmfcWW0jVa2yqFI?=
 =?us-ascii?Q?jlmfjHRLIkpl8hUnBmilH8OO0XDy/RLTR1yOTRTIIRJiT26g0JRjXJ1+/zLw?=
 =?us-ascii?Q?D1U5ja4SUhQSYrqlzp/olNjPk65XYQlZbeVGf3eEBLi/FCpeMlZTOsvgmGIS?=
 =?us-ascii?Q?CMM4UMjXdrdEGmmVI83RAtAjSyrw9WUGXSgAipkVkC50FwoHWUEA9KMhZed0?=
 =?us-ascii?Q?Y9CPTIW/DcLzQwmGjc9lpfycsX41uE6w8eJu17Bf5kHwDFCy8c4O5EBgVvXL?=
 =?us-ascii?Q?Or5FjS2oyPhR0NnE8CyCDKx/EexZqSMNohAfQ8KJveNS+Y3RB6gwgdQGQEP+?=
 =?us-ascii?Q?xZhUvgXu+COaI3nKcR0cjiQWvoJ767Ocherb0nbF+sKTZGG8mC/uIvdJUHyJ?=
 =?us-ascii?Q?SOf2ASxzA/2+7+KNUmbOUkuWFgFG4r8PoytuhSnPQilj9R1O7FSI71qgYASc?=
 =?us-ascii?Q?b/myPsKmKkFexyNs86ZPe8xaa0PYmdqeHCRneQX6uiqWM5wh5qA121E/dyL1?=
 =?us-ascii?Q?99lv5ZLOsndHYhiN2KjNO8QCOGCWfq9M0L/oublcxt49r+7xl9F2THmCXyKz?=
 =?us-ascii?Q?6JZfp2l43VCtsFUk9Sm692WTLPlDj20GVx2oSRDVvcJJy8Nof9yZgquyGA2q?=
 =?us-ascii?Q?Ag3IpG/yLoN7EnP5O2SQkFfjkY1sH+0qf9Ihk9p5vudZonvySMRD9gVhjlKT?=
 =?us-ascii?Q?AxbetwhZr5RSGTN7L+x5mByIbV0X/9cTe91IyllAAXNeHXPvJdNjDQ/9BHQu?=
 =?us-ascii?Q?q+hf3LcuRQmEENH1OgUsHWEE=3D?=
X-Microsoft-Antispam-Message-Info: mDVW7Om5BFwy4rB+OChEloPV91fCdUlML0sVF4OpuMSywGa2S8pFmTGCwt6qBJTYDc9h7ntQ+PyR7FbVps9LX3N0tGozZu0lDV2mI26zabdzU4jOQxNm+Ttbx6DwJFcM7HlG0EvXlbLMrlX9/op6pjatDLGO8fX0imIPA1IcmdfXDcXkC+rfeoJfkj2nXnVT
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2431;6:9c3BIwYoq1L3l90653NYlfdyHxPKO/FuVSDCIaO+0PZkYD3/yhzsI4k2LQRfC/Who2WAG2JcSmOTS46nItA8l83rsIFCAdhxJG2MwDMA1Gj8BC8itp1budjTFHWGSGFfwt+nFC/Qnfo9ZZugIEXGYhzn3t3L1Fv3YDpQBxS9IHLBP6a0I8nzxXvE9WVxep32+7TJ0CPkyr6O0fPU1KHqOFbHXIbYCkZmMrIPIcODOSfix1la0JErNZq4cXxt5vHycYjLichfFY5dwT9D8vOa0rXntahkQ5Fkv4NisQfelb71MR1S48lT8JVy6WY5zPe2ihe6ee0qbzatjIOS2g8PSuTYBmRI8a9PE3ol7G/Ww6w=;5:ea6FcYrvHzKPjMQfuzezgGHOsGOZsn9qZ1WqFp5GvZNsoJpB7VXo/NcJVoQ7vPZGKa+b9YG3WXXxW7zUJdkZg7N9ghrfd/61HRU2v9H3q2DPyPep8yx10IVpAMyhIKksFlYi/0YcticUrbZUCWzEDmHye+FgTD9Rh1g/ffSzX2g=;24:m+CTGBRYMInPMZ5/+xP3XPd1D+GKpYnPp2XAN/2qkp/Dco7ZavoEPOHnLodbVDHmyPRXQQifpD8viPQyds983Huu63BHj7TG2BYhB61GPzs=;7:peFTycMMn+lATLXzm7AySuTJw3AZw1UvFZHxpNKdFmWWMZAAdChDC2I5CMtkQ6sZ48APCyfokwkkSdIUPHeCIGg61pCE5c83WcRb/bQVixr0nnV0cRe5K30zaUIFRcGHP9oA+FeGD+NCBmif+6SrWUWpCTVbj1AXvLAp+cldxGd33d54IyeqGIyHH+2aMkPoSDcgEhC6W7TYb2Gx9K+8mah3++2o41q8l26WmlmJ6X2zgn4osH5wxYINgsXqMN4C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 06:55:58.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c035eef-e2f5-45c4-84cc-08d58ef8d059
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2431
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595529357395463019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's bus specific aspect to map a given device on the bus and
relevant firmware description of its DMA configuration.
So, this change introduces '/dma_configure/' as bus callback
giving flexibility to busses for implementing its own dma
configuration function.

The change eases the addition of new busses w.r.t. adding the dma
configuration functionality.

This patch also updates the PCI, Platform, ACPI and host1x bus to
use new introduced callbacks.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 - The patches are based on the comments on:
   https://patchwork.kernel.org/patch/10259087/

Changes in v2:
  - Do not have dma_deconfigure callback
  - Have '/dma_common_configure/' API to provide a common DMA
    configuration which can be used by busses if it suits them.
  - Platform and ACPI bus to use '/dma_common_configure/' in
    '/dma_configure/' callback.
  - Updated commit message
  - Updated pci_dma_configure API with changes suggested by Robin

 drivers/amba/bus.c          |  7 +++++++
 drivers/base/dma-mapping.c  | 35 +++++++++++++++--------------------
 drivers/base/platform.c     |  6 ++++++
 drivers/gpu/host1x/bus.c    |  9 +++++++++
 drivers/pci/pci-driver.c    | 32 ++++++++++++++++++++++++++++++++
 include/linux/device.h      |  4 ++++
 include/linux/dma-mapping.h |  1 +
 7 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228..2fa1e8b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,6 +20,7 @@
 #include <linux/sizes.h>
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
 
@@ -171,6 +172,11 @@ static int amba_pm_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+static int amba_dma_configure(struct device *dev)
+{
+	return dma_common_configure(dev);
+}
+
 static const struct dev_pm_ops amba_pm = {
 	.suspend	= pm_generic_suspend,
 	.resume		= pm_generic_resume,
@@ -194,6 +200,7 @@ struct bus_type amba_bustype = {
 	.dev_groups	= amba_dev_groups,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
+	.dma_configure	= amba_dma_configure,
 	.pm		= &amba_pm,
 	.force_dma	= true,
 };
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..48f9af0 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -331,38 +331,33 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 #endif
 
 /*
- * Common configuration to enable DMA API use for a device
+ * Common configuration to enable DMA API use for a device.
+ * A bus can use this function in its 'dma_configure' callback, if
+ * suitable for the bus.
  */
-#include <linux/pci.h>
-
-int dma_configure(struct device *dev)
+int dma_common_configure(struct device *dev)
 {
-	struct device *bridge = NULL, *dma_dev = dev;
 	enum dev_dma_attr attr;
 	int ret = 0;
 
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
+	if (dev->of_node) {
+		ret = of_dma_configure(dev, dev->of_node);
+	} else if (has_acpi_companion(dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
 			ret = acpi_dma_configure(dev, attr);
 	}
 
-	if (bridge)
-		pci_put_host_bridge_device(bridge);
-
 	return ret;
 }
 
+int dma_configure(struct device *dev)
+{
+	if (dev->bus->dma_configure)
+		return dev->bus->dma_configure(dev);
+
+	return 0;
+}
 void dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f1bf7b3..d2d5891 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1130,6 +1130,11 @@ int platform_pm_restore(struct device *dev)
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
+static int platform_dma_configure(struct device *dev)
+{
+	return dma_common_configure(dev);
+}
+
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	.runtime_suspend = pm_generic_runtime_suspend,
 	.runtime_resume = pm_generic_runtime_resume,
@@ -1141,6 +1146,7 @@ struct bus_type platform_bus_type = {
 	.dev_groups	= platform_dev_groups,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
+	.dma_configure	= platform_dma_configure,
 	.pm		= &platform_dev_pm_ops,
 	.force_dma	= true,
 };
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 88a3558..fa9896d 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -314,6 +314,14 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 	return strcmp(dev_name(dev), drv->name) == 0;
 }
 
+static int host1x_dma_configure(struct device *dev)
+{
+	if (dev->of_node)
+		return of_dma_configure(dev, dev->of_node);
+
+	return 0;
+}
+
 static const struct dev_pm_ops host1x_device_pm_ops = {
 	.suspend = pm_generic_suspend,
 	.resume = pm_generic_resume,
@@ -326,6 +334,7 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
+	.dma_configure	= host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 	.force_dma = true,
 };
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6be..b473a4c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/kexec.h>
+#include <linux/of_device.h>
+#include <linux/acpi.h>
 #include "pci.h"
 
 struct pci_dynid {
@@ -1522,6 +1524,35 @@ static int pci_bus_num_vf(struct device *dev)
 	return pci_num_vf(to_pci_dev(dev));
 }
 
+/**
+ * pci_dma_configure - Setup DMA configuration
+ * @dev: ptr to dev structure
+ *
+ * Function to update PCI devices's DMA configuration using the same
+ * info from the OF node or ACPI node of host bridge's parent (if any).
+ */
+static int pci_dma_configure(struct device *dev)
+{
+	struct device *bridge;
+	enum dev_dma_attr attr;
+	int ret = 0;
+
+	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+
+	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
+	    bridge->parent->of_node) {
+		ret = of_dma_configure(dev, bridge->parent->of_node);
+	} else if (has_acpi_companion(bridge)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(bridge->fwnode));
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			ret = acpi_dma_configure(dev, attr);
+	}
+
+	pci_put_host_bridge_device(bridge);
+
+	return ret;
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1534,6 +1565,7 @@ struct bus_type pci_bus_type = {
 	.drv_groups	= pci_drv_groups,
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
+	.dma_configure	= pci_dma_configure,
 	.force_dma	= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405..1832d90 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -88,6 +88,8 @@ extern int __must_check bus_create_file(struct bus_type *,
  * @resume:	Called to bring a device on this bus out of sleep mode.
  * @num_vf:	Called to find out how many virtual functions a device on this
  *		bus supports.
+ * @dma_configure:	Called to setup DMA configuration on a device on
+			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -130,6 +132,8 @@ struct bus_type {
 
 	int (*num_vf)(struct device *dev);
 
+	int (*dma_configure)(struct device *dev);
+
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4..c15986b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -761,6 +761,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
+int dma_common_configure(struct device *dev);
 #ifdef CONFIG_HAS_DMA
 int dma_configure(struct device *dev);
 void dma_deconfigure(struct device *dev);
-- 
1.9.1
