Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZr1BZuPKyNNXftvSON+QJL+tRYBql2nKSLB/99YvSasyrXoIC0EY54NSQEgNBvKgRDy598Q
ARC-Seal: i=1; a=rsa-sha256; t=1524883953; cv=none;
        d=google.com; s=arc-20160816;
        b=CK7zsupbHNAOirdK55VwmPIw/Iq9fhP6CIYB/btQ7RNt46nNSthIbpaMoycQfzPiuZ
         elCnmrTkPIx0JgLFytdiqlccMgYQzelUg1bIYnUzFg3Ctis2SpzsB4aMdvuQwT7luucD
         mtdpx/Vda+a451B4lAMRDm14I3X3xAzLhuJQnAFNQTIq5HQnQas88O/N3t4paSBUUsX+
         EWCtByH9cUSf+OEsxTr2t/GJQhg1nMaa/u43Sl/wRbb3p7Xb8jHmsn3+6HUXmwcLdgvM
         +ndcQQKzbGG7Hg6v/Oen+gHmNL8i/wTMyyaInaDG9mgwdAOWyTSn/PsFTvJiQuIS2NDv
         4P1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=zuCLuozJK5yxXZpwmnfsGgcdx9+JnQww1/uwu5A4ZC0=;
        b=uXjyPIkrq1yHZI4UCOjdgZGVfvwo5B3CKG9LnNPc3+gJCIDhBasSxFNjFDrbpIZHjq
         XVw5nh+aAS3xiUF6+nsjUvYOyQImNqRSCczd9IoOXq+4C+1NIgKBP5COPFRV4J4jA916
         d97w3DSH0ePJxnduvDEAe98FvXyJ4BZORoSasUiR/zrMK1nDc2UukCL91gx7dZDyr1R6
         l0F9DiA39iLyXFL5z+O8j31M62lVH5GySbs7JCP0TmN3EMFJsKO2ixLiP9T2x8WCb3wC
         JWO0FW3hNRBQ4NBvqnMLmxXXssDX5/HZi1o2r/0qOrHV6fE63NcPPP4OUBH4LVjDmqID
         1srQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=YPodo4ke;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=YPodo4ke;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.43 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v4 1/2] dma-mapping: move dma configuration to bus infrastructure
Date: Sat, 28 Apr 2018 08:21:58 +0530
Message-Id: <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::11) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:PqmsH8qqwsXero3+XISRDGI8+mfBQWi7+O4QUYV9vbyGyBvKZ1CAw5hjoeOrvU4kBmqNgSqYWGebhnWOZPK/Gx40EA8Ob0mvzlsMf0TDq1ACHHHh1N/G6/kOjCzX8pniiUNV1p5kDWMhK5DXeGjCD5D9BpRz03RQJWzJCUnl40phpfYIFoP3+s+GVjhUHNX9pA9JtEVrEfzvfUv6/tXWCWIIJCgsmXW+xK7Ig5fu+sqK8TRaFFzdu8nt2hxvBwMp;25:KHuP4B6l8Z+7aEbPFOVJKDiUoNvqUlACjp8AotlzBvadhlrCkmtZvcwj/+hMqRYotzSh2ywrGEhubZITsdWvLezr2zwY0Q7E2yOSa56+UR0t0Sng6ap8pDMQ2hnYIQwX++BLkvoNyLD318xBMSaDQGfhlZdawrzPpKcgtQWWfnAQsRdWtc9tAmCOIztJKYycpyO4gh7Gpxf7oMBfDbTw4dD5o80oD88ftvqcHb0wUavNdo8kUkxpn49nF55abFNYbx/puHPXhiTxdldjwiamjcev4jcdnqTIBLM2dqQK4wSr9w1pzYoamlzHlPo0vN+Y7yfZ/OucBBDgsT2bpADv3w==;31:sHILoEhuDRjXSXPKFwxZDrRoXt//GNM85NkoCQT/PIgBt58Rr5+kBJmOneZO3fc1NY3Q2/I8tMMTQM8q0lVKb7yvMXKGzGZadvir+xo46mg86qTFZKIPFmhgJhtIZqUG2AVPdhEl2WzE2GWqWD5zIWdvK71GDR34qzbd3GxUx+onkN8PHcwDYSoup7o7m7MIs/p5UMO7ISrHYDdOmSiuslYZEVK1WjgGqK7tbb8vgwk=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:9aYsNcs7TmYb0LrxcLzFs3skx1q6v7BiNnO4LNWUzEjr6BPkqk/yLDHdm9/ddHzFDZ02qxgA8bVXlQ6nMaC3blF+k0mQLCo/f0qx2vyqwXFdbDp1A9Bi/IxyUGZKbzHVeomCfuWl6IrbZvzf8rNzpUOIYS0w0S0VljYbwdNtHhuTR92Z/0R9f0NXNz5sXCZGc+wdbq+aS2KM+Xj0dncPkO+Yy7jFAkT2Qo7so6hNXalPcEjXuMbCkMNQyUL0ol1N+E5Gneg/27sKIfNH0CX3ObCCC7SKj0d9gl6keVbC+EFTzW5jDNZayplWfAzhLWPaHkk756JVDds2OXV1RQnPBqUyeP9Lb1FXTYEPzPGlpyKdWzoZEQTkq05rLk1vJErHZQr9drMOfcGHdG3AYcvkB40dOI4yAjyZBVSWdfORc9vJDiHMGErfWTKnTNi8ojRN+MewQe7op/R3/meoXHgnQAxxuuWXom49vad45smZqn3TNzFvZ4NZoDalZXQeCSvr;4:te+Y6AlJJTnUBW2BofJ3OEA4PT1T91cKK437aDxfVh09GK9vA4KTAQ+b62pWve+KLTv16Kzr6y34DcCuDXPYUQulx2IHqPYTwJkqx3eDMsLn0gc+E7GHVCDYGp55MM6Cykwns6YzVUtV505+oOka+of0PhqyF4chZMphvGDZZ3POkHqQYj5FEhtnMIGgn3304hk2fLCqDEcQauJb9+UxE4O0roB25+eSyZxwCmYS/noa0huIIy64zdZCOm32kGkMiaJt/qjYAhpVl/1yApHbxyOhhkTKaCCUH1SsrtbD1Y0bSM5EEFC46fwKqpHnOzF6CjQujCjX3xB+jZk+lWSnB9oK4UecdVFuvhE6OQ4Z2SrlS1GhLk9ZMATj+QwyLp0aQpp2gPlstfaOyoNvhv9WwRn4/umO6H7HXq3aZ+T4PyE=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB24259923450415511C43EF02E68C0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(211936372134217)(153496737603132)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 0656A4403B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(376002)(346002)(39860400002)(199004)(189003)(26005)(16526019)(39060400002)(5009440100003)(86362001)(486006)(105586002)(956004)(2616005)(11346002)(476003)(8676002)(186003)(305945005)(6666003)(478600001)(446003)(25786009)(81166006)(8936002)(44832011)(81156014)(4326008)(106356001)(7736002)(76176011)(53936002)(97736004)(16586007)(316002)(50226002)(50466002)(59450400001)(36756003)(6486002)(48376002)(55236004)(966005)(6506007)(386003)(5660300001)(6512007)(66066001)(7416002)(5890100001)(3846002)(47776003)(2906002)(6116002)(68736007)(52116002)(51416003)(6306002)(110426005)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:32LTw2NImcBHB/lwhwWUNHXTwOMjh8CuUysbjji?=
 =?us-ascii?Q?senwDiu0f8h25qi9iGkTdk4Sw55LgaqPLI96cjb0iDC8Xc8Dxe3vkdTgTbbI?=
 =?us-ascii?Q?nR4tuobOox8NLACbN55++g83vPVKHSfrl9ifoZl4KGBZs+DRAHSkmYkyEP0j?=
 =?us-ascii?Q?BhJ+pgO3+qj62b5EOeHhwgwJQyGTte/CcsuwJcP7kRB8OQ8OFz9qJ0eLMyCZ?=
 =?us-ascii?Q?63FFM/4UJE7of9mu1g7KbwZqj93PNdPT+XFv/V86I7dUrkqzvgzHunw8LAL+?=
 =?us-ascii?Q?cTildgj04GPzZks5qY2LIbmN/ozwQsW8Np1wCm2ecrQS43Bl1B/TasHqFJxb?=
 =?us-ascii?Q?LdeBAiPUqJkfG4vV4GxbJw9ZmQwLzE7WYjry6e2jsJXskqh1fbD1tn+CAobY?=
 =?us-ascii?Q?mihNBsB3lPCVaE5Ubl/GoaiUXeeom0M4z/GZixaPUtHe+cxzBk4uV+asxVSy?=
 =?us-ascii?Q?FP3YfTCFf7j2nkTXnUkzU/01tPd/QUs+3wyp0sJ6OaJP/P9Blv20VAEjm6k7?=
 =?us-ascii?Q?SvfPOFKkrVp2/E9ClGSZ38MnVlW5ZkchdcRN9r7Ol3/vY/7CuSzEhBzZiNmS?=
 =?us-ascii?Q?JgM6UIKfZRgYkWDEOiH5YFy19LsE1icPXB1PF/+R/8967c4IjsNEsG00geuQ?=
 =?us-ascii?Q?y4Lx6v4EqFxxdtlgv8WQyOnzch3kfQfdTRZo+jsBKpVj4mux0DtiOhaTyArk?=
 =?us-ascii?Q?xW2EyUr6V/YDM5KCmr+tmvU1Z6XM5YjKHCenLTDAkPqkwm0KNNU8s5Hy3lSv?=
 =?us-ascii?Q?5nC0ncuRuSwX7TkWbypShZYjzvevAdsr6G/4n9bTqzA1a8y8guLCBShFs2c+?=
 =?us-ascii?Q?AtpVjaUGB7zUd5f2rcrMs/UA4iwIkQI1xUBuuu9nyniC1L1SiVdHlU4Trrt2?=
 =?us-ascii?Q?tMeV4PaW0vFcbXwacuxZ50xY6D7Kw2PsXz0dtqytlstMGp0EYrGmEP7F8A3K?=
 =?us-ascii?Q?aNE6pjCzepH8kUVbV1RoO6VtsUz6J8bDPa6yBrw4MqiE/TawvZ2eiNCMxRVU?=
 =?us-ascii?Q?XHGMFGoBKBBHv1Di8Ee7HGWFGVZyVGbWf3pSyBH1VqIiFhFOJuCtvEnw0teL?=
 =?us-ascii?Q?oyOiVEd2MQThp16e2Ar8RtCqzeeZCpzJsDpfOnUjInkEEPDluZGXv1j16P5y?=
 =?us-ascii?Q?/Txb3VKELoAS5ME6ZWQ7IQq7Jokihg6QapU3i8r+gBuxDk4oDZYFWZgGv67T?=
 =?us-ascii?Q?M/SmGn48i4HOTBVTdtJFFYWLdPgiZL4M8uWv+f/OIuIGUOsLDo2FnZm3/AVY?=
 =?us-ascii?Q?UZEQpPJCX/9TsCxMb839JAmpcOCZwUNT9tr13Kuf9fF/pLQVaYmpVlpygiWK?=
 =?us-ascii?Q?W+qMTlNlb5D2ed2Zf+QEeqTi8hec5SPh+SHoDUlrs05tpG/GGVgNReTUakZm?=
 =?us-ascii?Q?jvWubQR/uF4fEWTAQbT3KeXGDkm/iIGKVo1dmcbwBDKFFCUryt2Rnu69a5ss?=
 =?us-ascii?Q?4eyRy/+cs4A=3D=3D?=
X-Microsoft-Antispam-Message-Info: Fh6ibvQJ/oSb/T8+iPAtWwe3yEPCKXTIeulrrRQwvcP2U9fMLzpqaTurp46dRC8DjI3M99CzjE/1/yUaKi+1AEJ4b8KtaR0V1O8qAdVEPXE9U0eD/M2uhnmO5g9KkWEZngaKh5NJrAlFkXStvqxxmNLjffD1+mgp99OVAXAFGCRtf8ynmI4Nl7GJ7403SWlO
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:P0mGYVMOVkFSUNL2i2eKpd+RH8p23K8w68F/QdT59HQXVO/p4CcboLQXgv+JZXiuioZUip3pe2903D4DVO3i+qbvoMBb6FoBpq3SfPnD92QQQMrSiiz3a5lH2NxHggHejrB5gdlhrzLgG87D41VqOxTtuAN7cbv/fesl2vloZwZdl/ppAZVa8DL1clDFqACjtUhVhQ1Evt07IjklDEbJOO2T26xvak+Yd+B0Z7HQLKlaBmoDL0/sE8AavWCS6iDJ0KywcHYNSfsOfD1KA7p/OtUPwI9JrEubE8hYBdwCLN+gOeOto+uopoQ3K3XO6SHDWH/PmqUjf85cgqRYgGOtAEwbEb9rt2utURzILV1cr61H/9I6ZeFL1ZJWHtLCiGzotNw2IQOBbT0uBWXP0HJ2bUJbecyq/xHI2KhU827NlpCw7GBSldrH8R5+RKnRcO2GN3dgbkBfU75GPTnxzq/Rvg==;5:zVkN0sQSHmd+YH/w4zadHcTyE4nKWnjbKuoNMUbZknfjCTrVI571qZU9Phpfxc8KZVYDLOT59FjJAZNvTuKuz/0CrV3CwO5ZnVcUDNpvmpNLw4iZK0S9U11bEhuain/Pveeip50+zBr1H741d9R12U0uRxom4J22g6dWhzGkB1Q=;24:flzfkHqem5T9DurVIXE5LK+gqYBAvAeXec9E5nQkJRzMhj+5tJKG0shiO5vg5Gu9Ydx9rfTW9cVnMvttYBCKc7P/mKK9/Db4RPLh3J+w+8s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;7:oa1/lBXFRMFe6tjm680HPkPQTV0/t4c+k8DyybJhLndk3/MA3fdvksYcmfCm5UDmZT7NFhD0amitIw/tDjvUdtz/3H1QhiYiNtajPaXnsOfxeuQznXsYF7JpylQRLQ6fy3Ep25DAtoHwm/mKiwBMZiLUjSsWxbc7b+AJOhiM97Kr/ui/9lQ8T4hzQ/dHZccYDHP3Ro501PMKH801oXHVSQRcAlHHtLiJ9Hzrx9FfAZWe8coJiQDuakehZ6A4HWE2
X-MS-Office365-Filtering-Correlation-Id: 4087e252-248c-498b-c171-08d5acb313a4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2018 02:52:21.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087e252-248c-498b-c171-08d5acb313a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1598956716093931806?=
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # PCI parts
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

Changes in v3:
  - Move dma_common_configure() within platform_dma_configure() and
    reuse platofrm_dma_configure() for AMBA bus too
  - Declare 'attr' in pci_dma_configure() inside the else statement
    where it is used.

Changes in v4:
  - Rebased on top of 4.17-rc2

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
index d82566d..f831a58 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -329,36 +329,13 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
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
index 8075ddc..638d42e 100644
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
index b9a1311..ba8c6b4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -16,6 +16,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/kexec.h>
+#include <linux/of_device.h>
+#include <linux/acpi.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1577,6 +1579,35 @@ static int pci_bus_num_vf(struct device *dev)
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
@@ -1589,6 +1620,7 @@ struct bus_type pci_bus_type = {
 	.drv_groups	= pci_drv_groups,
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
+	.dma_configure	= pci_dma_configure,
 	.force_dma	= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99..607c7eb 100644
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
