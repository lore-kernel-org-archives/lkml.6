Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7B9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C3A2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UFayxehY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHaMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:30 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:51227
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeHaME3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2uN5zD1wLZH72UwpIbGwF9qKq/nFJG4ub9dXNnplbM=;
 b=UFayxehYmqrUNznRLrEfmS01wR9Vtp9K+j//ws6N/juJ5ijHPvltwy7AimUkI2iDtTs3BWGC8Pb/W3rwo1uMbiOUfbH/SnCIxWVOYBDH9dSGSZLq5egFKKTpRexvfcuTEDWcwNAwiM2NiHsWR5rCGLGOz/F9puBAC3yjelsYK2s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:58:07 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        colin.didier@devialet.com, clement.peron@devialet.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, shengjiu.wang@nxp.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/7] clk: imx6sx: add mmdc1 ipg clock
Date:   Fri, 31 Aug 2018 15:53:14 +0800
Message-Id: <1535701998-20443-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e7ac68-5ce9-49cb-ed6a-08d60f178110
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:8iUZH71F7QBmavjN/nTs/Yjr9WqE3pZNrou1ZkrSPwXJOxetziON8u1OH5S2quY7HRrYFnxIWFBa+J/H3yXMnoZckEINiTV5om5Wt517PKiq8jbykX8D7SLD6Q8xybOnPErhEzZiyYHL2CUxWDnup871d+GYZgWSUNqA7AIVMQVLPkiIPBcxfKnDyQaWxJ1FhW9m0aKTB3EbBWxIEsMJeSn4A1Xk6HF1Pc7B8Fphm/873jMDcEaS0tpUFkDc8xji;25:Yh3SjjAu2M0w19Teof91AtuqUjxjw/1LdFijoPFK8GXdD7NqV8IS8iwhdvkbvdPyg1ZTdvyyNkuoZVv1cM5iEP4TAfTJz9G7RT18o2RQ10NPYmOHolKJWaM6vsGod58JiV46DR6HlmW0+sveOp7D7QKJzcy3CFTaerj5iy9jKjVQdV5hyuba7IGoisio5S/OZEnY8eGj4ih/2M2Be2vMtUVyEgjNFsmkJCezn84sn+IFD18K13YASL2tnjt/ADsc0UDdX5Dw+/WXiYgCzr5HnvksrglCxJu1QnKpai/VHiKYbUbexAC6RmDUFbgCsoQoAd+ZPRbu5JBEbGn0zPbwZg==;31:R0BIIp9nd6dNx7vARHQ4aMuUcacvs5ebRcsCyQUOLee4z2FbsZ4lo33awyUzFYJEfdWeD9CDA+jDXapMJR8L0D9NTTRGzx1srC75JIG8O1iPAxiOLUzNgXgRTedsepk+BQxQ9KTL5E4PIfcFiUEvNOEA/OxWBqy3kkp/8FT1KVbLxJv5/byFotbRgB2RBwKHWeehVGLwmd4rZ1FQhpXPFuXd1Tjcd64rHNy1U+SheAE=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:nvJ64gRyIyOzBtu5uMsauy4UyQNAaW6v6xTaLrQFkAmK54TLpxC0z1svFES/XqrO+D3Dv5wXngahzyhkLubo85Fv0KFlBJf2/erOYzqpcy11pprA3dp3OEpsm09h5cb2w1fwjXXhOKUa2XdZNC6DvHIgkM2Ipx3NgnoWmaK08ts0BrNsbPA2oPGnl2M99pRJDmjT1tGaKGjkXx7I2YWdU0570otbJo35cFcxP/+NEKj3n7Jjw6LHdAbLpuEcRLV6mHDfd3l6R7gk6eEVoEEWytL2UD1FpX8I5Zdbc7iKrQFCaZy2dQbc8tNzJ1RvGuD95BbmTuhJ2XqcU8OGNK80xXiJKlYZ0z03bY5OhhWMWfrOEw/wb8neGSk/4NbKRlkr/zdBHhsmHVmDUgMTZ8rtW3z5dD8hapWL42GaU9l/j6JVlYoXmI+p14if/RBxqcUPiXQLKvaNIIhIURh3kYEkBg9ceEYIJDJEIbLOQua1BKADFOLaCiNiut4zMRC29qFq;4:nB7yc7Bga/nIWaGINDaDaIxhlKvy8STfytgfpsZFSE7EZz9VIJbEwGkizqYh0Ah4mrXWIHW//Voj9SjBfSfXJCxAMl3AH5ewdghRT8V+kx26mpflsl4NDyAEIFY4aU7h+iLqbAU0Tf7VJganyMz5zsdY9VJtpwKhk5/5VMQyTGKzb0plwoZFZdtGYFelPTEME4FS4MCqgN63LNWoYJomvCzz5OIv6YbstdUmiQ5jZ+Ho/Bz4Tq80CC+Pi9dJ5qX36mh4rvnM/YIegPok75bJTdwdDHzahD3yaw2OkVjyGruwV2EAvcrTaHyp6u+00oJ3
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39074AAC9149F62E6C323ADDF50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(105586002)(86362001)(48376002)(50466002)(76176011)(478600001)(51416003)(52116002)(316002)(16586007)(25786009)(2906002)(5660300001)(305945005)(97736004)(4326008)(386003)(6506007)(7736002)(53936002)(50226002)(186003)(16526019)(68736007)(36756003)(8936002)(6666003)(26005)(6486002)(6116002)(14444005)(3846002)(6512007)(66066001)(8676002)(47776003)(81166006)(81156014)(476003)(2616005)(486006)(446003)(11346002)(956004)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:1CaJAfEbhKGnH8laGHXGzNEqxqRVK0x9jNdbnTX?=
 =?us-ascii?Q?z5NPQWK79aAzBb94fIs3eIKrXAFMkpRXXnTzNTuwC718C5xZvCO3DIChMk9/?=
 =?us-ascii?Q?N76jR5F+WjJTd5MDc68Awap1r9lTgEatuXGQ6yubHl555ygzD51QEvxwZqa1?=
 =?us-ascii?Q?4VeuVFdfIA3yIKCqYq0IE/b1YjuYKobUSoUeBj+imQVDVuZkfMax1yE7Ml9H?=
 =?us-ascii?Q?6ie4iRCNSDAjLqK11p3kAQJMOrgMQA5pOr7uaEMxk3V027UR5/8niEjx1Wor?=
 =?us-ascii?Q?6SIHxe5Bk2TX6OcAwEq4EYk/87e6NK9AY8XXgzTHI6oao7ZgES1zT+Vryqim?=
 =?us-ascii?Q?tqZCbyoLQBaORx60tPBF8MdeTIDLPMVSvPztx9BQrpIyT5iUj64I8GWNInwm?=
 =?us-ascii?Q?f7cNZl4WsqUxSq1Aav5QxmOTQl8CH5xSmngAUQaB0YA5TEq570U4IvJmhhTV?=
 =?us-ascii?Q?LwEaTgxdC4++Zibygd9lJ5KVj2+Yu6W3mDRD73uJ/yK+IzEiA2dI+0Ne8waL?=
 =?us-ascii?Q?OsPUgneTORugy2FEsYrLXsAOuma3Xfzcqjx8DnsXWjixAy67voCSKpyQYXbW?=
 =?us-ascii?Q?fbRJzCRv5rnjOzLlR5SBq4XDCWGyy7IP/Sn+DKwjiKge6CHHV0yaLAGP4W34?=
 =?us-ascii?Q?67Fh8Bbo+4WG2sueDhShgNuTtowPVAGuTtvP9UxbdLUyvhORdB6BZBNj1r1d?=
 =?us-ascii?Q?b0Ycg/gA3xn+KeWAaSrE20xtjCFXBtafPyPasxyVOwXAMoJlGq4hymWA/djL?=
 =?us-ascii?Q?O5pyqWndOmb93Cll4mqiL2dCQnIlbB7ZRWhSZ8iz41V5tkqqUTxNpDi0VdQg?=
 =?us-ascii?Q?x+0i2s7FjVZR0lZEHO4fY2+wr8C+NJ2j9ffXmZbdwfVDzsZESjD3B+s4LfUe?=
 =?us-ascii?Q?HzWHNruwm6KT76APxtDgaf+RMtxQVyrS9eXV8elj70yX18lk3C/Db4fPgq+n?=
 =?us-ascii?Q?SMcbWgQfgD6Gc/NOrGNf7Ss8QG+XEOTknGDNs+Jyu1z/0Z6A1Hr42HnZsGA5?=
 =?us-ascii?Q?6cy8e8HQnhQu8NxzqRtMCSmUAXuyklXTfUHvjvS9sn0NKXxq5yENtxpwnYbp?=
 =?us-ascii?Q?qjCEVn1y/269gCorQ3f/KRTuG+NHaky14iC+HDwe3hDEfdFXY/MmMO18aMYt?=
 =?us-ascii?Q?J5ebNzXD72/kCLe9F25vF19rNVb1TZonGfQR93Km/8DSJ2y38Rk83yyiWuYY?=
 =?us-ascii?Q?SE6/7uhwx7dtzfZUyZMtb8/BvEv3Ar46+dfOh5dIQJsgW5Z5Faw3m399kZTh?=
 =?us-ascii?Q?KwvKrHtucngepes9Y5pA=3D?=
X-Microsoft-Antispam-Message-Info: byYJWs0sfW7WxtgCs/XTTEZaQ9032+ENmvups+V3bklIeVm1RQQirlsBao6Pzuh0dbGGmOr3AB2PoU7iuqEsEE/YySPWqaj9lFhs1W8BZDV/u4WVQdbLxvW2nBprtJH+4YKBXiO+U6B0lHUMvWqOkqVs66xOHUN5041xwAZEdrJEhVOz4QP2MMniNOoJXTCaD7hNKiYxVV+Wlr/8UWoWJOOPukFKWUZA9QS78sA3fs2mOQx9hRwq7+lcXo1fRt1ar/CbThET4oJCvTSG4/MCpdpz/3yuNYPA8eCnaqs51ERxOhfdB2fTRtnDwggDdW9Mmw5PzwvMh28LYxJFIowZ9cWGnw1qVp2+Okzp6ftxjPo=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:L7zUyVNAAnbeqNszAGqcdQOFYEIdOGzm9zIIHp59RkBSGlE1k8vAI1+MUQlKC/AxKMF/hIrNggJWk8mRWiUeoo8DQSx/ywr4PwU8nIia8oPVofuaEQwRInl+Ud0T+6buhOhBofMs2L8rFwDnIBqaBxRIdtz8i+3XKAtvA8Q80yDQTYRCJknmGvZZUtLDj/PspxQDENaDCKJL6EGNoYcvtwk5eEA0/1wZYW9M40BfWZ5CifDwdgWTs64FxtyNaSRCcAM8pf/UD8qK20N+Wt0T6siPfEhASHd3N2mDlkuJ+TsQOrhVVT593Qiy+NT02KQVJ4onulE30O6875MDux4/YYoDOSFo+zCgGE3l+oNiq8Ipy4KlyuqbF/uZGez/Cww75xPYrzE6wwnYk/sT7PIU330b3Y+qCgpmlHROXZUlWdwUGYM8MnxPenTUQiWQlG7xiOnO0aTi3fKiDmQKJcECQw==;5:jGVL9n/7CYUmNYIdZC4k4fg54NARdNBRojv2VqaJYtMNfbFrawqGfZLa0+tztqKEvzxdF04z6Tgt068mNhwph5HDMMvL9DU14mebDywEHc6dOjhWllXLYeZIzX0/72sMixSjgnhy3esineot6cRlOSvRfr164Zy4z5ltu5dTGNI=;7:HbmZBoz9sBFNdco5Z6SDg+nKZxGew5mw47ie2o5PP1xDn9Y90w2R+pnLQa4kX0K1VoyIRNAvADDuPEPLSNo9L9mEYnO6UWeOcgXwt0thfNOBxdHCWFK9dhuxZZRlfYeTjZ8WAg/6m8DcIN8s3uKaXAJFDrOucnce2RLBgRnwapr1Q+icyeuzvpVVsoagY9qByTgOBvikoG3AwnqQM7//KErl9TNL8+fC3m+B1KQAtfEwRwfAwRhgO78PGBXn5Rkj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:58:07.4162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e7ac68-5ce9-49cb-ed6a-08d60f178110
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has MMDC1 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c             | 1 +
 include/dt-bindings/clock/imx6sx-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index d9f2890..18527a3 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -431,6 +431,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_MLB]          = imx_clk_gate2("mlb",           "ahb",               base + 0x74, 18);
 	clks[IMX6SX_CLK_MMDC_P0_FAST] = imx_clk_gate2_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74, 20, CLK_IS_CRITICAL);
 	clks[IMX6SX_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg", "ipg", base + 0x74, 24, CLK_IS_CRITICAL);
+	clks[IMX6SX_CLK_MMDC_P1_IPG]  = imx_clk_gate2("mmdc_p1_ipg", "ipg", base + 0x74, 26);
 	clks[IMX6SX_CLK_OCRAM]        = imx_clk_gate2_flags("ocram", "ocram_podf", base + 0x74, 28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index cd2d6c5..fb420c7 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -279,6 +279,7 @@
 #define IMX6SX_CLK_LVDS2_OUT		266
 #define IMX6SX_CLK_LVDS2_IN		267
 #define IMX6SX_CLK_ANACLK2		268
-#define IMX6SX_CLK_CLK_END		269
+#define IMX6SX_CLK_MMDC_P1_IPG		269
+#define IMX6SX_CLK_CLK_END		270
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4

