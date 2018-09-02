Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0B12077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QQxi1G+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0B12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeIBRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:42:30 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:38064
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbeIBRWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikwtyhgKPHG14egAcrPKxvRF2bzPb/t6/V+GF0n1onw=;
 b=QQxi1G+6zZ78yfSlStLloknjHo+ZEOvXvPxQSNYOfrT1d/ejOSvKeP+WF28bIS0sZm6h16bGpAnj1Qs+teSKA7JXt97caqJhGMbtdRMcY5v1SVdwFOKUqxWTrvjdedq/EeJeiKW5USPECuw2VUyoxJ45iSo2dUHMAISBE/Z6qJM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Todor Tomov <todor.tomov@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/89] media: camss: csid: Configure data type
 and decode format properly
Thread-Topic: [PATCH AUTOSEL 4.14 18/89] media: camss: csid: Configure data
 type and decode format properly
Thread-Index: AQHUQr3EJ5oznQXc/UGsSMZ+0mreWg==
Date:   Sun, 2 Sep 2018 13:06:30 +0000
Message-ID: <20180902064918.183387-18-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:HaHHAF2PlLUtR8DwuuyfM3onVlf2r+GmdogYWA23DILO2ovRK09s4dwyRAVv7R6in9nQroz+ufS5s7EnUimTUgzC+ACsI5oNi1jOYH5DG5ugbIeqxB54rBGnejp5lbJrEQAABUaqD3s+leU0ihfK8N16aOqn4fVawGIwQyAmoY/YIguTQm4AtMtZNlHVvvhQ3Skcus0MShDpLeDOO2DFJIJg44nod39dJCzPF26moGufhH3L2f1C5lMH3QQk2UFeuDhzIr7zkOIhR3IQw4dLDNcfI59CuKBtK15cI8UONAfV25bXnWCk/dt7gsj7HgrmHzkMQHgxxddgm3jAudJgYmDia1MDRmDY5ZiXgL7DShC5cRnJX/zb+7BsO1REDNkJjOEE8tIq8pxqiEQCu307Mb8HMB9hm2eiw1Dg13hTozpUphsf/rgINStU+XClP1nS3Th/jh1etBDlVN24tm2oZw==;5:dRPpZjmaf8bGf9hKqmXL19d5YDSAF7Ic7k4QRFjCmvQCmIwGwnzfl+D3DP/8/jqy3DSq9jUvpzbjPxLsknO2Cra9FUp4W9RkbfjXZNnaGedxtClEp4A/X01QdTmSr7fdJPWJ79f4XGb6ohorlR6QST4R02uewzaRTqi9/H70SZk=;7:t9Fnz4kfE4EDLrHOMGA4NamuWIq05aIhEc2OSmE8ewMa93EL4TiXqCIectKBjf89kNuoypxrFbl41NugicfgH85t6V9xdDGpL6j4JKG/I9sTsiSo86qy5RmSn9hbjYVHO9N6XJxSdMN7/UhgLdYlS6O9yewp+hsL1lF8s4eGtSeI+naITx3OreJ9XWAc9kPOBl3WDFHz3AoPQrP8X/RIyBD7T760CDyy2874TxCt7Dj2V5LiMoJnPhtvJbwIDO1L
x-ms-office365-filtering-correlation-id: a3e3bd88-17f0-4f5e-81f6-08d610d4e6aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629A36A6FE6232C909AA5B0FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aBzSjS06fz2xupwWfW075+keyjoCTvJnVkGcctkgwJTqYdjqREzUH9WuHSZc4YpvzRPSAmqtcT70sVWBFtMnqvNSKc2x9gm8piUm6RDny+W1uC8jJFNgBlwz2aZv4+4CzAolKYQ5En7zxXQYMSLRo/RbP97r0AYo5Tq8jKxxz0JhcSfyHk9MsWaJ9B6poplRZbqIs77tc5U/f86tjTIrRoU9yqhsr+GT60Wk7tXOEhsn02SPaV1Fwy3wfiAq6RatVqKbfZ5UDsEbd01OaAZoOtCFzGcGWOvzqJmH39XImWPWTxb81fzZYdzyOq9S/Psx78Lu32SJuj2Ggb1xSCQRUDkJKjsp15QIdIZspxcPlsA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e3bd88-17f0-4f5e-81f6-08d610d4e6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:30.6887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todor Tomov <todor.tomov@linaro.org>

[ Upstream commit c628e78899ff8006b5f9d8206da54ed3bb994342 ]

The CSID decodes the input data stream. When the input comes from
the Test Generator the format of the stream is set on the source
media pad. When the input comes from the CSIPHY the format is the
one on the sink media pad. Use the proper format for each case.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../media/platform/qcom/camss-8x16/camss-csid.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/camss-8x16/camss-csid.c b/drivers/=
media/platform/qcom/camss-8x16/camss-csid.c
index 64df82817de3..4882ee25bd75 100644
--- a/drivers/media/platform/qcom/camss-8x16/camss-csid.c
+++ b/drivers/media/platform/qcom/camss-8x16/camss-csid.c
@@ -392,9 +392,6 @@ static int csid_set_stream(struct v4l2_subdev *sd, int =
enable)
 		    !media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
 			return -ENOLINK;
=20
-		dt =3D csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SRC].code)->
-								data_type;
-
 		if (tg->enabled) {
 			/* Config Test Generator */
 			struct v4l2_mbus_framefmt *f =3D
@@ -416,6 +413,9 @@ static int csid_set_stream(struct v4l2_subdev *sd, int =
enable)
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_0(0));
=20
+			dt =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->data_type;
+
 			/* 5:0 data type */
 			val =3D dt;
 			writel_relaxed(val, csid->base +
@@ -425,6 +425,9 @@ static int csid_set_stream(struct v4l2_subdev *sd, int =
enable)
 			val =3D tg->payload_mode;
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_2(0));
+
+			df =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->decode_format;
 		} else {
 			struct csid_phy_config *phy =3D &csid->phy;
=20
@@ -439,13 +442,16 @@ static int csid_set_stream(struct v4l2_subdev *sd, in=
t enable)
=20
 			writel_relaxed(val,
 				       csid->base + CAMSS_CSID_CORE_CTRL_1);
+
+			dt =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SINK].code)->data_type;
+			df =3D csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SINK].code)->decode_format;
 		}
=20
 		/* Config LUT */
=20
 		dt_shift =3D (cid % 4) * 8;
-		df =3D csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SINK].code)->
-								decode_format;
=20
 		val =3D readl_relaxed(csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
 		val &=3D ~(0xff << dt_shift);
--=20
2.17.1
