Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B319CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFEA213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CPDi3s/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFEA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJDPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:00:37 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53390 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbeJDPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:00:37 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9480MrB009798;
        Thu, 4 Oct 2018 01:08:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=s2oKyfl20M2NNnZD5f+EmlQH5eg1d8wPiwErQ842aE0=;
 b=CPDi3s/FaN+Un38LpMtod8QxqImMXZfqAS0EjDIiW/e1ca/NVHu2m5fBYvGVN7c6zsvA
 dYbPo4/3nTs+TI/3ACkpzy00UvUOW1wuRhR1Pt2ESf2tsAYAmGjreaPKyTgPtBBt7gim
 ttgRuFdI3zPHwvW63XfsgWsI7dhv9p4It2E10XwAPODOkfbmqtO4AXZbaLR9BMz13Alu
 i/qBwwi8zpFHz12Hc/1Y/1nnzoBOTvbaIMd6oFiA/Y4KB+UX1aM1eMHS+zNjHvP7fWGm
 QdlpJXvhI14lLvq8BbAO0OiFyHasIDeVlMJXKFfjPrvPVG2epXpQgMjJoUbd++NIoRO6 wg== 
Received: from il-exch02.marvell.com ([199.203.130.102])
        by mx0b-0016f401.pphosted.com with ESMTP id 2mt8wh063a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Oct 2018 01:08:32 -0700
Received: from IL-EXCH02.marvell.com (10.4.102.221) by IL-EXCH02.marvell.com
 (10.4.102.221) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 4 Oct
 2018 11:08:25 +0300
Received: from IL-EXCH02.marvell.com ([fe80::5893:b43a:12ee:1b7b]) by
 IL-EXCH02.marvell.com ([fe80::5893:b43a:12ee:1b7b%20]) with mapi id
 15.00.1210.000; Thu, 4 Oct 2018 11:08:25 +0300
From:   Yan Markman <ymarkman@marvell.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "Stefan Chulski" <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] [PATCH net] net: mvpp2: Extract the correct ethtype from
 the skb for tx csum offload
Thread-Topic: [EXT] [PATCH net] net: mvpp2: Extract the correct ethtype from
 the skb for tx csum offload
Thread-Index: AQHUW7i7bKe3wJSXT06HrXe4bVthZaUOumRg
Date:   Thu, 4 Oct 2018 08:08:24 +0000
Message-ID: <763e186250f44f9ab7208478442ce1a4@IL-EXCH02.marvell.com>
References: <20181004080308.7687-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20181004080308.7687-1-maxime.chevallier@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure that kind of ntohs() using is good for the Performance.=20
htons(ETH_P_IP) is CONSTANT swapped Big/LittleEndian by COMPILER whilst the=
=20
ntohs(vlan_get_protocol(skb)) is run-time short/byte-swap for every packet.

Yan Markman

-----Original Message-----
From: Maxime Chevallier [mailto:maxime.chevallier@bootlin.com]=20
Sent: Thursday, October 04, 2018 11:03 AM
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.o=
rg; linux-kernel@vger.kernel.org; Antoine Tenart <antoine.tenart@bootlin.co=
m>; thomas.petazzoni@bootlin.com; gregory.clement@bootlin.com; miquel.rayna=
l@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@m=
arvell.com>; Yan Markman <ymarkman@marvell.com>; mw@semihalf.com
Subject: [EXT] [PATCH net] net: mvpp2: Extract the correct ethtype from the=
 skb for tx csum offload

External Email

----------------------------------------------------------------------
When offloading the L3 and L4 csum computation on TX, we need to extract th=
e l3_proto from the ethtype, independently of the presence of a vlan tag.

The actual driver uses skb->protocol as-is, resulting in packets with the w=
rong L4 checksum being sent when there's a vlan tag in the packet header an=
d checksum offloading is enabled.

This commit makes use of vlan_protocol_get() to get the correct ethtype reg=
ardless the presence of a vlan tag.

Fixes: 3f51850 ("ethernet: Add new driver for Marvell Armada 375 network un=
it")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 38cc01beea79..4bd5b251e3c7 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1737,7 +1737,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, int l3_pr=
oto,
 	command |=3D (ip_hdr_len << MVPP2_TXD_IP_HLEN_SHIFT);
 	command |=3D MVPP2_TXD_IP_CSUM_DISABLE;
=20
-	if (l3_proto =3D=3D htons(ETH_P_IP)) {
+	if (l3_proto =3D=3D ETH_P_IP) {
 		command &=3D ~MVPP2_TXD_IP_CSUM_DISABLE;	/* enable IPv4 csum */
 		command &=3D ~MVPP2_TXD_L3_IP6;		/* enable IPv4 */
 	} else {
@@ -2600,14 +2600,15 @@ static u32 mvpp2_skb_tx_csum(struct mvpp2_port *por=
t, struct sk_buff *skb)
 	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
 		int ip_hdr_len =3D 0;
 		u8 l4_proto;
+		int l3_proto =3D ntohs(vlan_get_protocol(skb));
=20
-		if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		if (l3_proto =3D=3D ETH_P_IP) {
 			struct iphdr *ip4h =3D ip_hdr(skb);
=20
 			/* Calculate IPv4 checksum and L4 checksum */
 			ip_hdr_len =3D ip4h->ihl;
 			l4_proto =3D ip4h->protocol;
-		} else if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
+		} else if (l3_proto =3D=3D ETH_P_IPV6) {
 			struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
=20
 			/* Read l4_protocol from one of IPv6 extra headers */ @@ -2619,7 +2620,=
7 @@ static u32 mvpp2_skb_tx_csum(struct mvpp2_port *port, struct sk_buff *=
skb)
 		}
=20
 		return mvpp2_txq_desc_csum(skb_network_offset(skb),
-				skb->protocol, ip_hdr_len, l4_proto);
+					   l3_proto, ip_hdr_len, l4_proto);
 	}
=20
 	return MVPP2_TXD_L4_CSUM_NOT | MVPP2_TXD_IP_CSUM_DISABLE;
--
2.11.0

