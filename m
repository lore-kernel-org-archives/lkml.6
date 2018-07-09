Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1420DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCA320881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SIoL55n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCA320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGILTX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:23 -0400
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:11280
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932770AbeGILTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngj95YNmm4wbigjDBUZoc9Z6XrAr3QNi+1Mnz6jA708=;
 b=SIoL55n5TBRKPMvCEBWRSfrSEbo0cXnjK357PZt2FVhZ61M9CawNVfW+JJIkZV/uAUJBP8NipvFRgjsFNQRupebFOq9UFOIQM2uPR+ISUFv3q6tZ9uEwF+6NQ2+RyZcG7suZk+rV81C63BB9Kvm055LPwg6UyixiOEqpaPAP0BE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:08 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 2/7 v6] iommu/of: make of_pci_map_rid() available for other devices too
Date:   Mon,  9 Jul 2018 16:48:18 +0530
Message-Id: <1531135103-10699-3-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce021de-9d95-45e3-663d-08d5e58dcc6d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:FzWugWILTAmIjqKmWTGb+y4/uYj+4KSd4+Jzr1p0z+bwssk2ev4RYh0fFh7M2E9vodYKMlchgqsjsoqzMRo/nR3gq3z34Ad9lT9NMdffngNua3YXXV4DAxoLw/8ksAKh3NKLs4eVVJA17WeDmmJyXFBEslYMANtfCBI9Qpi2/I7AKPugdAArvWdYqg2pQRaAWcrI3HxrZfVG/lr+WqGkLAVFipueePusd7g4PHMeSYsADxRKKR6rsTK4BTZ1ZwPI;25:4lFlSIhIcp8pd1Aem1TBELm2JgvhSZumTmRcIpbq6zA3aJPSsEBR6k5qlqHnez1hdPU4RHk5zaRaCi4dZUywKRj7bg7osbGXXjwuQF1tbvKKkNM4YPDEOUxgc2Oloii8NXYA3nwHZiRit4mu077KJm2NgZJWbjgD1kkb+pscop5vm25hlo67Cwt9A1c6+DdnwA0wFRIs+ymNg4MdJIIJFViXvFvVSEACnfoSStCHR2O7hAQ+2ZDiWgOzf1F9P2D+fbRbLBBbrsR64n2cpbn/oL2KP7B+2KYaLmym+kmuGPmreZJhDf83a5XE6P6EVOPHspUSi5sCFGPNikZ2BajyvQ==;31:f55ritRkcmw1r4eWcoNekIg73wowkhDOQHvZ3BmTJjIlbFIXDUEjYnZ7B+BzP0tlLZ5J5Vzjpczz0EC3qfSWkTdcXxjrWVCG5+rutihTTG2w0csUpC1gb/qWRDyrV6w1xb/q564bQSFYGgj9C3x6VmopN3RibPBStb2HyNGMYiuvdtKyhgd/zWurhF/4shAJYYHQw+cVZTEFQGetzjPBeAOSRuCuoVvym5Rr1e4z5Pc=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:ry8GUIi6hWJgOkswCx4EUKezU3sARYYAZuVwnngYQHR7NjjCyKJ97irJyJFv5RVJ9NLOFN7ODPkp8Dw7VxucQ9bQ47mb3TqLvOCxGkyCEErYdbchcBkipyjkBaWrNUTGI9hZMlVu2MbdCfoCz7u53gWUWRFtXRKSTNEbyvu+rdJpSN1CEJ60qB/naSe615wQBgiTSYXDMYpB4Xjyxy0rTIUtsehdb/LubxR6BOQW7WzO24K0N/ifYBFMqoFoyxIBBhOr3+GiOJ92LJSTeF2TfuOhIX1SYiKttTvS7MN3Ivb60PAWb3MOaCVKUDZDsw97V7gcgxCYihKpW2ua9+Fp8Vuzf5UUcR5DmvFR/cxXD69UbzUSNeAj9fyH6yrN/56fs6ArMqHR2Bj1TDwlElEkH5PyV7Rg9FrpzdGvjCLi870a4/6Fp2YGxFpAR2tjqMhOpJGUxOoBFM2rlKOtIiUUNUTZAXi75si/yfePnktBIJ1R7VukHVC0InlSvRr6xaRt;4:bOkTEiAC9XfZnVFbmiLKxev58hWvhTg+mH535ApUdnzENH6ukz14sfj1GumB0TFe5YTOltydtDwDeSfaVGGGqI+3F3bXtTBWeAqkEOSJt8UBufVdZ5Atldp1/g/wE5WgF/fuwTTutYoTQws1xWCwk+lEcdy4tZExzB9STettmS5g0YMCFEoBwqACuWfRVhU1HK3xrkBcMdZqBUkokZL41MtnHDJfPbRB4jMrMaOoKkSTyp7umKERHG3BHq29BXpGtNPl1ZGTDxW1dHkllJe6o56l4aPn3PbxEmfFeJd8q/3p4JdmKdNddfKdvq/HVvQ1bA3mu53e13xY2i1pwishjBCMJ6k6pVFHDtPbb5TO+n4Me6KRW90gZbPf9KI6RLDQJ/7k5rCIQGF4p8+CD79ubWh6sWGrw6/bpOBSlMctQkY=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2427AD30C5DACE17278F43B5E6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(14444005)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:72rz2jZ2a59AHrjNeU8KoK5KtRf4Ck84wafllmH?=
 =?us-ascii?Q?gdyXpG9H9w5ByhGcQ7n3rBg4vhxDaRe6eayUDwMm9NfQiMYGtzXDYO0Hmhuo?=
 =?us-ascii?Q?qv+fEng5rStYBx07tbNSc+NuftWW+zG8uv/XIXvng+Afsi1oQsaAi52FkoHS?=
 =?us-ascii?Q?aH3WeOHc63PKDbJeVBdcORtLzJH4c037VCWYRpmB+YOTIInPguyVhkjm8tMH?=
 =?us-ascii?Q?ByvJIp5YoEv3MJeEPw/XX2WbCd//HE02wgFA7dgRdazwZnbc2kD9BKCA02x7?=
 =?us-ascii?Q?t6pO5H0ud3uuaKyYOfHDz+6zwFQBqVFA1cbydXsHyUJdy8fAOtyf8mdsfWQC?=
 =?us-ascii?Q?dgfJZ9J4xl7qM/4Y++gUOjqrAAchXJ19xsNjCOPu19MwQpTMftqmetuob+Iu?=
 =?us-ascii?Q?R36gbPo15joJvaO35xb7ZsvCXvuxeaaiO7LcokZUcRfpqcdf/Br5dXziNYgp?=
 =?us-ascii?Q?jIrVcCCousSNOAprEsupXPhdcPiWgS2FH4RhJi1+3tX5bXLw1POchXVaE7Nu?=
 =?us-ascii?Q?43yrBr1CbGOAVo0PqqYyntzED+pKj4QO3B63Tbblb9H1CuDYbzxvoBfTnjbQ?=
 =?us-ascii?Q?oAm55tieE3AmSJAZLxGeBlruB1l9LaRIs1m/zazmlfrZ6VvD5c0XMZAY/1I3?=
 =?us-ascii?Q?R+a+l7wPzTQVdvHRAfoxbkl1HPq9SqCzsnqkrcegDMHqhAbF2L8CEs0a5MY7?=
 =?us-ascii?Q?ELlDnfdiVfWHzq/FWA003sIQCtn0nOeEmQTqmhdbsmCTHX5jcAoJCVOPyCoS?=
 =?us-ascii?Q?AJW9ayO6LV1yqJPLOkX/dOkWorFwpxxbaaRuGHE24vjlVH+iLxHNyy6DLQZ8?=
 =?us-ascii?Q?MzetT8QxeDhgvYO/fiqYFHOQ1D1N0AMSFhhbvPrJs0ASEyDUG1AGFlwQ91s5?=
 =?us-ascii?Q?x/q7QHcBp3lKKAHxHClRtuzjVhtXK0EzKTqFGnFLiIjWRiiJHUiAd7HqaKBw?=
 =?us-ascii?Q?23Peu+RPpDaRx3Ndt6OEXEnij9X9mv30RSfyiX7sWvrphy6+P93ZyylTy/gb?=
 =?us-ascii?Q?avFaqPuZOixCaiyWBKbmtXKIpEaQtxPtsFdJIoZ/xNHDWgcg7nAx/UKz5gK8?=
 =?us-ascii?Q?EMVHSzo6YEruHT5st1unPwT3wdBaX6vsllBQrvImFEMJwI0yZ1Mvbs+iLYTV?=
 =?us-ascii?Q?f3TW8Q6EzdYhdsRp4C0rvEZK192nqMSSbUKkjufaSfXU1cWci5fhwZbNtV2z?=
 =?us-ascii?Q?UD8pwZe796e/4jMPX43HxE/M8qFxxE/3JO549fG91AJEiChi66Llp8wUsks8?=
 =?us-ascii?Q?y/95zHN/PdljotzN1mGsBAEWIIP6Sfj3o3zqapMrVMnv7qlOFCX0sFBWefF8?=
 =?us-ascii?Q?G+8tUIKkf4k8+FwF6l5MvAXd1cCTTZjd501GXRThyIheei5FPqYXl2woqTp4?=
 =?us-ascii?Q?61Ra7vw=3D=3D?=
X-Microsoft-Antispam-Message-Info: GbBwUVc/rsH7fJsi3SJobbUr1kRrkwIRsTCjeAk9zMJyjXFEHxajwdiMcxsQ+7ah9OKrScQTfluVmMdcWojVOFesHEN0jyklc7nP6RBZvW5orxD2DEuq1JVKggo/M40O8hI9xxd32k7P0lZsBU3Hs1AqjfHmkEoiwcN2xCzwghxXz5m0htkhHod4SJ5kpRnmzeUXwqX7f5vsQxG+73slMY4jDXGOZGIK4L+y2iLgdlDlDfVenRLihTiiXHy8o9otct4Sbv4l1pC6LQDY/4M3GUUAIaVCQjpidCw5mIo9ME+yBtFtDi/k3dD/q6qRrfcF76jXjFbzqruCNQwQwl76RwvX0VyCfiKCditDWgpdMVo=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:oMKTuyjuL0N+K74+eCzmdXmyYbRlBvErNgwK3i5ye8yNcMoWJJ3tZJlPFrvlk9QrUap76veNte1PmjKH0VWuUsidS48jvxPquTg5FdJuKBMhWsut9s1hqIHvzX1bnDnzq5m5tFaLgB/sOVInvjTIrN32YkC562Mcd3hxMl19mEX1GWrVAiVEZLs1KRcgsjmkjJaSfHMFlg1Y9lbOTkh0COyUXGRb1qNwa6K2ef/IBAhPUYUTmmGcka7AB/pdWJDplDsjt8FSRWpx/PFQ87sQG3tXzHIxxbgAaerRsvD2QY40wTTPmx+XJ0sopXUswKXnFf8BZKjF4iRwgB+N/l8QzKbssAOLZVaFqxkeNc8sDhsARuIz9qVnozKZ3gX6WK47JNMQ/pZtioDkhpolV+6y8LVfVfDRf3wbVJxu9rc66Lny6g2HJzQRL6FE95MqOOnYYYOC5svoo5KGr7LQrKScuw==;5:MMHRZ5lCpEzje63yJSh0tnweoIABR1x8QYnWUoEOuOXMtdCH3J2UeXKbPgXZCrGWs4KKNha5SwphxqD0BbTmsjQfKMdq5iqMfXTO61jfRXGnkHnpdrDUE813eRwylQaIv1Sv+ZdqI4ub1jIpwrDl4UxvlGSzh6dX1UZlJa0Zs94=;24:ZAWTo4OE7CQh7Bs4PvPPbjDotg/dIfZO8TNl2FCMsbh8YxMgSPJLaa1ZdvHQbX5MCzOBOcU8fzTmJqS0HwqW4aExbpOF8XeWazMkI7UWg20=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:hZk+O5T/zSp8t6yhYGkgEEkenv78+Dtj8BA1fYYm58LjhbcssI7HTTLwgEcRDUB4Ekw0UcX/0r+witjjmScl/pbU7uEVdBEmk8LYJTFcwwNZJclOybdd3ZJojMRn9YNjJfT0xDUCEd/8b5RBtHDqEGEgQSAvvAsW8gV4kRO1wdvElDcDwzp/B2LCeytyrxA7FbhI3huMmi6bDuSS0Z2vxd3JsnFstRWTh2cT1RnmhF1+yqlKRKOQ3n/jW361xBR0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:08.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce021de-9d95-45e3-663d-08d5e58dcc6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
functional change done in the API.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/of_iommu.c |   5 +--
 drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/irq.c         |   5 +--
 drivers/pci/of.c         | 101 ----------------------------------------------
 include/linux/of.h       |  11 +++++
 include/linux/of_pci.h   |  10 -----
 6 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..811e160 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -149,9 +149,8 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_pci_map_rid(info->np, alias, "iommu-map",
-			     "iommu-map-mask", &iommu_spec.np,
-			     iommu_spec.args);
+	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549..c7aac81 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1995,3 +1995,105 @@ int of_find_last_cache_level(unsigned int cpu)
 
 	return cache_level;
 }
+
+/**
+ * of_map_rid - Translate a requester ID through a downstream mapping.
+ * @np: root complex device node.
+ * @rid: device requester ID to map.
+ * @map_name: property name of the map to use.
+ * @map_mask_name: optional property name of the mask to use.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Given a device requester ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
+ * @id_out may be NULL if only the other is required. If @target points to
+ * a non-NULL device node pointer, only entries targeting that node will be
+ * matched; if it points to a NULL value, it will receive the device node of
+ * the first matching target phandle, with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out)
+{
+	u32 map_mask, masked_rid;
+	int map_len;
+	const __be32 *map = NULL;
+
+	if (!np || !map_name || (!target && !id_out))
+		return -EINVAL;
+
+	map = of_get_property(np, map_name, &map_len);
+	if (!map) {
+		if (target)
+			return -ENODEV;
+		/* Otherwise, no map implies no translation */
+		*id_out = rid;
+		return 0;
+	}
+
+	if (!map_len || map_len % (4 * sizeof(*map))) {
+		pr_err("%pOF: Error: Bad %s length: %d\n", np,
+			map_name, map_len);
+		return -EINVAL;
+	}
+
+	/* The default is to select all bits. */
+	map_mask = 0xffffffff;
+
+	/*
+	 * Can be overridden by "{iommu,msi}-map-mask" property.
+	 * If of_property_read_u32() fails, the default is used.
+	 */
+	if (map_mask_name)
+		of_property_read_u32(np, map_mask_name, &map_mask);
+
+	masked_rid = map_mask & rid;
+	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+		struct device_node *phandle_node;
+		u32 rid_base = be32_to_cpup(map + 0);
+		u32 phandle = be32_to_cpup(map + 1);
+		u32 out_base = be32_to_cpup(map + 2);
+		u32 rid_len = be32_to_cpup(map + 3);
+
+		if (rid_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+				np, map_name, map_name,
+				map_mask, rid_base);
+			return -EFAULT;
+		}
+
+		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+			continue;
+
+		phandle_node = of_find_node_by_phandle(phandle);
+		if (!phandle_node)
+			return -ENODEV;
+
+		if (target) {
+			if (*target)
+				of_node_put(phandle_node);
+			else
+				*target = phandle_node;
+
+			if (*target != phandle_node)
+				continue;
+		}
+
+		if (id_out)
+			*id_out = masked_rid - rid_base + out_base;
+
+		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
+			np, map_name, map_mask, rid_base, out_base,
+			rid_len, rid, masked_rid - rid_base + out_base);
+		return 0;
+	}
+
+	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
+		np, map_name, rid, target && *target ? *target : NULL);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(of_map_rid);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a..e1f6f39 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_pci.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -588,8 +587,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_pci_map_rid(parent_dev->of_node, rid_in, "msi-map",
-				    "msi-map-mask", np, &rid_out))
+		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
+				"msi-map-mask", np, &rid_out))
 			break;
 	return rid_out;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index d088c91..91600e0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -357,107 +357,6 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
 
-/**
- * of_pci_map_rid - Translate a requester ID through a downstream mapping.
- * @np: root complex device node.
- * @rid: PCI requester ID to map.
- * @map_name: property name of the map to use.
- * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
- *
- * Given a PCI requester ID, look up the appropriate implementation-defined
- * platform ID and/or the target device which receives transactions on that
- * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
- * @id_out may be NULL if only the other is required. If @target points to
- * a non-NULL device node pointer, only entries targeting that node will be
- * matched; if it points to a NULL value, it will receive the device node of
- * the first matching target phandle, with a reference held.
- *
- * Return: 0 on success or a standard error code on failure.
- */
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out)
-{
-	u32 map_mask, masked_rid;
-	int map_len;
-	const __be32 *map = NULL;
-
-	if (!np || !map_name || (!target && !id_out))
-		return -EINVAL;
-
-	map = of_get_property(np, map_name, &map_len);
-	if (!map) {
-		if (target)
-			return -ENODEV;
-		/* Otherwise, no map implies no translation */
-		*id_out = rid;
-		return 0;
-	}
-
-	if (!map_len || map_len % (4 * sizeof(*map))) {
-		pr_err("%pOF: Error: Bad %s length: %d\n", np,
-			map_name, map_len);
-		return -EINVAL;
-	}
-
-	/* The default is to select all bits. */
-	map_mask = 0xffffffff;
-
-	/*
-	 * Can be overridden by "{iommu,msi}-map-mask" property.
-	 * If of_property_read_u32() fails, the default is used.
-	 */
-	if (map_mask_name)
-		of_property_read_u32(np, map_mask_name, &map_mask);
-
-	masked_rid = map_mask & rid;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
-		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
-		u32 phandle = be32_to_cpup(map + 1);
-		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
-
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
-				np, map_name, map_name,
-				map_mask, rid_base);
-			return -EFAULT;
-		}
-
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
-			continue;
-
-		phandle_node = of_find_node_by_phandle(phandle);
-		if (!phandle_node)
-			return -ENODEV;
-
-		if (target) {
-			if (*target)
-				of_node_put(phandle_node);
-			else
-				*target = phandle_node;
-
-			if (*target != phandle_node)
-				continue;
-		}
-
-		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
-
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
-		return 0;
-	}
-
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
-}
-
 #if IS_ENABLED(CONFIG_OF_IRQ)
 /**
  * of_irq_parse_pci - Resolve the interrupt for a PCI device
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f..f4251c3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -545,6 +545,10 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -931,6 +935,13 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index e83d87f..21a89c4 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -14,9 +14,6 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -29,13 +26,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -EINVAL;
 }
 
-static inline int of_pci_map_rid(struct device_node *np, u32 rid,
-			const char *map_name, const char *map_mask_name,
-			struct device_node **target, u32 *id_out)
-{
-	return -EINVAL;
-}
-
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
1.9.1

