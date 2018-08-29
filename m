Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC8EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E464B20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="b3qyWAxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E464B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeH2HFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:05:49 -0400
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:14435
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeH2HFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF/yHQ6vSFIy2qUV7hbMzs1AgKPNUd7hWSEl41vPOhY=;
 b=b3qyWAxtSnweUK89b0bsh/9yebn82eYTe3vX7cs67sKW3xG7Ak1/3fZmUkeyiqkqxTFbp9YjUCs2ArLtpPgIC2+msgOWr15pFJEeIldpz3TUE/9dZaPKO8juTIXL7kVq85KDYlUPfBFTwZRMuy/W6pZR+u4NTPKWa/ZdfNRvTBY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1579.namprd03.prod.outlook.com (2a01:111:e400:529c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Wed, 29 Aug
 2018 03:07:14 +0000
Date:   Wed, 29 Aug 2018 11:04:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180829110408.556c3622@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:402:c::26) To CY1PR0301MB1579.namprd03.prod.outlook.com
 (2a01:111:e400:529c::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f58c90-e7a3-4fcd-fa2f-08d60d5c8658
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1579;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;3:ZmdUgBFmUsuzpdlBPdCpYEppvtJSkyX7PtWClKTkvdKichTxavcaMFHnr0u2WVck7dJp6HymEEq7tvLg0BMcwqJ5etJgsQwAtAb77Rw+pPTrcKtZpC4rNt1TmP5Pubj2Aql6VmDd/T+4qSpWXUKUXOhrrU7NOWYfeq/Pb32eyNVRYU3LuX+dWErRUyNKVTplQ+kU9obQAA2lQ1OXDImD+77tpCUyZg+jBN7olMVAIzzy3dwvBusrkjxlkgPFZN5P;25:N05uj38x8SCu9qTWZ86Aory8Hl3a0+W4NAdM4Rb/0pwZl9Mu9fa4GJwDqN2eYOqEQoRX/LP5n8wT6vVK3bYU9+gmHs6CGC89LpDhb0LwK2GYSUIHQHqrhX2YDRmyTGhiWKkF8C0JYDDUvmNjM4aAxS6P09xL4o71wC2D1lJYjkmDS9QMWFtsY0N9Hya0fTCRGb+snVK5SCwP/gwVMkI2PK5XcbaWKxBXE9ZHx5NrjzrBmqYEQ4VNIk553rP2KU9nSiVYswPEhbimtrnraOkTQOx80sYSz/oLIfJbltUHWmjwg1kk9j/5DX+neXWOXKPh3jdqwvS8oZzcwgoTZuLXqw==;31:s1ITjxvIPE4o+L1YVP9P9LvVZTNAa4eHpj3Qw7fWxvrhAtIoTMsJonlmOHM+A0qXRg8EtXyTat/aC08uQY78ICKPtkBoaxlbzcR8WM3pB0wzgu8pDtYMW32VIBFVUdR6Y0FWrW1/Fkz8nbgru6alvfNe0mjcYXOXu8RFUtChZ+QH/A8qBvSg8c4SdoYjBP5W8nYr+OkngeNtwGJmSEkI47qB9nftNtyEUp5i1LXXPa4=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1579:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;20:R0+iHMLI3A3NoN6hEZWuvDb/As2gjRvhr6WMedR55i88QCycFAjudDQchIn9Q44frGfFIMqDTQPFVLE0nNCbEcYoLCZK1i4znTdG6h84jbcmc4Kkf6OyfwaglxxMOueVHM38kK2uyJgOahwRATe1GwanSf9URZ2w+BJnaVe9b3d5Fe86WOaBcS/uEGUxR3aQFkwkheClaJldLpj9p7BXfFb6mOKsmsiL9sQZRbU1OoO70WmqFWFXZZMrQ3Yb0pP3Qb0sK9fpYCGPPQkEM6Lg31D/zAheu6eSEetq7Cr/epB3OYdgMFw/i2K5/8kkdyBbokX0tJCFhXWAW8vcwkOM2yH/hTJ1Ebx3uQRtl/aRSCwlvNJU5T0vyrLHHsnR7rwBUsegP5Ly8To2anP48v7xVaG2/0FF45BmA4/N5uCBXLZ/PicH8/1xd8K/HDBVfxQx3S4UBhwoUeaEyuoBs4DI7Mr5MMkKIKPYPMI5Yn1oYBxZUjhFjkyRDrnFWWYn33r1;4:8CgtAvGBJgoqMNmNoJIo5recIp8ihAQRq13woV2uQQmx0jvjfyP+iCu9XOkCvL7w2YcosEyGdV79VeFjJPHnFTFLYfzdOnFKvJzkKCgEgpYSR6y7KphceWsEOsDA0xV0C3QgZOI/P8/nSw4hUcvWcmaqEIfTfJ9QEfMyPUv2SOiTU+cXvl6sr8e7Uc7a+UAOzMeG1ULOwMYtiKuwy5bkCJgCEnaj/UN0H/VOrd4Syy1/saiadEZtpzTfO707KmZcRQC+ORPtpNFbaMfm2L4RwA==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15796F76358294A5E592DB91ED090@CY1PR0301MB1579.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1579;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1579;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(366004)(396003)(136003)(346002)(189003)(199004)(81156014)(16526019)(316002)(23726003)(1076002)(50226002)(575784001)(105586002)(86362001)(106356001)(110136005)(39060400002)(55016002)(8936002)(72206003)(230700001)(9686003)(53936002)(81166006)(305945005)(7736002)(8676002)(6116002)(2906002)(3846002)(6666003)(478600001)(6506007)(476003)(486006)(956004)(33896004)(68736007)(97736004)(50466002)(7696005)(5660300001)(66066001)(186003)(2201001)(47776003)(386003)(25786009)(52116002)(26005)(2101003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1579;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1579;23:x1uEyi224StWEr+KtU3DWqNDpZi2i8v1LJcCoU1?=
 =?us-ascii?Q?hqr+fjiapIRWnT4woWflKzX1zmOFopydurxGEQIEHdNam0J8vtpz44gVBjQ9?=
 =?us-ascii?Q?8aJZOlgNVQ+ktY4foTBnr5QQFsYunuUSdSZo0Ne2sKI0lZjUL4cMEW2N4nwv?=
 =?us-ascii?Q?Uzd7LzoEHiYYI7+9yl3KG2SwlpUstfv0f+wZDqlpNG2KZ3Sjc1FTfbDX0zj1?=
 =?us-ascii?Q?/JFs6wr8gt90VLRQuUe2o3ZMBWY0aKphHOcZ2viRYioe1ZmGuBIm0JNruMbe?=
 =?us-ascii?Q?x4zK0Yb6qDNK57FgdcJ6RLZ9wuhtEJf+XRkIdozAkh1CPei3hhejPhiWsWkQ?=
 =?us-ascii?Q?0YN1TmMnakoGkEEzGJ+SULagoZSuuWgJ1Z49AmEj9fs1LT+kpFWSJ643gr6T?=
 =?us-ascii?Q?aNfG+mxdypazO8oC1wBEvx7oVTOKs+veVPYPdYN1grxIEyQKBetbA816jbKx?=
 =?us-ascii?Q?yfvTqkbfdWrY9Vx/CP8FK4wxW9zpSwUxfklHWluF+vPjLyBx+JKGahTgjspa?=
 =?us-ascii?Q?LLngX/bOerfCQPYKrMj/6vN1TdwGTFxGmTNxz5tLfkL/Ca0RNsVKIKSOKSsW?=
 =?us-ascii?Q?26NbSmBPWIWFLPsEfyYGu4Y/bz2FteNUekujzwErWwDaa4WIdJFkg3Dx9Kbd?=
 =?us-ascii?Q?0yx6qscj7SUSIw92VMEQFissKhuzuxdAQAJirRlBoyyVaakG14fEnrzWiruR?=
 =?us-ascii?Q?O7lkRMc2WYAUKC2/PLZrbD/TyycmurQJRLHHvUAMyGBf37xQ70tZZP6o+FMI?=
 =?us-ascii?Q?X+m08PqzpETG3zNmZwZadTt/UfyipAR5VmXnrTpd/i8zjz+rkKRTIYnDJrp8?=
 =?us-ascii?Q?JmPqkQt26O+bcHAUOG/1FgKdAkrp/IZEquR5KqPY5pF3Zt3yvnBhR/UKSwFl?=
 =?us-ascii?Q?bYMEscmY7tIbrEBPb+LX0K6yBtGxltMI2HRRgsB3DoQaxfi1r8vAqn8gnGbT?=
 =?us-ascii?Q?zbqcghskSPTp67OPIhp5O1t7geEu00rcfwZliYY2XHA/5FGD4OeyfVy8hDBq?=
 =?us-ascii?Q?Omx6ufvYRGJcJNn/2rYXvR5GdGeHvJ6lIr1Oq1S9Kl0Fvfg4SJ1AjoL8ZhYq?=
 =?us-ascii?Q?wScmgx61FqyvXVtYxuYo5qsvMpTjumOQfjyaQO/H2UEfuTKl0DhcHF0NXAQw?=
 =?us-ascii?Q?9eju6c62cqqbenTq+U91zly8JBPn15R/sRxvIJ6RXasJzRWq01g3jrMKI0UP?=
 =?us-ascii?Q?4fyLjnL1r3iU/ttecOJi6reU9QLfQ4mRYNaKdfz5Odly9vlSWrCAPE5tr7g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: vPasNb1XXZHIYCN9scFC63OQlD85hTHHywcMVvpgOE6Jr3goLN2g/esno4M6qRNLhyY0RdqMcsKgxN5lqyl7XzrwCnUZ1XlrpK34TmLrVQlrI0qxg7k6A4GtPY0nnQ+Y0qAuMTfunTHA1Tyxx84ZkSXYalRUZNX3QVPD67IXp5DU1jXzHUgD+i/fhshZC4A677/fh9iXnKdoH0LV1U+XC5kQ8E1FmNUhtEXjicGWZddz0VGUbbJ0sWjQ9JZAtr4ifutz+iBoXHmu/ZqESBJho2hZVRG0JC2E0yPVlSVWZ70aMZBlxmflcuMbDfJsa7C4c3xjD1tUEg/xSIzKdA0lWF1ahtqOqtwynqTfbv/O7WE=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;6:MJiG930qka6Ad1KOaGpydK5o0cfNfnEze8I5bjNoIXcwv/1vEOsgxkU8kgrSKcrdWxdohYsxlioNGXD7OUJL11TYLYa+GWrq6ktFABV7Dyj3BPPZacPYmm7lXKiKImtT2o2eNceCqBliFIhyiUcmVPK5OOpK9CVeBlvtp/Nte5ZThvHGfIi07pzDgHO7hDW5thZuoZ1IC/5qPpKL1eb9YKSTRNd6XfDbNC/VR9HLjkBDenPT46YMQTxGdkyaaNIZrdEYm5pdFwUd+gyuGweEkxDhB+9nS2gNNWFkzuHwe4MavBrYxi0BE/qBpcC1eu0SNCqITkkE8kHexAbFr0TXga8pRXKZuTvizyVf0jRbBes3Zzj0noTennZs2cxl9X5mtZZdS/R1S+irvra6b7rZB9grXR5pODLkHfpljKbyqSC/tWf8sObxSmkQyD/+hYaY2A4fOtQ3j6AD+Mo/w+Tteg==;5:NGsOWCzV6/8KeuBPOTc8A+5m0FX4lC3p8OgaxubuRN4KF7d6ZObDSplCYnD3CloRw2DuQZCud4b49eG1jb8+GB/sM3Ou6IBIS/vuCY70UUryPbhass3dJy+OzXdKyA8XnnT4ngMUks+XjVhkCRo3UeLKgJHB7UC6RHuoFFvwxB0=;7:lau8Gu53b/a7gkcdlOM8P8ZyW3OD7AjfjmYu2iNFFXNCJvOK92fVpmASi7FKk5ugtx/c6zAFNS/0Tiew6s+CTq1DD21nelJyIt12jzsDy5b4essDeOMe/kuXfOk/nufXrKqUy8aDWzdgrg2Kd545gJ0CvVQSm8OH65CsDiHtMuxDk6RDn3xs6B1EVo1AYCWElLe427t1tqm1jgWdhvFBAa/bcSFKStFCy/obATlrPbayKgsT3VHE5DxWihQGRT47
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 03:07:14.3239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f58c90-e7a3-4fcd-fa2f-08d60d5c8658
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1579
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

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---

since v2:
 - Add Fixes tag
 - Add Gustavo's Ack

since v1:
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

