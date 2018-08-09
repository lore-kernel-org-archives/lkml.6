Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C30721A8F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="GysAszej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C30721A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeHIOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:30:07 -0400
Received: from mail-eopbgr710066.outbound.protection.outlook.com ([40.107.71.66]:38479
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730032AbeHIOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/msNgZMfI36Qqu4xI3k2DbtsISHakXYY+w4oscGsr9g=;
 b=GysAszejDVmkNBNKUHqsbdxGyouzg0moxumewEb7myGm3mdJlYrFN0gQDzXnvLCotdDjApb3EUGDZea9DeZcHxliSF8lpcp4pWnHeIGuZ0uvkCGlgUARXXFToyqHnS0t+shl+mjuyA8wOuCBhN3FkeNwOKFl77xSKLrPxBBmWDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Thu, 9 Aug
 2018 12:05:24 +0000
Date:   Thu, 9 Aug 2018 20:02:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomas Hlavacek <tomas.hlavacek@nic.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] net: mvneta: use the correct napi pointer
Message-ID: <20180809200242.1166f86c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK0PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:203:52::22) To BLUPR0301MB1571.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9ede5fb-395d-4340-edaf-08d5fdf065e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:7fbn0TQzpEEAgbDGNHmrQN7YQjpnWIGcG9tzJk4vjapBVVYCx1uTGruoBCdfw2E3Bw6vOsBvAG73TB50Ttfc6XaRy/MnYSD03m66YfTg2RE2gDvDwxFH0VL7+qTeARJqFrHP8h88dVSnooPNrGLPh6RAAj8XcOkc/D8bAzWxKGOCInaT6Y70usgzunbj6dNFLvz7Qz+149x5tWSA7ENKYWvegJcgHPopC7IW11+TSmk7b3wieUHE+klPh0X8Rp9J;25:eaH1B8HwEisc3krCHw25UZ3RsMz0hLf3i3C8Kc+TkInOsMSvab7wnSVR5QCSMkwv0uIopoqdgAW601yYfVvJSkxlQTSdCFIPCx70NwaLikFk1cCu1ljEws8zzV3GA3etxOdItnzkCNSk4xt9vQF2zKxrzWJaPchHDiRHaEsOEU45L/yL9qcPu/0yvgNHdiNJskMNRj4Bnq6anjBBzxbDhrsj143hTlvZ424cGj2BDo7Zf5J4vsGakGDpDrWCIystMGzcUpd1j0uxujTqDiKdy2NTXWsOKUgmV3J/TrHFf411bPhlc2jRLZ7UuPg83A6CzfcJYkRK2MWVwRaciKL2Pg==;31:TarTHkA4PYSaNbJcrWcuflJDIaGQg/Fnoa+7NjCVH6Rwl6vIO6qXiSj1p67Rgaq2hRl/PtRtLUxgW1iYFozCVHaThopaF2WgsodMUYLNJy8gXVyCIX5Rzr1nNzAtEmCqdsSbg3KMPMZe8Sl7Dvh0K4WS5ImeJQrLJHVGVPfNwvZqBsOzXdAudTuJkCnl1VKxY6HWi7CPpSXxe7dsxUNrI0A5t2aENkrcuI/gmNrYiF0=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:K2uKBzN+E3/VX3LC16GXBxTNhHqMdX4WhnabHtcViZGBPjFNC1xj/g5JvWaBDXbG05LROUVxCXDrR77fzfYaVW1Loa4jDeMcqd+202kfLSg2UJYzdBTrZJXasVVxldg458xZI485WO2pkJfMVIkE9s0r/H2LXPage6Ylld51sCFv0sTjuHqbchU1vhRGVu1B4sjbvmzjK7L3tk71i3YH2oaUZcbBxpPi4mVxDgCaYjO5XmUD8BokjFl6UjV6teA4wcPw6Bd7tmRw5bzGAxHhmiKhHOcEmr7wcsP0q6Dtpx493BO39O8KTdibgL5WSuEHNjosQGJgKFthckeF1hugjmNt8w473gHHx6wGHCZZlOdZfTQdGIHIcY6sLLnDQ0DTsGHKQo//Y47/26z+SO+nWOQnwqpM1Kle3HcoQnJ1PEgwl8TqAJNVQDyiOQ1d5sMYRYYmQxAEpIsVEDqFTO7G4wV0GZ16h9/NYA8Cu1Gs6vbqBb6SCo32n0dgSmzwFITk;4:Xull4ommzayNb0FiopRhHp6OarcfXaou7apWQj8WOlyuwxBAcpH3vKOyc82tR47Mzd0CrJcL1ed34sPDvo8jQvXDJw9AqUswldFa9/fJO2cObPS+Sn4lpjXu6kfusNLzXv+/LEIroA7lniqvuXBRfMHzkWFZoWNlVuAxfGybuKUiNxSjChNHGwTAcPHNoilLQB9VP5CcVngJGdKJqgypCBQfZUU97Iy3TWYBhDbBC2L/PqVZ7kQlwxNoLDeh5lv4TPs4nHh+BjWekXnR2n7hkQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15711BAD731C6C3488EB625FED250@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(5660300001)(14444005)(52116002)(7696005)(33896004)(476003)(50466002)(6666003)(53936002)(68736007)(50226002)(26005)(72206003)(55016002)(6506007)(386003)(66066001)(8936002)(316002)(54906003)(110136005)(486006)(478600001)(9686003)(956004)(47776003)(8676002)(23726003)(4326008)(97736004)(230700001)(25786009)(81166006)(81156014)(106356001)(305945005)(7736002)(105586002)(6116002)(16526019)(1857600001)(3846002)(1076002)(2906002)(86362001)(186003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1571;23:tp73AH1x0jQqZ3sad39nl9l+3I+cC1dasnPPM5S?=
 =?us-ascii?Q?COkaV8V7IU6gJ8yN+lk6T3YoiLGnwa2Ppk4bIx0UdHUzs2MBeW0vpGEha6d+?=
 =?us-ascii?Q?JOQL/X/+QwmjXBFxylWrL+9sV3QRWRDX/nXJXWBUJFiOIwnXK3cE62++vAz6?=
 =?us-ascii?Q?wGv0F+QDjni0DrlxXmXsDbpoNaZY6saICZPD7Vo/9FbpL3uXIBqHmBL/87LL?=
 =?us-ascii?Q?E/Tkl28aIpBLiq2EBIwXUfDu2sfMaAvAWC5QaR+d4yYI/CYWSGup4hP2Et8A?=
 =?us-ascii?Q?c0uBtGvmw72sfh+FtQ0ET8FsFhwmavc2E444eryjJR6qk7PZjozXgEf9WQfF?=
 =?us-ascii?Q?2bRcdBkDbvgcNA4kjEP+ARog5oP7NTrkeAkq7pJlA5E+ZB3+bbALS0KpMP5K?=
 =?us-ascii?Q?Cle+lwhXO2gOepZeI0B067/RD0KJUKPKS3TjLKzxBc3J6fyzblCgjWDOdM+q?=
 =?us-ascii?Q?Zp6in2p1idqY33WXetvvKjL/xE3yyrFIB5UjXSGEMxcYV3ubQOr8BN1d/cjb?=
 =?us-ascii?Q?Amw/0AnGyEpyJkZhQCW3uoR/vJoKF4/Z4WnHKvr4pWVNauvkFvydAenBzU0Y?=
 =?us-ascii?Q?+Crmm87N2bQe5EGyxiiz4jrETGDwdOjtdrmmw9eFTwXQwKQSDaljkLOnhZ5K?=
 =?us-ascii?Q?+GYes3CwZ7ovVo03GTLKq0lOpY6NMirwo+zf643WrN/eeFmMAC6RJOU74Xzl?=
 =?us-ascii?Q?FosRe3SXd6KL2pZq/FZMKGWm8XK2QE4aEDHCqf2vUr8obLbm++OvQ6o1PnxO?=
 =?us-ascii?Q?tkCFEd5sYU8IlSQsrKaUzUhsIgjFgD0pZLENKZ0dOcTuzS7oLbtNqW/1EsAE?=
 =?us-ascii?Q?d4Rfjh0hwsq8u4TsM+R7/t7oCX+isiJd3xWVR9kE0MycjPWHSTqSHuiU5WYR?=
 =?us-ascii?Q?0ytaRdO4JmOb2tqe1qKRPUabqGnjI48xuGBuAu6I1D62jLaw7Yc+1ROjRGJz?=
 =?us-ascii?Q?qLXcN3cdvlGA8iemP93kAUgGQ5cTeioeXORYfdNNmeP8DWtXeZQynQlVE64Q?=
 =?us-ascii?Q?F4uAj50SlhCcQkI23IXj7jWv3h06gkgNfPanPvvtECSsk34DSSo1LOplARlS?=
 =?us-ascii?Q?DizCoZZ7hTnczlthd9yCsF34lbkNz2LQc+OWu6IF7UD987b9tnMGX0KGXk8t?=
 =?us-ascii?Q?umv/KlV3UhGM0Toy+ylooXK1fj+qgWgn0CiF/Je2yVaMY9jP2YcOhVPV0irA?=
 =?us-ascii?Q?DK7IRDBmnfTe1bP4BEBRADXhexmGdVv4lLjCaPD6xB6QzZGSfXRf8CgXY3Q?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: JK+hs7EH0ndUx/WDWTCOTAlXN5YhvSSQfIOEvOsuWr9Nf841nI+2n0PdsacBE2eiyWjDBzLdORPdiNnfzcz72D56noYcstknaTtYwzjsYr7chg6icdalHaRb0RTkyxVbZDFXSkXTa0LpC/9cURqQAUa4sTYim+Gbsb5DO6E5hL0jYmC3H5kLhcgfupdwD3mY8LpTrALWA7mER7ZxsYV5btaWiN04Ovhh7yDrIQSRvIQ13C5+Ri1gO+9pX+wb+k7n5QvRVr5SKKXo2a4hHuRv/Lp7OtXwNvLPY9whuXaaCTues2lAW1i7xGkVV37CiyDvS45vO7YcWgqZb+AMSciaWs0qFPuCiHqyAhMcO6vpBFk=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:GvoNLukZdAaECMzyEeAYdoIi3Esib2FExYMXiifP2Zb+f8WuElf/scZwtFqjj+Eji2pHFVWpJL8SuUdsToUv8rZNht9nfoSCKETc/TNR/DEySlTRm+b1D0wIMUfWuOddQAM52L5Dc7755/OG8W75oOjYh9qnSxx8NDEHlx8pvx+GEDIczWicZeEyKIelYRfwGVS7PYbOjXPAXjGH07vKRWju/HkgNBgtOwIXPo0k8MIQNZqIWMoYCK8YPOWASrcS1N3zWTXVHdHK1mWUjfVsQ7czBg2qC5Nw3fiVYbNgLQefEr9BKdhZZIm9xr/ANNE8MMi6iM7PECoYhyDeTTQvWGUky2LvrUHUptX2QqLmBEw/6D/p1nqFXSta9w/3Ui2t1MeXqyX7jAtCygMR9HCkGl0ezCbd4/+AzD1VOduDvLdp8x0gxgaw4fdRdFb2y6zd8vDBi7tvFCh5ZsNKONYajg==;5:hRnEP3TrXV9eEprcXkvPtpocHSr4i/vuHhQ5920/0oqn5Qnal279ZDGKMBtBEDDRqBGqm7gAN9nnyxzL1ZddimjQx/YGGLj00/YMkND3CEujR3pBNzXz/gQgKq76bKtSJx8BvaQGwZXJvxfrnogGvZA/acJjCXHZ2aelEcFVY6g=;7:fseycEJylONF3mLJlKvVVYhvr/8egIH6+AnSMJVS6SpEOnSSrCW38yyhlLHH7ora84PuOQTsRBiaugwkf8jeW5t2UOTaul3Qnh1bceaX1f/t2Gs5+zXWnUGgBJo4vBY0dOysu+PaUjhBH0CqHdxYW9PEBwLWOuvPb9Qsgl6AhPx6VZBdRANxfhZuFLHQExqbKQJR1a47Fx5BRoe8IwO6Y7sRcsoEqepTcZ55PcEZ9fRdmaEGRivwSZJ8mJQIhHKp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 12:05:24.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ede5fb-395d-4340-edaf-08d5fdf065e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if neta_armada3700 is true, the mvneta_pcpu_port's napi is invalid, we
should use pp->napi instead. Fix mvneta_config_rss() with this method.
Although we can fix mvneta_rx_hwbm() and mvneta_rx_swbm() in the same
manner, the napi parm of mvneta_poll() is always correct, so we can
pass the correct napi param to mvneta_rx_hwbm() and mvneta_rx_swbm()

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 55 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ad2f3f7da85..74b701fed5ef 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1901,10 +1901,9 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 }
 
 /* Main rx processing when using software buffer management */
-static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
-			  struct mvneta_rx_queue *rxq)
+static int mvneta_rx_swbm(struct mvneta_port *pp, struct napi_struct *napi,
+			  int rx_todo, struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -1959,7 +1958,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2001,7 +2000,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2020,10 +2019,9 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 }
 
 /* Main rx processing when using hardware buffer management */
-static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
-			  struct mvneta_rx_queue *rxq)
+static int mvneta_rx_hwbm(struct mvneta_port *pp, struct napi_struct *napi,
+			  int rx_todo, struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -2085,7 +2083,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2129,7 +2127,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2722,9 +2720,11 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
 	if (rx_queue) {
 		rx_queue = rx_queue - 1;
 		if (pp->bm_priv)
-			rx_done = mvneta_rx_hwbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_hwbm(pp, napi, budget,
+						 &pp->rxqs[rx_queue]);
 		else
-			rx_done = mvneta_rx_swbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_swbm(pp, napi, budget,
+						 &pp->rxqs[rx_queue]);
 	}
 
 	if (rx_done < budget) {
@@ -4018,13 +4018,18 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
 	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
 
-	/* We have to synchronise on the napi of each CPU */
-	for_each_online_cpu(cpu) {
-		struct mvneta_pcpu_port *pcpu_port =
-			per_cpu_ptr(pp->ports, cpu);
+	if (!pp->neta_armada3700) {
+		/* We have to synchronise on the napi of each CPU */
+		for_each_online_cpu(cpu) {
+			struct mvneta_pcpu_port *pcpu_port =
+				per_cpu_ptr(pp->ports, cpu);
 
-		napi_synchronize(&pcpu_port->napi);
-		napi_disable(&pcpu_port->napi);
+			napi_synchronize(&pcpu_port->napi);
+			napi_disable(&pcpu_port->napi);
+		}
+	} else {
+		napi_synchronize(&pp->napi);
+		napi_disable(&pp->napi);
 	}
 
 	pp->rxq_def = pp->indir[0];
@@ -4041,12 +4046,16 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 	mvneta_percpu_elect(pp);
 	spin_unlock(&pp->lock);
 
-	/* We have to synchronise on the napi of each CPU */
-	for_each_online_cpu(cpu) {
-		struct mvneta_pcpu_port *pcpu_port =
-			per_cpu_ptr(pp->ports, cpu);
+	if (!pp->neta_armada3700) {
+		/* We have to synchronise on the napi of each CPU */
+		for_each_online_cpu(cpu) {
+			struct mvneta_pcpu_port *pcpu_port =
+				per_cpu_ptr(pp->ports, cpu);
 
-		napi_enable(&pcpu_port->napi);
+			napi_enable(&pcpu_port->napi);
+		}
+	} else {
+		napi_enable(&pp->napi);
 	}
 
 	netif_tx_start_all_queues(pp->dev);
-- 
2.18.0

