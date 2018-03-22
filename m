Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755664AbeCVNw2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:52:28 -0400
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:52734
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755611AbeCVNwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:19 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <harinikatakamlinux@gmail.com>
To: <nicolas.ferre@atmel.com>, <davem@davemloft.net>,
        <harinikatakamlinux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCH 1/5] net: macb: Check MDIO state before read/write and use timeouts
Date: Thu, 22 Mar 2018 19:21:36 +0530
Message-ID: <1521726700-22634-2-git-send-email-harinikatakamlinux@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.548-7.0-31-1
X-imss-scan-details: No--0.548-7.0-31-1;No--0.548-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662003369765219;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(376002)(2980300002)(199004)(189003)(105596002)(63266004)(336012)(316002)(76482006)(2876002)(50226002)(73392003)(2906002)(36756003)(81156014)(81166006)(8676002)(8936002)(86362001)(2201001)(47776003)(61266001)(426003)(50466002)(7049001)(54906003)(48376002)(76176011)(26005)(77096007)(86152003)(9786002)(110136005)(106466001)(55446002)(16586007)(107886003)(73972006)(51416003)(5660300001)(498600001)(4326008)(305945005)(356003)(2950100002)(6666003)(83322999)(450100002)(87572001)(446003)(82202002)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2625;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT010;1:tkafYrpfBNHA0GA9pEK1drhhPkmasc/FmrDRtm226UYeUGImNIMBdAXPmC/YbHgk6MGsDQafWaOaKSwrXzIPKzyjFoZJbw4RAXcQ9MYOBC6OS/tgP0PKxMIGBrJ+sQkl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea334196-8ecc-469b-dfef-08d58ffc1fb2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR02MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2625;3:ofDHdzVunvxVRp5sziT7d6r/ssaNWHvesOmpucT6BmA7eUF4HhYZrNB7eSmHBgLJVAjvNf4q1rv1AvmSPnUtueHeDNEBPBk0z/PPMEsJCWZKm2E63lDTeqSixvor/u+UNV+Ll/kOZiZGKTOYtL2y0u2jj10XxXZiv7TbWtLRpTlVAv3ipSpu5a3sAZoXug2kmkNWM4d/FBKJ705NyXRSp/T7Twj3T5ft1xH5Q0TdN0WNGM06ECpxziVMD8egOLoD9AFKc87bOiILlyNkiqT8Vwo36ibOcQIue7SLe+641itcqF8PFoZeAf/eVJIDSdKlczRhTsDjeFtk20e83YTA+d5VFI7wKQx+fFtzufgiOmE=;25:/8nFRlX6Gj1SAireaZ1IvakOV3RPfPk8HqMNvxAEMkyMpBTte4kcN5zuQkePR3o3TNmqzj+1sFl9+ydBnu0ft4kIfK4nNNv9k6gC/hzAiMwQ8T0ppeuI3cQ1uanpVV+j4KRLBt9g8f2gGh5MNMibb1GUqTnrr7badR3AO3qkES5yPVbzZ7roKGVOiR/BdfVAIXKS6njNpu6wHDtCwXFJ2X/iOvEedqqi8zeDWbvf28TrKU9safTBoUmAnrR5KL25aLwH0QsJxwpZZWYrYja+L3VxGdqL5dsL5F0IhYLP3NXmu5S3FGXQAPU+ygOS3syOj1WWfm5/9BUEKLlAJ+mE5A==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2625;31:zMOlAjqYi1uLFRPTicMKzMNjOvnN+ZP6Lz3lWkrneeSDGeQFIgJ4qwM+nHuRFRw53TwJdcA/2meQomkv28ZAbzKuJATHWBzKAS3mUzVVhaQGJngmKfYeZhR623EyyTb35l4O/49nyf5H13ELSqDCMYbldnxItTMIgRE0Wesx8Actlgv0yIJLljiKHWFE0PvUKGjIyCh70K0u3tai9XTDYuooztOeUmjxsSc+dzn40/k=;4:GLBzFS2+Y4XOUDCCOUVmTQBP57T9ramGaXFRVwqalnqr28UOAaarh70gWoZejz/nbZtmiYlbWBI+imueZOVFVp9O7fHZRJldA6sPo7vtVhvhNNd86WC0nP6qR2mrhctwLUg9DHXUuAQUUkn6p8Jf/gwFUjLFBOqILyYvacisU4Q4WaMhZwJPNMZOCgbMUKdxX1f1hyUvgFd1UXMtCaTbVl0ZSwPL49ALFXf2dFU7oa0cAb9V6urhvFsyHEYtSrkwsJgZ+UWsC42x1Ua8fpbF8wDiJTYQttph+GN3xtdSLM0HvO+nw4tue8YGAAi0lYjRwXeHXdHj9SC9H4LoArrygw==
X-Microsoft-Antispam-PRVS: <BN6PR02MB2625931E4C2E42F1F0E41354D0A90@BN6PR02MB2625.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(201708071742011);SRVR:BN6PR02MB2625;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR02MB2625;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2625;23:yBvEF4TiuNOJdvENPN1S+P3qahfpUHE4tRw7F+kca?=
 =?us-ascii?Q?PypYLssR23bjzXnSF13s5/5wVZa3NKuS+p8qK+xiPaoDxDlyD5s4YM+Nrr1t?=
 =?us-ascii?Q?ESKo4x/0ESl929ypW6DiYowWs8vF3JORGpDZ6J5EB2JvGjxoiZY7dt0RVtdk?=
 =?us-ascii?Q?bt8LND206cS3aaPq97wUPstkzgR/5CmjXTDRsm+bJYBl9MZoos4DVf3PDF6l?=
 =?us-ascii?Q?kQm0gpa559KzWi0G6IENmYKZs9j4SF1o3EaW7eyVBLgQoPuNuEIEswFk8GTq?=
 =?us-ascii?Q?I6jSc10nrsXBGYAuzZycwKbYjqg+zsMjhqM8+6YSrtiwlwMIS/EQEut7YWa4?=
 =?us-ascii?Q?OMKFD8OiaTL0eV+Lu+HwJC3fbpGTZBZ24BL7n1cx2QjeX1Nen0gFImYg4Vlj?=
 =?us-ascii?Q?Pam/ji95BYt5DQOLAQAPyxUSpDwPsEjk27R/8V1wXLDeNF3pRDhe2+TYJ7H/?=
 =?us-ascii?Q?UWXDeM2YXt+YPmcIbU8gAorGBpxzcg2B5L10y5rNi4eOqdY11MW3DeM9c9XS?=
 =?us-ascii?Q?mNyPlF8oOX+FOeR+1tlND0DH3F/hv++WXunYNQAemBimCUezVO0bTo9prGUb?=
 =?us-ascii?Q?/Uy0+fuS5WkAnBqFcUiBSBaIr1BOArs/U7hQjjfmnPD1gwHX2cVAZi8LJeCk?=
 =?us-ascii?Q?xxnAT6Wr97ClBOewlWWbDc34wsCl2CXWwupYqGKQBzy2t7XPpTZkIxgF0GNs?=
 =?us-ascii?Q?tWMfP3a1LU3Yr5WHIK4bIPFTxboZAu4yeZ0lqhz37k2nMk0HoRHpXuyPaFFN?=
 =?us-ascii?Q?UzyWiGvNHErZc6h5/2w54jjRx0BUnkGunriwcXl4/JdH1CekM0/4UTG0kqoH?=
 =?us-ascii?Q?xQdwVRyh3mTRZZrgzYmOOQnKxK4AjCCNbZuDoZhauD4Hy6XACSE6iQvWuOV8?=
 =?us-ascii?Q?KC4ZEgUrdHfPsE8XY0RBm40GJt4VlVWT+kOj6XPqbGPyvlyvLAvwukt/g1db?=
 =?us-ascii?Q?XJ/Bosozzivq3rurcGA43+OIQ6ryYwX9jUKj5Ey5+jH982IPRUAgwvhKKIM6?=
 =?us-ascii?Q?QA+7EdtFb9fdMe2Y4MeZfMMHI8DzM90KOmn52oYWYCWCaZX+w4sOOFbVxShU?=
 =?us-ascii?Q?REVz+8zsB4QjLPyATYayGe0dx8YFav9jHDKfZyDk9sVm1GnPIK1i6nw7uMjm?=
 =?us-ascii?Q?G/UnWHhiMznDr3/4QqFxUuGUUciJcvA8dOQAwU4R969USV15d20TInck0nrb?=
 =?us-ascii?Q?WXrMflEQMmr/ycEbN5RadXXaUrAge45J55qtEhuz9j+/+1FO3CoJpLLmqeaC?=
 =?us-ascii?Q?X2yCGcAWI/XK7XGS4rBHJCEgzsQKoTXo4T1GiDj03tMowIRaOKBtTto7lxqy?=
 =?us-ascii?Q?h6pSdZWPdRKQe0cDFG5/F8=3D?=
X-Microsoft-Antispam-Message-Info: b4y0Xci6DiZtFj3md6nmgGjG3ohQug7XA2d+F03k8Ae86SslgPmYMzWQR9ZxW5BgpyZfXsUlE4ug5AQS5PAi/Fe71RX9CZFEdmHRlT/3fgAcvWrrkpqL3y5mzlW9Bbwu/9hFp0EWdCy20KBToxzvozbTyfWH8v9qIVEllgo6599qYcPbw4bK2432OJbC/KUR
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2625;6:f0OhIOP4o7YobRgc6JMljHmkXdfH4cJ2R7/QHn+l+dh0qWVqEXlYN8NswQmFUB2M3VqM3+2Aew0x6Y2DP7ox+SeU5v/hD6lg47hYFwLZgfktPuOaZZiPWG9QE18GuaR4hS0+alqKX+/BAR41KQ0wSUSQmo1chblFa+uy9kKYYe0rka/p9H3B6h02h3rF+GjVpPdPAryaIi1Z3zBMlr0cRopgfZCrVs1oSDSe5wsLVCksWGccaU/WceGIa7ALto5YPkstUfjvD+FTia0bvLYCw6YkMgwsHKpyAPjkGjkqM8cdb0Cp4qysEeXqns235ZCHJetZMli54gBbGqhmsumYCl0x+Etnt9xNoIlHc67MFGSA0hV7Ei5z9L2h+oDqhnYh00Vexw987vAdBzlj6P1rojAf3/sXSZ8GizSvXd8rahg3P+kJsREC/s41T9hGmLTPL8QjQy5L5xepqUdKdC/C/Q==;5:A0ab2UYl0HoGmNtp+inS6J8BgpwFR1F94781DQ99arqyh+n840xVJxUH8eawAc0CYVN6GUm5jeg1qaWgz4QIDTzDViGUMG35PJx1KLNNPrLWTTO+syfA9iXfB+7zrqZtZgZ50WDpJF3lwvLpLyo24T13lrH3aXdZpOgMjwfsd1c=;24:F9xTEgaD/XwuzVWChzmt6XrqKdcViJekDjmBMGZssfg/Xh95dr/ChY85qLrcHB7aiOEqjkCxQUJuEr34/ItUN0j5mDrdzjBfV75uy06gSeA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2625;7:uIe+WuAuJsKCyiOMT/PtS0zRJKZSWshzkA07/nA8oRt9ZiCBPipeFhScKaUiYgsRSi8p+0hNoQuWvrWmRTDzGl/ztfy4FBlaHN8nY8m1zZYrAggKbRAj+4TRTc7CvZqIr+Op3lv8woo5i6ehz/dY9EWs2tv5cgvX4Vjx8REck9uRiwvejT+T5aGooP3DkGsVQVhKpTF3pruohQ+nPoiBaQI2NooJ0Fh3OyAyGIzM5LvRC2Er3ZKIQtSjZdyBxR94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:52:16.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea334196-8ecc-469b-dfef-08d58ffc1fb2
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2625
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

Replace the while loop in MDIO read/write functions with a timeout.
In addition, add a check for MDIO bus busy before initiating a new
operation as well to make sure there is no ongoing MDIO operation.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 54 ++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d09bd43..f4030c1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -321,6 +321,21 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct macb *bp = bus->priv;
 	int value;
+	ulong timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	/* wait for end of transfer */
+	do {
+		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+			break;
+
+		cpu_relax();
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		return -ETIMEDOUT;
+	}
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_READ)
@@ -328,9 +343,19 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 			      | MACB_BF(REGA, regnum)
 			      | MACB_BF(CODE, MACB_MAN_CODE)));
 
+	timeout = jiffies + msecs_to_jiffies(1000);
 	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+	do {
+		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+			break;
+
 		cpu_relax();
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		return -ETIMEDOUT;
+	}
 
 	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
@@ -341,6 +366,21 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct macb *bp = bus->priv;
+	ulong timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	/* wait for end of transfer */
+	do {
+		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+			break;
+
+		cpu_relax();
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		return -ETIMEDOUT;
+	}
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_WRITE)
@@ -349,9 +389,19 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			      | MACB_BF(CODE, MACB_MAN_CODE)
 			      | MACB_BF(DATA, value)));
 
+	timeout = jiffies + msecs_to_jiffies(1000);
 	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+	do {
+		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+			break;
+
 		cpu_relax();
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		netdev_err(bp->dev, "wait for end of transfer timed out\n");
+		return -ETIMEDOUT;
+	}
 
 	return 0;
 }
-- 
2.7.4
