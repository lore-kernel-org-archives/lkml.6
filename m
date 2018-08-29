Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5D0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A692C206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="wG+Eta2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A692C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeH2M0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:26:47 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:48160
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeH2M0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm4BaL0NQFhNa+A1ISRcyLK+GL21wNHApx6exQXongI=;
 b=wG+Eta2axCAZbZut18vbA038uS2Djj1W8EeTO75PMauHnna6dWN7lvuFp1/uiDH1ap9CUF8+wDTC61AcUSf4wiUnLlqfTl4vxFSwvwUO3EFo+UhmgSpUeeJBGIwzOnbsXZGucZjQEYHMtz4YIB7y4EvioVwt6a4TRmLM7Iek6LA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1573.namprd03.prod.outlook.com (2a01:111:e400:526e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 08:30:52 +0000
Date:   Wed, 29 Aug 2018 16:27:51 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] net: mvneta: fix the wrong function to unmap rx buf
Message-ID: <20180829162751.018acbb6@xhacker.debian>
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:604:d::28) To BY2PR0301MB1573.namprd03.prod.outlook.com
 (2a01:111:e400:526e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 945bfebc-4224-4d04-5707-08d60d89bcad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1573;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;3:fQx6B7owvOshMs6bwmGj73eyFiZvPCJfTs9WS2Y2Q13SGHMg1JC+4oDQ5HZXQrS7RLfwAeHnbv/pM5DI81o8Y2QFKCeWD6NNTaUesJQW7T4OA7zrD+amS4oCsWBpSpfnawWy6LMAvPV4O/zjpHIrsjm1YyjYZCvj3kW1nLE5uCYDIEgQFWKugccth1Rh7egVp83rbjztAIPiHh70a80AXzL0UHw5vDGcKz8jtIz55zXuDEYKdpPlfwvLVAy0tUwo;25:/XQ07x7CxfhkE/sgxD2ymR2aQNew2+hxBQ5H3NQERWLuXr9OPK2jxAczRoDyvhDyiBDAIwiEz87+SCe0rX1TV4J9X1iRd4f2FshByAVDtX9/tEAXaz2EkBAC4LTf7zdkxpmo3VZ16zGuowqLjyUEGI+9V81zTrNJIqrORz/lgPosgANBhXfaqhLznAxZIPEoJyNdJue13VF272hNxQZkGpCTVpp0Q8XrgX4COchfl8rihr+EX6H93wBd5BAH68lFKF7Idm8gl8aQgLC7jx0uNLKAu/VgZ4MQ0VAyvNGrWd7QFLTnGhoyl7pgDnw2cAvTImWMXQJ5zj3log/gJY+uZA==;31:vsMlEkyb+cbBTDx1bilkB4oshtreBZyZLzaFzLWjPWwVnEOJAXcWKODUrOkvy2Bl9wNODsqmteJ8bXldtnIFUj5PNDimvQDwgyT7EWPeiUBdgjp8GgRpM8arCjkzZ0HS/bsAPY63dF33/AMDCGne5EOv+Ol+Yt4uXzUHZ3PM+7w9r4KX3RTfdfn75Jy8mrVtMdWkXMZKq+X38K47nSgXLcMhirXJ/sh9e3w6VoW9XXQ=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1573:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;20:1hgPOa10t4XUX8a3b7A+rdlM6LcCW5udt5hiPawM6Un/2ErCZ68xidTKyY5TgxtBYM6mbKH0qmSAHdZiFtSotk1rOC40X4lAh7urIdx6C3/4DverIrH2+OFv3fBBF2FqH6bn+WDE3LgdtJUqs9f4zSSbuzhkaOZOl8U0tMdIAVUJE3oF6gyj9SBXvGD1RP+CHyI71MZnVhrNc5MgeBDHeqyfEHiLf5fhnPmedgjK7p8ts41aoFoD9hh9f/2qZGy7yKwOkefMPv7XfSGl+QDmHzcU+vJXD7ooYra70DhYEl1q7E2zFcH+7juMSgQHf4i9+pPXYK8qWbwHmlJ1PnZCzGCLfGlVl72ddTW6tPz8vBQ1yQlhix1zVvBO8FxDz0pneo5PLAPJaNakvw+QxFhsNdXQDcm2GFKpXKOIU3wWuojPQYt0n38tsVWAANGp/zXDroSs/Mb44YpFItehaQQFrEjzXqOWOMonoUi3Wf27X93+uwkeJwN90m9AJKjk/OSb;4:Oh+ZRBTLiD8lccKB6pCikHSRWcFInUXOBxj064njxVOBy96FU213r3S1MHcXxmtPy7VQt6QwJHEizqM/fGPQ8ZhtdT326TMbtw+ZI/NW8ryujQJxRTHpR/PpmtUE7HeKOb5bEdcCEmeoeBXk2ddHLYWG1Y952nXIqmJA7MgfMuYC3NMvyUnvZRDMs82K3p05ezA+pkPezrmdg3+SF95bM6Q8+wfM8Rf+F8UIOSWyTpfzU7Zvz/djm3yFyYMLddgTY6KcN/dTfEw9jgTGlY52ow==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB15731C1A51105AE5E02AFAECED090@BY2PR0301MB1573.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BY2PR0301MB1573;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1573;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(189003)(53936002)(8936002)(26005)(72206003)(52116002)(7696005)(76176011)(478600001)(33896004)(316002)(486006)(446003)(16526019)(186003)(55016002)(956004)(11346002)(476003)(50466002)(6506007)(110136005)(386003)(9686003)(86362001)(54906003)(25786009)(97736004)(5660300001)(3846002)(106356001)(105586002)(66066001)(1076002)(23726003)(50226002)(230700001)(47776003)(6116002)(4326008)(7736002)(68736007)(2906002)(305945005)(81166006)(8676002)(81156014)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1573;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1573;23:19zp3OzJpsvA+vIzDjWHucuIO5jP30pRrTNFIh4?=
 =?us-ascii?Q?4/+022ldvRLYh3/iP2KIVVns24MgroBEL69XWYbS7GT4tM234eCRx8xTsn8k?=
 =?us-ascii?Q?EaexxUUMYxIERRWuDWdJVFjy0262GvMg8rL2V/Jc0FX9hJo6jf9CS9ytHaE6?=
 =?us-ascii?Q?vtRMyUTGRDm0k0qd60FbRT/v8iZcccNFAakTRqh7+KVyYjPw9xt9SkMPMahy?=
 =?us-ascii?Q?nM6TEU/EDv4oE9Ay9F3JWIgCMX8RSH3x8BVXI7uIZsGbZ+crNSzrpLNoeTW2?=
 =?us-ascii?Q?2/XUaalltfDjwzOyK6CFFDltuLOqbhT2Em314zO2KVewTVt7PnkjA0KjYQt9?=
 =?us-ascii?Q?eXMhkOAVpw0F476zfP1Lz2XIFc9n6qeM+Lauz5u/HeRvCKWJJNSa9fdMKOrM?=
 =?us-ascii?Q?RQbaFN1gmFaEVEzp7SIzu3yssGuuIRBHp7gcqLYrP1xGcaSAskdCh1W+M3hu?=
 =?us-ascii?Q?LrAAyzFZoQKcKuLnLe6qgdkE6BNDOLKlviMh9YjLSxQmvINjLk46U9918qjV?=
 =?us-ascii?Q?MBnivYvHFHHADD1A+zudjDYJCny2PiA6nJwWZ0LyhSv7c6GnKQ0EOz38hcch?=
 =?us-ascii?Q?QWxOPsHoO0dM4rctLdnHUOF7tdG2uIAUBL9khuSbZ0tNNJoJW9EX+Mtxjiko?=
 =?us-ascii?Q?D3OuTiiKS2zbaUqDEvLRqcuQZci+O0PZQCCnYNPtST1TIJ8JUtEFVVckDZl/?=
 =?us-ascii?Q?I+KH4RsvglJbDdXanXzmTh1Af/Yp0J1SOWcXG46BIDJvpyQcy4Dfia4WkiF0?=
 =?us-ascii?Q?Q9/M3U7KlPzjWA6x3igzsXTsgPIBokowTF3jhrNxTM0InXkT2MjuR1rvh20W?=
 =?us-ascii?Q?ztuin/UBF//Tzj7q0cCEXg+srC/GLt42M7RhkbQUQPj6qikAK5CbwGCGqUHw?=
 =?us-ascii?Q?BV5Q6kr/GLElRBRS+FYEPvmPJWuLFDsoHw06aWXIxky0zuKaeITUF3JvwLWC?=
 =?us-ascii?Q?RZ1jqtygdbt6i0aSDHOHxxPUQeO8D6nWfzoUrIKcHVIujPpwUhbHNF56/Y3v?=
 =?us-ascii?Q?ImJJ1R0a86ATSk7F6Jxh5HDrs9ujaCLjnoarpJULq7la1xnq0VH5sCwcGoEq?=
 =?us-ascii?Q?f1Nv0uL/Z8GnMXPrvYG/qaIHmgxZhiirvVlwUGme3quYDeA5kZndamqxOJtk?=
 =?us-ascii?Q?lxCcpa2weGJP7hMtO5YezlMH4SiVpFO7Z3i4QfhfMmaq9XCzbnsLegw5l+8r?=
 =?us-ascii?Q?BuXyUgi3rjgTG0ICXvfTYqWxZ0qeWgiEnTEdYDkWEvmCsEvQWIJu2+RuM1Q?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: q35CbPSFFR7dw09PcmqbSq1PF4tAR9sHrkcKF42VAufpt/N22NdKg2RwLfgHY46TGM62sZ43476Z+MtfoeandzFCpFadEDDD/1hLs6NglHV7gckkBm5+Zy6puk3kwJLdjuQHX9IG6+Rdy2D7sU4AUUmQRZEEaiuKRbu4zmTgUlqL31ztvlM/wwMxSoELgGgL9/91nW//pNBI5uGOg4idwjuQIqaPoH+SEEBfMWi6DX/t2GvRtj+FfMkuhIw7szyP7ZYez/nbwjuZ9DdkIA0me/FvgtfGn0O+NZrM9JOEif5O3AzKgzc6VPBGWyzXZj34uaJWeSFcEsHKIHr8AEsEDXnZxiA6MVSQokDrAFPcbIo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;6:Dl2OTBmjKT2OI5csLo4hDb6MBqA+oppZzTirIPipofflpzTEgMZCpYwOes2mpSiLX/c0Kiayjzd9WN5MRNEZOJu1lQCvPoEE5pANHUEMphEEZJQ+lCSJvBQHx0ZXfWLhpRRu6aJYCzdKw4eCTZrTKajeXB9Kcm9izZeWK+rvSUJZFwuLS1NUeLr/nNMHZ5QLEROSccqAk7+BLFbuh0I4go+dUzNsWY41LsIdkiF98RQgW6H66H7FDWMagT+WxYiuJ7vdSgTqh8bfImHEqSota6CbS9cR8uDVcR24SIhsx1vOctZUoRK4mJZ7hlwqhp4VE/QElyGoeIR27zun+/jdPtLg4lFjpIh/5hFjdi6IROejA/FBAdstWO3NncMaWpUvruN80a9ilr/lR9FgvyQIXQzhRiiVHqCV7KtY1OcTsEFuj35vFm8BRyCM6LSa+H/p2gUA4g7dkUUZROS0Xw1CnA==;5:hrku4tz40iIt4wMnvVkvlynzEFFwxVOIzEgivxRTwxLUSBuHpgeC5pkhpcHuhUJKtuZQooVRoCrMF47v+wpl354KTg3Or+7S9xSfEkcOSlRYjBG1HRofbZn8cWpHe0wwUKohRPp1ucjejlmH/WIlapIYt1Vm7RpsmJYU5m6g01U=;7:3LF+w8ozXHU+gsWSROyvaLDVsGYsizdxgrfNVDb0CvmAOwm2ZOyQ92Rsr0YkTpq4COr5AzA3lAjfdZ54S30RNQP5TyfWpKMZ7kMEOMfghQtAaxpHLXmV3E66sbxTP0h7vl6YQZQtcuGuTxtj642fgAkKDCYsRR+jP/2RhyXx/r/XlRFZnKOrNWPmY8fNpIC1Bb+74XDB7c6w3SKHwBqg/GcehmtvyDBh1O6/a12gy5EFmEClnDpft/gj2nZUo0Tb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:30:52.5133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945bfebc-4224-4d04-5707-08d60d89bcad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
always allocate one page for each rx descriptor, so the rx is mapped
with dmap_map_page() now, but the unmap routine isn't updated at the
same time.

Fix this by using dma_unmap_page() in corresponding places.

Fixes: 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ce94f6587a5..d9206094fce3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1890,8 +1890,9 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 		if (!data || !(rx_desc->buf_phys_addr))
 			continue;
 
-		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
-				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
+		dma_unmap_page(pp->dev->dev.parent, rx_desc->buf_phys_addr,
+			       MVNETA_RX_BUF_SIZE(pp->pkt_size),
+			       DMA_FROM_DEVICE);
 		__free_page(data);
 	}
 }
@@ -2008,8 +2009,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 				skb_add_rx_frag(rxq->skb, frag_num, page,
 						frag_offset, frag_size,
 						PAGE_SIZE);
-				dma_unmap_single(dev->dev.parent, phys_addr,
-						 PAGE_SIZE, DMA_FROM_DEVICE);
+				dma_unmap_page(dev->dev.parent, phys_addr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				rxq->left_size -= frag_size;
 			}
 		} else {
@@ -2039,9 +2040,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 						frag_offset, frag_size,
 						PAGE_SIZE);
 
-				dma_unmap_single(dev->dev.parent, phys_addr,
-						 PAGE_SIZE,
-						 DMA_FROM_DEVICE);
+				dma_unmap_page(dev->dev.parent, phys_addr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 
 				rxq->left_size -= frag_size;
 			}
-- 
2.18.0

