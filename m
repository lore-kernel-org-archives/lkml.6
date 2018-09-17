Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E67ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA131208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F0ooqQnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA131208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbeIQIsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:48:23 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730167AbeIQI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiEuJyNJiGJVU60I4ghpOZ8yTWXGYqvvIxzACnA/XBs=;
 b=F0ooqQnYkdWhTp+nLU+KfQYyKE0YCC45vMwM9gt5wmvd9A1G9VuUUiRHzyRAGo/xYRd8qnsmAdoxjTgzw74OxcjB9OQYU4KLGcURKlyxAZF4ZdpdSjMtuhW7MvRzrL8Z1p0xv7pbCCdIAEs/an5fXVe/t/xalLEoTX8KZJHyzR4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alagu Sankar <alagusankar@silex-india.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 39/87] ath10k: sdio: use same endpoint id for all
 packets in a bundle
Thread-Topic: [PATCH AUTOSEL 4.14 39/87] ath10k: sdio: use same endpoint id
 for all packets in a bundle
Thread-Index: AQHUTjLqtqFKl9UFmk2kwZZK3mZEfg==
Date:   Mon, 17 Sep 2018 03:02:48 +0000
Message-ID: <20180917030220.245686-39-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:Ez/m/2Vxj6b/OoXUy2rFGoYbLy45Wv7H7h02qHfEWW9LAd3Wc4q/rTNVc0cutaAY1I4wnfReRfqayMOEvKbvaZn6zLvPMXIem/ouT0XiRPQUYQFvXa6aTCotJy/Skqpi2kkToVTTvTwsa7GkaMAX00HdkZgOoveqYEAlo9cAK9pTT2C+2sW97lb6vpCBMXP+cR39XqSoIIc6+qGNpFBgI2dDodWcmhZl1M5pmIj05KgJ5EwsyKiiHCJpaIku8b/V+QWzAQgbQ+vGp3wn+zBIJ5CAjmssBHr1cGMSpBHkGBG6nWGXrc18KUgTS/Zddmm3b8xaM8doj46/wCQSpPKTEmdLoQxCX3Pc2+CK5NMInRfMafkU3mJudzLLOLGYnW1dq318vr4zOiUv3c/3Z29+0EY66VzKOcGCqYAmfFzmAGSJDYNixfaPB4gqZXRWidX/B6+XRS/CKAypN39BfUj00Q==;5:6K3NGGCi5XRQQ62VZ8ceKtORJRsUBubgsBHwN7/bOksYYzsTuEzOCfRZsiYfefScnp4TT75HHnuyiKKXpaMTkIuR0Pb7Zyfil3CHtsU1qfl8w3KiHeChgbY/PWt3yzEyg7jEGMxu4uoGouqg9rdXYILsMiIVBn3YKn2WQL2wrik=;7:taF/G4HuOBYM0t1V8tQ3eMjy1GNK77cf/xY2N/xOTwr2bAwB/NJRjX3J8kPJEGn7/f4mlwstwRQVSRwvPszyHhwPE5bnr3m2r+L7/WjmE8cQ25gURuWU+BI9iMt7ddsvHCRfVvABBzif7FgiIMpYyODrRX25k1K5VkXS2ENw3E378UpwD0Ul0GBiE2MNOT7bnkjIn5GEyjWG5M6BHKiJQqj+/O+COYAJYaByYmE+1dh4+lfYr0QmACbKH7Yb4++g
x-ms-office365-filtering-correlation-id: c4626549-a335-401d-6139-08d61c4a4033
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB077641027BDB2CBD2622F8A9FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KFCmIe098T9AtGuMidoQ46H3BpjruHyFbFh5PpNpqnA1u0xGhJvVdJyTae46/Ib7mtrD9O8znhMlxV0fRhOcuDMXzrS0p4bg5Otjs+rWCuEM1+4txyQUujsc1ucRacLgUgAceoQtk9U8G6LzvQTojhCanveIjjrE1b2fCNLDNA+/nywhqmUeuCD55kJqK2BfVxXM0O2fb0o+EQ2g1sU1+bVGt3K+94aqpEnLb9MMbLkhwXUdNjFI+rQpfR24ExgCoT+WjNywuLxBVgKlhyo6JnIQAnJGmwCLXZI0i6AjUKuG2YC51wJ/74h/+YV/SrEeZts63U8jMhZXMAP5em75YgF8NPbe0Ku+uUxj7CutC1U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4626549-a335-401d-6139-08d61c4a4033
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:48.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alagu Sankar <alagusankar@silex-india.com>

[ Upstream commit 679e1f07c86221b7183dd69df7068fd42d0041f6 ]

All packets in a bundle should use the same endpoint id as the
first lookahead.

This matches how things are done is ath6kl, however,
this patch can theoretically handle several bundles
in ath10k_sdio_mbox_rx_process_packets().

Without this patch we get lots of errors about invalid endpoint id:

ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12

Co-Developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/=
ath/ath10k/sdio.c
index 03a69e5b1116..895ccfb2141f 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -434,12 +434,14 @@ static int ath10k_sdio_mbox_rx_process_packets(struct=
 ath10k *ar,
 	enum ath10k_htc_ep_id id;
 	int ret, i, *n_lookahead_local;
 	u32 *lookaheads_local;
+	int lookahead_idx =3D 0;
=20
 	for (i =3D 0; i < ar_sdio->n_rx_pkts; i++) {
 		lookaheads_local =3D lookaheads;
 		n_lookahead_local =3D n_lookahead;
=20
-		id =3D ((struct ath10k_htc_hdr *)&lookaheads[i])->eid;
+		id =3D ((struct ath10k_htc_hdr *)
+		      &lookaheads[lookahead_idx++])->eid;
=20
 		if (id >=3D ATH10K_HTC_EP_COUNT) {
 			ath10k_warn(ar, "invalid endpoint in look-ahead: %d\n",
@@ -462,6 +464,7 @@ static int ath10k_sdio_mbox_rx_process_packets(struct a=
th10k *ar,
 			/* Only read lookahead's from RX trailers
 			 * for the last packet in a bundle.
 			 */
+			lookahead_idx--;
 			lookaheads_local =3D NULL;
 			n_lookahead_local =3D NULL;
 		}
--=20
2.17.1
