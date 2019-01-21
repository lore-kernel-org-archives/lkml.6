Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF58BFC619B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9495320861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3Uecs3h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfATRZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:25:47 -0500
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:50928
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfATRZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej6GZbuwZ+xhXXi2eN25Wn+IptfFQxd76cEuCrgitso=;
 b=3Uecs3h/2QAoZVmKEn7zuRcCOuUHobkaisUvHHvy58bck9DTAQC/ZIzcqIAllh4CQ9S2CmhOhn1S2b+AuvLqM4N5pCnHshM2Z0iP0AiG136roIMAEaduimThKmRLAx4A2s/+Clgz+i2PGjjs44AqKUxImvD23hS+qcKKP4jvZqw=
Received: from MWHPR02CA0056.namprd02.prod.outlook.com (2603:10b6:301:60::45)
 by SN4PR0201MB3518.namprd02.prod.outlook.com (2603:10b6:803:4c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24; Sun, 20 Jan
 2019 17:25:41 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR02CA0056.outlook.office365.com
 (2603:10b6:301:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27 via Frontend
 Transport; Sun, 20 Jan 2019 17:25:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqq-0005VO-5Y; Sun, 20 Jan 2019 09:25:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGql-0000ta-1b; Sun, 20 Jan 2019 09:25:35 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPRRd024207;
        Sun, 20 Jan 2019 09:25:27 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqd-0000sm-5f; Sun, 20 Jan 2019 09:25:27 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 1/6] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Mon, 21 Jan 2019 22:54:22 +0530
Message-ID: <20190121172427.20446-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121172427.20446-1-nava.manne@xilinx.com>
References: <20190121172427.20446-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39850400004)(2980300002)(199004)(189003)(107886003)(305945005)(106002)(39060400002)(51416003)(7696005)(63266004)(76176011)(4326008)(16586007)(2906002)(316002)(110136005)(54906003)(36386004)(478600001)(9786002)(47776003)(106466001)(50226002)(81166006)(8676002)(8936002)(36756003)(426003)(336012)(356004)(6666004)(77096007)(126002)(2616005)(476003)(486006)(50466002)(446003)(11346002)(26005)(2201001)(1076003)(186003)(48376002)(81156014)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3518;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT064;1:TlXVSvDDAHJfiu96DctOMSOnYMzaKKREcLEV9WugL18OPgyBZqEHaa+igk+ka1l76fvWIQMlXH8tpZjg/DufKG2+aynePi6RiPPsBYWP0VJ7i2uX77P8YnOY+0zgWYxL782gQHGyZU1/hT/+fbG3ye3wKKCjyQ63rDPzpKe91aQ=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fb5efd-7479-4315-a932-08d67efc4d13
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3518;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;3:S1DmuKRrrGk9l2MTmfg/fRU6jnJQQpik9YPXtzER9SchLz3Q5E2gc29VTvbOcjyLvL7NWJ+C1y3FMP9uDxb4AazqhbBLsclkJxUBNyvwLpmGvAHR4Huvw1HFgaqQxqSWMgkVfCFxLoCuVeHmpADJIMVEw6cC+xbt1PdTZfvHpCMEmvUXsGWjZJEKloAcigZCvkt3FZplHuhe8oWTvIucNd42ZGfxheb37Dx5wwyvnwfrru0ZKmdHbVxmp7bfxwifTvxX5w2+3C0PhHobW+S9S+n77T93vwX4lQThpp+HGwPDzC02qdywTvmYkIXXQ0czI54dhV2n+scbK5Pb8yogqZbxM1516hkfP2sakqHCp9Om2Tlgtuk50U1NXehOcX3Y;25:dJAx+hKJj8bDT8+H0Zs+0HDNASqSbTrs4ceKhYbiSAAf+HnaeGgcAmvlI6MdbdzbLeh/v7nsN9Db5sVbFQOQReZWEhOwwFhKuun8RIZgDuy+DbW3iZzb+hytaTjutp4hChFdLQDv/ejHEBXUR8YBvrpcz6KTGnyktCSHYa6BaHlbuGyqWZcJjd0EeTRKBhadCm8dnGfU9FldZ5pyQn9KGStLgMijdfA+W4dCQnlCosZ9PbQ3LwdEtBPQJPr3ocz3t3FNqM9tvlL3OT7D2mZcZTwIIh22ZlN+EOp+Qw1HNx2qzxIdDHgYizjMpRBbTirg8WH61xCIIgba4tRlAeg8Ew==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;31:WlyJ892w6NkpJfblI9alKbuAj/paIPfwqyQ4czXTI2pOF2xWEJ0TmzaXIv4VpX1/ftr39aPDA9avMoXcRGdvhTzIkCfs36+743Z82/foTmxFLHCg+ctKVzN8l2sqyWXdcYKub655MVpWNcRj5BDrvJV5jZZDFIIdO27Jkm06OnbYL+WRFVIbLUMyR63BxzR6AaPkF+EQZenDMI1YI+vBz37FsdVb93XQ8lPVwr014GQ=;20:mW1bhSX947XDys7Meb9GjbCbESiV6eZkizsrFZa8nNYj+2UVes0ZE8m9GJ1PpwYhAs7JrBA3RSnwy2x5tqEshgQM+2wc/lnaRXw685qIl6P/LhXGMPjDH7MniVEKqYDy+G51kfvzzZ7b0yzSsMXEcE/pjcM9zWY+hsMifGorsHNJVOU1NM0dknmFgRtIICKATzJJub8UFdFDvEprxvr8g8PP28msA3IRerwrOwAThLOkW9XEsE59L0/geOZ6PRJzrIofp3dRIhZt6yNUOOE/eyS5kcFLH2c46KZui/riU3Q/xS9gn/fnI9ZkdWawyuQsCPtUI3J7N+aw9cIEAsF7+029Ap3pft1lsmrzjhv35ZHjL6slr8OpBMs4koASPC6kxcfxXcN9ODxrR26BEF9SiJI+sT1OK1JhHRixDyZ6/r95cmJMNB/hnltfcORQ1Nl9ND5bQ9vPbCZXDp4vtDOCo4jhwLLOm6t+AWOa6JVBLMfV9FP6wEoqLcWX0hyNgJhW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB351899DBE56AB26E951A9510C29E0@SN4PR0201MB3518.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;4:arKNSxeXjDhsmxGaeEgo3JOCWS1P+wcrEzp4ap1T6Jt8O/IsfmxH5WbAleimoPdYYsOZdFJyYkBtLOh77HZFW4MMR9k/rIqgtBC6PGiSzTXaFQJbSCjJEH25Xq384SJRFMaE/PFB/h6QOs6mAaxELcBNtt/EHUgd5samvq0orcBxlQ3mG16vJ2pkS7+aBEBj7FSiRFwj6EJBoiOd4YpF/3SnHOndqlNJMVMk9dlx26E9YqW8bFn/t5MBxLY51KiKOI5Aq1SYukkPVjF9j5H4EnGwFtdZYWyHAyyfNN+a548=
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3518;23:CkguqGkaORSlsFjqbAOqhKqtTWVveo9J+IVI9aD?=
 =?us-ascii?Q?UewvGkAVbwkdunLQHqfJHebQZgXAFDUb4seTZFWv9EAXFp4Ggv6Pk9BYysru?=
 =?us-ascii?Q?btfcSRdiGr3cFiVlyAMO6WvUIUVkMWvArqPTE6k7KrUVXaCjpRUCXQtLaaUs?=
 =?us-ascii?Q?EzUaP9a+JNIlgO//KLA0Yw3w5bZTEUbxZrQtawUVaEG2OSIAdsoHVemz16vX?=
 =?us-ascii?Q?gAmoFvJshmEhVpJEJ3cHWqYuNR3Jqq+bPQUjs2z8AtBqe/eYsM3AR1dn3/yi?=
 =?us-ascii?Q?fkFJnxTRXirGGX22BEHWB8FLYNMfjFQ3V6vzAnZssGwTfdKdniYrOMo1qbKQ?=
 =?us-ascii?Q?UQxHDKoci/+4aF6b+ZpZd6/YsYW5OMQfLSGCCXe3P+GFDEfCB7ZWijfD/0mU?=
 =?us-ascii?Q?TJnxNpMPDVPZVSBOk9HadChf7SF3jOJu0QVEO3i4FnQnKv2OQCl7LNKTWApq?=
 =?us-ascii?Q?DXs0JXb3lTZX41TLXgg2tnSrUGygsJRyEapOfQCUz8/8VeRg4u1xWMDtYkxq?=
 =?us-ascii?Q?WIRW/VJf9wlKVVcWeK7AvdtfdxUJls6LKARYfcQzhYVZ2R47tjHs6VXY6tg2?=
 =?us-ascii?Q?nWTE7egWk/dZlATFLL5jIsQL4VE+2eMkzVJ1/68IS3b4hkbrdo5F5lxxoEc1?=
 =?us-ascii?Q?Jy3IifdbHu0ouxziC3mQjnmAR6FVbl5wKtDxaht+ZV6h82Vz2HFCMtOMGam0?=
 =?us-ascii?Q?rjzxTvJB45F2AQOb6cdaLVHxz+yTa7oENydp1z7jPv5j6T7bMmgmkgFW1Ri8?=
 =?us-ascii?Q?O1DtM227c3HWZ+O4m+yeehqscWRdBih5w1n+8sZYXbTrFMFmBTpYNPO5SN5i?=
 =?us-ascii?Q?m+GhHPA7H9UMEx3h6qPaAr3KJ82keXZIi40KDIJHhfSV/10BFB3RAa6kvRqQ?=
 =?us-ascii?Q?hWvvEVN7EIcYwzhoYN3LCGRoKgBo2AJQFFUl93ufS9P9aSH3vBbrd/pv8KOA?=
 =?us-ascii?Q?j6aYqAupSDZBPVqIDqqK0XB5cLgijEyQhN74RJ9U5880IEXCLRGRyPMW712/?=
 =?us-ascii?Q?kgHmNYp93nEt5XnxWQmyikWgZHd4hzJjvYTVPBz4KIqNO7jXhTa7zJNJHwjG?=
 =?us-ascii?Q?RDezvzPwRX8zvCWBW+3psihiOJj4Jaenlrw8OvNdU3gcOavO8r3grlikwtpI?=
 =?us-ascii?Q?00zMQU9vmjLBDMGxIp300+k+Zr3ZqmnwY?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: C0mZ839ikjuExCsQu4FtnjdWA+53PprJ0/F7wRjkhlTHusDoYewP97monsJO9rW2xHZEroqGNlOvEmbBybyrqGrupMBM8dFaDZtMhlg58xdWdfyS/XEQNR+Zr9FAfle7APsw4iiIMXZ3CAS+R7gjweH5tjbS2hfjO4sB3QD9A8HvKaIuhYWM2usvgcdLeDScwjWb9Zez+Kq3ALYPR0F/nEd9WYqOtGi5BPTn1HYivY+y3mwHwzkeaJHsynplWed+b0pkgmlCenttkEwwQGgeWlzi7VQGlJ6POA+lf/61RLpDRG3XtBSpqXf1NqOPOVm2ihs6pRgK4/7rwns2IpAqMzCC+7mmCcJne8Lt1fqFURvQBZVmbbX+9TOqrmpXNNs0y8VsPphh1/Fp6k6n26BhcLrNYgmttbNmmVd3LDdTYpk=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3518;6:m+qPtmUnx/5jt+bQ6P1eez7rfm3rjV3m70WaKSrs7sE5lvSDF/j5tdHHFEezYW6OaJxMhGR81EDauFp3uyil7k2Yq4PJ94O4cwSLSofmgRSASwOue3YJlclQgiFkXle/nXP+yiOfdSQevPGgYJOw5kjvnh30LJzMUKnZmm3kabRxHX+VhEH8SiuMutK7LvLLBiycyilK+eNNuQQ/kVHsFrJh/p/ttNDaEXUd7p33aZpWcZ64itT9OwAZ59eRYvtKEd4+6d5kzrZWUVIK537Y5MU6i7/Tn822cSQPEV+C5bAyMXCzFnxcHcHcgj367dicIpvAazuwwJbK35a1EQpUFRFoVBJrtM4HjVcvHS6kYWqwrtG4QcqZZMtCJxXe9+UIj11XYII32GY6QnDKvO0rt/fJyGfWhBNbHoLcG0hrya/U8rdkEy6j8dW0i9uI/H7T50V6D2MgwP564yevWXLbbg==;5:VZHyoE7f4WCeWPHeFPAWB2jb/LcIDo7mR6qO3JyssSsUXgZsYjFURkq1pz8Biik7fVDV2ECbOhtooEpe/uLPER7V846CXp5k4MybZF3XhvDfhPM2gs870RkCwQsA9zoGmiqaUrp+0KzHPDNh3sR9H2+F4hzhshAY+4Vz/SDWusbzTbX40rebu8ZJBwNllceGojZ5hSoa/KWK6yfIUonJnQ==;7:NHBbsJs+p6GYd69zoNzTlUJdZikypKXf+2da5sqMupXDWCQjDDWy9Dc2bwkEE68SX0e9ISfwXLUSqZ0etGCDltrWNpxjFx6WsM26EcOvSCqrTnXTwCpGUEPMNMQJ27OWdOWXND8mMFHhu/taD/kP3g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:25:40.5746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fb5efd-7479-4315-a932-08d67efc4d13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
		-None.

 .../bindings/power/xlnx,zynqmp-genpd.txt      | 34 ++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h | 39 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
new file mode 100644
index 000000000000..3c7f2378e146
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -0,0 +1,34 @@
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required property:
+ - Below property should be in zynqmp-firmware node.
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
+
+Power domain ID indexes are mentioned in
+include/dt-bindings/power/xlnx-zynqmp-power.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#power-domain-cells = <1>;
+		...
+	};
+};
+
+sata {
+	...
+	power-domains = <&zynqmp_firmware 2>;
+	...
+};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
new file mode 100644
index 000000000000..1bc9636098ca
--- /dev/null
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_POWER_H
+#define _DT_BINDINGS_ZYNQMP_POWER_H
+
+#define		PD_USB_0	0
+#define		PD_USB_1	1
+#define		PD_SATA		2
+#define		PD_SPI_0	3
+#define		PD_SPI_1	4
+#define		PD_UART_0	5
+#define		PD_UART_1	6
+#define		PD_ETH_0	7
+#define		PD_ETH_1	8
+#define		PD_ETH_2	9
+#define		PD_ETH_3	10
+#define		PD_I2C_0	11
+#define		PD_I2C_1	12
+#define		PD_DP		13
+#define		PD_GDMA		14
+#define		PD_ADMA		15
+#define		PD_TTC_0	16
+#define		PD_TTC_1	17
+#define		PD_TTC_2	18
+#define		PD_TTC_3	19
+#define		PD_SD_0		20
+#define		PD_SD_1		21
+#define		PD_NAND		22
+#define		PD_QSPI		23
+#define		PD_GPIO		24
+#define		PD_CAN_0	25
+#define		PD_CAN_1	26
+#define		PD_PCIE		27
+#define		PD_GPU		28
+
+#endif
-- 
2.18.0

