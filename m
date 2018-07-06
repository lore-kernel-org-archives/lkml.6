Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7075C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A59821EEF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="moDzRRVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A59821EEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeGFQq7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:46:59 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:2880
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933157AbeGFQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzFEwKMuM8DkoKyUK3n8rrRwMR3LYSeZE1wtsbM0aBg=;
 b=moDzRRVWCJqGKALZHpjC8l9EyL18b15FHeEe9OqrPXU8v0tcNV0oUdNjF7anNrZ/t9ccYsb6QPSAWEYFODVhm3A2DGsiHDcVizltg+Os+DCfsk87198evR1HMM0HAf2GIDb5tWS/etBWiPfUuKcbP23bBmRO3XB0EFWPcrZViyk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4299.eurprd04.prod.outlook.com (2603:10a6:5:28::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Fri, 6 Jul 2018 16:46:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
Date:   Fri,  6 Jul 2018 19:46:33 +0300
Message-Id: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::24) To DB7PR04MB4299.eurprd04.prod.outlook.com
 (2603:10a6:5:28::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b698ea1-94fa-4a58-2235-08d5e36013a2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4299;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4299;3:54Bn3mzwokwaiWz4ur3kANcWgmWqJ5Yo03yny4XbF66k9UIqTi/OOSbU81ecHgI3eGXwzYh26VptpMMa5uMIfH0OE8cR0XQCsnN6bcJEtLKaXf2IQiBy8L7+pejUEEqEjF+Q9HrPnb3sODvo92E/KZmD1XVmxoOCYmHw6IaDx+ZTySmSHe2szUkE8TApGz7q+f2psjG62tHP+bvAtlbaaZIzeh9LIW7pOW8I4x/p0udWJCy/EsENrKYQy3ERxJM6;25:hSMBFn79QhpZDZy6OrFQ1QgTbZs41BVBpfHjntwGVOIZKOjUnXUlRek/dyYQjdBYdWiNafPB9cWb0CBTEYOtFxtsbzBEDE4MhPK0NQh+rMDft1aCpwRHBt1aAKzX/xbM+Fgkc14A8bz0GZO+uX9cjwwRxHYdz3iHgC9AzWw5AYGbV4fas2svdGjmWBXnHIMIwPW1h11HxCAku250GJZqIHTa8xpnLIvmdWIRdt5/rjk8FGqn9asdmt/z7zhEnEB+5Kjc368tWKuuLSoK3JHOc1QC85aV5J4UIeEmLLZnfaLMg8yggGFN42pXJyl4kxmS3rq0AO9RX+Axop0kXhnlFA==;31:53iS39cjWXVBp9kWmSpYfCj+C150qWDVg+KjMEho6pR/Of2RV6oa3BjONhopdBsLvXpY1G+IhMDv506Za+rXMpo8bnTzJ3JsA8BYUa9SgjpUpdZdJnRZJzofyoineqIlxuiqPUGPG7ZM+3GXZ+Qa49KpiRdX1lSe0wXnZFBVh+AnsaBVZ8HwBvvHFHxvuCXK78zU+A4fJxIHBubMnk9W4Qmr41Z9fGHbNzJdb9dCi5Y=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4299:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4299;20:Yx5oSnt0m87nYzp0Tf8qzZs8DGQM6m8tJ8YYNgH7Dfr+JIfAdkUtf6B/7cvTt8/PREhEU+FcNePRzUXzNh82eIcuvU+lgKPCW8jEA0fsmIWJfDa+YhARFdI1t5N3C4zO7U4IFWaqrgmakeRPSFjyig5m5Dv904Sm7pUJMhEp1i0HAlelxhmlNoq+DZLdO8w/OltgpakOau3VuqgG9ncZjkJuaTZY+/pdq13knCSdxbnP75+EoMjraJTJ6ImfZ53ENdFhwSCfb8xLLm3GU0YiDuwcKqohAmsdQoq1d5K/HZGO/cv2t22tCzRscAjCHd0Nq7MAtlcYADkpXZWONyk3Vo8hRf/zpV5yvDl1+n3pCwOiJa7x0sBN37ygTqpH8ZnMnLLaIDf3bET4c30scXnO4XfcBv5xJLsDY8l/BSwNgKpIeU+QWtc+zVsl0LUZL85eJvqHmolT5moEaWBAmyy7mGjS5esjPvoHVrN1smC/zlhp+R2Hxw3JE4hk/GNzChLG;4:XPxTaobhDblykdtE2GR/KcHNfmcTvCEcbypLMUXbdrqSaGm7c0ukNNKHLOm8toOF+Ns26VEociWUswo4dNwxs54Qi6G/Bn21T46jHWI85BdTbSesQBNHpix6JO60A4IrKhfmsFTtyt9U0ZFUUSJdz2TcnL19+RKYSJX4WY9xU6E7bW3DEy+RTrZl36NloTDz1GsqBCLJo5DA84BrWHUKh9QM06oAOXvi5iXH39ZYi6+ZNe2nvK3JfkPIJZrkQK064FYfveOOYPwQ01nBUuHjSi2UCftUy44H+xBCnFnZ1iKilQP7PzFDOrcnUF/chJmxpcJ934K0njw8orDJkrAlW4NZ1qxmpGPM6T6FhC13e3s=
X-Microsoft-Antispam-PRVS: <DB7PR04MB4299316383EED34E2DBFE062EE470@DB7PR04MB4299.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4299;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4299;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39860400002)(396003)(346002)(366004)(136003)(189003)(199004)(6116002)(106356001)(54906003)(110136005)(186003)(478600001)(52116002)(476003)(68736007)(26005)(118296001)(16526019)(6666003)(386003)(6506007)(97736004)(6486002)(966005)(105586002)(50466002)(51416003)(48376002)(7736002)(305945005)(956004)(2616005)(81156014)(8676002)(81166006)(36756003)(6512007)(6306002)(5660300001)(5024004)(14444005)(39060400002)(53936002)(486006)(44832011)(25786009)(4326008)(316002)(2906002)(8936002)(3846002)(16586007)(66066001)(86362001)(47776003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4299;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4299;23:AEC8TmTUdQf0tFBCjtd2Jjyvwvrgzlg3rdiR4Dgwq?=
 =?us-ascii?Q?MJzoQx521ypkHPyIRu0Bx3YHrxv0QAaZo2GBcEJYnJ/ERt0BjV7k9qRy3Orb?=
 =?us-ascii?Q?e5i+tQ7oetgFTy9v9kXKZDgNk6Qd25hw7lz7CKGyoXjBlDju/wb6d2GeqaND?=
 =?us-ascii?Q?yMiggPGMquQmqZXhJhX0paRSuoPBH9SgN6DaIGtdeMMxHd89chR+TGKjNwl5?=
 =?us-ascii?Q?VmxtVcf3heVHQyCdqKELsImhs0PMPc4/DX6iZJkB39V4j4AtxWhIDgpUfma9?=
 =?us-ascii?Q?ICpJC7Q+/ozVh52RyGp18dcSLh4JMba/gZ/aXNx/YzrWweIGPx97jei6gxzX?=
 =?us-ascii?Q?NtEHVVzr2Af5XdPHQAoppWMkiE9LQRrAN2WTSYUqE+D04/fx7FLOZz7kCq90?=
 =?us-ascii?Q?2n00JJHFqIql+2KSVpWLoNendnI2RC5fVtLBTQmruQSjSTcUTQh3/hwlwJT1?=
 =?us-ascii?Q?eHsOPBm3gHhL03iJfJHg1eRnVgJwZfoFmW124ZJ0Cur8e5YOiiCH3w/8AJU9?=
 =?us-ascii?Q?Jrcafh3tT8xAVSDoRO0Qk+9PNUSfPqNxS5MhvFVPkayFYY1TwlS5H/s8lTZZ?=
 =?us-ascii?Q?36qcTF4rhYdAXV4JSSd4LPb5exdY8u6e3DWDyowh3z1HEXQDqvfwnSRpmbvN?=
 =?us-ascii?Q?m5Ee6SKQpI+f4lO0o6Mek/KYka0pbrBFBKayqoF2zpRPUhwQGbjAtq1supTE?=
 =?us-ascii?Q?ZlmF8kzFXELbebxKA2EmeMxY48ZwLKiX8d/P+Ao/bjScx9uWELwpOqW1i7NW?=
 =?us-ascii?Q?iyDc9v1854LvLuCRFh5PEerZ0Y4e16gbRCxXxv3cuM08bhWQEz9FZBAa+yuY?=
 =?us-ascii?Q?a03cyC1opwIRv/o9CxXyZDEzcgW0AQFgUn3sTuczQ+kQUz4iJi6hZTObYsN1?=
 =?us-ascii?Q?tJte34QBkV/qbhii0YbQ2DARo0tbLVoRTXVkW2vQu50hGI/uCGLSif9z614n?=
 =?us-ascii?Q?++gBoebqDNLQmSAKYLhRmRxIHRy0QggJwgz8shjH3N21UId6c5qh3OvFsNTP?=
 =?us-ascii?Q?6yAlp1Bbvpbs968loyS1bHhe296EAEacKf7lnfZm/f4gqKzAFbxq7vL2RsoD?=
 =?us-ascii?Q?BQbcqDIN5vSnBiufv09/vi5SN/cyh6R1L/liWP6C7R512ravAMCk9RADF6K6?=
 =?us-ascii?Q?WiUL5x2hDpW1+nEQWJ+6LPIelFHzW7fTatGRJtfWLaJW6CLfOOMLEYH7p1lP?=
 =?us-ascii?Q?TvMUn7+SZOOKLwg7J2Chynq88BGuLt4B+6FtERv5TBh5fQXHnQH0ggBX+csP?=
 =?us-ascii?Q?iJNczokX+1KOVWO5K7C32DyFbue958wYMfbxmgVWbePvBP9kleXzRTMA280A?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: BFXO/GpYEvCmL3VKRQqyMbQFg5fAy3EzeO2WobG+D8TgxXVn/WATpPMpbDYsxPv0H7sEz76Twm4UUnX97YTe1m8tzz6Vc0JxIshvi3SOTvAcHlhVYgABCr3RP0fhAuBJn8x2f80lt81luM6NbZS2uMCJHzVokMmJtZWm72o3WtWOtkK6EUI2CYWQBCnbVUsSFw5aRy8gzQq1RozVmfBz71y1l6JFGEexTh5AMXJluKjXXESob8XANMK/IA7GQEIIJsnCn4yl3kPCgB0Pojj7DEvXezlc9pZJ6pJey3oT33xJ74p1XhSPhMwuWCpabPnQR4Mo7Dli6mCBItNnqdB3q2h0jpi/NGnJ/VC/h/Svs+g=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4299;6:0d+xOO7OX6oX7dT41k1KeCzqXsGzuvyxJvD9PkH8HxGhl4SnPn+XMApXjGwGukuoPk110CkQbQKCNk7tqwlPtG5/AHmhTIvDgjt51H15E1RCmcQUvysz6yJuWcId5bX1lN1OfyscT/JebLhKQNJ2MS17RA8yc923qanx25TK+s0adXkNKfycAdIQrjCAsGsojUfKxWUea0PRlth1TaCCosB9SdEsxgVZJuUu8HIrSm88jpOStPXxnYGbIt68uh3xOg0ef7agUd5PpvQcQarrxaXelb0quOEt2WnBO6BTA5lNJf2an+d/0N0mJpMUOk+ZugHmg9IgYqtwVzBmvCz+Ei2NbVVNkx1bkQSO1n4Lk5fBO7NPjOceyyF2pALNv+NVvR+TksCymqUMYpP/fCmbORD3iLQYILx8Eqsq1vL6xhdbE16ChP7ouKzs67WLjravNeU9Gx9XyEDLo75L2VybXA==;5:zMeAYP0SLBW8Gw2wHw0ijyY16tMgjvdBxovXYdehQQjwNpymncsDvyon42Sy0wAl9YM/0XyGJ05e9ts609t6OaQZSAB7Lf8xza/s8wyCU66HDI8V8mrqJxsHk5mkdAQ7oieB/VFI0i9lFJ8QdE/AbQ4YbFxiUXhDyKzo/6QOeSY=;24:a91806CZy2l+AW4B+UCpk0ie+uV9lhux6Jt30X4kGLBOXTWyqunT3aX5INe0oqw7mJsuXWrIFUikcFmmoyd0rXaiDWq2HJhcy2XZ6ggU+XI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4299;7:Ha4kXW80Wb1vNvWJPkgUDEou3IneLcj2Q37krtde4z/IL8Am1sj25rSv2zlN2HKWJJmlSKnaaTzg3vZKispDq8kL/O9SA064Zp+lWlqkR3JVa+MYCdYTqs2Tv1vlIkvyuJkxz83NU+VZXrzq7e7e77poug4239m5P0DHCqZMKiWDT1aBdd9RQ1RMIDFI79nEuiLeygiV1b+IjmmsHq8H/LBnMCszvUa7STWsyTAKx3rJN3UebN9GGI+DYjMMoeCU
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 16:46:51.8864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b698ea1-94fa-4a58-2235-08d5e36013a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx6qp power gating on the PU domain is disabled because of errata
ERR009619. However power gating during suspend/resume can still be
performed.

Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.

In order to ensure correct ordering add device links from devices inside
the PU domain to the pgc platform_device.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/soc/imx/gpc.c | 88 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 15 deletions(-)

Link to v2: https://lkml.org/lkml/2018/7/5/564

Changes since v2: Add device links on attach

The NXP kernel has been turning the PU domain off in sleep on 6qp for
many releases so this behavior went through multiple QA cycles and is
known to work. Further small improvements in power usage could be
obtained by also shutting off the PU LDO regulator but that's not as
well-validated.

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..b96d8dc9626d 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -54,19 +54,16 @@ static inline struct imx_pm_domain *
 to_imx_pm_domain(struct generic_pm_domain *genpd)
 {
 	return container_of(genpd, struct imx_pm_domain, base);
 }
 
-static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
+static void _imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 {
 	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
 	int iso, iso2sw;
 	u32 val;
 
-	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
-		return -EBUSY;
-
 	/* Read ISO and ISO2SW power down delays */
 	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
 	iso = val & 0x3f;
 	iso2sw = (val >> 8) & 0x3f;
 
@@ -78,32 +75,33 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 	val = BIT(pd->cntr_pdn_bit);
 	regmap_update_bits(pd->regmap, GPC_CNTR, val, val);
 
 	/* Wait ISO + ISO2SW IPG clock cycles */
 	udelay(DIV_ROUND_UP(iso + iso2sw, pd->ipg_rate_mhz));
+}
+
+static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		return -EBUSY;
+
+	_imx6_pm_domain_power_off(genpd);
 
 	if (pd->supply)
 		regulator_disable(pd->supply);
 
 	return 0;
 }
 
-static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
+static void _imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 {
 	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
-	int i, ret, sw, sw2iso;
+	int i, sw, sw2iso;
 	u32 val;
 
-	if (pd->supply) {
-		ret = regulator_enable(pd->supply);
-		if (ret) {
-			pr_err("%s: failed to enable regulator: %d\n",
-			       __func__, ret);
-			return ret;
-		}
-	}
-
 	/* Enable reset clocks for all devices in the domain */
 	for (i = 0; i < pd->num_clks; i++)
 		clk_prepare_enable(pd->clk[i]);
 
 	/* Gate off domain when powered down */
@@ -123,10 +121,39 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 	udelay(DIV_ROUND_UP(sw + sw2iso, pd->ipg_rate_mhz));
 
 	/* Disable reset clocks for all devices in the domain */
 	for (i = 0; i < pd->num_clks; i++)
 		clk_disable_unprepare(pd->clk[i]);
+}
+
+static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+	int ret;
+
+	if (pd->supply) {
+		ret = regulator_enable(pd->supply);
+		if (ret) {
+			pr_err("%s: failed to enable regulator: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+	}
+
+	_imx6_pm_domain_power_on(genpd);
+
+	return 0;
+}
+
+static int imx6_pm_domain_attach_dev(
+               struct generic_pm_domain *genpd,
+               struct device *dev)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		device_link_add(dev, genpd->dev.parent, DL_FLAG_AUTOREMOVE);
 
 	return 0;
 }
 
 static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
@@ -198,10 +225,11 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
 		pm_genpd_init(&domain->base, NULL, false);
 		ret = of_genpd_add_provider_simple(dev->of_node, &domain->base);
 		if (ret)
 			goto genpd_err;
+		domain->base.dev.parent = dev;
 	}
 
 	device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE);
 
 	return 0;
@@ -224,18 +252,45 @@ static int imx_pgc_power_domain_remove(struct platform_device *pdev)
 	}
 
 	return 0;
 }
 
+static int imx_pgc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_pm_domain *pd = pdev->dev.platform_data;
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		_imx6_pm_domain_power_off(&pd->base);
+
+	return 0;
+}
+
+static int imx_pgc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_pm_domain *pd = pdev->dev.platform_data;
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		_imx6_pm_domain_power_on(&pd->base);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_pgc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(imx_pgc_suspend, imx_pgc_resume)
+};
+
 static const struct platform_device_id imx_pgc_power_domain_id[] = {
 	{ "imx-pgc-power-domain"},
 	{ },
 };
 
 static struct platform_driver imx_pgc_power_domain_driver = {
 	.driver = {
 		.name = "imx-pgc-pd",
+		.pm = &imx_pgc_pm_ops,
 	},
 	.probe = imx_pgc_power_domain_probe,
 	.remove = imx_pgc_power_domain_remove,
 	.id_table = imx_pgc_power_domain_id,
 };
@@ -259,28 +314,31 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 	}, {
 		.base = {
 			.name = "PU",
 			.power_off = imx6_pm_domain_power_off,
 			.power_on = imx6_pm_domain_power_on,
+			.attach_dev = imx6_pm_domain_attach_dev,
 			.states = &imx6_pm_domain_pu_state,
 			.state_count = 1,
 		},
 		.reg_offs = 0x260,
 		.cntr_pdn_bit = 0,
 	}, {
 		.base = {
 			.name = "DISPLAY",
 			.power_off = imx6_pm_domain_power_off,
 			.power_on = imx6_pm_domain_power_on,
+			.attach_dev = imx6_pm_domain_attach_dev,
 		},
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
 	}, {
 		.base = {
 			.name = "PCI",
 			.power_off = imx6_pm_domain_power_off,
 			.power_on = imx6_pm_domain_power_on,
+			.attach_dev = imx6_pm_domain_attach_dev,
 		},
 		.reg_offs = 0x200,
 		.cntr_pdn_bit = 6,
 	},
 };
-- 
2.17.1

