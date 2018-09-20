Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F3ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E721521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OTNVBUaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04E721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbeITI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:07 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387856AbeITI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEQ3Kx9S9y+qkBwKfEaIvKJLuslYGStcMBCn/An6B8M=;
 b=OTNVBUaDieUP0Kxhm7WdWtCiPNxHXjLSShuEv/0rDWtO0T4Ifc6xmLNwmuHxHU3kCyHXJgV9mDfjBiZQIgT1RuGcPRKzNFRSiKHQPtPd7lt/eHnvWzDseN3Kc0GYEiiy+stPyVAQGVKTNtpoMCuzyTPlDUHLu2mbQhtEYVfmrQw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 28/56] ice: Report stats for allocated queues via
 ethtool stats
Thread-Topic: [PATCH AUTOSEL 4.18 28/56] ice: Report stats for allocated
 queues via ethtool stats
Thread-Index: AQHUUIxPStZMncmD10mnCtGrTm9Ahw==
Date:   Thu, 20 Sep 2018 02:47:46 +0000
Message-ID: <20180920024716.58490-28-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:nTocBTcRatVXQpNtUOMMLf6XMi8fabQDCo6fZT680qhsqft0ZDD5NLBZk/1d1wtpMOvnL3kMu0z8pPyPDZXW4oQRb/7dOSOOsG4gfBrjaWoA3NqNK1iGf49QfoN24AIzAMe43Efxvkbf3Mlk+yhuHImTwR/lGVjYRL8n5ieJJmXaSQ0NVZcVxpfx+MVTHoRv0BBm+9zDBkwqmIKDR3TvipV5pkfgg2bRq+7oB7bSub97kdN5w3WRNqGSi/BXn5Fd1+vZxLukH8C8n7+R8CC4eCwOKNLLWW3u1UIupFYkaaRLOVFd0+RqA523B+wlVMnTxFfTcpaWTOgrIG5BisuVSD9a87YAl4S8NLBTVIvlP9+MqnmNhU4HvxMXgehjK6wNROOJCGcE78vp1vWA7IDiFboQvB/lU4k1LNHZvkbzOfxN10A/r33CqHe5D+TASsh4aGDQ+r5U+17FbTUioaTG2w==;5:Ag0ruqBolrmYnaARVEdZoenpldX+o/GzeS7AtS1lo4Mn4YjLh6dyT3ggRIsjLbhqt5UscXAd9ZD5WG/zsm0tYJ9w1bp5oPxCV2GhgehpC5WsZxHIWgHm0QRSb9yFXL9ge/p0pQhvAlfAzO2eDR8xua10qNnQBpcxX0jE44wrLCM=;7:PXC0rnkcP4qdUnFkxVX++EtI5ykcCGWKtjeFmW5NEA84TwviwxBWqx3dmO/jQAUnQnP1/dgD/a+7r7htTnqQSx2eoFU0jNQrFnuqxwLSpDMiLres1smWzWe8x+Bhc5YzvoeInonNNmumW/4yggdWRYA5FnPhzzvHXu9V2Iown4O4Mg6YdEcyYn16S3yP+jmaQWxDHwaaVYkVqml0RaNeEjdSnF2vAQkUQN5NgLJSxeNKZUZ0Tw7ap1CR2YsAbDPD
x-ms-office365-filtering-correlation-id: 6063720d-c12e-4097-1b9f-08d61ea3733c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08222EA2C35C077B26151D74FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jCxBXugv4W65DMjoaFoBINBdAm2wxCSJ01rlzzjy5pUfosLzjAyTEcnnjo5Yds7pbWXqB21e/QtCX+n/gN+CrY/CeZjw2c5cbzzvlT4ES8j+5jLJyqUz5ZAcrFnf/7krBNikWwe1/mixVuskib65BMHdZ1kAUojCnN85LQzuQBey7X6u5IBUYbgVqoENlvd1Wltr+yWHUP21E6XR8L+2oRB0UDIiQNFlXm62ZRd1UDH73oXEcl+XHbl/YvLHrYyTG5l5eplaIzdQcj2ofZLkoraK5dTe1fYVvWUZUQSGWjNOCQBGmxrD8QMQ31gxtOssYOEk1d9sbn5m84fwQKX2XzVLMjC/itALadjaOks0xmg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6063720d-c12e-4097-1b9f-08d61ea3733c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:46.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit f8ba7db850350319348b6d3c276f8ba19bc098ef ]

It is not safe to have the string table for statistics change order or
size over the lifetime of a given netdevice. This is because of the
nature of the 3-step process for obtaining stats. First, user space
performs a request for the size of the strings table. Second it performs
a separate request for the strings themselves, after allocating space
for the table. Third, it requests the stats themselves, also allocating
space for the table.

If the size decreased, there is potential to see garbage data or stats
values. In the worst case, we could potentially see stats values become
mis-aligned with their strings, so that it looks like a statistic is
being reported differently than it actually is.

Even worse, if the size increased, there is potential that the strings
table or stats table was not allocated large enough and the stats code
could access and write to memory it should not, potentially resulting in
undefined behavior and system crashes.

It isn't even safe if the size always changes under the RTNL lock. This
is because the calls take place over multiple user space commands, so it
is not possible to hold the RTNL lock for the entire duration of
obtaining strings and stats. Further, not all consumers of the ethtool
API are the user space ethtool program, and it is possible that one
assumes the strings will not change (valid under the current contract),
and thus only requests the stats values when requesting stats in a loop.

Finally, it's not possible in the general case to detect when the size
changes, because it is quite possible that one value which could impact
the stat size increased, while another decreased. This would result in
the same total number of stats, but reordering them so that stats no
longer line up with the strings they belong to. Since only size changes
aren't enough, we would need some sort of hash or token to determine
when the strings no longer match. This would require extending the
ethtool stats commands, but there is no more space in the relevant
structures.

The real solution to resolve this would be to add a completely new API
for stats, probably over netlink.

In the ice driver, the only thing impacting the stats that is not
constant is the number of queues. Instead of reporting stats for each
used queue, report stats for each allocated queue. We do not change the
number of queues allocated for a given netdevice, as we pass this into
the alloc_etherdev_mq() function to set the num_tx_queues and
num_rx_queues.

This resolves the potential bugs at the slight cost of displaying many
queue statistics which will not be activated.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  7 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 52 +++++++++++++++-----
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/in=
tel/ice/ice.h
index d8b5fff581e7..ed071ea75f20 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -89,6 +89,13 @@ extern const char ice_drv_ver[];
 #define ice_for_each_rxq(vsi, i) \
 	for ((i) =3D 0; (i) < (vsi)->num_rxq; (i)++)
=20
+/* Macros for each allocated tx/rx ring whether used or not in a VSI */
+#define ice_for_each_alloc_txq(vsi, i) \
+	for ((i) =3D 0; (i) < (vsi)->alloc_txq; (i)++)
+
+#define ice_for_each_alloc_rxq(vsi, i) \
+	for ((i) =3D 0; (i) < (vsi)->alloc_rxq; (i)++)
+
 struct ice_tc_info {
 	u16 qoffset;
 	u16 qcount;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/eth=
ernet/intel/ice/ice_ethtool.c
index 1db304c01d10..c71a9b528d6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -26,7 +26,7 @@ static int ice_q_stats_len(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np =3D netdev_priv(netdev);
=20
-	return ((np->vsi->num_txq + np->vsi->num_rxq) *
+	return ((np->vsi->alloc_txq + np->vsi->alloc_rxq) *
 		(sizeof(struct ice_q_stats) / sizeof(u64)));
 }
=20
@@ -218,7 +218,7 @@ static void ice_get_strings(struct net_device *netdev, =
u32 stringset, u8 *data)
 			p +=3D ETH_GSTRING_LEN;
 		}
=20
-		ice_for_each_txq(vsi, i) {
+		ice_for_each_alloc_txq(vsi, i) {
 			snprintf(p, ETH_GSTRING_LEN,
 				 "tx-queue-%u.tx_packets", i);
 			p +=3D ETH_GSTRING_LEN;
@@ -226,7 +226,7 @@ static void ice_get_strings(struct net_device *netdev, =
u32 stringset, u8 *data)
 			p +=3D ETH_GSTRING_LEN;
 		}
=20
-		ice_for_each_rxq(vsi, i) {
+		ice_for_each_alloc_rxq(vsi, i) {
 			snprintf(p, ETH_GSTRING_LEN,
 				 "rx-queue-%u.rx_packets", i);
 			p +=3D ETH_GSTRING_LEN;
@@ -253,6 +253,24 @@ static int ice_get_sset_count(struct net_device *netde=
v, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
+		/* The number (and order) of strings reported *must* remain
+		 * constant for a given netdevice. This function must not
+		 * report a different number based on run time parameters
+		 * (such as the number of queues in use, or the setting of
+		 * a private ethtool flag). This is due to the nature of the
+		 * ethtool stats API.
+		 *
+		 * User space programs such as ethtool must make 3 separate
+		 * ioctl requests, one for size, one for the strings, and
+		 * finally one for the stats. Since these cross into
+		 * user space, changes to the number or size could result in
+		 * undefined memory access or incorrect string<->value
+		 * correlations for statistics.
+		 *
+		 * Even if it appears to be safe, changes to the size or
+		 * order of strings will suffer from race conditions and are
+		 * not safe.
+		 */
 		return ICE_ALL_STATS_LEN(netdev);
 	default:
 		return -EOPNOTSUPP;
@@ -280,18 +298,26 @@ ice_get_ethtool_stats(struct net_device *netdev,
 	/* populate per queue stats */
 	rcu_read_lock();
=20
-	ice_for_each_txq(vsi, j) {
+	ice_for_each_alloc_txq(vsi, j) {
 		ring =3D READ_ONCE(vsi->tx_rings[j]);
-		if (!ring)
-			continue;
-		data[i++] =3D ring->stats.pkts;
-		data[i++] =3D ring->stats.bytes;
+		if (ring) {
+			data[i++] =3D ring->stats.pkts;
+			data[i++] =3D ring->stats.bytes;
+		} else {
+			data[i++] =3D 0;
+			data[i++] =3D 0;
+		}
 	}
=20
-	ice_for_each_rxq(vsi, j) {
+	ice_for_each_alloc_rxq(vsi, j) {
 		ring =3D READ_ONCE(vsi->rx_rings[j]);
-		data[i++] =3D ring->stats.pkts;
-		data[i++] =3D ring->stats.bytes;
+		if (ring) {
+			data[i++] =3D ring->stats.pkts;
+			data[i++] =3D ring->stats.bytes;
+		} else {
+			data[i++] =3D 0;
+			data[i++] =3D 0;
+		}
 	}
=20
 	rcu_read_unlock();
@@ -519,7 +545,7 @@ ice_set_ringparam(struct net_device *netdev, struct eth=
tool_ringparam *ring)
 		goto done;
 	}
=20
-	for (i =3D 0; i < vsi->num_txq; i++) {
+	for (i =3D 0; i < vsi->alloc_txq; i++) {
 		/* clone ring and setup updated count */
 		tx_rings[i] =3D *vsi->tx_rings[i];
 		tx_rings[i].count =3D new_tx_cnt;
@@ -551,7 +577,7 @@ ice_set_ringparam(struct net_device *netdev, struct eth=
tool_ringparam *ring)
 		goto done;
 	}
=20
-	for (i =3D 0; i < vsi->num_rxq; i++) {
+	for (i =3D 0; i < vsi->alloc_rxq; i++) {
 		/* clone ring and setup updated count */
 		rx_rings[i] =3D *vsi->rx_rings[i];
 		rx_rings[i].count =3D new_rx_cnt;
--=20
2.17.1
