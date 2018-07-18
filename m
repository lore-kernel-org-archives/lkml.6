Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF012075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HL2cHfb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF012075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeGROSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:01 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:39184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730920AbeGROSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArchSAE/PZjuOUXdVnlJIM7GmUwOGOaZfVVsYTmOsBs=;
 b=HL2cHfb4s6taRXnetjs6YnAmjasU99w33Tytw8dII4Yc/dIEC6qynlEDOJWmTGZ9v1Osi0P7yulFmqK/4nkLjS9G1oUP+wyn8rRiCgXvUt7gXXAL/3+noEGjW4fIw2JhEkH1bC0BeeuSOPfn7GGxJt4GiR20S11wPP5nJpvbOC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:39:51 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
Date:   Wed, 18 Jul 2018 21:36:55 +0800
Message-Id: <1531921023-18497-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17751a1c-5799-4753-d8ea-08d5ecb3f2f0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:xvH+dosz3gQbqlAneacnhLtbkzsUVXlTIZWCm5Cb6v1QS/6wtgob7hLwQSdSC8P/lj5jd4kM+tX4woJwQVwIFjHvTHzCT1qwTEoJD0ShY7NaGENf882gIFvbboGJPo72ZZE8evKttFGuPR1FvN0jds0EF4zSqCR69EOiGA3NerJ6mwmsgcq+3S9k2KNDRuXJVSQojwjNj88/V89wp/82db9AK4ZHbk0Sttn/GjcQTLbnIakVjkSbXNWq7t6Fkydt;25:kaSzEvAl4kiVqODyCfzwHN9MBss2HjukWT5yIYqsXGwOaMYxnUgS2GDFu3IChMiSvUphb/20zOrSZOZk2B7yEvlohXjbzkCWGjtGcPM2ZUnUcK4Np7WTxqSM/JWzqyisf2k3AKHjVcCNPBYMuiZOWlRcEgMB4h9nyUR7RkhMAZnRW0YmF4BTErbuZOkt1p0m1CQMey2OBTFxcGwZEd7rIKzl8Uw3QlqLSXMfpFRcBIZ2dwHGnFNHFTIbhZJ/JyiwpA6yW9mmjJMXfURmMm4wu1v0hAyKPtNv6EZawb6GqYSbuAogXzt/Q7goQVKRVyE4cfutDotEMzwLP/6aki+lRA==;31:OGZYPvYos9/DP3gCYDI9C+AbNEtMIh1nu5bghldTTBFPbzOAKOn5NDb1CE+OHk/KFHhm6n9zn+956Etic+Jn2w2MtdwijVdtK16eby0DtsvRp18WPLCg9xhm4UzceJyWO2E6Gi1Z3MkeDhqiyu+JzjFApsXHprtIjEEgEMecRfD+Ekon1cIRP8Gk2Knzw/LWAxiqOxAH0z8VZbFXquvC8kLLGuctSKVQk4Tfi63+gRc=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:SgDudpQrBtQge3yiiklm8oR1mzDsZ86Gg/TJjaGLA+wZBpPpGyfDidFjdKR6D+jNQcHKuoSJMZNuvaumwAWaXTzuA5SvYEG7F6XcltqCV2+WExHWyzodwiUPxSPW3myw6MCgABW07O5OnnbW6Y2B63hw9vV3XzszDA/jF5YufYW3qvq13wnFMuDGvKksD9MhhvyVRvZSXVGHB7/1tfaSgDifKMoY5BVKQxvaB2Q+jmL3VIw8H5DAl28K9i+ispiQcp7QxTgI7CWMgUM9XNIoT/fUBHzU92lCWyQ9qLHkROKxIbVB/gwK7SEUdRiqc63V1hrcDIHDPbxOIBNqP26pAceeGYRoWFD6V397jARWNuosgU9ft3ucpTvI2K1Xr/VvsE+Kh9jeb4JsQXtKAj4zF7uNVAOhoHhFSQ0qvc6wrk5ZBycdaIKLEX7WRg8R4htFlufMp+7j8Xr+iu9Vgb9XH9CwRRi53aKJ/owjCbdKo+UgO8gnrzE+jB8T2tqcHwTZ;4:CEU0Cg/iBvf22dxKolZfFTIaUtL+al+WxuKbWPJ/saK7H2OcYMOl5ztJetwmAG/drN8V97wH8BKRY8zFu1bAiPZy2Uvgo5E/ICHTFMiH80KSsbmIupbdhyNl6vovSexJMZV9aG5/svN3s0NKB4WZJAJFtI21as8oIvDvtY8XnhY8gAZ6+8khs9hzQu/85RbV29noUa9Frakfvz4fxOb8xtQBTi6V30sJr6EvAEMIwju5Flk9aBiRH7X7gRumzd7Xh7Vw4FHmVq/rMPkKJlOljD/AyjHN7Bq73TJ4GTUhxCD7LQo+JWtUJV1FyfvTwI7q
X-Microsoft-Antispam-PRVS: <DB7PR04MB4219AD82684DDADBA1403BCF80530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(86362001)(446003)(36756003)(16586007)(25786009)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:5X8zlZjjZftmE4/1JO5C91RKc6gBqoPniGxXFQkoN?=
 =?us-ascii?Q?IfKpNi3ff1Y+BxlEv3A7IeeFo00AfOxOy3HbW41fSk15Ud2KLb+R7Lo/97jj?=
 =?us-ascii?Q?ILyzUNDL0INbuIHrGu1OlopBuSsuzFy6otYfPhWRDvg8uAAjpSaOWqaapBMg?=
 =?us-ascii?Q?q9aHxtp2yDgimIRV0Q8dR3dLj+PXkFpX+XYkcAHAMQu2VPctHNH4ydrIWQpJ?=
 =?us-ascii?Q?oD+rH6mR+nRgGIKJu1QYX8BVeKMaP92qN0Q/BbQboknUMlvxaWyfrtpETF00?=
 =?us-ascii?Q?GSWVd4/ILCtOfjn92QVSzviMD9E9lcE+LQ2vq0pmMU2nl1Q57fW1EWMKlDKY?=
 =?us-ascii?Q?gVkwptSxOSc+JToIjK15fWhIHDwdVduz64pwqBAtbGqrDkWTdYi4Jn8+hcwI?=
 =?us-ascii?Q?BlEhADGrDvxqJnadWEKgSBROPDzuyO8W45NclS1kn8YvjA3aVw/SiCNqvOMt?=
 =?us-ascii?Q?LmIzhCd536k+e4zIwjZUkDncqyuAw7WhcZYpCng/TpNuW2/YF4HW4WjMlxMG?=
 =?us-ascii?Q?NFkgNms43jwYaYOLGpx/XfzSffeRehQq7rF8hC5OA1kK5pLIsoMAFxTstANs?=
 =?us-ascii?Q?FNz+h1VcdnbQfGMNlt17//ZfHKCOrvDNMDWXyrJ9ybL1Ccrz4j0Ug64a1WRF?=
 =?us-ascii?Q?nGKKyKBVpt04Xjg6ByZdyefRa/6D8p2MHsWD90o3T9LX7DQHv6d1F96MkGru?=
 =?us-ascii?Q?oMq08OFiyO1TWdbrj0kHRZ7U25fGGvbaMKk2yNX6dThfDxamJ9lI3j/pCzMY?=
 =?us-ascii?Q?SetxpNHaWnFX9FnSAcoDIFdhpsafdwHymR/L5QJoy65K2tsenUgll9KNJfbD?=
 =?us-ascii?Q?MX8/1HthR1WoCr2pUXqwgjlBKY2ZMKit/+N/Lf0X3F9MILl0ru+devBf+oVy?=
 =?us-ascii?Q?X5cEcH2rAaUAsu/xJT8Fze4s6nGxx/O7cnLjSdTwknn1fVx/cdy0sMgNJRqI?=
 =?us-ascii?Q?G0pjuW7or1JjmkYZVTahaA9p+LKYrYCgDh12wGuZEry7Y8ZeVDehBsVe6r6H?=
 =?us-ascii?Q?xCPSLPyHvl8fNbAdMjHPQk9aHLfaGEdwQQpRPY3Inxx9j/uE9Q2mAPbUor4m?=
 =?us-ascii?Q?Dmk4ocX5gieX+oAEo21Il0y8AgF+AspK1mPztSEVNtCI3zm4sWEyMXu4YzEa?=
 =?us-ascii?Q?V2uykHqGEfelM4k08gKJ8H9im1Gphdnnp7ukTXIGNJb15F94YHYXJ0lJQhRf?=
 =?us-ascii?Q?/jXRlJIiRur7JrodjRkZTuxh9MWstNjE/zrOqY7Ut6zVjM1H+yEpZS7eQUlT?=
 =?us-ascii?Q?3DiUZYqxqxbRnefcGI=3D?=
X-Microsoft-Antispam-Message-Info: deGFYsiRywFdfDAam9RsqbGmOdRKFP0OCwDARytohYtInkBP/EVt7x+ixbTOhrkLlkfdOhAbUR0jbHcjMIlm3xWa9hrqP7nKivclOatfSp07KVSE9jLo4Zze2ts/Lhiv+rA4Y3Bs6rFPzgS+nNHqPFFCOw1jAYgckPfZAn8Lmf8BCYeaxorlNVgGoYGt9XDg+6CT7nH4IGIKRTJVoIeSMNjwV7U0hWOAvv7VL8YxrRGGbtz3geCJbldIMP6PRY8DM3FWUAKk9/iXB5Y/U0ITCWkkVfdX/HHCee+htPdrXVZ8ptiyvduxM4pCeHyTf4RaYSQGQryDMsEs1Yq6BfFLBZ/oo2359M37lpOu6XWNIbA=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:WQPbkFo2nLYOILs07z8MziNiSg+JHQc4bZPPWOdFWx16qA/7XJRAJOQMVE0WCpAb6oItuEZ/3tSk8+2Gs+a09sLLaZPol+suArOxi99uKwTx2jua2uXMPuqUbHCx4/ckpE/voph0xea+greHx4ST4LClgH3TVRUxraUyTZo1MnhNvi6g0SUknZEB455BkMCt00fVeogi6A2tyqseYh4xU82Gx8SeuRDcape95VsxtgWc7J1mkjUBGwWBpfzR08wOapSaIf/R1uxnAVkJr6+koIblvAfB9F2wcqMjIWIrT62xt1nWU/cgDz5mspgp/SLOJdA9v66uabsqUAzOSO0RQOB4Kk0marZZL7eG6ocpRBmVZksaYS4ciXymAtYSD7tRK0+27tMJUWj4DIG8RJkYEtGdEoh8siTHsNPwYR3EPKW0yuuNt3ol/YlSFPRHYmqOFgQVOTyyU7Zcd/p6cuuIIg==;5:gR9m8DCk+1G5xuTKoNqVcLGLf2U6JfAS6TaYFTfKP4skYAWLhGIiwsf5p7GdeOA8QNKOx+6Q5Eovv++qm5WpGCGNfB+hYuhq2JL6jCX8EtCtpfov8B1hoCeNW46zCsSFkSujZoAn/xBArFszIuqVUzqLPoM5+nFr+Gs17K/Kag8=;24:4yJnGBlzDx+4+itXYOpUsS54g5Pu5grETXrbBISxY4IPuepBZniiviJFY3JD7Kd4xWb5lc4W5S2BS0tQ3fHR7ViMI1oaICbFVxurtUgBU+g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:KmqgeMtGKwHFmo4H/WmB+x7h9r+Iu8agb7o0iEu+jBVuDMX42Wrw2yS9JUpNJQH/viZz5srxSSZ4vERUbn5HLHSrym3447nro26evZ0yC2phcFvkbDXY4VmjCCyYazRtnMK734VBwlW4YV86LoczYhjNF9W/CUzTa0mCr9Bjy0olqPU2oZ1WyR9Rx9wQUC5viL81IgAvMouTarZGCdLu3UOI3g8nVmvIEOZcqmnB5Rz7JkNVRnPLjf9y+J7opcDF
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:39:51.9307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17751a1c-5799-4753-d8ea-08d5ecb3f2f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dividers with zero indicating clock is disabled, instead of giving a
warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
set" in exist code, we'd like to introduce enable/disable function for it.
e.g.
000b - Clock disabled
001b - Divide by 1
010b - Divide by 2
...

Set rate when the clk is disabled will cache the rate request and only
when the clk is enabled will the driver actually program the hardware to
have the requested divider value. Similarly, when the clk is disabled we'll
write a 0 there, but when the clk is enabled we'll restore whatever rate
(divider) was chosen last.

It does mean that recalc rate will be sort of odd, because when the clk is
off it will return 0, and when the clk is on it will return the right rate.
So to make things work, we'll need to return the cached rate in recalc rate
when the clk is off and read the hardware when the clk is on.

NOTE for the default off divider, the recalc rate will still return 0 as
there's still no proper preset rate. Enable such divider will give user
a reminder error message.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * split normal and gate ops
 * fix the possible racy
v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
---
 drivers/clk/clk-divider.c    | 152 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   9 +++
 2 files changed, 161 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b6234a5..b3566fd 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -122,6 +122,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 
 	div = _get_div(table, val, flags, width);
 	if (!div) {
+		if (flags & CLK_DIVIDER_ZERO_GATE)
+			return 0;
+
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
 			clk_hw_get_name(hw));
@@ -145,6 +148,34 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags, divider->width);
 }
 
+static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	unsigned int val;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (!clk_hw_is_enabled(hw)) {
+		val = divider->cached_val;
+	} else {
+		val = clk_readl(divider->reg) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+	}
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
 static bool _is_valid_table_div(const struct clk_div_table *table,
 							 unsigned int div)
 {
@@ -437,6 +468,108 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	int value;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (clk_hw_is_enabled(hw)) {
+		if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+			val = clk_div_mask(divider->width) << (divider->shift + 16);
+		} else {
+			val = clk_readl(divider->reg);
+			val &= ~(clk_div_mask(divider->width) << divider->shift);
+		}
+		val |= (u32)value << divider->shift;
+		clk_writel(val, divider->reg);
+	} else {
+		divider->cached_val = value;
+	}
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static int clk_divider_enable(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (!divider->cached_val) {
+		pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* restore div val */
+	val = clk_readl(divider->reg);
+	val |= divider->cached_val << divider->shift;
+	clk_writel(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static void clk_divider_disable(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* store the current div val */
+	val = clk_readl(divider->reg) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+	divider->cached_val = val;
+	clk_writel(0, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+}
+
+static int clk_divider_is_enabled(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	u32 val;
+
+	val = clk_readl(divider->reg) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	return val ? 1 : 0;
+}
+
 const struct clk_ops clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
@@ -444,6 +577,16 @@ const struct clk_ops clk_divider_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
 
+const struct clk_ops clk_divider_gate_ops = {
+	.recalc_rate = clk_divider_gate_recalc_rate,
+	.round_rate = clk_divider_round_rate,
+	.set_rate = clk_divider_gate_set_rate,
+	.enable = clk_divider_enable,
+	.disable = clk_divider_disable,
+	.is_enabled = clk_divider_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_divider_gate_ops);
+
 const struct clk_ops clk_divider_ro_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
@@ -459,6 +602,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	struct clk_divider *div;
 	struct clk_hw *hw;
 	struct clk_init_data init;
+	u32 val;
 	int ret;
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
@@ -476,6 +620,8 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	init.name = name;
 	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
 		init.ops = &clk_divider_ro_ops;
+	else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
+		init.ops = &clk_divider_gate_ops;
 	else
 		init.ops = &clk_divider_ops;
 	init.flags = flags | CLK_IS_BASIC;
@@ -491,6 +637,12 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	div->hw.init = &init;
 	div->table = table;
 
+	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
+		val = clk_readl(reg) >> shift;
+		val &= clk_div_mask(width);
+		div->cached_val = val;
+	}
+
 	/* register the clock */
 	hw = &div->hw;
 	ret = clk_hw_register(dev, hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..08f135a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -387,6 +387,7 @@ struct clk_div_table {
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
+ * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
  * @lock:	register lock
  *
  * Clock with an adjustable divider affecting its output frequency.  Implements
@@ -415,6 +416,12 @@ struct clk_div_table {
  * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_BASED
  *	except when the value read from the register is zero, the divisor is
  *	2^width of the field.
+ * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_BASED
+ *	when the value read from the register is zero, it means the divisor
+ *	is gated. For this case, the cached_val will be used to store the
+ *	intermediate div for the normal rate operation, like set_rate/get_rate/
+ *	recalc_rate. When the divider is ungated, the driver will actually
+ *	program the hardware to have the requested divider value.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -423,6 +430,7 @@ struct clk_divider {
 	u8		width;
 	u8		flags;
 	const struct clk_div_table	*table;
+	u32		cached_val;
 	spinlock_t	*lock;
 };
 
@@ -436,6 +444,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+#define CLK_DIVIDER_ZERO_GATE		BIT(7)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
-- 
2.7.4

