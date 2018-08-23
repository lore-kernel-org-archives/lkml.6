Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79933C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7421530
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="II0i/UJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B7421530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeHWNkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:40:18 -0400
Received: from mail-eopbgr730080.outbound.protection.outlook.com ([40.107.73.80]:54432
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeHWNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHSZSuyjNGrT+Sf76Mxn24jsh+NJ/0VMIqAwG89hV98=;
 b=II0i/UJnI8SEJBqwXhHSdNTAFkADBNO3hn8Itwe1NPXycnktJ19KJhQYJJhSqVVqPhYXpDRYvW6KoYRvXGgUx/yva4rEU8l3cJDCojXaPRPSLgmFaen/gAn7pO9v3i+Nw1Vt34kRA/B87hEmUTkkCupZXmEb2ikJE1tasD/nx6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1584.namprd03.prod.outlook.com (2a01:111:e400:5232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Thu, 23 Aug
 2018 10:11:16 +0000
Date:   Thu, 23 Aug 2018 18:08:22 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 2/3] mmc: sdhci: introduce adma_write_desc() hook to
 struct sdhci_ops
Message-ID: <20180823180822.7e904f73@xhacker.debian>
In-Reply-To: <20180823180549.78e508db@xhacker.debian>
References: <20180823180549.78e508db@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::34) To SN1PR0301MB1584.namprd03.prod.outlook.com
 (2a01:111:e400:5232::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a759829-6b39-4e1a-d4e1-08d608e0c41a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1584;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;3:vtRkCvRmfvL/hYVEl9lJdTyq+HucFaH2UIMIkrQqrQ3r4v4sp1LpJ9VEyNbsTJ7XXpd3u9GAwoeRLXuPpwfRv4FxqX36C8bMKMKKWyWuUdBjpUuZkdqQiISMAf4zB59YQIFanWKCIaGYVT3SDgH2WBBOtCGL+Yx5UZoDnxOn/WidWZ+aZhgUBK9B1krztRTs7k5ER8432fAOtXYWILV2b+1KhF6px/pmp8WAtnG5t/hy1QiTgZxAaseImjaHuf+r;25:thr29tHJonoA16VcoEzb8pmNEoKQ5CJtELj/eU+DHv9SXST77QfxSoMND1AE+UpbOWsAbqbauKjxV6mkURWuKiS10cTqt49QlQECoGcuX9NGU2yEts3ydj9XqRSLk1V+XMLFOQRI74KTG2+hvPCqEsDhtF66oM8m2SmdkrxELx9YtleB4+QfDOmuEhOTOEaH8KIIHa3LlKBIyfs6esQ029c7X6HjIoGYit09SlRfZIwoghGJEf7epwGcoULy8yATTRkBO6JNWO+ziz0yMV6pwqnDxUk5rAMK5UjKlAyfxye8WxmzAKNZTlQltH6ozfcFSwzLXEM8TeV/Jd2OO7zsFQ==;31:A0bfOGHL/lECFWut0io8fWI04dzj597THxqShFTEzERuSK9YGuPP1VHsy4kPuiBU+bs9KOLBZGKoy2vSbsGiQVvqN3RnZRacCi54fVZqdbngAp860b9aEKOswqNjZWrKvwfESWG7RAgU0hMoZ1fv81pm/2q7JzaIM8QL3tes4Uw3CgQlW5a7Yqym4JYVlMZQhD44ZPSYefihnlMzYhdQShD0n9Qr9HGWB5oeRCfpsz4=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1584:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;20:lNlGD9QkzpWSdVvNB2sYwKui2COfXXjRBdh01yHwMFJ9uNSgQbyE5LhbyLx5FgkL4Mq8znLhv3gVx5WKz3TD/WJ38LdXuujz+ROrkj/qAWYn1YPIbkQ/ZisVh+3RUvyjEJbrfNjT2gc2gTWWw2P6A+3B2BHKg/7PzBI1uTwikOyRIIgaoJ2/0P/IeVHdq7oifu9FCi/OjtfW/9EqEBvPqcVhn0vs6w8XCG37Fh5Sx9ZczHMH4H8Xd3EI5GSP2gHoXProD8sroah1aMrvPl3anr/JrPrMVMc4dJvXaDp6TlBi0eQFFCgTN4RcF6vWcm9/jUBlZSzyqPZmMp8wDJ90FKg8PO9+JVi/HYz+it4jNmfT1Tybg3jr9KT9YpbjnJiKDzpLI159riTW8NKyFTBomY4TFhuLSJzo0vufoDjTpGJRolhgwmGWNeU6I+DJf6S/PRmI3qQ2VYq+pEnM4AdtjUfauhZwQlxE82YDqfhxEsgeiH4Ls31jEIrveoBswRl9;4:UisnWzMJfyp4aUnN6LI+I+dWPBLQ0REUKkBgxge4PQvGa1GFvNP2D5zY1Spbz5RMkZvRL4UZ7EEhM+6Eu+MXpK5vzyyCg4ZAI3BxIVxO2z+MUYOPMl/m5HJ8wIYWcFGRh263Cy9ZrhqdBRoHX5F/fM6BntsiEcq5N6qk1plFd06q/rdtuJMx1olwsEtX9SI225E55EzQYAkDjAZDCTRHyYXH1ERvbeiKSi7PWg1b+JjUTCho1aplrqL+P0JguMaYMKusgBNtEStHFEh3U6NX+Q==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1584B6813EDDEBDE2BE53F72ED370@SN1PR0301MB1584.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR0301MB1584;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1584;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(6116002)(33896004)(76176011)(68736007)(3846002)(23726003)(50466002)(2906002)(1076002)(50226002)(14444005)(305945005)(8936002)(106356001)(86362001)(25786009)(7696005)(52116002)(7736002)(97736004)(230700001)(81166006)(16526019)(316002)(6666003)(186003)(5660300001)(81156014)(956004)(47776003)(11346002)(9686003)(26005)(4326008)(386003)(6506007)(54906003)(105586002)(110136005)(8676002)(72206003)(478600001)(486006)(446003)(476003)(55016002)(66066001)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1584;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1584;23:q3shqjl0WNRsOm7UqLMxA6vHJs9TULO2xho0o28?=
 =?us-ascii?Q?NSnMdJP4qOyDtABmfIFbELn+SxDOBI2wK8WT7TUJO7WUQWhtuBopVGR0pLcc?=
 =?us-ascii?Q?rY/hRoeO3vZ55yhA2Jnh2iuL4KU84z0mkENSf948cy0lvCFJLorM65eLA4tx?=
 =?us-ascii?Q?wLLM2aLWQYT9x9aRR6sTqJ20P+GKF3z0Web5cp//C2PJcDQSLX8I0mj9Nnc9?=
 =?us-ascii?Q?OixaJ2Mx4iv2j5lDDwRQLTH0BJG2vJblioksnnBSKNiF72QjRI22Hi6YWfbn?=
 =?us-ascii?Q?oOkVh5FZv5VBzPZ4P1AQSDlYfxucIbiE+GTaAqy7YODrDgUjWt9apvyyrbm0?=
 =?us-ascii?Q?mYjVHqY0HV2coR0JIBm2QC+vwM/icPNH0a9xncBV8AK1ohREVQ9nyq0BbVsC?=
 =?us-ascii?Q?VdAp+DZXFne+5DPE1ieT2KxcbFxcP4GuisrvENGS6Xj7bO3E4NvU96IOt6VY?=
 =?us-ascii?Q?s7zYI2fVGFU2pXV+EzCdQc8d/pm8OocfwABw+sz4E5I7fnuWvIlwO0/UFiRe?=
 =?us-ascii?Q?SUlAvGe0ge1nLlwuKNLsNKd5LXUj0YAQ9JqFzn1pe91I54FaHW1CuQf5sBey?=
 =?us-ascii?Q?tPMnsS4OFjsuqYEwKGimokGSatKx6YEeNf7hd0yxscdtWY/aDixVagnP0w2t?=
 =?us-ascii?Q?pf8XODLVw1CIXEKmzPvvh6of3jQAWn34RnmOvonY34sXeTB20IF0IKuEAUas?=
 =?us-ascii?Q?6n5rlWioxgWrgNxF+/IEcL6GHbafQsOA/o2fqWfXrCoyN+CR35uUNzdOtqDD?=
 =?us-ascii?Q?mnahc1KlePLtC7PG6OxcuhrhU667UDTzGfvjy3nQdmI7mmH5NLvZ/UBBoFFy?=
 =?us-ascii?Q?zjBPcG3F/lYVz11PnohwutNKMQy/yzadMCHZwKq0BMxbwdoY4CKk8kI0E+9G?=
 =?us-ascii?Q?gxOCGRmXqqKX4pmAdNln3nYaZipwCPz3bECzQ8v8UzZcp5Um0Z0YMJtPbKnB?=
 =?us-ascii?Q?YpQW3yyHsNrWgcvR2J7bw8IqGjY4uZOZ8SflEjffWRvg/79FmpdfaAmEo033?=
 =?us-ascii?Q?6G/0D8mIucRxWMGFB2bXQu3GZo8cAeNWvoeN+3sLz2E3xFXe2QwH/oO+Cn+K?=
 =?us-ascii?Q?pSQEu5NH2L0ynkQaql+MVkP69AZxHJV/Q8NfHz2iPhrxujnso2dbxvLPqVVs?=
 =?us-ascii?Q?9IBGE5cb02KFJ3p5fgllxxZBgpvtmC/jX1/PfyVZZ7vglCCaNM7hWb2idoFO?=
 =?us-ascii?Q?R9LGEclJFtR4c6wmnOlk5Sawj7cCVq9kufpO8cUBVu26r4B/9ZbmDGU8wRdJ?=
 =?us-ascii?Q?iBg6RnJyjKwkOp7UK3zgOhQQ5xLWjnfXqmVk80CRr?=
X-Microsoft-Antispam-Message-Info: s80DVqHr9IJmdeLkcIPfYHTFBCMtKMRHEv1nXXObXZVFwHkdbapo/7vEULTopen3MLeP5neZqvDwFvBw6bSuGRAiQNYCH34WD/B77MpH8nIZvBdLL2mTM+MgDTjb8Ebtl9UIQktqKKx9WWqPHqocNj0Hmmejl423H6mPAYg0+mDcrG6OO0rKa3wfbZjSDYMwAD8MPvXt7l1ekyPBIBLO2FLDKrs3cG15ZTqBUU8fuEfe9MbRPsXqNihI+AmB+2lw3WRUAiQXsZb1FvCm5cj/OfNOu4D+WRCRR8Zy+3YTtUReu3MNcc3UwxViHfK0isigH2wFdITY0KkF/NgRejfA1N1nZwyZjL+xcoXTS0n8t88=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;6:+cXFhbb39SRQJZd729J5mWdt2krXN7X7eVAMm9prBBg85cTcrI/jU6dh/Z2vySbyWg6McggxWQLgpOtzXZfPGZgu6YtkXoCUtlW1e0xUSxGVMORy8r2EMNk2VNcO8IBBEhd6sAwHFV1r87VA/CdZTGeNAd3x70Mse/YMDScGuZSoJvbmouatSk/4iIwVRQseQ+neB1OBuC991yDvPQuxTLQPZtsYih7XPbo4npZfDY6/66vr+5C7gY58MW7wsZM+kuzVRItnl9U+V9UUftuJPCwJMNNq21NJmWQFVMiHUQwNXesZs+9cGoF/fK7WGUZzK4/aiftn7HqTz8pmE2+qMxMLt4G0NwKa3X1jfqyD1Sn9ohZS/zMW4WrsqSaDffCBjEL1e4y8KkGWk4lePFyVX7sK2SxBT+3oS+updHuOJbb/Fd5CpkM7UYSaEDycuFMT0azRpp3G3NKFmAxPkresMQ==;5:FMy+3tQpU0Sipuutc99Tj/ifjGuZ/zOxOim103okZUTOWLj4Xlvb06JuEousgsPCXku09Ha+/Td3L+s+wEwmdxB1gcD8brIb1pB6Kia+5Tc4QW0h952CjrThyUhI8lj3VX7KcAVeiESXtUbPyIVgbxPdBIMYS4EjGUm2iklkJAw=;7:8G1vtTEqorXc2dTzve+uUlPXKO9kvfVvvvaXp13HxzjydqZwaubLbjk7IZZaMtuijDrrBDMxA9q2MpdE4mdn+2/vg/Ly1EOiS6C5odQfgX/LE6AzyC/eVv+U+G/cH5/m3gaCmdW1TDW2Rs0AWU1GelawwVim3lzOBohPQUESashOfnRjwag9nA+wjm1LEALsx71lr3noWsc97SuDgK6stNbfvfwyvS+APnkaYsydH9TJcSrwXahDBd0aiD73tYdw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 10:11:16.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a759829-6b39-4e1a-d4e1-08d608e0c41a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also let the original sdhci_adma_write_desc()
accept &desc so that the function can set its new value. Then export
the function so that it could be reused by driver's specific
implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 37 +++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 52ccf4644384..eb21d2db7f05 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,10 +554,10 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+			   dma_addr_t addr, int len, unsigned int cmd)
 {
-	struct sdhci_adma2_64_desc *dma_desc = desc;
+	struct sdhci_adma2_64_desc *dma_desc = *desc;
 
 	/* 32-bit and 64-bit descriptors have these members in same position */
 	dma_desc->cmd = cpu_to_le16(cmd);
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	*desc += host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(sdhci_adma_write_desc);
+
+static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
+					   void **desc, dma_addr_t addr,
+					   int len, unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -618,28 +631,24 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			__sdhci_adma_write_desc(host, &desc, align_addr,
+						offset, ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
-
 			addr += offset;
 			len -= offset;
 		}
 
 		BUG_ON(len > 65536);
 
-		if (len) {
-			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
-		}
+		/* tran, valid */
+		if (len)
+			__sdhci_adma_write_desc(host, &desc, addr, len,
+						ADMA2_TRAN_VALID);
 
 		/*
 		 * If this triggers then we have a calculation bug
@@ -656,7 +665,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		}
 	} else {
 		/* Add a terminating entry - nop, end, valid */
-		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
+		__sdhci_adma_write_desc(host, &desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 25bddd21de31..2115416f973a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -606,6 +606,8 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
+				   dma_addr_t addr, int len, unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -736,6 +738,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+			   dma_addr_t addr, int len, unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

