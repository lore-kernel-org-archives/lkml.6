Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx48ueaL7+rOaHanhoajFj1FRBMDrT9AjBe54jypK+VQMPXwlqaX4GO00zjseVezmI3XzB6sB
ARC-Seal: i=1; a=rsa-sha256; t=1523960836; cv=none;
        d=google.com; s=arc-20160816;
        b=MoaTipEVSKk0KF2UwkaGnFcrnwR6Eu8tEKJEUdrNyAhkCnHaZPhLx/v9hWe1GefH/a
         62anl2JziAGoVflkP9Wx7FVy++kXiH9j1dupxHN+rC6lmoxejj8J2SaPNtoSawJFoXA2
         qeI5HvnL0YWeyQtAaLnz30IQe9hzsGlcDI2QKb4vyZgXRLlzZ7jMhQkX8+ISiPJJuvoq
         BmL0qC+zVFJGHAoGqIPii3oMYfzYMsIDGsvAbInP9wVllEfKDWLxlHi3fMyiggvy4ji2
         c6yRwKX6RnIfRQueH8BId7zBr71HhT3/cpmd+3gysuPUEZBHLuVPyLmz5NFHSvCdpaHO
         6fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1+yxw6S/vp1VSFuGYRtrGi5r7mrmL3b9MhCxyfdDNnA=;
        b=MMu5Bs8Gj7bBSt+Wa8TjzcaoG56t7DMTumOr2uc9ylUPeoZ7pHFtfOizxYbyW+99sq
         5c6zreCv2CUgKorkKEcapeLMttGguVtrPrL+BaTphj+b0KMgFrXw1cb/XXJ789Jq+zDS
         HCZP7l4Qsy6roAU6YfCq/h5pU2Fa+mKenHV6V83j9DYTsvu/pCCpX9HYiBPJ9t2p/hkq
         fD2JyCKXMoEtLitUWb4xiQg62v2MKFxeS+tQD9HhdD/xLvaynReW8KN5Gi16GHvlxZR9
         TNUaNeF4tyg3KOkdJV5qpfURfa8pqoHuBddiCnXXHuVGbvWlMhY2QNrzYKUqxzIBvG5N
         Sehw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=PC0jqVBD;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.74 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=PC0jqVBD;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.74 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: hch@lst.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	m.szyprowski@samsung.com,
	shawnguo@kernel.org,
	frowand.list@gmail.com,
	bhelgaas@google.com,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 5/6 v2] bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
Date: Tue, 17 Apr 2018 15:51:53 +0530
Message-Id: <1523960514-25457-6-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:W+o1OAO4xLCznmYODTmzwlUN1ZgASEEw+fd57yj8UygcDUcMX2ztslh625z98HEKsM3MjSQ5o9wHdCkhhyvBpUilnnyUO619O8injDOyozms6LofOd+Xdd1ibCSmfErqBxAHp2zzaz+UeQIHYNQ4D/BlcCJKWUr9mrzpneb9ppFIS9ofANgA94eFtjkvATj1pYRovSBImQFmJjdpG2srHjxAoCUj6+Q/YUUAz7WZhuCiP8s0DHN43Dvlqn5z1Y5k;25:KFlnpiy80rvUnuYxWlIyOSsxypcvvCZIMA/8GZtqGuWxd97F4nAU5u7eLWZKowVvnk8YmLngYLaXpdBZHjlZGz+SLOKZ3qnpfZwqrjfYh5yIoymQVDZcT9rWXiuStPuXQhjWexl9LuGusP5N7fmbuyi/VVIHBp3geNCJ6TgazBEcWTjfYSQu5prhTLN2jrWd9IoYpm892eERB6yd4ngSuH8HFOQqAmCmmhI1wLUFvXKDukM3X2Qzu7P6fykx0CP2r67+5ZuERR03Qa+x5etK4r9ZLLgQUXLLxQVxnzCpPaP5+2hI4eMA83PsdDGQpVw7DlYM7zya0RxWpV3ovZQcHw==;31:QAFiWxk7Gl2G4rFimPr1ie6i1WfDBApTEHBBgOGDtROieyp6hHsc9EyPIMeLbGy/SzBAjcBqA3JD0BkpB0hf2ELvNpnbdNCGiqPo1SpWDfE1VyoLjDTsbL3t04VI0IFZA2Y3hdwl8a/8li80XLeDBpumnlF62L25zeojRDmuyYf72bwaXVlkUsSllYnx8h7OsmZVikzMnfIkyLJTdFw/MTfBJtABaCldq5xPVVpsMuU=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:h2jTpqb1MWFePpDz+4iTQQ7myEtFqLwhj4ToDyAVTcTm39Oljs8uo+OlKPrcHvc9KDqnVSGG2FcXWXo0k8dr16ecqopJ5IUusGvHP87g9sjharn3d2XsWQNIjeIaeLY0MSVf9iaDaBvYBAK8Z8kpTquP90YDBunq3IgUi2jMLXsuEdloWfgpWSIlJ1gnXlBTdFO0p9HsveEQJlCpD44NQLFJ2vYJzNTqLCtEf6fnCt6mxsgrKF+xIG2BIUsGRSe3ORFeNi6xKi1UpbSNk5IYgxUZ4oNiMZPBTiNkhs5tEj5n87RHVovR4adFCm1LLjKbJHW29X/haRVJYbs6KvBWhe9Tdj6SEEIrJYp9bMOkSoCqtJ7d+gWw+603nICVCzgCcHi4iJp8Toin0v91EQVY0oejMIEpu8K7AH8nnB+JrlyPaNixToWrmkvprT9IiF2MTEvVG+53iDiEaSJnzLQPiC4u8rxk6Cmk14P1ZPuKWlwxBbymzuSLp1a63l73voZd;4:1VS4qWFXh/+xFNdtOeZZn5uwn83LGunawseiUPkU70bLM30U3Ijos449Xi3H5b0NJ/ZMXSZFLvwkzxawTBTYu0vMAxb1rM4HiUH2pVhTqlVf2yJ/+jExCso6tFd7fVwU+PXxqqB4orWjs9VGLvmjvpyGEqZaz4cTEM/wNIv6oh5pnMWGrCvBuP7SdMrEPDAbXlSPTKdhIZ2EVMCktl+VdgHrqw3pQMaVBHxoBYOjhnkcsvUWOC4as/vp4p42dDlUdfzCwFB04WUNd3LYS657X/YcCC4teYdPKUm3eZg/SsNdxalGUNM4qSB0suEieriS
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418D40C08E4C84B5E563DDFE6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(446003)(11346002)(316002)(486006)(97736004)(956004)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(6666003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:c3lnA+mhktyW7YstuFm2/BOOsipdelLICy9Y1DP?=
 =?us-ascii?Q?95lFu3X5PXPu5ibYevhuH/kepM3G8oSwyXjGELp2WhXp8ia8XlAtfkisfzy5?=
 =?us-ascii?Q?ya/t+hqC0ijV8ILKje1VBhYM8cjCl/1yY04vCGqgKAlvDMnwWwoSurwOzZdd?=
 =?us-ascii?Q?ufzv11VTwqBMpYrfo63ub0kgs5L9niVwpZfS0gROIBmA2/sYIOGUzw81fD50?=
 =?us-ascii?Q?+CLPw7+A1riTyR6+a7AthzZBRvKtjmChrOPXs1i5XwD8aHlrO/Nh2L2nK6NP?=
 =?us-ascii?Q?6M6SLSS4+IbW/GIgLcgaDwvSswzSFnzXV1bdaa0nX51Nj/RZEvPfRtJC0r4o?=
 =?us-ascii?Q?5ezYXcDZi9KZlmE1OfOvXlcB6ruN0GHsRHje0UdZ6Hd+/2wEE7eW9qQmIA04?=
 =?us-ascii?Q?T7/37Y4j87jUGhTq5W4OogimgRjnDUJkiAxoETXVkrc68M1gKE0427kEDwcZ?=
 =?us-ascii?Q?n4TvXgWXj9ST38l2m4sQJmdkhSRp59HSt3tu8oLfPLqaS1HeWf3yzaQVl8HJ?=
 =?us-ascii?Q?CXceFI1PckdEWgu+G64PTkjEYN0looIC2B9VvnG4tgvPajrQZbjGlvrOdXiR?=
 =?us-ascii?Q?PQ7dOEtPKpOjnBx/TIGF82H9jQAN+pemBFp5fyoyOBll8O1FT4/eXY+/7GVD?=
 =?us-ascii?Q?Gl7Jh2lv+IP1m9+Cfm2Fcwesxps/JVoSADmO3w4xPna0w2RzEXyL3d+edLkr?=
 =?us-ascii?Q?EQh/aL0fYZRPuH+6cyy2XAfl2W9lbkjo39oObiICvNKeM/6i1o6jq4WkXoZM?=
 =?us-ascii?Q?1yPvtMhYrIEfQ4wt2QL2Qn0JSQvXZvppyiSwdRAi38x5UYenfCRDuxVnPr5x?=
 =?us-ascii?Q?puG6S0dUFjx+7KZplXqAkMTEPVMEAmLWaqiLWhfWzA+KGIjoU1b0NSA6UYKc?=
 =?us-ascii?Q?KcXpp3a+sCFr5FN34lh3fwf5FI8bnKyY7QWk386hG8QvHG/d72Q/mA7FmG17?=
 =?us-ascii?Q?2luWvUuZHz0kFG2jV5FqXVhMBPt8CXQB1LrtGy8HokdnnYwJ+8VGsbX6CyAe?=
 =?us-ascii?Q?Auy5fa9Xk2ursm6nr9Ovf66/+HW9UTXW0tfJ3VWjWFTcL9PBXayYNPj0Do2D?=
 =?us-ascii?Q?SMvuK7W6TH6CjALdgUEZs+rhWOHyeKNdRMkUh+zhBMuFNil3JX06sOHoz5pd?=
 =?us-ascii?Q?JzCgT5W5eY5MesLB0M0vuoF7CJ44blRsy4tjACmvV6IlfH9BH5KRQUPbJwuP?=
 =?us-ascii?Q?lXEbW0TJGclwB5yRw9HoYEvU2iVXm5K8WToT2vYg5PVXk53KvTrQft10cl1P?=
 =?us-ascii?Q?KzCxCTmdUH4TxD8AwIbk9NqG53AevEOvbOjaruYtWi/fJbi7RGz9esfGvhPS?=
 =?us-ascii?Q?L0SJI1IGHPXF6YsNg1FiN5/4=3D?=
X-Microsoft-Antispam-Message-Info: EIsja0TC/HBHSe5XT3OfWeR21GHTsVTeYTq/LhzBCel7JrxgMtJ9Qwod4Ob+nFqFm96V+CLAfnFOS8zWaovjwOhBDuwRGLQg5AxRZSur/2ahW6ZHmLrKMFPU1dqWrLsyaO+DXQ09NEzd4lSDOjEQPmI/Plui9H0k8rcNoT156R8yMjlfSX+zOmI1NFypIeCM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:JeebTOu5GO0NoLoqgPlovxrBGfCjz1QZPKAr29xbSPGmqcYfdGlphR0fqjpiOsJ0Mp8RXS9yoEy2psgzxaXhULMzNEU4WkG1ncooKhBSS3Hww8vRmeXYoeC2lu74QtP8HESmSnyefyn1DEulzN7Ihe9r3H2M6zRKPnuVqHZ8caug/hIOW2DkRLqV8jipwoFgH8UjNKdhU2HF4EDRkL4995pOZnj1JqVl53DZLW+SAbP8RJs+rq5nOZE1sDfCCWgZPuNV6tIGnDQvPg5W5/SsBOHWyW0mvUokYizLNUARyCBtFoBOp9gUZcp2DbqBft+5+ghmZRnooZVYnmlvVjxej+xzesoWoP4QL1NCNMS/kZJHyg3f7FCki4SUoBRf811Z4Ad57FN/d9sKvrzEjOhkT0bY2DSS91g632zRNDHl64pzLlTwoZJXkqJWAUBdtZpRcfN3L/z4d/sFxP8CPgQojA==;5:H63++BsH/6g33KTw/s68AENM7V8rQTUnBEiHfyL9fiYFPKN2K1q+3hZwlvP+n6AprEFW5KDRyJPtl6eWd3SvJey671KJPyjCXf/yRP7LSHJWqxl/I4NrEpNG8ruqN/r7jSGt2N6F/frkeYm+VyHxZRzHSHTThQb5C4ZH9dRPb/s=;24:BfyvmKzoOteXVBdzjPdVQ2E8bVK1BQcRw1Nbr3rNgT2p6R2l56KdOmfSp79m6fTdbVI/nkww1rcm41YQomxcoFLp6LGxQiMhRqZgrD2iGUs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:H52bIyTdMNFJTL+dI3YFN7ZSMYeWq6pg4A2Si6VUC8kBoujPU4ZdkZS54epGiwawtD0hdJWp27Ye/DnjAR65CasrEG2rLDDy5+C3I3CM8jzYxZyfJ64EETNcUJ5ShucSeX5ORKUEv46RjeyihFGNopz7NX1IH3k9gfhPA6rba69i9i6bfV/+CYXKQYyEwj8aKrW9fS7HaluUZWnbtMjUvlG3wot9Jr03gL9UK0E69VcZdF2BkLDVSRyqbVejI3Bs
X-MS-Office365-Filtering-Correlation-Id: 8982286a-3949-4cbc-ae53-08d5a44dc927
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:27:09.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8982286a-3949-4cbc-ae53-08d5a44dc927
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597988758112276356?=
X-GMAIL-MSGID: =?utf-8?q?1597988758112276356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int fsl_mc_dma_configure(struct device *dev)
+{
+	struct device *dma_dev = dev;
+
+	while (dev_is_fsl_mc(dma_dev))
+		dma_dev = dma_dev->parent;
+
+	return of_dma_configure(dev, dma_dev->of_node, 0);
+}
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
+	.dma_configure  = fsl_mc_dma_configure,
 	.dev_groups = fsl_mc_dev_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
@@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
@@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 			goto error_cleanup_dev;
 	}
 
-	/* Objects are coherent, unless 'no shareability' flag set. */
-	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
-
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
 	 */
-- 
1.9.1
