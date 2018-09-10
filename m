Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D548BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDFD20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GOmpYLrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDFD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeIJSpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:45:06 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:34336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728635AbeIJSpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3LUbKn+NfpULplUoriITqfUZ0k7NzbW9xgQogrfMms=;
 b=GOmpYLrfs4nKBREeceoYt7nf1FiWiioRSe6CXLrLOiSOtGOY1qbFaBN3EtN+bIzl8Z+mslMFoBkIDHTzlYEqmDcLneE6yMU8FBK8NH/GdOvA8IYaqdRDiw+3fw0ufKL2tNiY4k1KCD1mkxnT42LE+/8AJUPmXnpUUWCDSveqodU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:50:34 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/7 v7] bus/fsl-mc: set coherent dma mask for devices on fsl-mc bus
Date:   Mon, 10 Sep 2018 19:19:20 +0530
Message-Id: <1536587361-11047-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::11) To DB7PR04MB4476.eurprd04.prod.outlook.com
 (2603:10a6:5:35::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcf6cb7-351b-4311-5ba4-08d61724642a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:d81IZH4A7x9ZZRAgyBBjvBH+a9cdkMx37SzZNM/9xIqHMtONpTiABrLr2/uWnIKo2VO432VeRLXToZDPhKwS4AdvptCeFYk57giIWsEJ3qUWVctlJTqXFjpdVHcYufkKOTiovD9tgwnmId4hFJhvmHxpbb4e7VeV0rq7GSoiFIekoAZLTYll3e3S3DUNccIrCBLdKQmRYoyvF98kEAPkU9WTvmH6Ajco/CNwF4G+X9+o11G2J4U2bjP0EMLhm8xd;25:pfAm23bWDocHRKKoe3RzIkQi1XAhWeQ9G2n3T1UBaIlNJPgcr069oIFUTp2/wqG4Fp4tv3h/8Ku+MxXQxFBx6vEUZmZmZsTdN2gmZFzm6dt+2h18Zp+qif4nRSX6C2KWgZPsy00ZpJXIo6zUtOqSji/rQmpMnKMn/yMgpzH++WAjbEbnD2MHeILChmaN6BLPiMugSsBB+n0r2qUEphKvvmkZtdAIxDdsR+DeA93sooq8oHfiE2+IGps/bm3OgjKsoYRg4C8VkJtJNcJU+OmYpbL4MreO/c0MygWmFlw3+Bs+1r4hxLhc6Aa7c1HypjvhK/nm5Uwbo+9T/jrWcvXW4Q==;31:kQZZiSNazTt6hsrac/lhAtf3BM9m+achI2//Y4dHuR6FgKRMqHDmgOBxzc9jFIzyeYwtKnGfmNIQ5l/Rwu7Mhhneax6UikGWlGhUJJdG9K7nUgUrZIWoJfKfYh4ZJEW8/SmwpX9mdlfnBkGBop/8mcyXYLOwzMoi7UO6/rEgReJA/nr10BfGlbQBk5DC5gpIHLYvlw2JQdYXC8CmmsvXVqBxYDVatfhasCq8BV9vPXM=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:AXaoYUEDppxwxy1PJt3JUKySQrRq8RLH/ViMOm7MBGa0moIskVEmeiHdFML+Ns/ewmnQQPTywJpaqoYiiPZqP2UGmTv2qLjGaLE/u17fdyuTns0JnbRWCekmWyCx+K4XXKSgLIc+JrBavkHDnUJyvACJVTv0h0p8c89tSeDxsS/dN373F7lniEAaPs4GCfG255iF3HzgZB5ns6y+aj8X1b1auB1E8xzVRXWOSVlyyIDSJbNAeGyp/lsnBAgQG+4mBcX81nqC/gXeQNHyNP1oC4PGoPxs1OhlzeBmWUEi/aMnCYzRwHKUBlbuR7TP6PjogIWow5dnHaGzwWkIUq2+RQ1DIJc6RdAHRs/j3XyCCgOmNH8EbE1q/bQ1lL0z/nfZMo2misF7wqvzHiYHHYJhiSRE4wiuQIdg8YxkEAqoEQ4pI58vLUXjrOIG2uNQTWn5oKxdsSmaiCIFn/qZgQ0TlmcM5nQ23PFqTtj7Ck9IJB1GuZnl3+rshl6IGSmoNErh;4:je73s0lI+9K/1V1YvApYhaoT8ozdwh4oqARpA3CEQ3iE0icO0g5gAvbMw0Atr6a5jwOAr2h7Pxm0gkImpRGK26NnL0T/dMesJwHiXMiWywvMbnqIBOUbPcjMeYGTcaqna56EMSyIZKm0/bQ7D83jV+wmYD9PsPTzR5ZlF04z7+iUMOu5LDd6USIoNnL2oOfhdF1FCjG0HUl+XI495iqrg2ujjKXCdRvMWkAGSWORVSdJSd+dZZE2W8NX+R6uAdNQUEQfVveuDuiSYd8UtWcYtbGpswV8nzg3yTeWz8EuIvQnbY5aD7BZFw/vOz8CbNcntGEuqqY3PYrh9OLVTmvAkf8U8zFDrcT6gIzjUO/Min4=
X-Microsoft-Antispam-PRVS: <DB7PR04MB447648A86955A7D081B14798E6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(476003)(26005)(186003)(66066001)(486006)(11346002)(25786009)(6506007)(386003)(50226002)(446003)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(76176011)(39060400002)(6666003)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:S4+7EpQcb/WmrS+ejibPdeZQ5bfXi6OKqulM+QrN0?=
 =?us-ascii?Q?gynfoCvEHpDbn7cMtlnWbScU1nqsCy7HCzht8BmVw7i4lwD/h5qw54PTmjaC?=
 =?us-ascii?Q?jqvNFmCw1uxZ2HXO7Xbu6JYMvmuEbBWdzRhhH9n/z0vEKRIBF14VMNPVv/vM?=
 =?us-ascii?Q?gIuRHn1ZPGctD5vSb6bCeWuEiCJJP+pAbC7ZUnvYuukttWB8LS0iIOQVZUqA?=
 =?us-ascii?Q?Szhy6j98sHfV4brZhSuXT/QIEHEe+gE/oTtNr8UkYV4KALaE8/JIE8XYcaSl?=
 =?us-ascii?Q?Kn7e1E9ncvo72xrfsyjYFnUG9Dd9/m/L+5pc0ROEa3aUYsVlOyyjPc2/HjIU?=
 =?us-ascii?Q?rL2HlzyAqmFt9huNqqGOQYrEDWX7Daiq0JEmNjcE/Mzw5Jw04YdiM0d3OXPc?=
 =?us-ascii?Q?daivp4vDQIq1EroiS8x+KSgmgikZcphyNg24zWoVBybSKhJdTzPtrAhe+ttW?=
 =?us-ascii?Q?h3x9Vlm4JDQ7dw11Hx6lvcdCXPEyGfp8bB5gNDfuICucSplxAGnlEJDmJWgG?=
 =?us-ascii?Q?iBsVMCiKiNyQaf1as2mFQsTrQ60LydpAzkraIeKpGrRDzJ27Bv82N4o5ahXq?=
 =?us-ascii?Q?wJxQzi0m8IZlfqY3yqwYbPdhbrh5wZTk9FwLBt3ZAqq6Hu+PVITiPIaMR7u7?=
 =?us-ascii?Q?BoArh/NQw2VNQ95vfwLNZi4PgzPCf16w1v77XbG7MJ6pE2517HxhipyuAvdf?=
 =?us-ascii?Q?CO8PqvjGadn6dk0eU5QM4yMLjAjlCKcpaBosgg9eHwAzqFCi4vLgw+ES3xow?=
 =?us-ascii?Q?UzegFF/0VfXPVBSknQMV8hJXZ38ZcRuC5GksUqAzWF8wXljAFE50c1D6kkCE?=
 =?us-ascii?Q?Dlz3FA5y8smyWNVP6kh7EDrenXPnwvIad2TMWOWpuRclrfZC7Tl/CEhgeJBz?=
 =?us-ascii?Q?TE5d/rpeUA18Y+F317dleCHuwOhvdIghK9rEXsyJKpeyx8wAFMo0y9PlYHGZ?=
 =?us-ascii?Q?FmuuFTDOJ85RuPvISLGBP3A0OqIK4+eaBRSNt/sLkW4JQZ171f8ROUXr/L7g?=
 =?us-ascii?Q?/l/K8cYisaquQWMoeMq7PBlhNP43sE2GKKs0U1XzoRW36palJO4HoOsEK1DV?=
 =?us-ascii?Q?SesLcmOYkvOKOeWZnm/YKf+anF8/z4Y9GX5WCCrH9SLnI7cqIVxZBrX6IfvA?=
 =?us-ascii?Q?6cAON91gHkFRxBkGptlR/dIe3XH02O1dBF+WKIZA6h7KHf3nb6+T5L0q3gAL?=
 =?us-ascii?Q?gtkf65NfFj8h7mPo/y4CGPzL0zeo1UMQgMnsdpk74tRVz3MhhhrIPkTyn96l?=
 =?us-ascii?Q?uJUF1r/dQdKKDUqMoj6Y+i4SJJCSl24bqCpMXWFO4GQ5hfC3Tup7uiOfWviF?=
 =?us-ascii?Q?8nRJSn1cGY7RFMlNMpBk29Bk6GP+ZE+bk8RaT4u7m6C?=
X-Microsoft-Antispam-Message-Info: UlbCXF+W5yC7lc19nPE7nbo1lcHXS79pXmXpSDdVZsf2hHcaBTgHf4eaHlTuQNvCFviwR63vAdSjwuPCWb7xtqOU/nzt8jkaIO74NGeb3R5JafpL8Fxl7am46ebX5kGeJBu0GrWnvYQfyeAVh2MNtZSjzdfUKU7sjRXFeHB5yaK9JGxJLtqOoHTXDk2SKlgqkyDXujcvih/FulZwXF6hInB0Dv/RThj+KbMc+Vn+Pwf+rrAihJ4eR2Nb7D3rUkdXkkHzyd39cVlbHT/8uZgjSfyAC9W7jHTcxp3usMZYL3sSltgI+BjpnCnKaG74Y21SYhIydTvxcD9A3kZl5FZdtgBghxhz+uAE8VoMJaOrQJY=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:DzEUXcucMSwNryAZLU7uYfIxQw0LzXY3kWM3z7UMYY7QWDcAstFg04smAA75Sk2qDVgc07mI5+X7pQeR7CrO3v3Xl3wzMY/+oNPQXB/ERZKypBLejnF/KVV0IzYqS3hLkFiVVDA0VDjkyM/NCjeG4a7P/opA3oi0G7GiENR0F5WP3CjjT5wwe+z2zyTCP0poDes1YR16HAswfo2gIC7++WZ+3rPxitSxjETb5yM3FmTMNtT1GRVsi1xqCLGXkzPtbWSJwrkbImrTnDZi2gImEkYqcl6CMFFoWsDPhMcEb9UxEM11on4afcRKL6KvoJGuVr+DwZwhiCvmF8uve+XjdRNTUCXEIyu0HHZXqPK/ynAAtE7bvOGgBzv4utlbZpvzDPK4hNkAqhuTYSL/d3YrS8akmw6MH5LbWRqFfJICgn3nnN3zt9mrg9cxbdPn8abdJtkYe2cByRUjBg0L4GSUxg==;5:Q67xYTBZpNg2/SEOcD5GjGEgMedhkPlbDXDy9EW53rXAmtsl69kTsFUZyeBQgazVwOE4zZgB/k7XgD46Y6mlcqnxQb1V9qjFrORdk7jv9IbH+dACsOai5R/zInPbW0siUAsXPrNWWpgRfQVXpwM/lhSvdRBEHvL3R9ZcOOI4Owo=;7:gWw2d276lOVMOeJ63IZKFUUgZZChsGTpbPr8nqLlGv4q9zfdYbpitMxIOQLrs2wThv3kCELbsdXe0yvIYQklqlliRyCiFBC8lw1aekowKQrBWIzdmz83/F/hpl28zqw9uLFDPEl3nypXGJVDQRBRKpy652K1LJiNdl409sPBP8SY0OXVlPsr3C7R01X0nsA8aSRbrRctNN+dUgUOc3fTqrav497q4WTE9ljvaN0YyjE0efScykZzwbQXqlpTUT0u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:50:34.4382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcf6cb7-351b-4311-5ba4-08d61724642a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_dma_configure() API expects coherent_dma_mask to be correctly
set in the devices. This patch does the needful.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index fa43c7d..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
-- 
1.9.1

