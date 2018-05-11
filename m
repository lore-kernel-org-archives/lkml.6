Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeEKDhB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:01 -0400
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:65072
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeEKDgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:36:55 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>
Subject: [PATCH 2/9] armv8: pm: Fix issue of rcpm driver wrongly program other IP control bits
Date: Fri, 11 May 2018 11:35:23 +0800
Message-ID: <20180511033530.7931-2-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(376002)(39380400002)(39860400002)(346002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(4326008)(336012)(8936002)(105606002)(5660300001)(81166006)(81156014)(2906002)(106466001)(446003)(51416003)(53936002)(76176011)(305945005)(59450400001)(77096007)(1076002)(47776003)(7416002)(7406005)(26005)(50226002)(54906003)(16586007)(110136005)(6636002)(6666003)(316002)(498600001)(48376002)(2616005)(50466002)(8676002)(44832011)(85426001)(86362001)(126002)(486006)(97736004)(8656006)(476003)(356003)(11346002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB387;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD005;1:mss9jxqfPOJfzxfc+6gxicOToO5M5ZbFuAS/d4cZYNEjdBTGCV0R+HKNlTzKW5OMVEbjWk1V06/j0vgZqDcL3O6FIdTlIb74ksKfVw6wiEQYrFXI4b5Pi58TEGG8QSxO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:BL2PR03MB387;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;3:yQjw0A/Tb88BraXUcQ09aEOyiWadLtHVqMTFkkdCKZianvA/jKwjnGMsT6olkPbNgONCLyXBUUkaiT8zGf7LW1f2BgtsL3xN7SiaaTm8BO81UO5txrHgo6UYdb6JsHcAwFCEsdQF97nWEL0vPufHqmsmXJd4CoRtv7R1JBVV9Mgx6yqMyj+kWIUtUbozs0DWnCeKcp+kWZMyXPFjzRjMgPHphRbDCTYXKQE9mz8wDPlF1v/Rdq4xc8LwN3I/0ooNcYC3ycLsnXeT8WluOEvo+Cc3yEKSDVclRZIiP4G/AyxewSywwaxCqjpndfrvB91kBVK7YhpHvx9mvF3QKLhPyU5LqYGOVJbIakckz8CTESw=;25:AzsSp8xk67ESGyUbez3RkLNgr9SvEgiIYB52zGQE3aqzQORF0ZkHJ3yyExiOq3dGg8Mn3ezN8r5waJkZNXGbnrdtNXTi/Al9uIouMKj7lUtir/iHZJGTAPpfosR2h+7BHUWons5bChHoW06skSssMScpISw4Wtqf/8CI6io7Scgx4Wj1fYfdNNiujFmaz73nCHXeouy4nDXe3ZIx/kfIte2Dql7nGS1VRpBo45Cj2/LZ76yBaJYubxF2wvJfWbiamxbQ6WvSxCiCyb1sDJIJRyD9OOh2bZiGagdQU2jzML9B1WzCKx16JZgikKbX870TipDL0dEq6XZ1hHzqSi9Uyw==
X-MS-TrafficTypeDiagnostic: BL2PR03MB387:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;31:c1mHT0S6/VH/rL6mF0QborRFBU7/IvC4sj0i19gagtQlHBOtb9Pey4dltsnA2zkQ6BV4rlKCw6AbuAPZBA7iUi+rMKTIW8ddBxUfLCNsd5BeFFdltOcmmOPt+Z7jVQnTHHl63wu36SxKbaAQzcDrqEZRO315QxA+mQlZFOcXCY6ggnBFVzAF/nvyunPaQR0erL62tkqt54rVhF6Si9QdxW/apR0/zAeM3d33Rafvs3c=;20:wn9nmtTflbyQ4tzI90xW2n8yMS+sMcS6rR5dwqOFGSM5qNfWRaAjBFXxDTPyfST4SXmoKGRzYHUrBTLLrFBitbNUzI6b9CDgGkwbnYpk/OWGYdbkR5UBpDhsPp2bZoHGFo2BeoIrStxIkJSQgR+WfMA2Q2XTv90Q4HAQfcAw39urTG/Q3UM8IZp8bSOSCkJVwBEKMRhOd8Mes831af/tyL/mWsv6OuV3cVWB91Nvjyn5YFsQvVrwqx20ShUMTeNudSnRHnpAfb55ikXKhloJmSuucsFLOwQS2xZ+jwvK2GkVKxh9kAJlwKLKji6yob2ItzOYBqi7W2MG0FwbUh9o/LQvy67y1E5nF0PPPBnHl8laAMhOFlU8Fii4nEd3GnJjD+qUz1G3op5wkQEY49ZR9HUqpVNfBKmvvtvKEkw/SneCGLTurWddry4J1Y6Ab+4BxRcT65tpj8w21DJcyb6L3ECjImzqDfPFJpyy/IvJXJlNFMql11ZNTv7zT5SEr0G45wtrCsQ/HqyCXD563Jc68P8x1XtXjKiEVSWUVQEnBkN7NcYByi4H2mzcwVsMCW8RpugSC+mK5oMC94eIfoJPyRY/sho+TW/FdyRai5VzMA0=
X-Microsoft-Antispam-PRVS: <BL2PR03MB387E34CC1977DD261809DE7E99F0@BL2PR03MB387.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(20161123222025)(6055026)(149027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR03MB387;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB387;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;4:JvnYfQBnhdfWtmyn75s6eQHnqzm2A38s0FSj1ushQhMOXNdAY+/IHQuoGhuIFVafI37kyrr8Jd26AMQwjV9q4WFdkSid9S4tOLIt/lYglLpuo+PASD7FApLHGKH/tonjAMmv376xfUGUPTp0ifgQpze4F33vNg6Zoqrc+VzBrBuSlc/v38usdnnzOxL9ZB/VIgeM6LysXpnzbsX9czqCMhFLs1sNswyhWKOCIFg0mTcktmSx+em7w5Eq+GzxfbRh6HLUqcXmKgJuzakjtnETCdqOYfBFdb5RzBpIZhW+rbODYa2X86a3qziZg13oD3Pg
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB387;23:nMSyme74rNyxHfhu8OdBAgTjaDnnwb45/TBkacZMSd?=
 =?us-ascii?Q?+EdB8YOz+3v3JZ8vN4dtc9bGS4otD7Su8S+ObPekagDKgLVh4WR760i8GA4w?=
 =?us-ascii?Q?hHGuHeCpm7r1HMYUWyuMIfauEbkErmcaH9vNemQ0rBxZkkgAIQzRauNhHfqv?=
 =?us-ascii?Q?cOnlO6kw4aXSI96Fp661JOx9uxI1YlSShgoHplZBHspyGbsTkUl1A02l7yju?=
 =?us-ascii?Q?ZWRFEqa0fzKskMyDl081dBHFPH/8QbIpqvwO4FVNXr41YKOyr0LwWUuOaW3o?=
 =?us-ascii?Q?Fd+8qhvUIJ098dvlALJq+stUHflAq/9K0Nut2orheMulQtJESfpVD3XI40g7?=
 =?us-ascii?Q?FmtTKlk0foMBc6Ehx7BWG/Xn5ATta+s5okux9bFi1ItgFiuZKsM/Lp3WKdwW?=
 =?us-ascii?Q?gUyTnvxdKMkwVL2PzlwHm9JbzAO2UnuIjBZ+A7wmw7muQ7hPrExXHZmM3tNS?=
 =?us-ascii?Q?3kDjQYSUgQWNItIz8Rn4ZKTyotQhe8sMIUTN4oJOsRy8uSuoCqsNtANV6LQT?=
 =?us-ascii?Q?nfz76fvkXeNPhBpGT9aIb6ZbkHbISWFABlctD4NKceYq53MGDbH07uTmynb9?=
 =?us-ascii?Q?fGeAClApX8vQvAr+M2nE8XduAsjAOOvCMoEM6xY7Fpk9MpeVH5metmV1kykR?=
 =?us-ascii?Q?hV5gR1ZVbGu/gBc7k1K7VbPgQ7KrJhI1uveTWCAL8zMIKltYVg1lfpGt+zmI?=
 =?us-ascii?Q?72TThBottjNyoQZjqUnI9JkjybsURwlKmmTklEkLwSfD2R9egG6YVazh7Ngg?=
 =?us-ascii?Q?M9RulbNt3ge6iTlgLEajnAhEkX+ndudUQgQxNMdV22chpYM37WOhNPEY2O7k?=
 =?us-ascii?Q?j8gQeDthU8OG5XLMxHeCWYw7GDlSeV1rRiJ8Tr8c6bD3pFDHoSMVWTNKgVWU?=
 =?us-ascii?Q?7pj1LQGNWyMT1gEC26oOXw8U2Ey7Jf3PvsuIkrwpfGww+c34DlSlvUR/xz2M?=
 =?us-ascii?Q?ULbUjkLmVV4MSV8tRTcFMb+Ic7zhujanEls09u6fkWCXLpS73kN2OLV3WaJI?=
 =?us-ascii?Q?HE2TAw9zf7nsuZkfhAVzXa0AUWvnsMpGSnyrIqGpyA9hHkZgwKxelnwBpqvf?=
 =?us-ascii?Q?ahYiRHQFQWyiYCQxRSrewijoakzc0towYdNdoL47YYKFfDzXrE5rlJQ4rdP2?=
 =?us-ascii?Q?jKn2YIeNKVzi28pYe+Cy4SwYpG3Z2ATELUUbEDrveeLJxK+QSKAtiJuIJEWT?=
 =?us-ascii?Q?hjEEUTG1Xx2gsFYY/7DNMW1PMnfZZSecGCVRSQF3sQINXvL9plOfhm6DDyRu?=
 =?us-ascii?Q?ZQUWFwbmlg57fxtaI=3D?=
X-Microsoft-Antispam-Message-Info: lLCPiJGG1E7tIDYaJiVzMPv4ZX+w9BBd5zqpWAij2uCUU8BbW42R2yd3tQMBg2fi+jxUx00It5jidIu7JduARMAyweXpVhpKiftnqJ698kC8SythnkiPtX0rp1AKAg03dcZIHlpceJaQfhPeJGD6eJ8S/BjLKolN4Vs7yy/FD48pwElG1db1NZopSEOci0Xr
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;6:SsZlXiiVkhBdFWeLfn13xhblaPV5yIhM9PuzNGtRtrkvuJ4Z8J3Eecgiw80m44/CyD/ZlZmVDavsSiH/wjjWEg7bRK7hX5Hv997Qud/UMu8AIRBoCJx2YCPPT5JKyFhmcYXazwLUOih6Vgj3LK+n/dZfewCiWH6wSpTPxfQ6vv724eIg6QooAERjM+d4cZtO4MnpYCH5V+SBJ45Y0aC9JsLubaBNivm5KzcFUpRo+1oOb0t6onQS9k9uQrL9bAjsaHnhBV44ZnlCgMp6OkUWV6G2JmNUExMIfNKksbuFkoBq8SwXM/GJEdZzdBguFm0d+PwBZoC2jFzQ8sD2NbYFqJvM+7NcMCSSYi/HGhmvNif5O/1vtKhu8+JbHcxiwvToy1Jnc0BqNmws4UP++q+psGaeYYXmv15ohCzmyAn1aYPuyPgmQy3ivzAPZiQ3SwvN0kasKp244/Nvt2VuIaomRQ==;5:Fa0d5HBK8BjZmA1Q127cscxEc+hD60o6RBLKk1uOu28naHA/ZUP9Qr1Os0ZOjRvbuECmqoO1yeii/+UHAG1GoQ7k7FGRJXw+TjxqaI0cvQqLTOL+3hpr3WxeH3wmjsW8BqsWduEXbNH/NedviSBLkoCb4fqLaTFjMbVgjtTyA2E=;24:LuGCupxC0bFJAmweIEAZzE2bCIxOJ2GJVlVrHf/2IXZmgwVU0wrn61U4SpTp0Lg5Ag7h8t//MqNfXjlLv8AP+XlGdwDwsThIFtJqWpvwPNg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;7:wLthWI3Ug9hy6UdwQdDtp4vTXjPcP4J6n/UP+GMZMGo/lzaHr7i5/iNWumXRnUDx7Nog4uinKFi61J2tWlYJkpv0CLt2NprqakK8jZOqITg/9uZ0wU+qRoat8oPsjOwJOTfBsRvGPQ+9YkToIb3pZZhbLg1GmysUxyZj74ERmfWAxEV1x+UnZ1/YLvCHw/SSY4QjDBVWfXByW9qL7O2d1zTO3JA/wI8fvx/MoLUXcvzd+iLadpQkQ1kUSCQuLHGK
X-MS-Office365-Filtering-Correlation-Id: 55fcea3c-8104-4d10-928d-08d5b6f06c22
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:36:46.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fcea3c-8104-4d10-928d-08d5b6f06c22
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB387
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Wang <ran.wang_1@nxp.com>

When rcpm driver get target register data from DTS property 'fsl,
rcpm-wakeup' (second value), it directly write that data to register
RCPM_IPPDEXPCRx rather than 'OR' the value read from it before. This
operation will over-write those non-related IP control bit which
might have been programmed, should be prevented.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/rcpm.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index ff0477b..39eabfb 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -75,6 +75,7 @@ static void rcpm_wakeup_fixup(struct device *dev, void *data)
 static int rcpm_suspend_prepare(void)
 {
 	int i;
+	u32 val;
 
 	WARN_ON(!rcpm);
 
@@ -84,9 +85,12 @@ static int rcpm_suspend_prepare(void)
 	dpm_for_each_dev(NULL, rcpm_wakeup_fixup);
 
 	for (i = 0; i < rcpm->ipp_num; i++) {
-		rcpm_reg_write(rcpm->ippdexpcr_offset + 4 * i,
-			       rcpm->ippdexpcr[i]);
-		pr_debug("ippdexpcr%d = 0x%x\n", i, rcpm->ippdexpcr[i]);
+		if (rcpm->ippdexpcr[i]) {
+			val = rcpm_reg_read(rcpm->ippdexpcr_offset + 4 * i);
+			rcpm_reg_write(rcpm->ippdexpcr_offset + 4 * i,
+					       val | rcpm->ippdexpcr[i]);
+			pr_debug("ippdexpcr%d = 0x%x\n", i, rcpm->ippdexpcr[i]);
+		}
 	}
 
 	return 0;
-- 
1.7.1
