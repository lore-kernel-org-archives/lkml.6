Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeENOz1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:55:27 -0400
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:36480
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932531AbeENOzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:55:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 20/21] i2c: stu300: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:29 +0200
Message-Id: <20180514145330.4857-21-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:39qAiwLH2KBXIAwuYQXAyCR6w9royC1ib/vPzbpX2NrrDovux6ixU3NUnAJy9coMzfV3ValDjOw21Bt7Cj9s9oBylI8NC810duBzcSDJKJnwXDHwABe8QtvYgJREWIgkxDDRFEtBYT5VdHBoLcbqP4ciP76JJKRxFTF9tAZCsBTDPgPGDDvk9JYxtPI+/8GVhhtafzzT9MjHpMADqvmJCs8BfHf50LEvoT3Icwk7lx/7ZKlshJxmnWuPjjgyh9u1;25:irBVEcCerxdYEm99J+i6JecrPxL1MhP6fawTtg3kBfFL1BqRintelaNIKQf+Htng0ONKNu9fWUOJsXW81eI1a48BVSoyVKkTz7uJj7RaiONlGYJHfvYLXm1t6KiOc26NuQDEocK/YpGf75pUZHOPfyIywAtOARaEX4yp5mspxqyvVBYCZU+E+8syoZf1BTiMDL0bNsGGKhyQ0DjljxlQsDxHHgm5ExwTNCwIKZEFxD+24/anQE6OWrL6AlcsJEe6RmKvRm8DjDy8mfaF2fr/3KBos1PJbNY9dEz20hdpkbQSqZ/m2tyE07k2H1Qp0goVEgPZzdnO7Se7jSbmjWHUGw==;31:AagwyXipzl96WyXURd+Bbgp4KPironT1w6xvrB6BwGsu4LJNqJj7zyTb14EAp+dqxsyvm7Ft75wODyi1GU+AbVOxdaCammTgsitnXWxyavygPJKDQTSQDLAtbOtKoHtT3DzAnh/wDwGkMq0eOal50Ld+oUshmGOm/rkPjJim+S6BeDC9xEkWl5vgAMBlUMQkjCJrbEt0AR241tAIHfoJXUaAyPOrXTptt21rpdEopzk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B2D2FA043C4071D8699FBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:XGeN7xHpcRKSm8wZoSIqtJ0efYkzX+f5+wfuJ79apHd4I6enlHk4+Il91e6NFaqiiwvXpGW+XSu14q8KTEbxW2kcJUjC0/bGN6NEiHtZ3t+YwDD9bpsBm6RcDNNPlWSRbcYwqk6kB5rgGa+e6h2KFOl3faPnA8M/cEa6ioVJ6YVO12/OQoxvmYo9MNxylXECCdF6Iiyf834ANvuCkJz0LPzP0QpnlxKS+VXSu+mux6vWNCu2g+iLDWamepknkyKE5Bog1BBEzgKnk/TEtRLBow==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(59450400001)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:jdWamBh9w8aa0/pHb9eoCcX3ntapvMnjUpXf6wU?=
 =?us-ascii?Q?V07aSFRdp6Wl+PKYtp7r4cR5K42eUvKqEDBGUBqND7BOvb5AnC1MvkxDnwv5?=
 =?us-ascii?Q?ZYknSXAM7cZ7F4ccCmc3dQnG/LOz33Q1cEqdEyR4QefoqvXlcdfj+/rUMCX7?=
 =?us-ascii?Q?LdT78GEODjD/XOiQLzvu9sAH0/oe5HZtwBSH2oa0RvaQirJIWeD943q6fwfd?=
 =?us-ascii?Q?ZPzALLA2nyCT8IC9v3pEDNc4sb1HE3+rvPjpY6q/d4HZAxga5ctxJqtzIoXo?=
 =?us-ascii?Q?SgB1RBgLP8wINNhTow1YaxipddKSlPlsx/9IJrVlICWZVoX+dQ/FRzYcW95Z?=
 =?us-ascii?Q?TX1cnRcyb9r5TFD27aS9GjqWxajyGRGKWbVfcX66EMe/uJ8lH1Ac1gUrTUGY?=
 =?us-ascii?Q?yZtyvHkE+QoJHjmrhlbUo88RxRnu3i2rxWHPFPXhP6+JD7AuazMySrB+1MbX?=
 =?us-ascii?Q?kg8yYYVxrrETDm7sqBtAsY3m9vcZJ98AnSp4oaRlXLEe+oweyBvovk6tvgv9?=
 =?us-ascii?Q?YbcI6MAQGOUIgVw9me1B0au8Gw7SKgpqrucuxxC2GtQpSt/mMNRr9Oo53fcs?=
 =?us-ascii?Q?0348F5732p/kczF7smCpw/kxgR+unF9EOXodb9D/deiPde2ltNoITTu+29J1?=
 =?us-ascii?Q?pcz88vmNK2AutXk6JRlQ0H2CQAqmrFpSXaxPuglo1YqaGya2MFhq8ms2cbxz?=
 =?us-ascii?Q?D90/S6o5pKJWPPYi2JA2HLPooZ+OB6IXygjkL5sRC2/8LLpQGOekcegjPbMQ?=
 =?us-ascii?Q?yeDZmXjSCvy8NqQA9/WW2n4viid40bHravnUhGTv+uHxxsfqLpjTVRECuOt0?=
 =?us-ascii?Q?fg7JCgxMN+Y/u1brHLE9ux8/OP7QkAu3RaKf84t36cerVrtLsMk0lxsxpqsy?=
 =?us-ascii?Q?HQqEH7lcOMvbHCj25uMt1qc4asr+yMJhpgsvcx/HVQY5eevm5bDFc21WpZje?=
 =?us-ascii?Q?j8Hbq5Cca7JMSdlvVZXL8v2AS1O3AXsHqV0efakl9i9RT+cBjaae3e2AcuOl?=
 =?us-ascii?Q?zuGTdyfL4q1ctTKMcupEoPbPgTZortjZR6ssEgTaRYnVyEh4ahkpKkwsN4vc?=
 =?us-ascii?Q?QYS54xSUhTeKd7m6EnkVX3agOdOIP5AMVMyBeF4Uyd3wL8wcUDVBsiTGGRDN?=
 =?us-ascii?Q?bOpvsppG2RaSz6l/gSiEoGTsIFvM/4YKmxaeseJU2SzgvtLCYNfnafW/qj17?=
 =?us-ascii?Q?pQnsKuGCQ5kwrBAnCMI4Xxp8/SE4YoTnSCWk2DGGlfXyTfOkAKuTtnfZVo3b?=
 =?us-ascii?Q?tU8t7e9qHliMiY1GSb0Map/ke3OTgVVU5Tpl3RAJ+mFwiReOndQCK8s49+Db?=
 =?us-ascii?Q?id0nV4Kuecuv634ddXrXSE0cASOyKtT9EXDXUCsMijsMT4s2mirwKuLtk6Ns?=
 =?us-ascii?Q?eUw4Z0w=3D=3D?=
X-Microsoft-Antispam-Message-Info: TI5nxVEhk10vVj3GCHUzJQtYEqnqDyG9Cl66PN9H4KWdtej/wvCtgOUHB5xLkWbmzKZZCWyxABTYh2B+tq8RCT93Pwzmat9YWloRDTF7hsdDrX8PMiExdFKOncEtvnytN4O59G92lyNUNnLAZxGXVG9TU6wn6KrFKJRZT8HCyrLjQbMx1i1WTDo70KFb4c+X
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:dJtPxyrbPsPVEOBesvggic080/OrB96bW5WnFJELbsMtO3HQVQ6X2plMDyjU4DM+v4Dp74IKJwbGlqOFThtYafoZ3LgnSRVqcifGUvvCWUfvty1R7UC/DktltP0mT0Y2eNE+kI4sAvbdkkA5EyVQXQUbgSfCemHS2VU95+cOC5rky6GDyFvp2rAIPVLMMqj7Jch/dNeP2VpBTiagRSIRNqQGHOcXNfjqUIBxE5He66w+IeqAHr0wbA1At5TI0Qn748Oj++gZvf173EiC2WkT7D1q74XLg+7KrmtSQ9Wi0dJslLhwM5oxHVdOIAu3scPPK+QJ2nYSDoldzq5R+IwdnewsJk3qC4A4w+FoEpD8OiTqen1RS2fm1u83zjm0wC45ypAO3BlRrHSiwY4EM+wB422A7uZ8JsEKujPWovZVL+8Y+Fi1YudDHJMhhV+UamJkCjrXLK7PuNQkur7C8ap1hw==;5:FcnrnfMTI9pSSGIPiuilrqxr4625RBk56K5LMKfR7V4e1C4uOYR/xv65opkPCVW0yQF/7tTxdjl5JzmNAtvPbxm9URNd3/8PUnCiff2A9Cehxc9bPjF/yxkH1ApRxg8A6OT8FAhPkrOkpyMQcJO+UlZ3a9NM6+J4wUXecOW2fBM=;24:baSX0ZMNu8DxHE6bkAaCq8fHJqfdfBhAE4p3EB58LQVkwFFFMnMHNKeB0pBwHCsUoi2Jkw7v9poNdaA8RP3QjpFeyJopji4gGo7/u1O7cSw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:LFkiOjtT5dkcii02T5CtF3MD5bMNatK/8kLdNkoHkjKgETrMDIyaT0RfYNvsGhDHDorn9TB/IazDBir5RfTbrfYZWqh0U3qf73FE8CSWuGZWiU0ti60jSmmkURc08A5bH3TiJyszoiTtFm/Oe8vZ3xZsYHhNoZwbFQr6K0dPUBX+HBFwFyj2dVnjAxN4cmyg9tzETvtQJNkXEz9ylLkrOrSUXeC7E395GH6eVvog/gKm2pvFD6Fi/Es5PeFFm26N
X-MS-Office365-Filtering-Correlation-Id: 632a5342-2842-480f-81f1-08d5b9aaab94
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:55:01.2164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632a5342-2842-480f-81f1-08d5b9aaab94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Also restructure debug output for resends, since that code as a
result is only handling debug output.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-stu300.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index dc63236b45b2..e866c481bfc3 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -602,20 +602,24 @@ static int stu300_send_address(struct stu300_dev *dev,
 	u32 val;
 	int ret;
 
-	if (msg->flags & I2C_M_TEN)
+	if (msg->flags & I2C_M_TEN) {
 		/* This is probably how 10 bit addresses look */
 		val = (0xf0 | (((u32) msg->addr & 0x300) >> 7)) &
 			I2C_DR_D_MASK;
-	else
-		val = ((msg->addr << 1) & I2C_DR_D_MASK);
+		if (msg->flags & I2C_M_RD)
+			/* This is the direction bit */
+			val |= 0x01;
+	} else {
+		val = i2c_8bit_addr_from_msg(msg);
+	}
 
-	if (msg->flags & I2C_M_RD) {
-		/* This is the direction bit */
-		val |= 0x01;
-		if (resend)
+	if (resend) {
+		if (msg->flags & I2C_M_RD)
 			dev_dbg(&dev->pdev->dev, "read resend\n");
-	} else if (resend)
-		dev_dbg(&dev->pdev->dev, "write resend\n");
+		else
+			dev_dbg(&dev->pdev->dev, "write resend\n");
+	}
+
 	stu300_wr8(val, dev->virtbase + I2C_DR);
 
 	/* For 10bit addressing, await 10bit request (EVENT 9) */
-- 
2.11.0
