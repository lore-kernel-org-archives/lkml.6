Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937145AbeE3HQd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:16:33 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:24753
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935466AbeE3HQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:16:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: imx: add cpu idle support for i.MX6SLL
Date: Wed, 30 May 2018 15:12:37 +0800
Message-Id: <1527664358-17844-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0071.apcprd03.prod.outlook.com
 (2603:1096:203:52::35) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:iew5hTWR9v6jRshdjss/bYeTOO2dB5kbI7tZYbayfAeL1duEgPhp5WYg9z8SORezFMwzQLDOxAlQ8VtmROmAUfxZ+9s4LjL8JaQ7cBywa2dLm8taGfTJusoDWCHr0h7He8/Qn4hItgI3cnNNc/U1Ng6SndJi1ap08hh/X9n68BIrF6Hk9dGSjOfhJEfb2mMSlgH/98RPdssdw1EVEWHaQjYcIg14DPAeem3hm+YE4eD2TNPD4r9UhHeAw2Sn/GQB;25:xwOwg8uCu5kArgpMTRj1khbQ8IdGrEV/3eNd8EJBHDtXhRc2oMnFMJZILjz+nJBj58nlaRTpWHSMGgqXUUUOIcOv6BKdjWCilUBfZTrJZrJCBeaWlT9oyuk3BesONKAPy4xIjiF7sIVdtdpVZn1B37RJRm+UGYF8Mod5Sp9UqqrDuisgyU8FmOSZrTCFfCjuuc6bcl8C2WOJe3VxQt7zMr5U3smqa79HzPNQDJiKdpqcW+Gxm25jJSTdGjPGPIAAnIMIExV3syxqaGhnCCT3+fcINdx4xY1vHYYHlmo9RAq0TwHxHUPKx7zx4/gH4shnyKo/GqyWK/28CA4NZPpMrw==;31:y9w0/KWMyNSyLJ3itBxiK7qO7Xc11ET45RFTEU35ZxCJW7lmY0azEL1e4zTw8Oj0pg8c5aDDDeev0qli19Un916q/8iJlQCMnRCctaux91tGIqi4ErjKnupsXIEFtVy1HhSJHzAbH20KXU+yqrdy0WNqajfHD9DZGFzh/YRBuZX0hFXZqANV8ysozrC/kxT+mT+xbGJDnvDOC35Yp+xGpy138PcS1TL0CnPU36GLOdY=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:oVEggsceuvyYc2OH4K49VXbxlpu83d1fzdpkWRBg70NsZ3CsVM2OaJL7AapgCjLjXkZG+bV52Addqe7fdTDJekp0MlnnnQ7aP1RKftpqg5670mDNsItX4gBlyOLGAf+QOUSEb40njmiIpRFGnpSOVVx4rcSrkY/PDgVNFp1zDx1dSivKThZFjmMrxBxdNautrHiCvJrDUL97TbGs6yhrSOYsN/HI6PjGp31Lg+wGYoAdWGgMIWWMsLBtpZbiySzYTPSgNECqjciKHSqu/HWfluN4sFNImeau/iIGBkJVQkguMSazBH2W6VTzguk+FYEyLIxk+LutOCpyPQFcmmI7Wp0lRQhZanjOkRZbKX1aqdZWjPsUQkK5XylEoAfgMjLLZxJwt8rK3gSNLsODdoh8YqosOe/PX+sON8UMgiMJ6/avCDZosFLplfhhJRGcTykNNxzDtY08Tfz3gQRLAiq1BSiOlhzLq2i1BpTEsflXt9XOh/NqZVzOjz5hIwE0HT0d;4:IURcH/tkwL0hFqicoMRdozQuqcHGSuDfQ/Aj3NzZZ1e02xBoEliWYwR/RzL13inFGd+JWblcnLZPfzdRzdq9lcn1r8PkgMByBWHDqSnUEr/WwUkFOi+n0hBr+mTD2+3DZ5JhU+5GcNaoQHPmCLDSXQVD+aIF/RyW/RbHPGPwwihsaYDCLjadrskksOSh22vloiM74LXxS69JMti46/PQkSktXhGYzwUZyLxum8KVvlf6hxTTUKoI4DxOH85HsNcMe7czTw9wiM2hfdQOxbEIIobPySgbwwnzMBByumkcAskjJyzbfVNT3fuDHd/1YXPH
X-Microsoft-Antispam-PRVS: <VI1PR04MB1326EC1DF1802175B02D8CC8F56C0@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(2906002)(6666003)(81156014)(81166006)(59450400001)(486006)(106356001)(7736002)(305945005)(6116002)(8676002)(3846002)(50466002)(48376002)(68736007)(16526019)(478600001)(476003)(575784001)(105586002)(5660300001)(6486002)(86362001)(26005)(47776003)(316002)(16586007)(186003)(36756003)(97736004)(386003)(6506007)(52116002)(25786009)(6512007)(11346002)(446003)(53936002)(2616005)(51416003)(66066001)(76176011)(50226002)(8936002)(4326008)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:EVD5uB50Ga2RCc7WnC2CQLLIFhs68KSgew24TG8G2?=
 =?us-ascii?Q?RitZWD4pMHwUe6OmL7cXJBh2TojOO8AkUwkmrd8PdWx66wfIpbeItSGP0PfQ?=
 =?us-ascii?Q?iiHL19B8OxIUUo0R36vHmHTWish8hZrqDB9/LWLdzm4/WPLjkNpQX10rOAz6?=
 =?us-ascii?Q?0BdgEvFImOjjvk82V6sWcJYX6zcGW/OR3BIYi7fptoW66kIWrE3ujzSO/yws?=
 =?us-ascii?Q?9NiFw/59FBRe21wF//69cCx/dSLk5sx3ujkyR4usnmcO73umsz0IcIUg1rRz?=
 =?us-ascii?Q?JTNx85oB8UYxPOjG6mQ3QiNgtmxJXRwKf4AvqR0BtVEateJweXbDHuS8S5hs?=
 =?us-ascii?Q?8/cFWSV4YOlEM01SwjwRkiDE5fPiSYYvaoDjAvopuRfGMAriAdtEiXpeuoGr?=
 =?us-ascii?Q?Mp252jdaQhYoNRivPIKHgqq8cIrveX3xAfVKtwpkzZzGlqXjW+3bRkefAIVj?=
 =?us-ascii?Q?sHOu5T+XFkaVlXmWqRn/cHhvIQZM9alh+rnamYcxFJ/11f5Z1HWCPHbAWlIN?=
 =?us-ascii?Q?vQtLMaLpzDVsTJIKuzzRZXSMRT+P7VxNSHegJNlrKCAc3BIMKBLwYtv0wKHR?=
 =?us-ascii?Q?fr4PjDwL5PyVUr/QkY3v3gfdmnM31yTFlAAbbAjOfd9kho49dPDpZyf9IcN8?=
 =?us-ascii?Q?ZM6VzTA355yatKm7PhSA4wnss9Sri2CWI2UXxJP64lUk7+MtfPYG72DxMb1b?=
 =?us-ascii?Q?oeo2CPWKxIlZ88snBAeFk0JSpIGsdEeJXslj1Ojn6T2A9+QjcLd7NWPgiEHL?=
 =?us-ascii?Q?EiXvQQnS5D1keZOVa40xlWGWzMGxPHhr/d0KZ4TBCol9f35VQs1vxLzbP/jI?=
 =?us-ascii?Q?9djv3GbhKL+8+ur1Txh/K/ri6vLWgzX29qRW5N3GN5vH83K8HhYWqwvTrZP+?=
 =?us-ascii?Q?zUmVWaPVdpEXjRWNGe54uMElIf9ta7xqiuTOznoyvIRR40U2VuVBFrpnmnis?=
 =?us-ascii?Q?hYgSDGVHs16NBC4x/cJBAIzl8aPzMaQ7q+xNWP42bs+RCATEYWQX9enGRgkP?=
 =?us-ascii?Q?yAe5VYVd7fHUQTHcPXVh1AFJzO7XYS4thk3iRcZTXdPdId0iWmcDbkmmoamM?=
 =?us-ascii?Q?C4f76VxI6yEdPRNSiJjDy3DQetq+HeBsE6Te1zds/We8wN6ZI6j2jn0ED3k3?=
 =?us-ascii?Q?gM6DC9bChA0y/x+Vr0nCskLycRW7Xw2LPb/Nm4aff2vSPgXZ019yMf+Wpw8G?=
 =?us-ascii?Q?zdKVbEvT0MErd0EZUwPu9iEC1sm2GRifsDS?=
X-Microsoft-Antispam-Message-Info: oDzVtI1XHnWdcTbVL6HIDiYBPo5uJrV4m/jX4WFdAW8xTHNbYnmTchj2Vj7mtqwjYM8rogadKSNqeIhTII9ty357JzOi5+ZxQ09cBy0qfDR0+fdGuAIRxHKsSAs8QXkg112mShqGabjADI3kbuLHdxvFT+4TuINrkPCTUmCtFNAZaI/jPfu31cRP3yx0IThd
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:inGY4zf00VGBEr0yEnrYQG2OHomgibfgCrBG438T2WQXkLwMRsjhOZEHLh6oe6BdBDjxDDSpsBmNQdR29IyiojFST8i7rtqGaaUgEDPI4d2urxTEpCQXqJExLgF+Q2awLn2cJkkuI5z9UtmA+A7aJCdQt0TTCmEmnM49XDLbn0+qQ+Q7oKI7ZJ2Q3oPfu8Eh7gmIo66wRey+bukTivbCqla7GOEAHqOxwMLkmr5Kw5WJeY4ncssXUIVA7+F63iJ3NsCGJvC8A/vATv1e5iZSQt2W2x8fJfi8nJwMfkJOextnpu/kAMfLD/NA1ffzmmDsRQQ9fNXbqcWItxQpOCTT+rl6oQ855N1V3q+fQjRjI1nrFCud5K/dl4GVCrXu+OD0UCLsqNgn3On+NN8SYDXqRWeriXiYXILAY3o6CzR+67AtYzTsqT0Lykn9KvfR4hFvUousZmrERUtyZuHtRza/zQ==;5:ddwTRrKRjeRmI8+4XSmj+OVooA0mOTgyjVKHo31BCOsdXzoCuXx1NfzJDudDhhHN+/bMCG7h9LrbSUK0fydnxefuY/Dqzvi4wdAq1zyCYbAXiu+PZy/D/hY/uLcJcR6Ox3FxW9K8WkMj8KNUAO/sfiatP9/cKMPfJahq5r+i++E=;24:Lj7fN/JkVa6TK29SJGOucC+nUi+PhdTmvLfRA29ioz5XMdwgsXsxRu5Z5b+PEwg+V5RAV04VzSZPqM9Mohfa+uQF46doqDkFI5xY5CSqK0w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:qMpSEJrHhhHQmf+vEasArSCij6ylnXh4+/qybJKjbPm6C9OORNZGwc7g6pgw1DbQqXA7EN2oIcMlhJP/7voj1BLCy3iP9EE3G8LVpuqWxU6Hm8IOT0C9BFAvQI3P7RhkSnW+W8HiAPhmzAcvp9aJq+Jj5vX+xnGhBKCCmZOb1xnENP/Tlve+qV81QNvvPNSUWWWHQNV5C/TkSTrgWcaIWZ6xwXQAv0JK4GIzItN2z3GYO13/sRcedwykLGvS0aEK
X-MS-Office365-Filtering-Correlation-Id: 868d350e-d10c-4b2e-817a-08d5c5fd3b09
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 07:16:12.3949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868d350e-d10c-4b2e-817a-08d5c5fd3b09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL supports cpu idle with ARM power gated,
it can reuse i.MX6SX's cpu idle driver to support
below 3 states of cpu idle:

state0: WFI;
state1: WAIT mode with ARM power on;
state2: WAIT mode with ARM power off.

L2_PGE in GPC_CNTR needs to be cleared to support
state2 cpu idle.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
 arch/arm/mach-imx/mach-imx6sl.c    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index d0f14b7..243a108 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -103,6 +103,7 @@ int __init imx6sx_cpuidle_init(void)
 {
 	imx6_set_int_mem_clk_lpm(true);
 	imx6_enable_rbc(false);
+	imx_gpc_set_l2_mem_power_in_lpm(false);
 	/*
 	 * set ARM power up/down timing to the fastest,
 	 * sw2iso and sw can be set to one 32K cycle = 31us
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index c7a1ef1..183540e 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -42,7 +42,10 @@ static void __init imx6sl_init_late(void)
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 
-	imx6sl_cpuidle_init();
+	if (cpu_is_imx6sl())
+		imx6sl_cpuidle_init();
+	else
+		imx6sx_cpuidle_init();
 }
 
 static void __init imx6sl_init_machine(void)
-- 
2.7.4
