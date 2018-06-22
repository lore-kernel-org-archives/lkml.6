Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37295C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D92488F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7D92488F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbeFVU05 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:26:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38356 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754290AbeFVU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:26:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MKPF9Q020969;
        Fri, 22 Jun 2018 13:26:50 -0700
Received: from il-exch01.marvell.com ([199.203.130.101])
        by mx0b-0016f401.pphosted.com with ESMTP id 2jrp6kttcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Jun 2018 13:26:50 -0700
Received: from IL-EXCH01.marvell.com (10.4.102.220) by IL-EXCH01.marvell.com
 (10.4.102.220) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 22 Jun
 2018 23:26:48 +0300
Received: from IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36]) by
 IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36%20]) with mapi id
 15.00.1210.000; Fri, 22 Jun 2018 23:26:47 +0300
From:   Yan Markman <ymarkman@marvell.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Yelena Krivosheev <yelena@marvell.com>
Subject: [PATCH net] net: mvneta: fix the Rx desc DMA address in the Rx path
Thread-Topic: [PATCH net] net: mvneta: fix the Rx desc DMA address in the Rx
 path
Thread-Index: AdQKZzflqC7AXW+7SbCthpO/KC9fcQ==
Date:   Fri, 22 Jun 2018 20:26:47 +0000
Message-ID: <93287208519f4364afbb299dd9961a27@IL-EXCH01.marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=738 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YANM: adding Yelena-K
--------------------------------
When using s/w buffer management, buffers are allocated and DMA mapped.
When doing so on an arm64 platform, an offset correction is applied on the DMA address, before storing it in an Rx descriptor. The issue is this DMA address is then used later in the Rx path without removing the offset correction. Thus the DMA address is wrong, which can led to various issues.

This patch fixes this by removing the offset correction from the DMA address retrieved from the Rx descriptor before using it in the Rx path.

Fixes: 8d5047cf9ca2 ("net: mvneta: Convert to be 64 bits compatible")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 17a904cc6a5e..0ad2f3f7da85 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1932,7 +1932,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		rx_bytes = rx_desc->data_size - (ETH_FCS_LEN + MVNETA_MH_SIZE);
 		index = rx_desc - rxq->descs;
 		data = rxq->buf_virt_addr[index];
-		phys_addr = rx_desc->buf_phys_addr;
+		phys_addr = rx_desc->buf_phys_addr - pp->rx_offset_correction;
 
 		if (!mvneta_rxq_desc_is_first_last(rx_status) ||
 		    (rx_status & MVNETA_RXD_ERR_SUMMARY)) {
--
2.17.1

