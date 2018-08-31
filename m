Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B2CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88252083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="c5/fvgMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88252083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeHaMTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:19:30 -0400
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:63456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbeHaMT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk/3BBOGvSH8mjzrpmZNyvfjMH/ibe0Pb5ZBdJjw43Y=;
 b=c5/fvgMT5lHEIl7/tB14JUy3pvOcpIsISjCx1y+wiVJhj/1UQqsTqL7ZoOfnsrIUNJ+mrjdutOVXkag4tjiEXqPfz2h7ucTGkC3bDgH0nCnjpBmb2Q4F6z1m/Fis3hTtZ82ha7csubaPopPFO0Uoo92MZOQM3aGXVEouncM4ung=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1573.namprd03.prod.outlook.com (2a01:111:e400:526e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 08:13:07 +0000
Date:   Fri, 31 Aug 2018 16:10:03 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: mvneta: enable NETIF_F_RXCSUM by
 default
Message-ID: <20180831161003.3f0dc351@xhacker.debian>
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0180.jpnprd01.prod.outlook.com (2603:1096:402::32)
 To BY2PR0301MB1573.namprd03.prod.outlook.com (2a01:111:e400:526e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e9cbb7-cb50-4147-f4c7-08d60f199689
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1573;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;3:jOBJI3mx0U+5tTNN+y80vf1r2er32zTYmYicf1wkZYOK+9PIt5avVuXtv4s3XOeEVDsm7LDWhCd7df0Wnhb67Sz3hZyX7wSUcBSvYN3FFaOHuPLrRKklKDUSIz9302oPcKfN0vSEyNU/g+n3i/uykh436HqiEjAC1f4MsYkobBZnv2FyZkMEJkXIhyeEGz6iDEdKoWTnpnFqVSA0vGwjREEzmFo7A7whome+I5wsH2uVsYrRl7LcLY/cTeIo7WmU;25:FHfflU2Cp4XgErIBY1xoE5Tepo1hj8YioTYOuWyHsx7vPORzuX3v/wLjV5TrO9Km3ybAa1CT8ha1zKEMKFGQRe6Q9fSz9kl0M1/RtQEIuVyBOfQcyrolOBhOoyylcWBcnSIITV6EGPERryvPirA8vnZVoA+GoQlewF/oYnbDwykLMjhIYXjzcb0MiHOzSV65J7WLxLKyX6T6d+1UK2G5nguA9+UAS3dd324hPRwxT1KIhJoRMcI7y6tR2egVg8sUF6lPRlfpFXJ5j780WztBGtnKBnweBRKjO2yjkgISNKH7xFPV2Iz8YOiqRf5O1jlpeogn5ca/bwQVA1nNDoHLJg==;31:7fVHChj5bv5uQSIRGnwZEx3hdvqWI5RvqosC5j4gvH9vzR8CmUQwIm62fr8tIVkLn2LYB6ktZe5+cVr64J+l3spf9icgWAvl2vr0A23sijL6ZI5YDXNw7vK6B36kgbOX7QbtMvyS6qgSjnk/GUHuZx85TpXApwYOXhNfJKX7cKgBizHm8mNO69cNh+LaQLH6Y1CkDkTw3HvRowS/Dmi239jbXhOejMyJ79H294fVqF0=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1573:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;20:29nvxAXo5aLLAjtg9zcucY3VmZRQs1KC5QihNZFtL4g6K/vkXQXjmOTIsbR50WQctXzHM6KT+PdzrkXA5/uuyEhE9KQJL+nkE0nawsVWIsNWfstc4UINfACbRr0gpkDA/5lMFS0pk2wHsBOvUD0PvSVQk6fDYLK2MWkwrbWhlNAcjfIpa122XU2ftgm2Y4YKRzhyaJngzmVmZpYMHypJBDD0m+5Jr+UBXsq0sRggT7qkiLO1YhAFV22FFEmuYyJtSSVL5AO8BXPa2cKsS3MNoyreslt6M6T9OG+22qYEWkB8y+o9nBThyiZZDT2/ZRmq/GupBe1X9ufFuZn9c3TCSm9arpFhv1RZ+aCZT7OIai/rUq7SLoZXF6TXJHeb3+J2LLuEW1WiqcvBn1Bf+IBAKlfQTbLMDPDuUSJOysJhBuwZ1r3OYeAv51qOXJ3BMTgp/pVlJGqn0mLeiBSxZU9lMa6zhPYpFjgq7x8Ybp3R0SCGgACXOxibKr77QsRF3HeW;4:B8ZhU7WVGBUa0AfA3bPj2k9qH1orZYGmbnYDNII2YejE61mauy3AHUar3V5lXHuMOZD2lnKsLQzWraBQ58gplcYVxAigGedvEcCqw0+muWQajyZpDZbngYu51Sm1frGT9Ea9Yo9yzk5bMxTqSsKT6+lxvgw0yXewNHOQfN8nfNNjZz076Qz9SootSy8zojJ2SlcmuQS73ULuNppNMphkus81WCX4MqCDNsPl6cYI0k8qHhMkmxKK6YGge4Ne2xqlC5d/cvdlQMmOJcZamF8CDg==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157326C3F76084DD6E25ADE7ED0F0@BY2PR0301MB1573.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BY2PR0301MB1573;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1573;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(110136005)(25786009)(316002)(52116002)(97736004)(7696005)(16526019)(47776003)(486006)(76176011)(66066001)(4326008)(26005)(186003)(50466002)(386003)(14444005)(6506007)(86362001)(81156014)(305945005)(2906002)(8936002)(50226002)(9686003)(8676002)(6666003)(7736002)(106356001)(72206003)(81166006)(3846002)(55016002)(105586002)(53936002)(478600001)(6116002)(11346002)(446003)(33896004)(956004)(476003)(68736007)(230700001)(1076002)(23726003)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1573;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1573;23:j3uPlZtRxsyQ0Rvf+FGznfjZ3xrkYUYOFvf0AiP?=
 =?us-ascii?Q?hOOAhe9tqOK4dbPbrWU76XtAmHbNw9TGYhV3yT1o81bZ3RwWDk3BA/9ootIT?=
 =?us-ascii?Q?wD8M4rD4Q6CBwCEjeHrZS5ivOtrJOKID4p4G/49WUTmihetfNKDjcbforEDW?=
 =?us-ascii?Q?H/mR/3yyZsGCQWy+LKI5D5u8DOOEeZz14aD3xYkTglZHBz5mDAT8Vom6fUfj?=
 =?us-ascii?Q?D8hP84TsR1Nb6dDq/J0kBpvB/I5JotCPVFmj0Kd5mgUCb9b+svBUvFmWWWZj?=
 =?us-ascii?Q?FkCRM5xlLqwoF+c+/qviP55uInPsTtD9uM9DK8FWBfYKYi/uF/zxZ9AGc2R6?=
 =?us-ascii?Q?Lx2Rgc1HF31xcNOaUpux/7hP7wNie9kTN+UPGDcc+/J/JOPbX8uR2QMsgbhT?=
 =?us-ascii?Q?nIMlffYGijqA/NivNnbylZQGX+DHno90HYzJ6t1JKfAdqGz3/RSAB8qisagP?=
 =?us-ascii?Q?Sqgf/xsD88FEGnFn1+EC21YBT2FgeaSlpI6DXSESYboRKPu5B2Go8K1z/pIE?=
 =?us-ascii?Q?35eigIlIIWjUFF+J+jDFqhZ4loMNaZqvt45IfWTLiS6m09v58VoeqysDiwuE?=
 =?us-ascii?Q?4UnSO1FGS5Yak97JeQldm2I3cSfjE8XaQ15TzO3AgXv+CCfZu1j29JJyilJg?=
 =?us-ascii?Q?4E+GoAXib4/jyPLv5n7jXuS15mwPFXYdMYcF+Dvyhpr+AcGJkBxRnFRySkqm?=
 =?us-ascii?Q?xzPr2bOvBJvczjS59sVZZg+GD2Fhju6fWcutXpSkUH/FohRpGBaEda4xYbKd?=
 =?us-ascii?Q?o1peszSg6Wqz7GD+efXuuHfIIO2HKPSGLittmHzoQFMlv91xgjUWXbvprSNP?=
 =?us-ascii?Q?lkZzEyAXid0TV2Tc3Hpv60lEctyIOdaOEdjSPFEzCwrs1wvH5GFdRTBpJ/0m?=
 =?us-ascii?Q?W4eXquCUvMthqsT47ybLAP64rTLo7bblX1CtggZuiYEO49o9TJywRL66U7fl?=
 =?us-ascii?Q?IbqHUvixdPVRU+ZMXbJOS/mzyHH0YwCxSmLKDqg8eWBi4GpDBXGBxNX0Mh8r?=
 =?us-ascii?Q?lb+fY3eg+gOjSZcbG2fGwhrVsOez66+L1BRuAVRa3aMu+ikmWXBlXl53sr2d?=
 =?us-ascii?Q?UjiixRzPKter4TCPpnShyOp6kmLbaGVbQqOj9E3YNt93wz/45MeUu61pBlNB?=
 =?us-ascii?Q?lwA5lXXvkCmsfxup1tOI+flJAENtMImudmPb/5EqfR2QuHbRHFShsBkjWKC3?=
 =?us-ascii?Q?mZC+QQJvjkzF5f1exc0KjQqHGKUsl6Cze1PzrUnKO5hNcqS0o71taMLWYiM0?=
 =?us-ascii?Q?NHJ5IsM5OoCbwmnxYT/Q=3D?=
X-Microsoft-Antispam-Message-Info: lyE9I0LuzlBaiFrcjJqedgUoawIyrdeYNvFJbu7W4/UyyFOjm0b6BS6rB/x0eo0KEywe+rqpYqPzGGpuQoqyOWoN8+9Xna9XCjurqDxRb5NOFfrPXkI6a5o9oJvxxny/qXDkSHhZ6lgXAERFLX752Yi8wiCWKICGiKLRWn3SRX9f9dG5s3jKd8sQp3aQrZJcK+6AAL6axkFEW+sFTR8LpsDIebPzrelunwft9TTaXiZf1jOnous456xSgR+ynNuGwA5p4HD1eKOAEs3nWfXeg6AiE0+vh5gW67WYkiK/uxKlEeKdW+chI2hRLNdDeuVhJcMQtm+hSiTaJq9uQHyMDeCZkhxpYZwdsTEzmLGkwHY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;6:cIIqQYoeg+DAHXK3zSFtFy9wEsgB5EzStPyCPPzLRYWEmfd/E9SSWxxfkt7uvQQ1N6kjRLa3UnfEKuTbbWYdQ3UvZ6O1cSIs1ZTIVhBQ8SynHy71puT4TsBE45pCZ3Io+Xu05SI983TKylh6PwgYTI7J6zfeotvs4fprPpwSyYT5vFgZgUdItjje+Eqwk9K1KON/1N3aWLrrhjK9NIDVwbOCw8FQRJZyY5Qg8BDCJTj/5a1cFV3M+RCjkofdudjYqc5PtJnD/YTbSS6+zlfUtbqubmVMXWrcL8B/qjY+obmAmCRVt7O2piAFb/lDFCJI2uhcT0DieNgizFSBfL5VzW0gMv2QQxxLxr+EVLNSwnYhtxN7bAcONaj91RvdPJAn0D9teFNt5f17dezuT4lG7850oHv6fVs5VMVpAr3L4Y/2EzOqBm/n3xrrphwAOFmRKRYB5irKB5rEExiuFuyW5A==;5:2RLHCzsrw7XFa48kQ5yrZqaFGrYHsA+zkYF34AfIFSsHolmaBvVtjTnLeX31pdi/RixJ1JRUAeXAkqWJk1mVAkTIxbqo2mc21c9pNsBU1yBEW2fBudl3sc/a0qPTBRydanWsDPsXKOV6yopCK5YBiHY3Lf5LMpZJqGwbwe5SILQ=;7:X3SMzlbGLpn5oU/Ap2Llddl85Gdemoyx/VOJXovNaVC87fU5DFyOgmgdd0lqwpOMk27plsWquaCGB/FoRJf20GHzDShVxZkigejF/HGnvqHmQ43nLTBkiIi0BS16J24kAKNOxT5ZzBSOUN9skHDTKoiP6uU534eAszKcrAqGl4foaGmjcQyKCNBUtB0WL7h5ki/fgx92h8rc2UXCf0z/zgWeGSceI5Z5MTtB9YMUPe/69SZ+2yb4bDMQb8wUSeWH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:13:07.3079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e9cbb7-cb50-4147-f4c7-08d60f199689
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 814aee92a1d3..bcd20ebb2ebd 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4595,7 +4595,8 @@ static int mvneta_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			NETIF_F_TSO | NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-- 
2.18.0

