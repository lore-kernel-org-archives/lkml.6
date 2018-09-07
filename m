Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504E42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cYRsY/yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeIGFTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:32 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730880AbeIGFTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGPZ0z8RjQLTCrrRyjIRMZEAQ2bnPpesWEOsjDyRZt0=;
 b=cYRsY/yLPfdhhDJC+uAq5nINgzK25t07LEXEkQ99PTTRRUVZ4zTysF1vZ6I34RyFZQ5kXdOZUCulk99dKEs31OCtXv9neTdOwwQsMthNH8cSfF1NRBNhpBstpPSMXpdz5+FuT9PSNeKTx/aKELOIOt+IUJjU3OPu4ssypyxvFMU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 33/43] nfp: avoid buffer leak when FW
 communication fails
Thread-Topic: [PATCH AUTOSEL 4.9 33/43] nfp: avoid buffer leak when FW
 communication fails
Thread-Index: AQHURkMgPU+fJmDpvEOqjZIhr0Dryw==
Date:   Fri, 7 Sep 2018 00:38:42 +0000
Message-ID: <20180907003816.57852-33-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:ESoYmESEXt8V/7JtQbUS5bZUjD8qJKQqudMvWc8vcGq2g4WnDo/AlGcKiI0kwPSvkZ9ukf5t4kUiSW9iChXBoXR2tHQfjv+rz/jWLGIbsJ0R39Tdv1uqL3m9mq6fsNy+WBq5FdUza5HpGOWIF/EE8LMAzqkhJsUT3hW1uz6Vj++Lwchjske9qEHYyDNbq4rM1pHIq2z8Alqd9SSXY/VThuXPo37iWDtD/GH+3Cs6tJ2SB79dHQDnyfJQX/fNkOOoJ8rX8dYSgGLwjCe1XVHIsPctwl0Q3JGPhtfbWluwtXqVlo9lvKPXQBzXNwBl3kRzhD8SVSsBS5GP1J2hV/42TaDEbQ4YfcEWynNecaNJ8jPs9vc584BdmgvIw1Po2l5jPXfOzlCpzR7Idwo5fTJLwkCdrLs8szulghWeLvQuXRAKMbtnO8ObmC/ZIwnUopuad2xHjGpM03bClEIfBsd3Iw==;5:s+YBgD6hxfsnrXMGPLYm1Le36Rpx2xaINIPrXe/T+eCRcUClhL2F0+k1+nvl3wi8okNF2snZdTS66dobpwL28+2CUCWejGc3f8aX4g2dLGPUON/szV6rxw0LKXbShem42CvkAOb+VpkNev7mKNtnlF/NX2TqDqNKt4gxugP/Yrc=;7:sWEakv07nXtPGqcOAx4bjoznzD9PaHJxSPH91EdSwWOSGG5nsqqmeo+DrDU3LyZhpikTvBpPukZ1FeAVPLSULCgY8a/oYMV1LBhR9WTBP5x02I/9sYtez59onz8+SkRduLHkVw0gsSB3WE3AuA+RQDZTWGf04CimW32McHRYTxQ3rLk6J3Nop0bWSeO8R2fYE8rQNoTlZdt/fS1Jg6+mWEcgOM5WA9wugRdoaRxd/cNWhXLlKB1jQKsOJKlvxVuV
x-ms-office365-filtering-correlation-id: 0610c7bd-0231-4c86-e180-08d6145aa109
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB06940C954FB40284775418D3FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(39060400002)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ODc3ry1IbIVHQ1uSLK0jujq2LJoss37U6DL6kvJ1am1cFF0nm7S03QyQsMtyjmY3JXfZV33IrF5x+gy/lHzCK63Jh7KjGO41GNbDLSyjDYGd+BM+KFDZ/9OuFxxkAEquWYXkT2KemJoSW272QECpKpcw+3i5cBRjCKc83nMhEFyZzQ/RtjxzNNYHVVrXO6elYtopmQcjTVw8pcAFRfSO19Xd2dnxbxbu5A74xb9GMUhUrmlHAb7y6e4kD3X8lpQzGpzFJT7oImHNFqfirjxrgwI8guXCIe5nqEwBFDZfzfw4PpntS4AQtDMQzfJ1Rpe3lTD8aT4+cH+QDEWSfIUAc7rfxREnqVoCi+AIsg2L2xM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0610c7bd-0231-4c86-e180-08d6145aa109
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:42.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index eee6e59e6cf3..2e8703da536d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -990,7 +990,7 @@ static void nfp_net_tx_complete(struct nfp_net_tx_ring =
*tx_ring)
  * @nn:		NFP Net device
  * @tx_ring:	TX ring structure
  *
- * Assumes that the device is stopped
+ * Assumes that the device is stopped, must be idempotent.
  */
 static void
 nfp_net_tx_ring_reset(struct nfp_net *nn, struct nfp_net_tx_ring *tx_ring)
@@ -1144,13 +1144,18 @@ static void nfp_net_rx_give_one(struct nfp_net_rx_r=
ing *rx_ring,
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
 	wr_idx =3D rx_ring->wr_p % rx_ring->cnt;
 	last_idx =3D rx_ring->cnt - 1;
@@ -1919,6 +1924,8 @@ static void nfp_net_vec_clear_ring_data(struct nfp_ne=
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
