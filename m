Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx48oE7f2oZlIOa4AUhrd+NLl/QNx9mfKtj2OE+EW5OqUSssv2oigCuF5tHSlvrvURGHOPcWu
ARC-Seal: i=1; a=rsa-sha256; t=1522396523; cv=none;
        d=google.com; s=arc-20160816;
        b=yOsv36S7LZRLhLo3pFIg8FwBqT1GVuU33+FV1HEEVphoVPAzXTdY7xXLyxB0TzUhMc
         FGMlctU3o9t+lNUE5xx6YR1lkJSvTD2sRTh5iDz7JRTx6N/7my1P6y5eWPETHaPVa7Ov
         61q/Dlf/vU9uFijKosE55tCPUSBC7BSOIDoi37En3uNW23D3BhKMNfke8gHTjicBbUEz
         DlB5pMf8nAoY4mtpsm+6ckyUUVA9wL3S84asUsgWFNENbb67ievfyTocfapcVXLBqGkD
         BUzJg20Ul18S3xnrgoS5AFirUQlNVSvIRybrqrJn8UEXW95p/+QWuFhbsBvMTkO3ojop
         xU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=fuKntED4Nu4ZghQuM1On7+Ho+M17cXHxMSqmAwLabHU=;
        b=Y1PksZNzCqcrf5RMMqNkL8xPcUwaXRWGiHbOjOYi0vT4nGJ2nJF6XGCWCC0ZXAfjV6
         oJKyZcrDNkbtcYLi635VMlWfy6ht8d3mcj968rQ5poL5fyp2JFItA9jUcU0E8R38H8Z7
         3j8qG0Higpeg11iStKCXRdT/7B95P29LXc/fv8Y8GB03ivRPUIwjycS1uIlH72HntEhd
         NGhB9fFMYuf8QGq8hX0bHaAfbFrYQPBUzQQKqb850K4EqOfBGdCTlVkTvNBU1DX5In6a
         aN4f8AEEgl2CESf81m+04mk1g+bZQ8Gkdaua5ijS4hmjw/dgt3tcdyi1ovxl7bCBNkKj
         GPhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=dvmcBiAP;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.1.45 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=dvmcBiAP;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.1.45 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v3 1/2] dma-mapping: move dma configuration to bus infrastructure
Date: Fri, 30 Mar 2018 13:24:44 +0530
Message-Id: <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::27) To HE1PR0401MB2426.eurprd04.prod.outlook.com
 (2603:10a6:3:25::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b5aded5-a920-4a83-5e3d-08d59613948e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2426;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;3:8hlZt9c8/o2yow6/iOHtuAgdHB+BCHKXIQEzIBjSJjIRmzQUWOQ4QXJRrm4euv2Bq4bRrB/mPaebYXq0cc018TrnikZlYnFUoLTsQH1LuDgQMKn+MdK8IGyL3CKEpjPewvjuQWgwXkdYvdoR2+0qms4fz45eBSx11EGj7MOLmrlCM5ryc4BY3876OCxjEdkNY5yLMwYYTCf7UZzWWBsa0pb40m7h8f/4SkrRS6sSYDWNndj8ejG4Gh5Y/qG8pg/+;25:CEQJItzidc8d8Xobx1C/QkVCCuGPzJD+pKqiWzDdJKBQ++17TEFy8okVvHBNV8+FKqqnfjcyMMhU84NvRplClr2U1+a43APUfiOv5d8UfNpOGBwEmSk7YA0rXN2UXIUKZomdbLEeyTE8mCI55nfUDuLDXDDj0iLq0NNHVdH4NeynXALwO51h8dHu113vjGDrVR7a9jn+VebkSiYHcTtkYX06Bm0mjrPG5KvHEFJFH1eUvYP9rLMglI+xLAK85oxVR9QVihSxLClE/LRNFzhhGyPdMo68Aa2laBzZ1rMsFtR/jHfIVfRAO9ScRIwM4Nrp4u6ugdXOc93K+/M4vOIIwA==;31:1kGbJC6LsnbD1Ajiyoy1jj+qO1VHDovSuq8rstI63aiMR2iFBFWe0lasVwHr+O5lgfAIQdm1euIIzek1sKU4otGMNYfKs1N4aI0XcJxxnse/hUSPS8TANg7dTfO9jNRExcSr2deRi7rTnM/FNAmSJTAw2/NLAExsPvhwlLGmUyTooZtghnqWF6b/nmwQIYlqP87DBIcufE2V6ez0tQ7rwyUxadTY5WSrTtnIBT1IDRQ=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2426:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;20:idB4y9Oilz8BYmgnwY0zC09QTejh67si0/u1firPR97fu2Vas5SkkyzUSEHS5sglk4ugy2jcEYza29UVZNn3nuY/+/yef3lEzla5vOjeDMbbB0H5Q2qK9+jOt9YsyKDDX3rL92I5lCpT4WNl7DHZrUDqON4RHD18y2JkH47VPLxrBUH0vlLSG3n1JBCOhbA6QniAmfKCgfDhRPw7/8Ombg8s1G8oB/Jdm7ekIfSbpIWfdZ03Bd1lIbiU4xVK/nLrqkd8gxc0QSodRUjt6TIvLqr+SIscqlYIfeWJNdGzGYpK4XvdN8LPxgaKUv7h1/vMH1YcB+dvn6Ry7/W96Tuy67h7Z8gKyHyqGmIW+aZbceM1jjhMVTxV77i3jSkQTn+u4YmDqoSC3Aqdi+kAKbTuEQZYT+gkauFgAKWPWFucquVe6k7royZ5XiD9PRZhYJOTDiUGXtsZUCN637FtlW6lxKf+Fytibm5dJXndXlH0bnGXzUdH+30k/74+QHwIt/fw;4:vfWDV9Q1Evyj0fO+r1PE7aG88c8+mrYp9FWw5zDQgSKmeOhfOcuSmHdSc2XL+ZraTsRSKYMbE28tCaOZ4Cedr53RjX29TuVyOo1Dle5sJ9Hph8aq/k5tTm7lhGDyLVDAkjPDlL0iG1VIHzxGJuBI56pPmvh569RG76Z7NTEuutL5Bkk/Fa8a6Aff7+SKHnnLSz/SEFXw5LG6IQvQWkTrtpsD9twWwsawVZ2i++gxVPBo5uy9PNNOhm6lw4+YZBbK1JkwdvkWTeDYWn7MRLuUMr2Ejm4efv5KC9OS3a9BUeEgMib2yUN+CRBxGpN462AD99DM1obRhc5BntehVYqy4Pg5+a1etHGcvvQo+9e63VI=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2426A4040D23F1DE49D2EAFEE6A10@HE1PR0401MB2426.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0401MB2426;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2426;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(396003)(366004)(376002)(199004)(189003)(68736007)(50466002)(86362001)(7416002)(6116002)(2906002)(16586007)(66066001)(305945005)(6666003)(7736002)(316002)(3846002)(48376002)(5009440100003)(97736004)(186003)(16526019)(486005)(6486002)(8676002)(6512007)(8936002)(50226002)(6306002)(81166006)(81156014)(476003)(956004)(486005)(2616005)(11346002)(53936002)(446003)(47776003)(5660300001)(106356001)(478600001)(25786009)(39060400002)(5890100001)(105586002)(6506007)(966005)(59450400001)(55236004)(386003)(4326008)(36756003)(76176011)(51416003)(26005)(52116002)(110426004)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2426;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2426;23:NgLA5ePcHB1nsSd7hGs01HStct584ZRe0LroXZf?=
 =?us-ascii?Q?v/DdmHr/N6xsRNo9/0snU7bF6zdIl/hjML9pkZtDzdYu6r2nytZAa75lU7Ta?=
 =?us-ascii?Q?XIlcKVBW28w0uIdY8Y7b0R4NVmNibGp7dX294gV75M3Cxgc8qItOJah38RUE?=
 =?us-ascii?Q?THgrhJUaZRQJu1K3Q0qgB0oVWSJbtIcgxGkCaxp/gvQwodIkFAjlfaC4mp69?=
 =?us-ascii?Q?I1T00gcJbT1i3hSiihL8v+p2po63WvkteYf3vi2txS+g3++0KegA6Y7n1lCv?=
 =?us-ascii?Q?0w8DoinKLFGnnubF6pZa0A6iDddNwAfpTlnAVIKqr8HosEx4gDHqCsSym7Ed?=
 =?us-ascii?Q?NFylRtz8GedbQfWw3pHUnFD2YfpHXW5zr+X8DciPTcr8t2gAir22FfVIVwHq?=
 =?us-ascii?Q?1WDYhLyeVuGkJP5M0uNDOsicWof3uXk5X+Wj3so72Zh21VU9DR1C411jLsf7?=
 =?us-ascii?Q?hEE2oPHDz62fPSygU/v9ZioYok84kLvyLf4kyVDru8mjC23D7h9rKGeOddnl?=
 =?us-ascii?Q?yeuD0f/LbdUP5GH4qGFmT6iH8MTahXpnNb209yCGJOpm0YNRv9m9PXXwCFhy?=
 =?us-ascii?Q?0NtKQwISzzLcC3mq5UB4vsC0QRbNVLprkg+ZfNZmCceXHFE6cOSuDavk4G9b?=
 =?us-ascii?Q?GCLy/LRrqmAoVzxmNVBub6VHyTmB9QzJx6kvjf7sjaTNcVPj/2Q/vDPpWOqj?=
 =?us-ascii?Q?7OaHUgpXpDRP7wu3mcpdOLgmtCH2s1wwTsneib2apjVw5jDMYPsQ7QXvtQ7t?=
 =?us-ascii?Q?hlL3e9x5YzsrIgHZN3jzTCT6x2wQHBaMLxL0+zl3YOVkUFcLcow2fjYxHbr/?=
 =?us-ascii?Q?qHiEWdGtiA8XIw5sBFpzt2W/1zgkLmcgVTwXphH+TAQluftbl4e2Gc1CivNf?=
 =?us-ascii?Q?N+E97vjjV+CXTXPS6jmPupP42h7oMDI23SQYxexYp8I3XbmpquIsw1zbuGyp?=
 =?us-ascii?Q?UwgQA8cqK/8TS/qAiCEfcIVIk729RahxMcRe5FOWZi0jNyN3eRWN1qXod9rl?=
 =?us-ascii?Q?tCTeBauGM1Vy4tpWqS3YrS3NOvZIbYJ4UCrtllHDFu8SzeQXvXIZY0ao/gx8?=
 =?us-ascii?Q?019iZZDUETwYJIiL6k38gKaswknXAbVCdg4p3IziE3yzSZgKlx+yAp2c+1Dg?=
 =?us-ascii?Q?y7FRRG30oxIQr0COFH/TOgtvwCMP8PTiHkRPSNzuBZQLq2Qj5ZRQyVTJuhWf?=
 =?us-ascii?Q?m6D7JGfcn69LFIzy3/lleR3OA02VMxV6WkLmlO1wId/XRSprY+73B8ChOS+h?=
 =?us-ascii?Q?5wD6Mb5FvOYv70bBOBqAmcK64Zkodvx/hC0UGonPaAkJVzeGySZlLjKgVKhr?=
 =?us-ascii?Q?WBvFBrB4Oz+JLpJnHfSawCe6RnGyDnOAv8QKmx4IKJhjEaxqY5/Xtq+2tcNh?=
 =?us-ascii?Q?eb6bAgTawU0yvVZCv8Gx7JznKe1FsfjdZkth5s+IfRSqFv9LIiah/yAi1j2y?=
 =?us-ascii?Q?SnArzeKd1sQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0wmwH4tME2nLGOhl4LLilfc6ZKn2l7MJCkZsjXP9X8geNgav/vq3eeNqPbaNHsPgn94tj9aBA5zfSqtCABhOAfyMWQfO2N2eNsHZBjo/SXCaH8UYD4ObtW3/M5Cppi3ZXGyMH3CwWDxe9hxC/SBSFWgnodGruE2tYhHx3h9H1HDioh/UZsMiOEBx5tJiyyEZ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;6:FWfvfY3/rVloRSYGOaSXAqngoLVxXye2nEI3/QBWnQORN5j/X/GZmhlWjR4BM4dKqJ0uJg1FveR+UNDwgpk/gPHWa6bQ9jRNQwWkOye2e6EliOPDRiTZG2QCFDsUdQwinh4bX+xdNs1bO6pIsxUwZd2uDbPQzWrJBzLhglLmlbEk1BaX5I1q4hqI9AgeDcAuZcgh+0J9YGumGBKZTzuePW/BtwxqerxNeiYkMxXCwKvvCO1SdS7NOC2w4rcQWBqUCRq9NaedSryPbxzEZKQMdNbonRRykcWZS1dTkBQrgQCkoNFVSl4iQoEPcG5FAD1g1pRFrJW9oOhJfXqlYCR1sMwOa8ubiVpBMVymE7WGC5UCjh6nF9VpgHExTQgpqES+1LmHHUWNeJnHFraDIG2fFZQVZBDg2Tm6RbFPz5jzyIkc38f+BGem2PWjNxxJ183Rah6vnjuqqQNN2hUU+l88bQ==;5:UejdSh4Qv+eJs3mN2E28wzeyMH/CnQ9N9TSLhYV5AT8zV4zybxMRzyiRReOCmErsCpJ7I5Ilo0pHB3ez4XWddmMAU0FPPJdn96GtliDLX3oNyzWk5h/01//8J8t6o0jbsfiwTtGSo2vvtNgvLBlhME5VN/dYnur3SjkQpEvBNlE=;24:E1+tZEhOWonCdWD/dxBhkjKc9l6prpiHckCUVeoLkH/364dqDHEcJqcyvOnbHu8TRUAGpzd2xwOSiF58jj4fwGnP0jHFqgkWC1pOMRs27zk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;7:1GjM96SQWVX6/YZDZ3/AegKyCBjz8vufaWqZjLp4GwfLyNqtSSJevYeV9BL8sf3RKyMDCFfK/RN4RCCYVJy/AUfXcl4Gs+2mNqMPWE0pUSiN8YHhXq07wLTIjXrRGl9obV9ud+dtP/wYrTj0OOHjIgKrAMVWmiShOXaWIfPSZfIVyLYsLW/JzRLfMb7fzN5G4dsHEbsM13nYVn5v6C+8AsOtyb5yycQeNG1iBOVJSBaIaTKgDYMZODimZ3NwYWUK
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 07:55:12.2290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5aded5-a920-4a83-5e3d-08d59613948e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2426
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1596348457327407489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is bus specific aspect to map a given device on the bus and
relevant firmware description of its DMA configuration.
So, this change introduces 'dma_configure' as bus callback
giving flexibility to busses for implementing its own dma
configuration function.

The change eases the addition of new busses w.r.t. adding the dma
configuration functionality.

This patch also updates the PCI, Platform, ACPI and host1x bus to
use new introduced callbacks.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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

Changes in v3
  - Move dma_common_configure() within platform_dma_configure() and
    reuse platofrm_dma_configure() for AMBA bus too
  - Declare 'attr' in pci_dma_configure() inside the else statement
    where it is used.

 drivers/amba/bus.c              |  4 ++++
 drivers/base/dma-mapping.c      | 31 ++++---------------------------
 drivers/base/platform.c         | 17 +++++++++++++++++
 drivers/gpu/host1x/bus.c        |  8 ++++++++
 drivers/pci/pci-driver.c        | 32 ++++++++++++++++++++++++++++++++
 include/linux/device.h          |  4 ++++
 include/linux/platform_device.h |  2 ++
 7 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228..867dc2b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,6 +20,7 @@
 #include <linux/sizes.h>
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/platform_device.h>
 
 #include <asm/irq.h>
 
@@ -188,12 +189,15 @@ static int amba_pm_runtime_resume(struct device *dev)
 /*
  * Primecells are part of the Advanced Microcontroller Bus Architecture,
  * so we call the bus "amba".
+ * DMA configuration for platform and AMBA bus is same. So here we reuse
+ * platform's DMA config routine.
  */
 struct bus_type amba_bustype = {
 	.name		= "amba",
 	.dev_groups	= amba_dev_groups,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
+	.dma_configure	= platform_dma_configure,
 	.pm		= &amba_pm,
 	.force_dma	= true,
 };
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..fdc1502 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -331,36 +331,13 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 #endif
 
 /*
- * Common configuration to enable DMA API use for a device
+ * enables DMA API use for a device
  */
-#include <linux/pci.h>
-
 int dma_configure(struct device *dev)
 {
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
+	if (dev->bus->dma_configure)
+		return dev->bus->dma_configure(dev);
+	return 0;
 }
 
 void dma_deconfigure(struct device *dev)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f1bf7b3..72fdbf6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1130,6 +1130,22 @@ int platform_pm_restore(struct device *dev)
 
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
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	.runtime_suspend = pm_generic_runtime_suspend,
 	.runtime_resume = pm_generic_runtime_resume,
@@ -1141,6 +1157,7 @@ struct bus_type platform_bus_type = {
 	.dev_groups	= platform_dev_groups,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
+	.dma_configure	= platform_dma_configure,
 	.pm		= &platform_dev_pm_ops,
 	.force_dma	= true,
 };
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 88a3558..a9ec99d 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -314,6 +314,13 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 	return strcmp(dev_name(dev), drv->name) == 0;
 }
 
+static int host1x_dma_configure(struct device *dev)
+{
+	if (dev->of_node)
+		return of_dma_configure(dev, dev->of_node);
+	return 0;
+}
+
 static const struct dev_pm_ops host1x_device_pm_ops = {
 	.suspend = pm_generic_suspend,
 	.resume = pm_generic_resume,
@@ -326,6 +333,7 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
+	.dma_configure	= host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 	.force_dma = true,
 };
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6be..78e507f 100644
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
+	int ret = 0;
+
+	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+
+	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
+	    bridge->parent->of_node) {
+		ret = of_dma_configure(dev, bridge->parent->of_node);
+	} else if (has_acpi_companion(bridge)) {
+		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
+		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
+
+		if (attr != DEV_DMA_NOT_SUPPORTED)
+			ret = acpi_dma_configure(dev, attr);
+	}
+
+	pci_put_host_bridge_device(bridge);
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
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 49f634d..3097c94 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -356,6 +356,8 @@ static inline char *early_platform_driver_setup_func(void)		\
 #define platform_pm_restore		NULL
 #endif
 
+extern int platform_dma_configure(struct device *dev);
+
 #ifdef CONFIG_PM_SLEEP
 #define USE_PLATFORM_PM_SLEEP_OPS \
 	.suspend = platform_pm_suspend, \
-- 
1.9.1
