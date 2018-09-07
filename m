Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523802083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NTDMaTvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523802083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeIGFfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:35:38 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:3440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeIGFPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwAFVkaCCabfkpkRFz7WYiJv9yNSBquCDwFGwZe54M8=;
 b=NTDMaTvIlhhyyEEGPFFYnfuovvg3D2oDDLIoQvJ3mU2kDsabcmv/i3DQ6wtEH+BZPiI9HgOaCn6SRs+TyChutazW0vxEldrkoyQaSv7v7SJqK6xhMWm/tNKTNcS65vIMIoiLKPPwguuM1DiRiYRyBVr7chs2vien6j+Nq5JWBe4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 68/88] nfp: avoid buffer leak when FW
 communication fails
Thread-Topic: [PATCH AUTOSEL 4.18 68/88] nfp: avoid buffer leak when FW
 communication fails
Thread-Index: AQHURkLX4Lwd93+QC063JIQG6T86hw==
Date:   Fri, 7 Sep 2018 00:36:40 +0000
Message-ID: <20180907003547.57567-68-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:eREdfF7MQHKdLPPgmpkPUKYLJyVtcztcdxaL3fu2zlCqLALykdkayDiX8DFkRX2LhQB37vHaKO1D3NdNEtxs1vqpWWbcyxtLLAaqAPEtCDbQ+cPrgvA6sODRjqJSrw3982qYwVbMUecPot9y713zIb69CubbDRzyBdJqeWjLQ4y5dUV+v54lGeUhRRLVD9CTYQySfx8vVMnCcuFSPaFI4knhsn3Av4LUPJsdAZPXMjLZeVc+WAcXat5G0RwWmD6VIiGGmjpBwBEar8EF0VqrCu69xG9CIyNZi9d/gQDuq+4M4yBjlLTYkFZ6MB8WBf5TbrBloQvWaQwPQ9/iOi7pAzlN3l4SxXaCfAVBewrFSbCqtUu40BuCQ6P0I7sdbC6TpN/rjIc+xQAtbjZmT4ezFD+GtQ+ugsXOXwQfQ76oqg8AiJQA+sETrNYdu/2kGk3bFTlTWLLYEAdbI0W0UF8wIQ==;5:LfFZ4HtnTxd9M20iprxIXO/dxAPbDpAu0nPByMpNBBKaUKUHIgHKhcGlZUhqUhVZAbO0KcJeBveCs/giqsYcYiFGL0GySXJUTXYGX488gH8tMAKuWLfnkSNiJIPap48qB5dNOEmXskQ5wpxo+Bt1zXFDy+Ze+MdAdWmeDWJxvVc=;7:qRXONoFkVoEuFx8UYPQoInQbiPLpTjVwI6AN+9uODGcgTb1g2nvdOEp3iBiwoJBHszIWTXwdmgFNH+WG4ls0QXnF2xlzi+Nc33GW61TOw5vo0b/ivPho9olbxH+ldY/hCEPzcondOc6oBD5kxPDTGSE9aBTg0QV5s4P7Cl9PY9nFtxNHH+GdvitQUI3dVoORVkJOtmk98L1ZbOFeOf+KdOiU/lRcu8jYfp7WurAljEbKW2zZyFwKsAOWsGRatjLp
x-ms-office365-filtering-correlation-id: ffdba8cb-b182-42fa-b5e7-08d6145a19e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0118A59A4E77A0C2C810731CFB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(39060400002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4kALkJKeDDdjQbcf6l7m/mwPuhAg6LGviL66PVs/HdfS7jksaHaDMlfdj7iIgN1wEXDPQjIPDDBLBMD39CQMM09hyJMxoUx3QgMnaJO16hD23uNe9Q9YJgYzkeB/LtMkm0CAqu2CFqrjPwrLbb/N0UJT4CK7JgfcwRdpKbeM0lXxw0ehHqUPXTlXKL+u2kTSMDRKs9jFvfAnwGaKF8xs9TJYSVxyorBmtljS8eCrkIgy43mqOLDh3sMZsratZMk23/JlLATThuxiS0yyaULyPKRcfqmrO3j1oKT8vTJ25rWoD2/zT7iQuwekOT8h8w+CnxeJ+e9CKf64zqYQsG/47KL99CFc2aqOqXo24QT9/Go=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdba8cb-b182-42fa-b5e7-08d6145a19e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:40.6568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index d4c27f849f9b..7605794b4e81 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1077,7 +1077,7 @@ static bool nfp_net_xdp_complete(struct nfp_net_tx_ri=
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
@@ -1279,13 +1279,18 @@ static void nfp_net_rx_give_one(const struct nfp_ne=
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
@@ -2508,6 +2513,8 @@ static void nfp_net_vec_clear_ring_data(struct nfp_ne=
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
