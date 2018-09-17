Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE65ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9668208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OfD/1+lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9668208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeIQI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:59:12 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:35844
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728997AbeIQI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfW1oiNw8MLiiDcrkrEemO3mqyPcmQac4N8AV+GbNKQ=;
 b=OfD/1+lIPCB+WSBYAdeluQ4UZxj11TppJ+tB9LJbxvSEe8hjLvFmU4PmwRO/5AxLjA71r8NhQyz9i09oMmOy/ZaWZR0y970k2h6uOABDggg/eAvtMP4jOIciD0YlrZf6RzJytipjAlnPHm3hHfaoVnVWJngAQaV/v+4qf06+pKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alagu Sankar <alagusankar@silex-india.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 053/136] ath10k: sdio: use same endpoint id for
 all packets in a bundle
Thread-Topic: [PATCH AUTOSEL 4.18 053/136] ath10k: sdio: use same endpoint id
 for all packets in a bundle
Thread-Index: AQHUTjKgOdPyDGu1ukmbQpi1ySYBoQ==
Date:   Mon, 17 Sep 2018 03:00:45 +0000
Message-ID: <20180917030006.245495-53-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:jj1oEbUKJaLIpFFdD9gTi/xMcYeuop2kXa5viZwyApgc6BC65k+E7Xmx2741jWIpW4MLWcW9mjk8/8M195ahc2LC5VsykKD+1M3jXNPSqFe4x6qp7KxuQlWbRkZGiMFdKKce6vyiqvmk2QsXAxKwr4AxAPiJTcFs8PiWOHE5nlPzFyWiAl5XvpB3i0eIcp6VKoew1HfI7aRM5XJh+0hcMwBGejZddS+iQrfaix4xZ+6rLoiXrcwrRHDibztl0/s0kkjxhbJfsrfiiuiA4XOrP6cH77GtGFL/IeXeLmLuhDaHac0TJLecO5Q1QV7YcjC+jvQMsFTnneC+HPAJx7DHXEGbDmOzLl6aUomi2OzsoZ64TtswQGSR9xsiR+g3YHh+v0uxWsXdmNXos7k01Dvm3cuyAjvaHVRZLUKB2/QssynyppuUh92GagRcJDiWm1Qf69k/dcdIEYsExzCLdK+fIg==;5:Qtmk4xaaHlaI13v6yUzCsqQU6xNe55UekCUUiknat2XhNcwwBhdoiZi7CNrISpwpqkwtwAOrUqZp1PD8HkpH2+cxVE7rLAzq4goJF4hEpwpvniTSjrgWBD7QVx2XJNOf/1mztVOwtudOvBzCjFj1cRAKnqAYeAKC5tjWHUAbvF0=;7:A+NxfVq0ilSksHVUG1fp9ugNvfivGDdlvswyboibep0RsZoc2I9uKAOFwdv7+Vrc7tHXzDohI0kU+lAbO43hoiwAyct/2+TQbO9Ldi3vPPKt+/xvGSQshN6er3Ys9aDjd+mSvuMCVXgpp7OdV3tUTxEPiannnyyqYJ0TKc2HNWuVkASasDHIZIBsicMU+M/U4bUajruQKq9bOFwdgMaDKpGbdGHwIQbTeJgnGsvcX4NlwHJE3GvhSOSHYXv2HxiW
x-ms-office365-filtering-correlation-id: e8bf28e4-cde3-4ea2-fc2c-08d61c49d480
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016753BF4D9BADBDEBFD3983FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: R3KiQ48giJYQjWwRNv3Azj6as5i1JXZ5ExYvUtGrbppnKCIlvLJhmjnEgdTnog57jh163nsSFV4z0S2mTTH6PQ71QLGjpCLW75y7BUdD8QkjQVc/dzDVtaLFJaOobR5eIzgp3trct7Q36OkBYEj3r+JugjWRUdr1jJKmnN57fVuTUMryrMLXeuFhunR6fMXYNJnCEXnon4cK4Lz7Ru7KyYXWCAYvzQb2SUX5cIYlDMu7ecLLQ3KOSN/7tm1PWKHwB6jhOONMUYPj97ZFoaXJdahyaMxBQ8q8SSFA7YfMJGNr+DczYx0OUzh3eGDYmmspjQ9QllDMmX+ECTI28g33Jfa9cXTnGG9i0oZJ5fhimis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bf28e4-cde3-4ea2-fc2c-08d61c49d480
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:45.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index d612ce8c9cff..d46523b0472c 100644
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
