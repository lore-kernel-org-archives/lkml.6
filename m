Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD5C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA95720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TIDRaLhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeJAHNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:31 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeJAHN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTx3VS+EmoNYshsqCwc1y1jHkXiSmCc/PqpU7EJBIBg=;
 b=TIDRaLhyMNT2UoMyng351mkEAEC0R7Py/0qfscFcs9/186E6Gh3PWgR8NKJu4/jKnrCIt1yj1VWuDVi4AyBislinx0xMmh1IHJoDO0yMDJRnpXtFWjhHp8YbrbIykzhtg56DSAKdqhX/kbOtgo/zuqp+aT2fKlzKe8bfJHsr/9k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/65] iio: imu: st_lsm6dsx: take into account ts
 samples in wm configuration
Thread-Topic: [PATCH AUTOSEL 4.18 19/65] iio: imu: st_lsm6dsx: take into
 account ts samples in wm configuration
Thread-Index: AQHUWR8JKdUnPHGqi0yi+47MZb2zgQ==
Date:   Mon, 1 Oct 2018 00:38:14 +0000
Message-ID: <20181001003754.146961-19-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:JGHi2BmK0X+o/dEQKm7LyfdWpPI+JKCAJ50Eq+nLcGv1jrRLQ2otm6UpVFm28jT8PTBFh+w+qKL6uuOBG377ZGPlzr4ZFilL5SLgyUri1IVhDtjhY+etVpT8oBHzO4KuCIhybEi5n68oi96jmGguBEdMlZEQIAdAUo3UiJ/mvivrrOJV0y05rnHEZtXV3pMRwav2TxluyACEuXsCGzXbxQgJ0JZW4GLJto4rRiVZIum+U3RH9dj9uZ/riPd/A+dHHlY5xq/iFJs7RJ6X+6Oz8pvFq679Jnr0nqIcyBdZhj25Hw9zlQHyDD8cwn/Hw2pMOfqSJmzf1qcw1vRbgYMwVpc+g6S2PVs7IWTenNmcWdixwNIhOPNdA5Mw5/jSou9NvchxkfuAs/4dba0Wapo4ONGhVA3b4TFpfcSvim9UXC3rVhJOLTHukmA52r4vtNuu3xn4dF2/MW6IqegFWcSgFA==;5:qrPgoqjIkcJ+/2dhBJDmcWDkdO+mv8Lao198Zx8A1xl6V4TOZmmgnU8GolzlT1WKrbSGQlJaU+qwVthxLAVNdNNvttwlS0x92yN0IdOMDjK5BiqgVl4u1srKcBMPNnstsbJ2MJAn3qhWTkbidMQ3wwxHSdU39tt2CgXZA1VbJiw=;7:GOs/QeyIupiN0XveKuGR88GCjd7jbnXvqPUXOORND8Pz5k7y9jwf84fjUyqhtVQC/Cbje8YhJzXVRmE/KewFQI8OWGGAA18kuD3HUHK99CmLNmd3ad4PWzaDzMxDftGz1nJFOcXOlESMy2Q/F1K3jUV2PW73UZP0fRzevO8gA/nirBzKNd2pePN1wx3zZdPUNZ++0IMrS3u6yVag+lwWNAcpvlZXuDF1vM7SB4rr+u9n2+Dwrdem6adkHWrYhmPf
x-ms-office365-filtering-correlation-id: b08721ad-d4b0-4c67-99a2-08d627362c87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB047274CF4B2E130EFCACD84DFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(53936002)(316002)(71200400001)(71190400001)(305945005)(15650500001)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lTgaBQiLUQTrduoWumJBxYQHTf4LD+jRu77JTcHLVeisoPglE+3EaUTU6AQVor2O84iVRG9+QPzxtt6PphaV8poPrP4BGhEoNNGP1Ic0K2yjHr6r07dJhG4KVQ5TKj1mpXdok2L/i1UvQ3gYrzCNdlu/zzACPkDOZ1PioXRNV1ZpmxZ2M0rh6pATnEvD4V08PvcaYQQSJpDUfuveoj6zR9tKJrh3ImN+4R/+YW4Ho77s763pyfDnfltPhMOypUPu2x7a/8CQvMcm0i+86ZmJyAAB00mgXaGVZxmkpkHyr2ZMWCALM59w8AolRi1RetzcBtnDPXkjekpZDQwM84NUBUYgnpFjrqRZF1qjVMBgR7E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08721ad-d4b0-4c67-99a2-08d627362c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:14.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit a13bf65f3f2e36008ea60b49d3bda2527e09fd9c ]

Take into account hw timer samples in pattern length computation done
in st_lsm6dsx_update_watermark routine for watermark configuration.
Moreover use samples in pattern (sip) already computed in
st_lsm6dsx_update_decimators routine

Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 4994f920a836..8653182be818 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -187,12 +187,15 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_=
sensor *sensor,
=20
 int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 wate=
rmark)
 {
-	u16 fifo_watermark =3D ~0, cur_watermark, sip =3D 0, fifo_th_mask;
+	u16 fifo_watermark =3D ~0, cur_watermark, fifo_th_mask;
 	struct st_lsm6dsx_hw *hw =3D sensor->hw;
 	struct st_lsm6dsx_sensor *cur_sensor;
 	int i, err, data;
 	__le16 wdata;
=20
+	if (!hw->sip)
+		return 0;
+
 	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		cur_sensor =3D iio_priv(hw->iio_devs[i]);
=20
@@ -203,14 +206,10 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sen=
sor *sensor, u16 watermark)
 						       : cur_sensor->watermark;
=20
 		fifo_watermark =3D min_t(u16, fifo_watermark, cur_watermark);
-		sip +=3D cur_sensor->sip;
 	}
=20
-	if (!sip)
-		return 0;
-
-	fifo_watermark =3D max_t(u16, fifo_watermark, sip);
-	fifo_watermark =3D (fifo_watermark / sip) * sip;
+	fifo_watermark =3D max_t(u16, fifo_watermark, hw->sip);
+	fifo_watermark =3D (fifo_watermark / hw->sip) * hw->sip;
 	fifo_watermark =3D fifo_watermark * hw->settings->fifo_ops.th_wl;
=20
 	err =3D regmap_read(hw->regmap, hw->settings->fifo_ops.fifo_th.addr + 1,
--=20
2.17.1
