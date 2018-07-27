Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B52089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A48+bgSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9B52089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbeG0LNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:38 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:54672
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730425AbeG0LNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryLb7Mh+uR+gxRaeGYeosHWmwPEXAu9BuZwvckUC+fc=;
 b=A48+bgSjP/XVid5BwZJZBgYx6TDurcIPaWKcBTnfcvVXloirOk3Fi56QANVOk1tj8c1Nz4WNu6z/MLXh+fFt0KvZVyEbHwu/meE71WTSuh4aLLwfW7yEwCpIU+RP/7uDmX0wkMgM6JluIf2nXiilDVz2L3Kc7Z9Iaore1DRp1M4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (2603:10a6:800:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 09:52:23 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 1/5] powerpc/mpic: move last irq logic to function
Date:   Fri, 27 Jul 2018 15:17:57 +0530
Message-Id: <1532684881-19310-2-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR0401MB2557.eurprd04.prod.outlook.com
 (2603:10a6:800:56::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19439271-f5f9-41e8-cabf-08d5f3a6a8a2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;3:PrY8Qh/hppkbHM27xXxMF7vb55OqWXxFI9hZ4U8+5fUONzmc9aTaTrSdzPo7pJ+xRhaJVR1Kq9YPK5hmlddH08UJoxonWh79MfcoNdalZjmUXU4EW08GMlE61jth4Bx9pOq3WUqzEqctl+0Mw+G8RAfnp4STsYcf+La4+USq8aIzDOZmYkvuoKkXLlzP3oFIS+yd+NitF0twMPmVt7TyEkgTz+RG6GY82mohMdSRnRtKBBdsgcVNZ6Toh+t20i5R;25:vJceRAk0TQxs0yTAMjwUBK+qKyKAAV7rZOmk8MJgH2SAJsooduLeAuj60oP1wG3cHJp5As10kMy/z65jeRbBBXvYObYULwMBsQZTSeoL6Ltl2ylgbT3gaGtdJMgBk7dZY/BYeqKHzocy+1LPrlCFtjwYcB6YWgK4h31wBJfuxgz054F3ZC/h+FufUtkTNCAYcTEMmJwdBb2TTqXKKtBn9Swzewe1E+KBD36Os+F+7N2zv2kD3WLap07YBSGRsv9V4r4NkzxQ4Jhfqc2bjCw0qRdfudpdkWJyb8ndQJbN/8ASzgOhsVa7CfdLCCaxlkiNrnmGJSfzSwByOOJDfFcqBA==;31:Axeux/GVUJvzDOgklr3Ljt8jOCdGmvy+Jqhibq4FCNujHFvxI+HqDP1zlZfGmsqErauHU+E5TnslxiNpt8y+ya7GBxiMzHTYWW50HUPeVOVF4+x3xxrFGb7k2Dcsqth+CjSfG0z1eK/dWKW+R9v1XM/9b8Pdiz3JAj5K3ie0EIw1MJHejV00KAeBFRzC270iqGevxSUETx87+fa4Nrj5ej94RD3gn5cM/wI+O3sqD+o=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;20:fwY+JSBuCTC+SFQj11exywy5G6EeFev1BB1BtdQxlJEsK0QpO5Va/HGcnUK0nDEYALib3oFuidAE3xFEpZPyZyDgd2PL6NnLQOp1MTAui4ICo6i/MoaZEM5b/mNojHu2CtndcPr/FM4o8xr/8zSEzHsYiZWFX5tYaZEl1QkuPkbcMmginBOaOrY2xfccT9ZfJsn9NCLSF64yZYEaEFRaH/aV4rfYb0HdUNuZuPGuaAXlOXgEJ2p48z+JVZhC4oJ0rTt6y5SS5ZwfBH5fOpjKYcaJ2Xtvisp+qg56z0lZPFhgWl+a2rxsqWXmKliyA1oSmNVz2KVhYXrlgYlU32QddNxUBFYhtIdE1eftVIWxAhzp9o/ckNzWLwCXYdANbpFwujw+QUaUEBmgtah0t0C1rcAQBYMUMyqbPp/bhzYo1obNLf16Ci/6VNeCIsVqVSwgUkyNkUNpYWT+OzlPVpzvDokiCFqiUU42NQX+qiYW8bzY9eBJq4utGDuKuTPvjNnX;4:yfEaNcOL3VJ5cmSzAqSvfsXqnCV+SJCa0o9gudTpxk4zyCgtq25CKJPPMz1K7Z+8J1/LdmVdiT6MOjwAjuxULlEiOgLet/XLxF3L5aJeE8MaE4ptbkw4nxEUgX67D4XoW59RJYcvrvQcz/I+q7yKFPa2Lt+k3tsZVkpNSAtrjJUsBJ/Xij5cQfDWZ5NY9r2fgXBvWtG9V6seWzYrrm5VLt2OF+3V3hoZEinD0aup2mCHrbxBdpbTmAkr7DxXE4m2Z6odx258TJjhZ5KhBJH3Zdwqxmn/hthyt0btT0WuKB2tkr0WKA7YVRaJ6ZmBuRQO
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25570BA34A9A444E69E9F4BD9A2A0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(6666003)(48376002)(68736007)(5660300001)(3846002)(6116002)(76176011)(36756003)(5009440100003)(53936002)(25786009)(50466002)(97736004)(7736002)(2906002)(305945005)(7416002)(478600001)(81166006)(81156014)(186003)(6506007)(386003)(11346002)(55236004)(26005)(446003)(16526019)(4326008)(956004)(66066001)(2616005)(476003)(47776003)(316002)(50226002)(486006)(8676002)(106356001)(8936002)(86362001)(6486002)(16586007)(51416003)(52116002)(6512007)(105586002)(76506005)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2557;23:bGo0tUGPdy8Me370uMJB3cSQDLkIYfzNfc0J+0n?=
 =?us-ascii?Q?Giv3soRrsG/nugfhhkGvgtcMrhm/Qd8XTKZeVhjFZbvOKgVR12nHxHIoMi9l?=
 =?us-ascii?Q?LSIyekpXrfSciWH5/putvulDYbUBWkmOJDLFEgiYUFxAfie+4M0Y3HWiZ/iD?=
 =?us-ascii?Q?WHzH3y4I8235vDLA95Si8E7r/F5v5avu0esdDup8Y5aXy5rM7MdA2XzkD93Q?=
 =?us-ascii?Q?tyAIxwohstPCJyH6IGLYN653vORFuEkWNQkkx0clx5XJ8V0WFsnOqP1b/V6s?=
 =?us-ascii?Q?Y7CLhLqBBwga0voc5RCJextLQPRNABb+jH7gKorstiXBf7+cZFplzBvPBxF7?=
 =?us-ascii?Q?1yknN0HQqvtKdIJHudCyLROwAhEkS/uQt49u4iyqAnBIgQ4e+wSkLSw5n8ml?=
 =?us-ascii?Q?u6+OPekLflzOocnCumc9aD7eJC6DwdPydBVUNDT6yPto0xwUCqFtcYnwpBN1?=
 =?us-ascii?Q?4b2bVnbtnFDHvm/eF6x83OpaQRBQp4AcN3Rsk6OIgbpL0hb6H11R9MAV920N?=
 =?us-ascii?Q?BaSH9nZ+19pS3CbaXG+UXT/NoJ8TBbcPkFUqhlUfXr3RJWAoq8YOFPdlaFq3?=
 =?us-ascii?Q?KSr8MRJDCghmiVoqaWh0d/AV5xa03AbPguzSXIfUGl051F4tNwTzn6QEsGe1?=
 =?us-ascii?Q?QuGi8Fe2xq5r9fQmedkNar2LepTXRy8+i484Teep+DCNWBlkwV4/x+6UbV3t?=
 =?us-ascii?Q?ro59lLQETnlXvJYuJjlqROzbLodA5SKrRuPvMIP05mLbX4O+4qkdQXEnrjx5?=
 =?us-ascii?Q?+se5ILCaMueg/l8iRMyMZ5a+gBxd1nbQp3h0rf8XU36xqwFlODIGwBrGb+kv?=
 =?us-ascii?Q?HR6wsDE18PxqArFtbtQusaNdA5E/dh6SNggs+t2z0tAWkRufzOkDxkObcy53?=
 =?us-ascii?Q?/EKVs+V8JM20f5ch3xfZiXt5r2k0XFlKzCzLqIFn0hEhEW1PvQ+CODEKM8iQ?=
 =?us-ascii?Q?qAiJwgA0IU9Q6Y7lj34m6FltKpfwoa96kj+8Z4MSQQTpwEy3TctwSYBU4Kss?=
 =?us-ascii?Q?xpOo0kC9jbOUoiHxtLbIGmvgH6AT5s9VxziVsJyl5QxSDbxHncdAirFB7DO+?=
 =?us-ascii?Q?o21pAt6LfCrWcXv/KTAlIPwTcdUeWHfXzWkH7Piu+FY6L6zHP5x5sfa+2p4R?=
 =?us-ascii?Q?sV9HXJx/JYpsDI+ZM8zntp+el6ZTGlZrih93qU/BGN058gRUTdFmrOtP4/j7?=
 =?us-ascii?Q?g8kSO0zC/pBICYuTff2EwEWF+NQMBdiJOsznVWeUdUxZ0stXSEcf9sgcPsuo?=
 =?us-ascii?Q?Awi3Ffv8/LjQaWVsG4vEq3ErvHJ86yoRzF2W9XnpkHnB2E7oMgsRsCiE1DHC?=
 =?us-ascii?Q?fMpPgnDNeCQIcZeePWchj3iY=3D?=
X-Microsoft-Antispam-Message-Info: ZOKqo/7alsASh/8ecUF+ur9NZrmi4di0YDutc/KXl33N+ksxuqqvKLSVv02qwCGxgSy8YX/7GNvk7x9ugbQbZUKFhGSQYJzpjAE1c11uBKSexVAtBfncGHXQoBn9d8pof9uza6XMIMkKeihvSVzPMIT3VMPceuv6oE2nIee+qS9f6erbi1y4dxM0ZiPhRAfjAqXWIburH0b8Qxf7i8Wrn4ytX6nn6eh2qtJLU2Qm4H8Amk95yjnT+OdtmNJu227YwImQSh4y7oA30onr51RNifPRwG7vx3DwseFt9BPJuEwVBJ24gsi7mjD1s/1OGVIEulXdN7rVrCnv8oFUbHCcNwyt3sNUG1zT2rK0D/6+yNI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;6:JG67WDw7HIsPFP+fZGP0Q9wjicj7FqLJeKyqGmE3RWh9o0LjcRC0Jh9MoRrr97cgNjjzLjsKPjiz4iH5Rgek9LIyVUctOurQtWZXweXgRoAH49fQLCCLlR2wz3ul286dyAshVSMntwDVlZddtykpFuGYfUAna+NBgUuSi9p9JQ8W3YoQW6fqw8I6GJL1vQKzjPbv4vSrY4DWcBgkGmVRN0vwobTCOeDrCxBTIv7ZlJCC1tc6k6HzKGGzWkBWE+qQQEpHVuXZOhRep+JSSg4lo6NIIfwY9DonFyo+IgDhPFHg8DYilWGqZcJbD0oxjpolV06/maJHegjJo7/PnldHNxdrUpPVlh3gYHvv6+IR0xAxopy37dC2k0RA5rpldvvAHVnwx+xDL2xTqrnVGkhoOUdzXIfiCO9UMrt3wxlkcYCKuAk6bsjNtjEGVVwNYDjPJTXGE4NOyc8jn5kcC6593w==;5:bCsCPrWXkYIgo2WHwi01cUKkRczlZzy2G61/rqFa64SWo1cfLNAekUBTVpF7b8EPDsm1a8ZlzFNRYA0/NBVadP1gxt9emwgNNol0Sy7EvRpbfnD8TUhPuO0jJrWXellBnc42M3xyA4fA5NX7LzaXV0p+AH0f4IYlH7Rk4DefjHE=;7:jhkOhqWtbaQDE0kKwfjxX9Zrtq5lygrk6diADQOq/Tz1ifCID+DCRwfAyZVDJFj0S2t5v/KkRgK0usxeiP328nJH+5UmDLKwD8C30IQKTKD9HQDnvHP6XoacDr6kdQD9Q7b2wsbaN/Em8PqcFfekVeopEL3WDMCwLl/mldEPX8rxGvrs5oWDIU48mg/fp7l+oSprwCNcLYiW5qRr/547kDjHVSS3vFZiE2D9SYQQEiTWNES8ChFuMVmreLsJQbNd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 09:52:23.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19439271-f5f9-41e8-cabf-08d5f3a6a8a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function just moves the last-irq calculation
logic to a function, while no change in logic.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/mpic.c | 52 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 353b439..b6803bc 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1210,6 +1210,36 @@ u32 fsl_mpic_primary_get_version(void)
 	return 0;
 }
 
+static int mpic_get_last_irq_source(struct mpic *mpic,
+				    unsigned int irq_count,
+				    unsigned int isu_size)
+{
+	u32 last_irq;
+	u32 greg_feature;
+
+	/*
+	 * Read feature register.  For non-ISU MPICs, num sources as well. On
+	 * ISU MPICs, sources are counted as ISUs are added
+	 */
+	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
+
+	/*
+	 * By default, the last source number comes from the MPIC, but the
+	 * device-tree and board support code can override it on buggy hw.
+	 * If we get passed an isu_size (multi-isu MPIC) then we use that
+	 * as a default instead of the value read from the HW.
+	 */
+	last_irq = (greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
+				>> MPIC_GREG_FEATURE_LAST_SRC_SHIFT;
+	if (isu_size)
+		last_irq = isu_size  * MPIC_MAX_ISU - 1;
+	of_property_read_u32(mpic->node, "last-interrupt-source", &last_irq);
+	if (irq_count)
+		last_irq = irq_count - 1;
+
+	return last_irq;
+}
+
 struct mpic * __init mpic_alloc(struct device_node *node,
 				phys_addr_t phys_addr,
 				unsigned int flags,
@@ -1451,25 +1481,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			 0x1000);
 	}
 
-	/*
-	 * Read feature register.  For non-ISU MPICs, num sources as well. On
-	 * ISU MPICs, sources are counted as ISUs are added
-	 */
-	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
-
-	/*
-	 * By default, the last source number comes from the MPIC, but the
-	 * device-tree and board support code can override it on buggy hw.
-	 * If we get passed an isu_size (multi-isu MPIC) then we use that
-	 * as a default instead of the value read from the HW.
-	 */
-	last_irq = (greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
-				>> MPIC_GREG_FEATURE_LAST_SRC_SHIFT;
-	if (isu_size)
-		last_irq = isu_size  * MPIC_MAX_ISU - 1;
-	of_property_read_u32(mpic->node, "last-interrupt-source", &last_irq);
-	if (irq_count)
-		last_irq = irq_count - 1;
+	last_irq = mpic_get_last_irq_source(mpic, irq_count, isu_size);
 
 	/* Initialize main ISU if none provided */
 	if (!isu_size) {
@@ -1495,6 +1507,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	if (mpic->irqhost == NULL)
 		return NULL;
 
+	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
+
 	/* Display version */
 	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
 	case 1:
-- 
1.9.3

