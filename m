Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F152152E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C27gFbb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F152152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbeITP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:57:50 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53520 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727633AbeITP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:57:49 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KAEhBx007684;
        Thu, 20 Sep 2018 03:15:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=XHCA96OtKoxxy7HYFctcDOIzjZ2kSEW+6KIjP1wNR9w=;
 b=C27gFbb0zKkvxgUJ1QkRnH3GLcYZo0Z8JMTIdnAfEJ5+inUYKvd8VYA8r8cCmbGJHe4J
 yD1hW/nigRFCcLL9S1WMSbCNw/5QkmZuCxAFGqbsDEmRoS7c/jSByLCrNk1Ugwdm+IMx
 OGNcIPnxZ9SSmKTmReGjE1YrmTDRW5FuFG3nZgriVP4fIEeghSfR0aq3WAbUD/6oCSwS
 J5PJIZrPS62Dy8YfaxEJiI/zICtsshJSab4ba0ZiOqm88qNAZbsy1hnr4DrzzroF8EcM
 Zw2tSZDY5IGurVzDfADDhk37XGfToLQ2X0ayz52DYnTopQcJZHY/e02dFFxHbHcjoA6/ EQ== 
Received: from il-exch02.marvell.com ([199.203.130.102])
        by mx0a-0016f401.pphosted.com with ESMTP id 2mm7dhge9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 03:15:00 -0700
Received: from IL-EXCH01.marvell.com (10.4.102.220) by IL-EXCH02.marvell.com
 (10.4.102.221) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 20 Sep
 2018 13:14:57 +0300
Received: from IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36]) by
 IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36%20]) with mapi id
 15.00.1210.000; Thu, 20 Sep 2018 13:14:57 +0300
From:   Yelena Krivosheev <yelena@marvell.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA
 unmapping
Thread-Topic: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA
 unmapping
Thread-Index: AQHUUB2ZKMnLakvV5UmL1EQUhBy92qT48r4w
Date:   Thu, 20 Sep 2018 10:14:56 +0000
Message-ID: <5ab58500e78549618b597fdc2e54356a@IL-EXCH01.marvell.com>
References: <20180919132906.26868-1-antoine.tenart@bootlin.com>
In-Reply-To: <20180919132906.26868-1-antoine.tenart@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine.

Good point.
Please, check and fix all cases of dma_unmap_single() usage.
See mvneta_rxq_drop_pkts()
...
		if (!data || !(rx_desc->buf_phys_addr))
			continue;
		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
		__free_page(data);
...

Thanks.
Yelena


-----Original Message-----
From: Antoine Tenart [mailto:antoine.tenart@bootlin.com]=20
Sent: Wednesday, September 19, 2018 4:29 PM
To: davem@davemloft.net; Yelena Krivosheev <yelena@marvell.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>; netdev@vger.kernel.org; li=
nux-kernel@vger.kernel.org; thomas.petazzoni@bootlin.com; maxime.chevallier=
@bootlin.com; gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav=
 Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Yan Mar=
kman <ymarkman@marvell.com>; mw@semihalf.com
Subject: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA unmappin=
g

External Email

----------------------------------------------------------------------
With CONFIG_DMA_API_DEBUG enabled we now get a warning when using the mvnet=
a driver:

  mvneta d0030000.ethernet: DMA-API: device driver frees DMA memory with
  wrong function [device address=3D0x000000001165b000] [size=3D4096 bytes]
  [mapped as page] [unmapped as single]

This is because when using the s/w buffer management, the Rx descriptor buf=
fer is mapped with dma_map_page but unmapped with dma_unmap_single.
This patch fixes this by using the right unmapping function.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for=
 SWBM")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index bc80a678abc3..2db9708f2e24 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2008,8 +2008,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 				skb_add_rx_frag(rxq->skb, frag_num, page,
 						frag_offset, frag_size,
 						PAGE_SIZE);
-				dma_unmap_single(dev->dev.parent, phys_addr,
-						 PAGE_SIZE, DMA_FROM_DEVICE);
+				dma_unmap_page(dev->dev.parent, phys_addr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				rxq->left_size -=3D frag_size;
 			}
 		} else {
--
2.17.1

