Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02AFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4A620895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tpko94Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4A620895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbeG0LNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:48 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:24435
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388679AbeG0LNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAcUjWgbH50eeIAWb89W6vJI/92guz1N2HHQUPFNFU4=;
 b=tpko94QgcXMQwk060DNnjwjg7crJolNo1Wf6XJ1cdeveMv2NloQrA59pzflge7rglGWCz8+5x9vxot4LQ2S/+nJVJygFtsuh6DhBFvlfLJAixc7Jf7qE9Ehvv3TsqckMxSkZTzJ1E6dzP4QB2Gc9pMqivDP3AqyW+d5kxsvc4Ck=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (2603:10a6:800:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 09:52:33 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 4/5] powerpc/mpic: Boot print supported interrupt ranges
Date:   Fri, 27 Jul 2018 15:18:00 +0530
Message-Id: <1532684881-19310-5-git-send-email-Bharat.Bhushan@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34fdddb0-1ecf-4799-63cf-08d5f3a6ae4c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;3:OZsI588Ul5jxFGUDCouNrRWO2zRQRNZlIQ0POcU0YC8hqgnaZjwV+NEnaK9k4EjdIELtSXcm8goPUHXcsYqG7o0s7ZVFJrVXU7CMpZ74Eh0XxzPbkuOeiAwYu6CVGn+totb4deR09TJV6st5ANMQrAO2KKIzfFBnhYL8VX876SRbTCvdG/7FCv2E4FLGL7MPo2jYqahFEWHZZUnJgyyCZkTgemAuZUxFJZj5D4MaIY0R1pMBeN5uocD4ta00fJoI;25:1Rj4oCmUtQo3wTFkDCem+UfPtuMUysi1gK1CoWBGVNr7kZ6bOeCeVBolVCO5W3AnBisLwBuFR2cFeru2LNASFp5euKqbjPUXkQRJI2C/f7XoTtnWwcUBwQN7ctT6V/z2IX+qpa1JXE8xqZM18/NS/7nBL/+j9MSJkcKfu+N8WDjRCgjdldYrDUP+pu7MgK12T4U5WbJutrA3j6wd5mpG9xsei5fZ5NrdikNPvB5q0GQuBc/ZiccmDl5WT2yRpjarRocQzSHtEb00zqHdD4dzQZ1pyfEeeUDMwauD9VCI58qhXMqz1zRzaqP33DMyVuSi36HBLZ4FsNzSUZIZdkzYMQ==;31:lvXMc648XQyF1+9IQ7HZUmA/vZxqwSqgoHHzRFQqrmv3kkWC4nvZLNN7w0J44abMByaNgMwdWKnN4idtdzmLYCwEJjaoGbDqmgWu1uMHWDWZm2ZZHCxI9hxLjZY8aky/DzLRGebZE8S6+02fhMIOrHCmU4vl8TMe8JKpeIIA7Kn0oPVXHWzVk+PI4cjioUvwMyRud9qzKI/Tldijd1yN6IMsZoEAZe+Ys87R6sBJc3c=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;20:iCIF6VvHM2bV9qv0GLVOZ8C9w3KuSdLQc/NOCXi0Cs/CId+9uWjwJvB9d1CwcTLG0UOaZY2izKX4it0+0gnXhrb4PCASP70sZYaio4yS59a8NMMHk7fMoAp4yXtCPysDKXENWZrmjH+CchWygiIhjdQUzvyaK2I8Cz76JL94jDyyMfHCrjkvji0vKVXx1nPGvJ9s6sk2G3pldlKzBntDlcLM5axFSRwMhWo3Y7sPqmzgcMZc7SCsJ830G3LJvyDKfwwyV2iW0kcawEyCfxo6xKmUgMMkGAseChyQCSbi1tLZs2qS8sCqd3RF+egftp5Hhb5IAnKEwCVENtUaR1aZuBpK98SLi2wE1gVEOwZ63t7Z0CWRIRGmSdR+F2b0ZeIwYnBttOq10DHbZ+4O9ojAciZb20r3yczmbLHdCrm1dvmdKPaOxMeM8B7HiW7rDeJUoc76ffyWzk7vSXp4Sh5oZ6VisnEcbqx6TyuP3QDotFvrORZl3JI7CeyAmwCR5dMB;4:XPSUldRNlSTpVvyrw+1RDNKL/Kq1stFU6VxjX2Ci47hA//1+yUtPuMMv5OsEeOMr45jDixRbsuwIbiCkGZ94pOtJykgJF0BYM8/ZByZzAzHk3dgStmbPLLujSnCuI08H6Ow6c7PHOyfowgjFQ0PqHhHMcdU16FzkMbpYz1n/UtErv8wYtMnovA6FZhcTjmgpYX1CqxhNESXQuvumvo/HMTbMy+H+yx822JcINvaxxLlHZMdXOby1oR5n09DzBFWKiyg3cg2o9IbKKKU29vErOtbi9ru2muyHlnzXIlN9KIALlq1WgL72zczvKxpmdqOw
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2557943CE566C2B43A00D7E79A2A0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(6666003)(48376002)(68736007)(5660300001)(3846002)(6116002)(76176011)(36756003)(5009440100003)(53936002)(25786009)(50466002)(97736004)(7736002)(2906002)(305945005)(7416002)(478600001)(81166006)(81156014)(186003)(6506007)(386003)(11346002)(55236004)(26005)(446003)(16526019)(4326008)(956004)(66066001)(2616005)(476003)(47776003)(316002)(50226002)(486006)(8676002)(106356001)(8936002)(86362001)(6486002)(16586007)(51416003)(52116002)(6512007)(105586002)(76506005)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2557;23:3pj8QTkqeLo/u6/gGK1p4vDizho7XENaNLWMgPL?=
 =?us-ascii?Q?dfJskEmow2TuN/RZ8C3zqMtaJZ5KdIVcIpWkeTts1Daz2tz62bus21c2mWXz?=
 =?us-ascii?Q?F76RRWpa6sLpKvBB/MRtMbFAiLdKi+PhL7jVYt4NTsYtx6PWQq/LuAEuhAAr?=
 =?us-ascii?Q?K4R7mjx2Oz7PXP8mlmkW3Hn2FGlyczQr/r6k7xs9mU3DR62BVY44BTDz/Dm+?=
 =?us-ascii?Q?qL1z4tnDs3PK0/nk8GP8cyLx48GO55iSY7D44WI3agTjKp2B7WdxgIuXHm8I?=
 =?us-ascii?Q?P3O0EeguZhbjfWKTjOAw0LG4p3m23NCQBcOOwkI1lc7Zwudq2R858mTnP2G6?=
 =?us-ascii?Q?zqBNUKto3CfLXQtNwgd18Kxq/0xQgKEmfIO9GteekJ+A5XJxbGMI75PqUs+q?=
 =?us-ascii?Q?VfnDttGpdD/MyxCgYcxu3kHJVx5H8Pasbfb1hB95TmiUvOf3ZpYsEkmeJ1OQ?=
 =?us-ascii?Q?oAaWAcXCeKn6DUnP6OfmdeJXIaz3DIEjr+NpLRrv7nccp3ZP0tDb8u3Aj6/0?=
 =?us-ascii?Q?4ypFvPBT+HJSAntl+wFYj4NRo8snt4R1zBkofHB5UwdDjrThcXYPjBVwhW5J?=
 =?us-ascii?Q?s9mA1SXSNAZ7g59oqI3es8iI47oXylQGUHolhtD4Z3CDSOvg9bg3+qkfZn4w?=
 =?us-ascii?Q?K0eEVLCsEd3vGDZ3IvREaxhHnaN9F5v4z3DrbkT3CD3hXC81ZWeWHHnKDDCS?=
 =?us-ascii?Q?7C98CAt2O0wrTfYk1h0c/OP2MhDui+SzaOukkDte+ED/bV5x2lAea9n64Bn/?=
 =?us-ascii?Q?zK9CdjqU43rSPZCUugLjjwEmNIXJT2NuOskvUE9DgKy65QJa3fGbxUWLReHk?=
 =?us-ascii?Q?+/U31W3Wgr0YDPKTN9sfWjKIQ5Ahi2gITW/mUrUQvR9b1gWOSpqGkpXiZyLA?=
 =?us-ascii?Q?p6+sQwjp30aeCuiK7FXIvkGfIRJx9Iiyf6UC2v8dUwsCitiFC7MThJQiNA/t?=
 =?us-ascii?Q?qBVDgGq6RcNl64IbkmhqVI0C5vC51Ua4P/+XQizbubWwd5pVhBryVwNNSOPW?=
 =?us-ascii?Q?XXLIuM3ZseK2VwKVooc+eYM57ZHIYhf3wh0cTZvv6zxxVnqc7XxrCp/4I7Bk?=
 =?us-ascii?Q?/1Nc7TJi/hdwqAIcDXSpqH2U2ZYw1SbhGGTDIj1b4pK+pbZlWwv7FaxcutrG?=
 =?us-ascii?Q?CCQ0ewQ5Z4LtIn8wfuonTJQog7+olJNdpiXD9lzBArrSyVg7YCInF0DepQS6?=
 =?us-ascii?Q?Ei76QsXVsOVwvrmzGfOvl/+1ZxNzpuEI4qIM0lyniGCwKs1Kv7VG+xRTaWRZ?=
 =?us-ascii?Q?hLuMOG36/bSn1tM/reZMvDna9emNKz5eU03lk7/s57d3OzH4hnaxbUVUfB07?=
 =?us-ascii?Q?E1kbO/Nuyko29NToRbHkyeoM=3D?=
X-Microsoft-Antispam-Message-Info: 5OwJLRhNNCPWTjU6iE8ttGxYu81d/omVC5QB+vPjWXgVncpSnldmLWJLSP5xeD2rRDa4d1olmJGZf4n8u9Ym8ezndpKeAshjyKFtnZ1ITM3MgHzdSuwWEBdyPjI9FnX1pD0JzbOmfnIa4Tik9ovQdjToG1GhNbJ7id82zFeGvZQl248ovA+i+TjuOHDFT+tfXlvwQg/lj+XPJZzRPLRg2nZ7bBnOhob5UoULGL+IDjTR8dOx6Li0o5+PJ0sCWZA0Y4yjmDOEierOoUvsKU+0uT4KGSx5hAR3K7XJK1d9R2+Rnbj/7FExd+zuZeHv8MXQYxT/LfyrwKTt2MU2azN9KesSUvoMiBZHsxgQg+vEinA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;6:/CqOADSvRKXioEoD0LKW2APanM8uZoij1obgecgH1vWZtsrlbrwpJ+Y+UBAk43FbCE2WTj3hYgqsSAIdcrgkNNJyMUh+ZCf2rgsw9u6794Zm+hO3S+DJnDpyKbEf+AmjGgqSEp9lEERPHqILVpAa/smykkb6AsfiPshb2eGf0eTOGpbhAGOTRNvM1L8O+XFZTYJ2aAQNaj+DwIB84w150clw2Iw6ug9zzcJ/WClN1ZmfOBidkPoQqkDR+G26SC//o3C/Tf+FkraYQcFke1g2IOS0eb88kivFZ3BIPknSeGF6ByS3hSpzS+AwHRKwCCUtF+9Xoqg7auOPPaO3ByWSnqZIfhkwiaErGVGMr65C/jRiycQ8qE5hU4WfJIVYHhrrbqGVtwhawQZPwupHqr0CXq9Agxz907RVzyuVVE7bTxmccCHcgjBCatX5mwrPornlOrepVssS1YheUoJ5uL/JvQ==;5:L5YtT1d9IejPNu7UHfuFYh7o1YQYFtxezsgIxNMifwMG9wBavOdaV30G5BNn5IVIJ4Z/6t7pUEwGN614kLfeg1/9ivKUAENdb6fFilu3ReTbTDW83yE10wufmdYsCFrhK1OO21LJkghJM98/zN2Upsb1JV6s+l837QREvAu8taw=;7:XUflrfO07SQWI0ls+89QiaqeuWpKXq6ToSVaN8y9U9k2ISmv6OpXGOVEp6wcGpUdqHUVz6uYwbXm4IhWCMphnJJJaT4aJqsP/U4NgjrRudaRPcQlJBca3Kt8T7WrzQYKusS4TUSne+ZjK7M2PRGytAC7SrIiUo/rhShNis+MTJlV4XNnNvQgJ179Mvka3k107pFS7fH9kpNn6HUf9fldD3ALB+/9OaL6xgJFI9ttSWPlgoBQKHRC58Ogurd6VXLk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 09:52:33.0124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fdddb0-1ecf-4799-63cf-08d5f3a6ae4c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mpic can have non-contiguous source of interrupt range,
print same during boot.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/mpic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index cbf3a51..8df248f 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -155,6 +155,21 @@ struct bus_type mpic_subsys = {
 
 #endif /* CONFIG_MPIC_WEIRD */
 
+static void mpic_show_irq_ranges(struct mpic *mpic)
+{
+	int i;
+
+	pr_info("mpic: Initializing for %d sources\n", mpic->num_sources);
+
+	if (mpic->num_ranges) {
+		pr_info(" Supported source of interrupt ranges\n");
+		for (i = 0; i < mpic->num_ranges; i++)
+			pr_info("  > %d - %d\n", mpic->irq_ranges[i].start_irq,
+				mpic->irq_ranges[i].end_irq);
+
+	}
+}
+
 static int mpic_irq_source_invalid(struct mpic *mpic, unsigned int irq)
 {
 	int i;
@@ -1646,8 +1661,7 @@ void __init mpic_init(struct mpic *mpic)
 	int num_timers = 4;
 
 	BUG_ON(mpic->num_sources == 0);
-
-	printk(KERN_INFO "mpic: Initializing for %d sources\n", mpic->num_sources);
+	mpic_show_irq_ranges(mpic);
 
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
-- 
1.9.3

