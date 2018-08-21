Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C46021774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Nwp67sQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C46021774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeHUJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:39:45 -0400
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:40106
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeHUJjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kmiFXa6A/cwzbx62ZVs4FdYi/R6nMnuJnalY4HTYss=;
 b=Nwp67sQu5ut8qqz3uhffBb16bB8YrSP9+13kA7szsZ93bO+hJE7dlnj0tpVLoNRN0wxhJ/1sMy/356Kv4H+yE03qNTtUtt+9GrkghzsHwi/4Tb8ewfzhaeb6zGEa9uqsGVJgfJqsHm8yNeAOS7SxNnx5Ve283dI++R2TSOQu5hM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Tue, 21 Aug
 2018 06:18:15 +0000
Date:   Tue, 21 Aug 2018 14:15:12 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180821141512.368e3df2@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:404:56::35) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c22d425-94ef-455e-7cba-08d6072de25c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:JS+Tq0afmbxzMHt8EadVnYPO4sqgSyXdLj9YeNJq2qKlqpK/qMIazl5lsbB7G2RIVdVsFQ5c0/R1zVW0xeG7MfkLLbA14+iI6biZWuZOZzn76cBAt1s1TnCsCPon4hWBvgF0OGUE5JfEE0z0CKFAqiVhKRsNRc8rJz6+7lQ88hi1sfCQENQt9EQ/8bCFU8Dw0e/blrtzD2t1WVtlDT20vHxUlj+ySnW+5miM+6UEsrBuBdw4Z9P5JXH2qfQraieW;25:Bpy1iRXPhcIuKYwoTiO97TbieepyxH4hU+6qyHr/hfGjhLICnS+pEPtOI98BXU5iz7DMkmkGsJRZZ/RHU+H7DBx9eEE0oC1Lj6SnDPAI6EaH4UpTKf4GxN1wv+m6dcvGd1fw2AcqwS8+CrKFpFpbtOQLasC0FkdhanqVVZ54u7dKWcCFWM2owfb7Lj3r7qL3KwTS6uRdluc4u4dB1KCr3xcpCs38HvVXdFVmCOg6RIbvxzaGCqhpbEx+ZYEmwKkUq51LZLgnQx2bSUTcb5/vmzrueRvgwlqQIccWvbZwqnRd/GNQ2SPp7yZIMo9jewq5SDi9agJmDvi0am5d1W7y1Q==;31:NjKRAq2I/FAxnUH9YfPpcdJIdFRxw9G+E0bw9qTQ28hIPTPBbzL4mD2+L18fsBXRmdkuHarMRrHibHOaiHa+RPhK5BLcvhb93na/Eniu69X9G9Vka1NSWDwky3OkMMXMmvVyytF45oa6y5Aji8zietZMJ52barAu3wdVABFHOVeza7NA/RTSSbkhlcXas0Wc2ZVkgmP5TsHEI0njakJOWs7e9XJuy1zX1U4CacD/hGc=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:S6Lawtlt6NGm2feFp977V7t3jPsq+zPAxxqBZyWz6tjRfK6zQ64kwKSE+F3n0j9WmtuSIipDtD9wEu4GTRYhPOegbRJvTGw8LfTizNBUl5OiRhs2yaV8rT1uDszKp75l4/pxrSBMzdjEqna7xG55fiEGoWGuLltnwNiEv0yHtAwgfW3UdZuOmyOtgsnfInPaLqZrDHaE+0WEi7GxPnYSGkm+kAvYis/xS6PEZNxI2QFeAGlK4WgiI+1odff9AG08yvIKScMJ3VC/L8PghZdpwtc2lPvqD0j77mX4Og0g6vfe+2uhrZ0MJr2G+vdn2qehBFEZy66HNTFFN4z7jcA4KLTplGzvj4o8Lxobh7KOaUnNgt1aJawmfAQz7wqUXvh+H49FP91yvZidtwtDmsE2VQGhqmGALNuBfcI2gfH6H5/IZkFbzZxaPthVOKA/w3C9g1+2zm6C4zhfX+lEDXRxqDn4pk11ZSXffW2wo6cnOLkutqHK4WJnAchagaOMWe6q;4:qE0/mLx5FD0YPLqPQ2R+NrRhHXOCTtQWflfUkv5QorEIJigRsb7aN55WiszwmGfU5xxVGSpWp29HwbsGANjvJDYNPmVyANsu2DD8U2Z/OJ6W4I1WuKYhxnvhPLo6bz6u2iVSEqpFv+bGAffAJvEgUss8XXqIk7Al5G7AOXHLXpkHFmVa6+b8fW1TNQC8C2GbDzNwkgOJHjD+aTkiVBvuLwGKFl501hjFDRJp7kQ9aKutoSHwlUhbOCb8GwMd+rseEJXOgN3g2GUb6NmmKOOApQ==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15782BA850CF31FA222BD100ED310@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(189003)(199004)(53936002)(50466002)(4326008)(97736004)(106356001)(9686003)(39060400002)(25786009)(386003)(230700001)(105586002)(476003)(956004)(2906002)(486006)(16526019)(23726003)(6116002)(3846002)(33896004)(86362001)(26005)(81156014)(1076002)(186003)(5660300001)(66066001)(7736002)(575784001)(52116002)(8936002)(50226002)(8676002)(47776003)(72206003)(68736007)(6506007)(110136005)(316002)(54906003)(6666003)(81166006)(55016002)(478600001)(305945005)(7696005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:pDXjqXiaF5hz2qcJybT0plH6pGZmXi4vshjSH3d?=
 =?us-ascii?Q?EP6jVjGrufns1YdmybtoZyktObF53TPIQfDHFrQrvl2zn02vAp1GpOYhRxez?=
 =?us-ascii?Q?cS+AVQ1I4h4CJ5XYY/uEiB300hzF8oxNt4ONBVsVPN+raA0Ppz37+AGD0OKf?=
 =?us-ascii?Q?S5dn+UTYzgD4Ov4i11+DsDrjeEOXQNVwD+lI2MXBgvZV27FtcMeVkQd6kAL2?=
 =?us-ascii?Q?kkE+2nsvIb65cNrqY7/cK0V0hmDkZ64+qlqclN5conBENIaeZCnLmry5LNhl?=
 =?us-ascii?Q?A8inCrwbnsIQVdv9t8ugsTWR9l5dsGU8eDZPYHLUzTYXMgWChFjXy5N9gnve?=
 =?us-ascii?Q?x0kqFyE15R9M/e/0wHeYeAZUPI/Xs91X+uzlpCb0qDqFQqgBodNDySAOR1Kd?=
 =?us-ascii?Q?pEjyGaIWZcErBdLG6rGkBXoqfGpGDaQ2J/XIo4vweN23gjwMWZ4aNnqBlT8q?=
 =?us-ascii?Q?22oMYeGditTyX08vCdu+yXWajRNliPbypcmd9QwP9Ke5ldvrgXKXLgKc+4Pw?=
 =?us-ascii?Q?0Vjo6Z/zvfTM7L5/tq85gApC05jON21VLtamjY0KqAggiYt0HzOnm3a8ITfV?=
 =?us-ascii?Q?DqawbSqVtYCsgCf6tYXbVQacGJjJb5/iOb5ms95DZeNf0qWl9+B9spiVp6A3?=
 =?us-ascii?Q?YS6DsGGnAMQnXrbxu7x212Qkv8SHBlhweIe9imsD0wCllGfygZrh4Tq9us64?=
 =?us-ascii?Q?I7KHyXU64P/3M1HLBzw9mxfNa6E1IyORNJmZXpqIePKfSzaUPWgLg0yadOm/?=
 =?us-ascii?Q?JZyFjlVeYmhQS9IhqhqwGqgbqWUZPnxNbUwI5obpYbOX/Bz+hrqwuRbvW/Wy?=
 =?us-ascii?Q?DjdDyDIVn29o4pvEnXeLHxFnMt/U17aEhn/3y+b2ufAhBSShnpSVsyM6Cl1B?=
 =?us-ascii?Q?fAMqcw6NExSLrTM4VjVSsGZ2Em2K/x8Sw4kJoqGp1sQEMLorgU/fcYlhULF9?=
 =?us-ascii?Q?QYeAGqtFfVht1URbw3YR9GN0nCQGnGrjiOzeZsgmseAXnHS+2xTmG1B/EUtw?=
 =?us-ascii?Q?negvJNEFayXsZ1w7LH/OL4GsardJEUfd3FTNeVPulk7BVd8y+JoSXha80N0d?=
 =?us-ascii?Q?0miE01A/EQiIT6/KaD859LfBxlphkBZ7AMds6PjJdvQfKrHyNOGZ+q05QcSe?=
 =?us-ascii?Q?c0JlLd35iZs0ikmy/SsTjgr9WqAAca23L1C6ThgqmvN+SqO61kAeoInXzXma?=
 =?us-ascii?Q?p06DmSyOtxXgCku6QdvSERnAmZbuK7UV+SIcEaIxh5yDSBZWW5ocIY5oW0g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: kkYM1lY781+8HdOY5F6wMfST2eqiNotufCpIlCwcq2p5/fAVeHFVRX4V5TtyqwXAbUcc2rxL4sp6G2hTfR40GS/Bq6ZcQTK17GBToKarg92DINdSnHNHJo9INllmAFwu4ds04M5eq+Mm5o2kQhlBmE6ZklIWwKEfbfep0Liah/iFWBitwmeeYSAvbnYpKczn9zGiFEm7cuO/o0w7icfRx+BRf1E/B1vKTo++iAzQNALyCXX2W5d4AUEk79SgxfTLll6VoELE5cyTqIdHHz/HqTgPiPfKBAaZnsQvopu7uSf24kuI9QBcXaVkbR8/ZKjRQYkQPHoyTgMsJHtqPaBLyAT/CmY5t3qKSVxEIKE/A9k=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:oE6N68aI1XSeQ+2rA4WmGRww8eo4FCLGiAQ+yrZ6g4wakuP0xcIFkNToUFpSL7bhVHfIJFpP3wHwM7FXWMYHIz7JJ0M2Kb7dmBBvnmK4+0apwLKhUUKpJnQulN5V2P2fTjmCtwepyT1ZRCZjWYYpJ5Fl42lPVDaZarEroByuzr597y4lWUvjLbsN0wN7eTKrSwE7yZE+AuQ9sKiM1Sc4NZKr8vA1Km6fScRyR+gSOg4Z+Wjihb4HJIwnYsz9/FLL7hsnYi3ElefgbtjcnamrvfAcwvJsOT7cJXEZ6mrw7960uAQokjVVSv/9vvvtWK/e/Jx2JfE1USRWyCjWW/xZVzyRr3GlAX47bPySrAOMQqZd79dDYZt6/NH/L1mj1eshxRdT2s9Rw6QXhX+d+ci+1PDuVEwAhnT//yuoQwR9IRKjYKqilyx1cxHzOuav9Dt2wNDliW7nBniaCYvTKlZTQA==;5:FF6VqTJyCasaOTIK/glqMGQyXa1Vfo8t5X3Viwl3NIUFUktJdi90drz14KKyI6T5fiKB6mi0NuIygy5Zje93BMbDjV5cF+0/L8emRslXmSpjc7qwRqQIhRXCIWCc/+mIMPsaVI73MVVDdnT7/mi6WwmoDAHj+KRke5kjP+H5M2c=;7:57SpFJGWfHu6om2uYsN2Qt0cP8m3TOtmrDrfmU5lWAfmT5MYH5kSj2f3YHquKGG1VXbQAhPfsevugZVbtm/zpf3doHnCfnazDAoe1PFiNZcWv/MdUni51Xfp1MIDfnMH+QwIG14RmPBoNs49j+iRcHvr4VpM2GD8WTXqJMgAg6KPz2rWCjnchu3v476oe8rElCyoysW+llRkNTb1gHxPS/ndlzI8KHqQDQeOQiKYs74yE8LrEQlQ6l/flPZ62ay3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 06:18:15.3663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c22d425-94ef-455e-7cba-08d6072de25c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
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

Fix this issue by calling mdelay() instead.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Since v1
 - use mdelay() instead of udelay() to avoid __bad_udelay()

 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 778c4f76a884..2153956a0b20 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
@@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 96126fd8403c..9f1a5e399b70 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -26,8 +26,7 @@
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
-#define LINK_WAIT_IATU_MIN		9000
-#define LINK_WAIT_IATU_MAX		10000
+#define LINK_WAIT_IATU			9
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
-- 
2.18.0

