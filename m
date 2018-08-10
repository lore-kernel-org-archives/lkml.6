Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82635C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205F6223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BJrPJ+ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205F6223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeHJGK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:10:59 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:31769
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbeHJGK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSGXHF03AVBo8ArFvEyNfjCzk4U749SHbdaL1oTZ9rA=;
 b=BJrPJ+olfiQV2y6R/GOqu2t4nFDHdC7kLojZHYHj/jaOp0rTAaur7bP8U3tDVo9cEXkjTAfUTQziWr03VZm74bGGSRCAyOyknScx+zs42RQtROyRrce383B5s5MSWSZC2SPqH0MBR3ExZWdHrl4RvEcXkGfQtiiM6LKdQOiNjuY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Fri, 10 Aug
 2018 03:39:06 +0000
Date:   Fri, 10 Aug 2018 11:36:27 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada 3700
Message-ID: <20180810113627.5dec5d40@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01390791-ba1e-4542-42b2-08d5fe72d3d3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:flyOSZnMS6fGx60F1qzJKYjlFcS207h8osGZLqPij/URSnI3sqMratwkFe7gBrDn4/fr/3OzhF2sIijxDYd2YSU54s6+ycOiSInLTjBYhiWaGfmoLCojt65W2SsBvKyzXUpDteryT/K/TZZjSWOE9rlQ/LE8K335t92sbBoO3w11LJMGbZVSDrgTcGk1Qem0yNgeIUZYePPbJLX5xjWruCdLgUsWpreYuiec3ffeHtFVtYGBVM+924yB5bwxo3eP;25:poog1EB2+8idIc4bMVimrIJx0mvpEHf9oKF9Pw5BWt2NMTgCiNXmb8wkk0jtngSPiB0C1r+NuataGyF1PLNl7eamPRyJBSHQvUAUSQpgu6RJD0Mcndo6MQDCdscdBE7pHVstERRDQBRIkcIjQUb12k7U877fBykOQthAvkedCAx7/28ialTxjG5UQVd/NXPJoQQoNLksG/6xVAU/CvvDLcjzsshM9N/azwiEpsYMYgXs1bifvxjarQIVs0Rve6qK8nv+Msabf9ftNjPhi3SY75PVdpxRE5smqXaq7Dl3IaDPG4kcKV7Ij+NIpoB8KX7g0aW/FzFYq4dT+z0WNYF/bw==;31:+cO/F8ixoNgThntQ3DZxhsza7vRXfK5IfTBaQ5LZdCmWHTnNulAZgB37BvdSlvyTr/P0dtU2w84L8x2sQeoHAMHQux72Kn+5nnekuhaIctq+JmJn/GsQNpRZC7lIOMSc9zRZbDnz+xBsyQL6hiRONpFdxMZ1f6KJA3WKG4X6J20oPDVGRrdeDx7XSRJO9ra8etv0xNYO5k9Pp7b1TTFWeRKDagPosOozZwt3RoZQN18=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:B1hiEPMpZ08DRnQyDeDCTGo5+Mde3s4mDifhF4YmikoVjy9zASSbokn88GOrxNs4sIks6G7DxU9sz7zbCjomN2yYPrlnXtjHsiL8oRH3z2yep7Dzt6IB1ItT+43VazlZRF5MMF7uCSO3AwxqDs4eFCs4TeiUOLejGPnXOjsrevcnildHvFw2ca0kSErMKvURIJRR0OkMCg8joF0kVFwYkxKz1ngHJoDYQninI1+jVkt1g8Byu7yKsfV2uTqu3WUDWAx7nqKEz5y6mYcurnvoAWrfTJ8hWhT9c/NfbX2NOiYFTDK2WrWFaHX+a/eN3K4fhaCCcRpaOAkWPpp81Mr4hNukhFeZq5BlaxoCFrbtLL/T8IwzZRnmSQ1TMT3W6L5PlpFTg5PcIiC7GfBdyJ6VozSG8+pzRV08eG0/uJY4AkZ4HKUM1Wyt1UEbC4W+7IfukIJ0YeSfVTAKpdbTnZ3GNzd3Hty47wWZ+q3lXDpslfb1yEUjhtbnvc+F/dr90Rpt;4:VL04RlVd7LOW8cojqu8iaxqypFqsJLLiOafqYqvF6hAmPLGA95ia5cEaXDkkhNvhpHX0YsLtdJrzcAGvDe9WtxQ2finEUqJXlqLA4NxH/6VBYvDo6PhgJ9NAdiCxKC9oawZiNgRnkQ1ixGMkNUYo8p6EWlREvZ9gDpl71Z0Iu8Whmq3rbS3MROj7Ib7jxpxO/D3+Xfmxa/gn9AERTvsezlFyt+NhlQrLpDLZSm3nWRGZWGX1W6DZTSBl3pGPlbE/gHHtNavPawwFJdIAO6KzqQ==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15834A728EF7FF4D668EDF4FED240@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39850400004)(376002)(346002)(396003)(189003)(199004)(1076002)(8936002)(6116002)(68736007)(478600001)(97736004)(50226002)(14444005)(2906002)(47776003)(6666003)(72206003)(66066001)(23726003)(53936002)(5660300001)(230700001)(3846002)(6506007)(386003)(7736002)(305945005)(8676002)(81156014)(106356001)(105586002)(81166006)(55016002)(86362001)(26005)(7696005)(4326008)(52116002)(186003)(16526019)(25786009)(486006)(9686003)(50466002)(956004)(476003)(33896004)(110136005)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:LcNB3KvM+q/eWp191xLVpn50xvBCKY+8k70YIHa?=
 =?us-ascii?Q?VRC0cUlfDMi3vpFuOdHfVUAt6CqUA8RzNo8Kwdim+AdCl6rooPc9GSAQcWsl?=
 =?us-ascii?Q?g2tqk7t3SNoXTuuOs1RLBm+f87B4a8B3lHGqJddJrYwl9zUD4rJrSX9HgxqK?=
 =?us-ascii?Q?5kquwyQxw698y0+0CXbJyJnbyjeBIW7ELeGP8IiKM3f4X2Kd/tlfifGkpv3Z?=
 =?us-ascii?Q?BBF/WWkNoc9gMVWrkuU9so/fZq8SvfjUFCXEihuMDtIPDKtkRt0fZeUUULeM?=
 =?us-ascii?Q?u4bPyXwj9+2uTrPi01X3fDObRfPTKa5WqRTtPhbeySeRmrXY4hwyYvEdJNOs?=
 =?us-ascii?Q?9cl+2iEpG8OfJ1+BDlgRcpudEJIYpX6iNmowQCPdD46hxqCIKuIxRI/pDxQU?=
 =?us-ascii?Q?L06pAd/Ju39WGyIXHG08loxFDYI0gQHRw3wlcvSwcC0EzLg+fzau2jNqtLO+?=
 =?us-ascii?Q?fZjk0saMKoAlnpqAMRfhGRnMptUhbFKiBM9Cu9kHqRjXETgacLAeA0l8/UVP?=
 =?us-ascii?Q?CMlwaUNOGhIypEo6manzJbVhsdMRmMdMKLl8fzbrVj+SbMrmwgwEcLNegHxB?=
 =?us-ascii?Q?tQKN2xAiJUszuStt2P1w98RRcu25Uk/VtasLXOrow1ZJBg3v1oBYEQQ5mRRX?=
 =?us-ascii?Q?Q0WKhMvBjrbUZDRvjTx8nBNoLdCSK7g0VlLtrEGVYpA+CkRx3whf3mHRBAYs?=
 =?us-ascii?Q?aK4peGpMHi1lJZbxT6Hi0ygaXPDth+K+kZvq4XnDaPbe3GfqLPa469/8PrUD?=
 =?us-ascii?Q?1/XclvFagbyQkufadOXASZaf7hHPOtuhwOwx192sxdPGYhWPaFCEhSjXaJY/?=
 =?us-ascii?Q?y3f9LWWZVI+rJcSpG0h7yWADniwVYDrIw1i8uccqlLkMvGu8vqy40WfjodG2?=
 =?us-ascii?Q?+A0DRRx47EnB8mAdzdW1j9vkH5izOXkpYbzG1qA8ZyTfMdCCG+9auMof4f9b?=
 =?us-ascii?Q?csqBIlZBX9b68rnIl9GaJwY/x3exFBKLteui7rBcSu76FymsXbzYRBwQiijk?=
 =?us-ascii?Q?G9oRZspGSMaaLLvq8UOREFhW5/A6PWW9XvbaQkXCgwcvcNh52JEnVOiu3R6U?=
 =?us-ascii?Q?jgHuQWj828ZdAvTzC06CJuw99hq6TB5NvjPq76ylz/6wqYNy9b1mAhaLAJVS?=
 =?us-ascii?Q?ZXC6c1qDApFyQU11vP4/F9CHYLoPg66lDNTV8i8+h5dmeWDHjWnWrNfff6V1?=
 =?us-ascii?Q?o0wnjS5gsMn1z9jA=3D?=
X-Microsoft-Antispam-Message-Info: i0yc+rN5iveDQektSDOmW/WqkELTyFn5ZIY0cGanOHsEU/K6SoVKQMXVlhxaA5CFSCQk+gjv8VFR/+1rBdhjS8ojM35KkM3Ne4roczNKMq8kS+dcTz6KhSo3OQJp4KYQQCAUjO5raRBNiRzl3COoe6Rlwf4sI+c21jetrFHvIPe8MKgD6Wju1ieGYRNflHhiuRDdT/3uNasnpwlgz6VzYZtr02aOGH6t1ficm4Sks7SQmB7ju884hu788B+zmOqkacttRtmQsjzn3GI+6P9l69AJr0k7dCR2CzHzdfk7UY1cDQQaNK7sKvQTDX6stzMSfNpUJr+JklL+uqZFg6sY0Gt9RnhyVXW3Q6LBnhvw6go=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:XkpEOQOwEjLDtELg1brJYuQf3bNLBVZvfHHERmXyJI0r2+Yo/mnevVbcU0kyPnPrz4SjkkFzIHabO6s7hydVx4R1w2ZaLJH1VN2BqCi08U1RIMx/OiQnPMqrPwNTvIUGfj2yHn8FrN50HImpI+25HJLmN9pdJD97DtJf2yOWmlf30QbIXK5DIEKaPOCohUfY0OzDhz/ndEzSk1G58LH1j9eIqnLh8D3E356DSt2S07tZ9Qr8POttUlQmE9fCgG3kO/yhU6/yQtnIgwr1HFwyaKkMTqEztyeuEeikuHrSVpwQPUbOTphuThJszCWC4CCIldTPvGstgKanudWoHMavSAM1GIy9gQLNz9cMJRJgbX9TTDHhAC5ewl/T0VSgNR93SjlIr+8PaDXqfOg9/iBQW8hCDPWXDietefX6W345bTEcR8ZIct3bMfyBmf2qB3ulLoCkpSoXk+RhawIoWXAOJQ==;5:VEGppER2SkmkC7GVCdwVSezBLuytzAnsBpqW/Kl/MAUGzosymkuNrtCjbhHhxuk/8p0HevJ9urMg8lCPx5lUSJ9P9MC4JakoAXDyKubjIfRYrRArTF20dpmbfSuY3GCkE587joN1iAo8G3BQwuUHILXOYG3Jj/D1dgibC8/8Ax4=;7:jGxV8DVbz0EL5EVBKaN0MPmZrlz34hh/yLu8c2Df3vOk1Llye+Afmc8Ibbyg+D0nhopz+wOn689GNNRHdvfyQE5SsctbnVHn95eSxRUMNUvbR0dYMlkMtJ2aoIGgDYnSrnyG0ovI7C2gckMJ1p9W85Lasp5JC7kCyjw6I3/ufnl2WDK0aDQzL6XzF1IT0ehtqJgJn873veJhgoGFyh3SpxZQGRD1u6EVkvdAWQcj7+Bngg3hzkmhq3DnXXfkZkB0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 03:39:06.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01390791-ba1e-4542-42b2-08d5fe72d3d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvneta Ethernet driver is used on a few different Marvell SoCs.
Some SoCs have per cpu interrupts for Ethernet events, the driver uses
a per CPU napi structure for this case. Some SoCs such as armada 3700
have a single interrupt for Ethernet events, the driver uses a global
napi structure for this case.

Current mvneta_config_rss() always operates the per cpu napi structure.
Fix it by operating a global napi for "single interrupt" case, and per
cpu napi structure for remaining cases.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
---
 drivers/net/ethernet/marvell/mvneta.c | 31 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 55c2a56c5dae..bc80a678abc3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4107,13 +4107,18 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
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
@@ -4130,12 +4135,16 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
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

