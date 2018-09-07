Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCD8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245B20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ovPwW0Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3245B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbeIGFRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:20 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730411AbeIGFRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouM2O3k/P5Ru2/dzk+JngDtVfPMXED/+4+87dMuHlOg=;
 b=ovPwW0EoGDSWAwRh2UIT7hG3IXu57/AONoXdzT58buAOnCIE92AEosNQyW/y6kRgqFbGByEudV5EI2o0VCpqB3jlS4XkiVsIRqo81BKA6WtaRhnjJ3bDPvXf0fruDs9R4MDWoZL32almlFsgN0JxWwR/qSzejVkaGVjneTjzNnw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 53/67] nfp: avoid buffer leak when FW
 communication fails
Thread-Topic: [PATCH AUTOSEL 4.14 53/67] nfp: avoid buffer leak when FW
 communication fails
Thread-Index: AQHURkMHjxn+xi+D00OYSNII6koOyg==
Date:   Fri, 7 Sep 2018 00:38:00 +0000
Message-ID: <20180907003716.57737-53-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:gtvBJ6qgp/w7LAvTK6FxbBruFuBdjlLWZRfqyLWQkT9SCcG56NSEPSgxx07VmYS+BLLI7wAMW+awh+qqK0WzlchjAnAqV7A6+h+Q168v7F+xBQlmt3ZJnws4xQMfuI/0HJb35B9/Oq1CU93h/Gkg15XX/7PJOnW1ZrivEuimCyFeuyj6jXIShen3uScJgzgPdpfg6rr36V19pe9FIloxRm8yEpavyObmKQsHAXoXRfzGDjhG2fEvT+kTQHT+g4LTuXkco/7V0tn+odgcQx5BKemHviNi1Hx8ZD5nwvUDbP69IDIP/kPcUsBQrP3lauJEDolqyOHNwiCK4d8uhd+TjspqT8Wa0+PqP2THEgCcoCaavRZr1i3ryQbKKd/bFEKo7XGc6XxuUf6rq6yvWtIylEvJ7AmtSLfREpaxcUjmtnrUi3+8Hp/EPR7y++7BD3/Tm8itXaAt7qxCujtshVaVIA==;5:lO7MKQBDAMb0nBQIsRiaHdXYu/GNNFMCe3dpdTtB7GjGsKfdvuPKptEar1I7WNSo+PbxyEOMdcDsWOM61zVu9rbt9wbbdNyMRZjwRommGeZnbXaYvlvx/HO2aSJbYbUa0GumjSmq0Ov1v7EHk/wB4HL+xkMnAJ1b+qhiUpK24IQ=;7:a3EOyN7Z5z8PcaqdYbm2Rtl33KwldW6ZJgur1axjZoG1DJrhrnvZSR5gNBTsxXn8scXE/pEBfvgkqd67D7vAbZr7kJhGTrp3FZEFiepyBp8LV/3CdMOdEfJSboQZJWy8awWPGzbGMTSfd6vQzt6NKj79xHfgARA84nDTh1wbgiw4Oejum5YofOKXMLO6tSh4ynlD8THd0Iv4J/OVi27NmT0+8oTgWrU7cgackct8cWrUG7MlwqBRxhVj8YxTfGoC
x-ms-office365-filtering-correlation-id: f39038dd-617f-4bc9-fb17-08d6145a50cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075712E1268E0C8F0AB49EBBFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(39060400002)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: PflWJFrVSu2oVX8MP9ulsjtBwZgcvvkFCVvOXHU8e5YgRGV8U6Dy5JEqT2h+o/AYa8fSKi4u65Rcu3W7Oy9nmx0PfbWceQpafpR1wSHc7x4nLoSgPZL8IBdoJZqWoMf4TAntS2A5/mpmKsNCI0605LjE+dPn3J+EGg+r7KlmMne60J1pOp4UXc5sdm2QnC7rQ1rYa7XSoHrmReKPJwZNd3iDx5clSuAWJUXOacADio6GpgD/Rabo6IG2EtXsSmUXwvLNh/fQ2g3H6NWJxOhUUdifJ5xGrGG9KM5CKp9E1fuM5Q8iILcK1r3vdpg61sck7e1qj4xUjYAB07J9Q8fciXkRgraEb3sb5r4V0n3Pir8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39038dd-617f-4bc9-fb17-08d6145a50cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:00.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 07300f774fec9519663a597987a4083225588be4 ]

After device is stopped we reset the rings by moving all free buffers
to positions [0, cnt - 2], and clear the position cnt - 1 in the ring.
We then proceed to clear the read/write pointers.  This means that if
we try to reset the ring again the code will assume that the next to
fill buffer is at position 0 and swap it with cnt - 1.  Since we
previously cleared position cnt - 1 it will lead to leaking the first
buffer and leaving ring in a bad state.

This scenario can only happen if FW communication fails, in which case
the ring will never be used again, so the fact it's in a bad state will
not be noticed.  Buffer leak is the only problem.  Don't try to move
buffers in the ring if the read/write pointers indicate the ring was
never used or have already been reset.

nfp_net_clear_config_and_disable() is now fully idempotent.

Found by code inspection, FW communication failures are very rare,
and reconfiguring a live device is not common either, so it's unlikely
anyone has ever noticed the leak.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/=
net/ethernet/netronome/nfp/nfp_net_common.c
index 8d53a593fb27..aba1113b2392 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1071,7 +1071,7 @@ static bool nfp_net_xdp_complete(struct nfp_net_tx_ri=
ng *tx_ring)
  * @dp:		NFP Net data path struct
  * @tx_ring:	TX ring structure
  *
- * Assumes that the device is stopped
+ * Assumes that the device is stopped, must be idempotent.
  */
 static void
 nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct nfp_net_tx_ring *tx_ri=
ng)
@@ -1273,13 +1273,18 @@ static void nfp_net_rx_give_one(const struct nfp_ne=
t_dp *dp,
  * nfp_net_rx_ring_reset() - Reflect in SW state of freelist after disable
  * @rx_ring:	RX ring structure
  *
- * Warning: Do *not* call if ring buffers were never put on the FW freelis=
t
- *	    (i.e. device was not enabled)!
+ * Assumes that the device is stopped, must be idempotent.
  */
 static void nfp_net_rx_ring_reset(struct nfp_net_rx_ring *rx_ring)
 {
 	unsigned int wr_idx, last_idx;
=20
+	/* wr_p =3D=3D rd_p means ring was never fed FL bufs.  RX rings are alway=
s
+	 * kept at cnt - 1 FL bufs.
+	 */
+	if (rx_ring->wr_p =3D=3D 0 && rx_ring->rd_p =3D=3D 0)
+		return;
+
 	/* Move the empty entry to the end of the list */
 	wr_idx =3D D_IDX(rx_ring, rx_ring->wr_p);
 	last_idx =3D rx_ring->cnt - 1;
@@ -2489,6 +2494,8 @@ static void nfp_net_vec_clear_ring_data(struct nfp_ne=
t *nn, unsigned int idx)
 /**
  * nfp_net_clear_config_and_disable() - Clear control BAR and disable NFP
  * @nn:      NFP Net device to reconfigure
+ *
+ * Warning: must be fully idempotent.
  */
 static void nfp_net_clear_config_and_disable(struct nfp_net *nn)
 {
--=20
2.17.1
