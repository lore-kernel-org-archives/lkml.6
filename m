Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE52C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5873A2174A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="aoKWuSk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5873A2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeHUGGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 02:06:00 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:40995
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725732AbeHUGGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 02:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmZ2GKLpLDuvcNh7uy5VeDL+9JUt2iz91G1SqMqUJic=;
 b=aoKWuSk7WKX9AFGfeiVzL0XrscHTY6hWqdQPwtzLNW0ztGA2DbL4rIbOOXGUx+5Wum5kXjH6Xxm8Wlwl4VrJaoc2xls9UJW2FIs0c2IiVZrRmqIdapd5Lrx7UsnvfHlK6JFOHYUwevNhXXxv0BbAbvLuK4NRABRxN7m9eJu6mr4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.24; Tue, 21 Aug
 2018 02:47:29 +0000
Date:   Tue, 21 Aug 2018 10:44:33 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180821104433.1c408d7e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::27) To BY2PR0301MB1576.namprd03.prod.outlook.com
 (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2be818ff-57e9-4141-cfe6-08d607107146
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:4zbxfGhZ1Y9ob8c2JOiGgWer9NLPA6ZfJbsPAx/pzZYXhRZhCVvq3mEbb5kUjrfR5JbcJkGUzbkfNQyMC+kd05EOuoK82PWdwy14w99xqhK6dOgsPKvoTraZgS5fyg7oFZ2bCylr0i2ts1jDSAMpUicZF5usb3kE9xv45RwemzHNckJftwbzX6LxFfjyGh0miyDW56dx7wgCtrFnxH8jvExEx+V98nERVdTTGqf5pG4Yt/1aIYIEeVh/W63Kac7s;25:ph6USRFkom3BeHsU931Dn4ePih9nahpN/gxe6ZpjP7nlS8hAIGotOYhDBg5SWaRgcvpHsUNzAwq47iOtLUTfzH2NnW90DaKsQRV/69QCi4/13dJTd9O8FwPYNub2BEQbBr6C+0yDYh92col5ncZMecRKLOQQ/dUSErM4yACrq2hMe2BfzG5iySFQSoeNbrguTQCfpNkGpct4jsrom17z1ZX6cLiVLYJXI/lvF5icZfiKO/1SeIcfu+PdOY4beFgDEzBVIhO7lNG+xWRvYPIfa/E/+qH+psomnzV/ABS/2Nn4IcbsVRqoJEsO5QLYQVhjGExg8C/6W4c0DCbSVyv7gg==;31:JeXKgLZab/3RcLZxwJrF59PpZ6c62smy6LNpWDFE0vSlIwfq7CqIe4S/fzGTkCMI/RQGZdZTOy+ZZrUy87/VyILs6JMvrPuNz8CdQNdW0FsrSftc1/ZY3f9nA6o9XYhAHgtFIVM/IRg5JnlbOGtJvBwpEcnzptmnbhrVyV2Do1VFbD3CJr2uKtqQ1zAbOGuoymBQpzKPb58/duBPZXNSk3rcgZb0xktOGRuu22kj8Wc=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:pdZYtnwGHtVzbW4coY2HqatZFSGx0eKWyhB8lFulhp7mni6V0YRX4QVNRESF8apZRHc5R3/iN+JbvyaUXQ6olb2D+FKjWeuNgS8OpdZX+JNnfMaFv5vldGs6ic5ERBbIjVn3Yvjjh7STLNsDlPvYacX7r8n1DnRvoqgrfk9OGiEmQhSr2EkmHdfJ1u3KYTqJ/ZdRFhJDlDZZkJIG7K2pbZ5KqDUuFZMz9v4pWBFjZ1Jc/p1uGzTCM9+O+R1ZeuNsQ79PJ7blxywbzYapbz9lnjct+l83PGQWPUNsWsLztmkV2h14uIlYaxXWZ0sAEqJHP7fy0iiIXsN6bB/NIfPf4jcFT6IJR/TAryBWYqxXtc1evG1kVtvh6s5OCO6WK2T7eLA2PyGUtgwTptWcZHduBtp/EP46S7E4A1tdkdeMRD9G56gZX1fPiKDzG2cC92lYci2uDLD0ANBa+Scod3STBg9xDXlhWlPVcKFlZk5Gbstu+9dpG0HLNJ4dcD8XKnMd;4:1mnqtmjTvcTTBzVD2tt6as3XqSR/K77/Hbi7G9Gn0bkMRlYVr6mbo1Z4RPOFFxTelSdTVpEaJHpLW3kp9vqstdj9vLYhB2N5fTu1iUFEFOtX1yM0qq0MBmUq7jW3FlTkxSui0DorqnZivLDPOBQbxam4aggkEP1Nrr1YdwB5KwsHbkekG6CMhVvXzzbUumGUCr53uYZzo+yD6pokIkiTRrrhvWixZtf+4plzJdOHnNz2mOjCb0AoiACMOwx945nRuNVKUG3WCAcTMA8nro5XdQ==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1576FF79ADC13A0631ADF322ED310@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(4326008)(230700001)(2906002)(186003)(1076002)(6666003)(16526019)(486006)(26005)(305945005)(110136005)(7736002)(72206003)(106356001)(66066001)(23726003)(478600001)(39060400002)(47776003)(97736004)(105586002)(25786009)(6116002)(68736007)(3846002)(50226002)(8676002)(8936002)(316002)(52116002)(7696005)(33896004)(1857600001)(956004)(386003)(5660300001)(86362001)(50466002)(53936002)(81156014)(55016002)(476003)(9686003)(81166006)(6506007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1576;23:FjJ8zFn7mRYtrkh8QTt5HCrW3m/HKBnUCGinoNx?=
 =?us-ascii?Q?EEkt/GmbAm21reOX9q23rBWi2/9FanQil90MaWu7GI7EogqTY8tf8JIrMvSv?=
 =?us-ascii?Q?0ip9j8ARLqttW1qAmH/Qvb/5V29x18HCOybfpMaaM9jusdYDy8trJoYHs3OG?=
 =?us-ascii?Q?+Zq/T79TBUCjoOnmvEe3nLBGIyfeexckmlsEQ0yg8pg1E6GoiI7wagm+AInH?=
 =?us-ascii?Q?cRBz0pW3BzTpe5n/DPj6HV93e5VifmYvpnMBC04AqYHyjuVKaYPZ1sHfgRRg?=
 =?us-ascii?Q?q7jRdAsSlmpCYOsTEAWe3xg3fetl/nqMLss+siUrlvaMuTZbCQ4DIyuv4HRl?=
 =?us-ascii?Q?byzgZbSnwXMrdv0J1JDifAIOouDGsW7KvxYAFdt8+qlrqNtRwf78ZNToiOYv?=
 =?us-ascii?Q?uNem0SzMNavjg8H8XylunyR/G02QZfKl07P25JOJllrXnYpFuQ69v7tkNJZm?=
 =?us-ascii?Q?z2OThkDEVYCwCVNZEtETYU9Z886ZhJzTMcclsTY9Sr2tjvv6zBolAPUcEtJq?=
 =?us-ascii?Q?Ex1tRojrIfQiHY3DcMcvhNt+ZpThIdK3fI5ymZs8JV8ZgjDBcoHqWhIj1ehd?=
 =?us-ascii?Q?Taqv4JH/jAs+WKg+Ft6BADzebB8wWFBKmUR7nB1Hq2khyOuB8qx+6PJZ8Qq1?=
 =?us-ascii?Q?2e9nShC9BYvRtA16MfTHoJcFtgB3QQcEuNm5kQiBxkywXu++f99MgijhHfqB?=
 =?us-ascii?Q?6d6VFcs6RQ40QLrCWV///Qng5iWB0x1binsVc4O4N+0mO2orKpGiv6/dLu8j?=
 =?us-ascii?Q?InUqLQasBwP2DT+GiJ5erTxKFHU4Nl3iayNPyLaYmQSsEJGz18KIWjpctgdo?=
 =?us-ascii?Q?aeNr1TisANZT21FcOi4VyoMMIzH8tV3/BbATkuZJuUD0lQmVVwb0vqxwb4xD?=
 =?us-ascii?Q?aKKwk2jDA7TwizltjHlLKLlWuxEbd3e13El61zkhtAu4/2YyR/Up19LjUjNC?=
 =?us-ascii?Q?9ttDY1OQGEeIdW94G5/XkdoCu1GQ+PJfvaxyEos9V9bK8djXWMiNgV6xN9XC?=
 =?us-ascii?Q?vWwzGKzHvGo4z0r0eIkoJJ3ImONwwMUTA/dVtal+2J8Jo+B1IhEZ4qhTM4ce?=
 =?us-ascii?Q?Bqwi6xoRqjmBmN8yafOBImTRAYFqhJCl6hNVO4RcSmp0VSM0k5prSGrdR6gh?=
 =?us-ascii?Q?/7K9DHcFVWhY6CeSI3pBtAUzX7KqyVajnfk2ugycPSdkfhWkraAR5Sx4DLQR?=
 =?us-ascii?Q?WbwcHdmclgyBCAC6XNG7LFNe0wvpbxb2nsHjA?=
X-Microsoft-Antispam-Message-Info: uDJr0ci5OnP2LY1b8eLU+6pH+bMWdEp3m5+72gpRjgFIOfuE9iwjBCHBFkNmLdm4nYb5jd0egRQqcccI2gBSXh0GYVosDszeotRzTzGHhjXoAGvOSVT+rQoYKtjEwgembsu3rqfClx4xX3JI0jrGa4z//7rhpGOOBZ8Pe1Bp+BVBym9XsFRYXhbhGBfo50wu7CJguVCTlROdAZKd+NCxZ9csr7MqB+TEgisubSZbkB6jT8pJ+8dgqq02jJiIPDKf6QLmauzzObBGf8W0lwWZ79m3GsnZNuBzV1GcMZBwZuRA7mVKhnnuVxrQ5GytGagUCyzZFMSM5g2m8Q6H7rUM0h3Og0ivl8DsXuY6/Wgc1u8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:gf1yuNxFJbNQq4Y2Nfl0HItZ/zTD0bSfOoDhXGewlnV530DZfsWTIj9H6axOHmxaQzzSWBq50OEcm1zQ18pi2IylRyfEC5ifCHgsBuEdN69aIuAdQS7cnagAJsCji4CUf4+mlWUk0f2zpWfm6DJxeYmY2Cw613ReYFY7yqDfsXH+lnosEP3BoIzdY/SzPH+ov5FnOW/GddW2SUrGC1QL0ChRXZoUHBLUoZm3G+jbDazYVkusVYa2Q0Sr+Vkd1sVL3A6V9iyg95yOUoaZX0hdsYmXrBtxfcfGD9dobz3sHNoPUbzeyp5Co4eu6g7+bNqnIFzFux60tGoAATE7N8NGlnD+DoWwooZhSrkQXDv6L70GW8abH2DQIPJc2A8Yu6BjeCrstAVM0/9/KKsLquAP/NfM/QaofRSE2G0Xt03bQq0lc32qj4seHU960YoAXKYr0laNah+CL/ABbHZwZUJdfQ==;5:DNbWdD7RrTF3tZUl4YYfv1nWKjVcYjLNkpLybc9pAW3UlKxtJg5Ny0EdmHVZxYFI/A+aEgrLFXzUiQfpUmq+QC7/l60pU8sn8LF8KIrs8QjlfQWnCzbKFzqbSLhW7ylVnyHpGZ+PVmtsxkQXJJodCgaHL2tj6aod3BrckkJJ+4Y=;7:qrHkKjlnkPPqa9LGaQ5j/IRJSlkBOA4oRbFZN3zj49t4Puc1xtAPvN3vNoxB1K/Iil424P8k5wxx83k26ChA/80CtVoOMdf6N+jsFgsV+1VtijZ6geasriziK4NcUTOwC1qGvP32BpD0UaFvtfc70e452Wo8b0Yc22fqsT6HCdAeNG/O3i0sbAU14NnHGJtjiYFX751Vyxe4gJUmVDgNmrDA+//yOf598YbK2znChHaUYoNXRJQ/avFJ51H+kRyL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 02:47:29.7941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be818ff-57e9-4141-cfe6-08d607107146
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When programming inbound/outbound atu, we call usleep_range() after
each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
can be called in atomic context:

inbound atu programming could be called through
pci_epc_write_header()
  =>dw_pcie_ep_write_header()
    =>dw_pcie_prog_inbound_atu()

outbound atu programming could be called through
pci_bus_read_config_dword()
  =>dw_pcie_rd_conf()
    =>dw_pcie_prog_outbound_atu()

Fix this issue by calling udelay() instead.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 778c4f76a884..4c15929d9c79 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		udelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		udelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		udelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
@@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		udelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 96126fd8403c..8bab329c5cd3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -26,8 +26,7 @@
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
-#define LINK_WAIT_IATU_MIN		9000
-#define LINK_WAIT_IATU_MAX		10000
+#define LINK_WAIT_IATU			9000
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
-- 
2.18.0

