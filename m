Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA74C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0270924065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="biFlC3Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0270924065
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeGEPNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:13:06 -0400
Received: from mail-ve1eur01on0070.outbound.protection.outlook.com ([104.47.1.70]:7824
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753592AbeGEPNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnwA/9/vyd5wFEoYSHIN5LaefqYEQuIdQ9A0tLsMR0o=;
 b=biFlC3IcuGJ0fX44sn+MeWJr2Cwf75Gen2VQmttzMOSkvO82C0iW0cpyXFpYiTVBbJPAwv5J2kiw8TPe2GvQylymeWyPKX0pDv4A+KjJqlQi7brjNDD2eukE/ueYddVsQEtdPpie0ycSYc0k9uNBL9h3imzESQjFWakymQsZvyc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 15:12:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
Date:   Thu,  5 Jul 2018 18:12:43 +0300
Message-Id: <72f3e615f4df69ee6d802efbd1e1e52692c8e134.1530803324.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::35) To DB7PR04MB4297.eurprd04.prod.outlook.com
 (2603:10a6:5:28::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e318785-6b0f-49ec-829d-08d5e289cb25
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:5qg24pizopA1KZDiQ10S5Cnn7rS8jdvdhcOAU/xp3CyjT1gHn+i4TPD0cDlA8kLy20PoWf49xB/2jcQ+0tvYRPa2XaKK5K/YBRBtbL32wmVGtwQkOgNWF22Qo5x9fC4qNyMF6Uvs8lWLbi9F53m/BzJq7IYUkFjmbQ6ytXRGmacmxbUZb3JXQDw6CGECMd1cZe5LV4LLXN5r8Y4U9qb3keVW5ijnO/X9uqWgEB1KZghqdOqx0vUlLAp4JpOov2jm;25:zQEnvaRfljUjEAMU/wSdMFKLzD9x59kUqLRjAAt8I/YcbxD4A+ZjsKhQPx85it34fx6hvYcGRFRhlxBkAXP/UjzfA1d6PnzH+0ldgNpWSYJrbohA6h2/eW5NYaq3mqTgnEl8NLVW2L8cbLdlYCiasJOEEmktBrG39Doja/4P4sjQumSce5lhn+pLwHuwwhPl/PHOtmvlz9tw/GWkC0iknnO9+hrl3xC77oG1gXoPlLqLzoMh6J1H70Dh5sr3AU2Kx0zdbo6g6i+eXva9N9cvkF7IrMYkb67jxkBuwJ42kO60RuUB0z4HRsnN+wKdbQnyHzo+8QTcyiiY9gN93UY5QQ==;31:vNuPH4Iq4ULSS2Dh1MXN1V32GaD/CJ4EurHnAFhkkY1yzT17q2VoVo9AHm9ed84t3cpoOIySbZFRkF2pd8DE99cunxqZj1odRtz/xChngpLFF7wrNdnhRyzdjSa00wTrY4JDrwgVUZLuUWH3i0jGpWiEbhgppQDar41+eWo2VNF9wNCAM9nvzbYlBLsMV1BU+M6aAuF9I63vMS89LvmGk+kVE8BuFDq7XveGOTH0MLo=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:wbBWWt0LitYMVKap7KBf35fMSQdKHV2WOlPfX35XbmcXwEojVY1+UMHBQrNC3OiApR4IBJ5/3LpoR/beu5HGQ+L625rO+4KLjAasdl1hoyzpzgbHAQ6Ga0YBqOomVfwmq2W3WK5SDlqrCLWCibBuhnqlbrUddTjw4F+PYHMD24BYeT2/Q7A9sN1TAcO44NMvrcYmeUZOGpbS/V8iWMZe4TtpRrOtLkhD9Nwoowc8QJCBRMQ8ajwCVjP08KHBeH32kN7gAsdXrqyZfTFOYNv0+H4UkLd7Nu3R0eps5sc1WR1iWhPYl25KXCrjqYZrNfQ69hOg44UzliKD0C0hQ8xdjrx8+DGRxsIoW0u08tYM6I+vqXSjKW3LyNElg9mDpYN5hWxviYnclweV3uQsL3AQXkv7tzFKYrgM8zNJw5NI+rEIt9whSFFh1CQjwg1ouirzXCCKNJHoQQ632oWDQt8Mnz0KkhYd/3e4ov15RTUuydavQCQc0YrNnHgqo8jcaDxu;4:sXR8vCFv4NiIEBIhTUKohZARnb8bYBzXi7J5ubbx1bxCApaIfHuqZOYkceGv8b/+m4WFyMKmzmbcKFrclTQlOkzM0Ai/h/fKYu/BvHTL+is5LEVIE40sQfcq4gO+VlXNQ6HGKr0hx7cRcc7rEKf45eboaC+L/RmtBf2ZyEFylcSqF+we8eVyJ5TlsD0jRw73E5pGOXq96Ke42D2SyintAbw9RE7fadXCXi5ZmxZWTJzOY9D2TZBg1p4FiYTKbrQ5+58wWLy8Qq3Gwhmek9LhpSQctEUemC909iwp+qWGjVBtb3He5mGCQtLauw/AEHhk
X-Microsoft-Antispam-PRVS: <DB7PR04MB4297A41AE1500FB598B921BFEE400@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(5660300001)(3846002)(50466002)(486006)(48376002)(478600001)(966005)(6116002)(305945005)(2906002)(8676002)(118296001)(8936002)(81156014)(36756003)(14444005)(7736002)(5024004)(81166006)(50226002)(16526019)(16586007)(53936002)(97736004)(6486002)(26005)(316002)(6506007)(39060400002)(105586002)(51416003)(52116002)(68736007)(186003)(6306002)(44832011)(110136005)(6512007)(54906003)(386003)(106356001)(476003)(2616005)(956004)(4326008)(6666003)(66066001)(86362001)(47776003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:OhQ6IAUMZQlEDXFDHok8nuaWSKwVgam9k3wFqu2/u?=
 =?us-ascii?Q?424Akm0hH/rzL9oTr8h4kKhobj4Ohp2/IF37BO0QXn8CQ3PN5s3GYf0Ksr8A?=
 =?us-ascii?Q?lMyz9FtTMkjzKoGjnWEh2h4+NgI7l/9sYqNXxkDQ2KAgU2zPjLxRmNXC3BCc?=
 =?us-ascii?Q?R1fpXgHsXcEmYs2JLkaK1/uxK4ekc6JOlJ5UmZjrkkh9iU2GhI7sITxlcBDF?=
 =?us-ascii?Q?Y+0268j326p061TCyBw5pie1xlpXqiQzfcuuY+yY9+SH6BrfYEyNGFYPKL7r?=
 =?us-ascii?Q?QyWK6T56GaIdzqML7CPHpxTc+QQQmpDRiN1mzJbJO7YB/EA5cZK7Bwh2SnIz?=
 =?us-ascii?Q?7bSLulI7Dv1evQ6MsdPYtG/DYIceuWB1TwlJwRhmm0hUaKOFZQxp1r4TCAEV?=
 =?us-ascii?Q?YdI+6bKqtrm7BcD2zmxbNjJp3Eipavvg6ugq4RmGEmj/ro6kPOZVuP34812a?=
 =?us-ascii?Q?USYRNhe7Aspdq4PQvre022Iq3UvWyhR3rsPHbEjHu6d5lLk4WnIFD+BVPnq8?=
 =?us-ascii?Q?r6aQKS8OWi2nLqxK2T+TEZCw9c5jOpekei5Md5w54kL0KOottxIIceGTkIV/?=
 =?us-ascii?Q?VJBkQ57XeJhVZVs10IW+FB4WvAqH+9NR9XjO4U+TGkKn3/BBwfxZV+nDXn2T?=
 =?us-ascii?Q?PzzLc5pJ/6iW6xeDA4V7/BvtBmjVV2UIwp3bNJ3fXzRt27h+ROMtBHyJQYzi?=
 =?us-ascii?Q?yfM9FmzKeplSoDuJ2SHFK7bpuzU4gHRqXgHz6Q/fZYMFLTNA15d0x2qUghyS?=
 =?us-ascii?Q?t/XPfNG56hQbZWjLUkG/fWD6TYgx4t0/F6xvTcPlXLZ9qj5pNhYacePecCw4?=
 =?us-ascii?Q?GI+/wBxkcxL+NO+HIrzYQV/fQscf+sVQoIQW77Q3Va2DSPML3LKiG4vj6FX2?=
 =?us-ascii?Q?u/hI4xte+e9HJHmzVhwyGiWClzyokqI64SvX3AOl0FqQDytgzuLcGCwnHZyk?=
 =?us-ascii?Q?wrO5/0wY2Iql429OJvkblEoPOFNAUW+4dFlJ1lUlLHfqBe1S0SEKaWJedBTB?=
 =?us-ascii?Q?3ksegFQBtrAolODa5dNYhw0ZndCMX4wvksRaxWViXkqNZuqLiQhOivfk0HvZ?=
 =?us-ascii?Q?OW1Ugb6HTbbSY4wYCV0+uVXIdHYETbRZOUYUfUVN1T7Ydt9TvbMjrymkwMqg?=
 =?us-ascii?Q?hZyHkWPUncriA3pikEahBh1kAT0+lftUkLLxW1vbc0uY814DRovhshi1/4hC?=
 =?us-ascii?Q?alfC28r0FBJAHu/4J7BZjHxiPVYpObq1STqjeetd+50mwICeQOgRQ32h/Eps?=
 =?us-ascii?Q?2z7txlb7qnduBzQN7yulQx1wRoMBbuCu3vheSi2DA9qUr1TZKx8kUPYgvFOE?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: lRhMlU6cUSDAtOHeJAqtvSzGMWXkOrnMLWXYdScUtOyJ87ABV3/VuSXvToKkw/Le8RhrkcFCOtWOG4ZzkqwdlvaYDDp6HgQLeNnf3YidFomvkfYXP3z+RmTBl7tCGGm3spGGsFYSfMgJVzJllBuIfN4PODjzD9TszAz7PA2EHlRmZNTWtB/ZuJGFbIOm74VuSXB9aazxuSeaV1PJ0vesz+MWPsXoDMCZRo8iTPzhBVQzwBABK7yjJCnqwPmE4De+USfS7o61OfIUF6+zD8ma8akSlNZsfDF4weSvAhNIcw5FwN7GlOFVcPGuTYWkyGkvhBV0jGVKOkEeVUo9Rw4viv5On0QZssjkKXEW4sRi75w=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:Cs2d5JVLH6a+8rKavocAhKXTLLWRG7FEmy8Lgj0sVFOPwdEgWt6+Z81L74yFTAEfjnQWji6nRcgDQBVunulCEsL9iISmdrWFMlWL6Ia2Jxj4x3y4XyExXlQgOYNcbUdYRw97ltWaY+wpgf6rpEEpI8anPUL1S6n3zgQN/cc3cQMcg+nKEGHWmFQW30Ignd4KMvXjRImuogDdyN8IlP7amnKEysXZDYvVJtfea2krbp6W+Gl+7wHH60jO515qW/GzvSl7G7Cvbb6eZyIRX21idhSVBMr0So8gAelejqKoRI3Ewed/KntzpXpFlHIoeLIuQ2tjdtth/jd7Yi/SYltbmmZ3jyk0o3dxewHd9YyEiU6cO7O5UrVwB5v5a6sbf9SO3VT2HMsawWQPtPmcac+dOZdch0sWlaPn0A1oX5mDbnBDlIqGbqgvafEtkU8F9ovn+ujAJ9+RogjcQ5ieeRxxzg==;5:wUcD7eRYuVAEx/m5oYdSK2m6oavqU+pvxzlF6V+rqUX8dYjqmClct9sawfBXIMWYtQSyeryiOaQHUZj1Jag33/TzX6K2fl8aufTHQyl/A15AXAeaD6HPaviqxO/uHEu9dhFEtV64J3/92B/30wr4aROjtj8xf034AI6ZIdv3Sxw=;24:hdQVEFEIY3O/Bdu5rSxAObiQJYxN85jBn5dUhrvVxrua+ctOEKDVtSdDRyr03Fkycb/LUNzmJjR8S8LaAE0emXvB4QuHKbEfa+zfxQhO6MI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;7:8+87KFR+KoMiE5NZEUvho+mdus23p7CSkLkRgEexuE4oOV12lMsUB8p4uPl8IvNpRFU+hVcjlUaLRkaywayXx2SDcUQmms7xdJplqld+SAEy5ik0zAISDskC2HccHC2GWNNnJ3e8M8+y5aalkMTPl/hCLoRgLihgWbJF/Z5qwbI3ao8ueCvsObWzHppZa5XBnq85xlZEnVstQ1a7B6kR+E1uUVymIEyPorxiK/2OHvVafKz4ZergkKG8Pj3gLHbH
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 15:12:57.8916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e318785-6b0f-49ec-829d-08d5e289cb25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx6qp power gating on the PU domain is disabled because of errata
ERR009619. However power gating during suspend/resume can still be
performed.

Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/soc/imx/gpc.c | 72 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

Changes since v1: Implement SLEEP_PM_OPS instead of calling from
platform-level suspend code, as suggested by Lucas.

I'm not sure if doing interesting things in the pm_ops for PM providers
is recommended. Is correct ordering guaranteed in such a case?  Any
VPU/GPU suspend code must execute before imx_pgc_suspend or it might try
to access registers in a region which is powered off.

Perhaps ordering needs to be guaranteed by implementing device_attach
and adding explicit device links to pgc platform_device?

Link to v1: https://lkml.org/lkml/2018/7/2/370

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index b4acdfd3cffd..96d9e882d583 100644
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
@@ -123,10 +121,27 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
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
 
 	return 0;
 }
 
 static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
@@ -227,18 +242,45 @@ static int imx_pgc_power_domain_remove(struct platform_device *pdev)
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
-- 
2.17.1

