Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F53BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59E52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ozag7y+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59E52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeIGF1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:27:25 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727677AbeIGFSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3wUyzsPWphOrXqxUET/4Yy/uyf+AkD2F+CSg27W7VU=;
 b=ozag7y+0CkWNIZHD026v9gBvYQKmCh9cP2JGrPgmHBxxtN7DZr9jmEK+htl17amxDFHXRKUTfueOKw+WpZz5t6Ii2jc18z4I0dxUCp/FUv4tE72EZLw5y/N9IOWU32fSBtChRzFfxyP+T5FnhQG3spDe+xMTuQrRCDkESrA5NaA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 13/43] media: videobuf2-core: check for q->error
 in vb2_core_qbuf()
Thread-Topic: [PATCH AUTOSEL 4.9 13/43] media: videobuf2-core: check for
 q->error in vb2_core_qbuf()
Thread-Index: AQHURkMY8w2jhSi5/EG2uo8ESATxYw==
Date:   Fri, 7 Sep 2018 00:38:28 +0000
Message-ID: <20180907003816.57852-13-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:rtM2gt+qF9K01stGB4nzaSy9d25DMI+r2cYq7Y7mYtOzH8ze7+lJuAQ4Xmsmz4Y9GNM2BNtHYh/J/RR5D+LoXUi0lyOi+X/ePyEYP2CRZcdjTOI6H35B0OSF6uyxTEr4BqbE9LByA2SW3PLHY2nJ/GH2Ya2sxDec/7Byit2okpfsSwhn4EzMydmW0wMGxv5htJshYQT41SClljlYYEt4bSCO+0EdeVacpi6y4Ck2TRm39MFxa/ojsMHkdgO9xpvrfp5YlNONgrfMxRaxCBychHxqXAHGWFbzK+91UhP3Ym/C45Lcfx5P0cOxrwfo9N458bjqFvEBS7tbAupt8zXCdpOQ2wmYPwN7hm0FQswATYBgIF2WkZeOvBYtV/D2tLli95ci4DZIOuzjbSw0JlksbxS+4PvWR7ylmz/a7+qTucVRm+PYvyHa5PA5oaAbaonFXAn2mjf7GCMOxiTOof458g==;5:hAnHO7ZC928WJmSlE5Jg7ji7yc01xjhtvlPtNMSaLnl6bg0mb0n/eY0Q1b8OAcGEia0fqeI4OHcJ242/Mwk5rNFP4wKAuT8YcTdlkW1JJvaa8vGrrauxpNeNALEP0djpMF5U1Zc5wutoIVsSs0xKcTMDS5Msgu9Ip0KlIZWF6eQ=;7:H2PmEvwH5lc63Uuz86x7S2ADwdD6WlEqrrzNrayLrpbCSwwZMtxdGHJHh16v/nr2WeuCDYi0GoVckkDzW15SxJdbGTYKWnWSyOeSMle8oVL4ysyK11YZi1k7CHGfsd0tLjcjBg4JsHWX985aPQm1aFTGNvzG+A9NqAADmnojHqCUL/VbTtOkADvJf9SwzMcZqGEqkYgBeG+S7xekwsGAfPhftq7BAQAurxoyNJ9GMkwLffDcW2HR3So/rpS3ebrB
x-ms-office365-filtering-correlation-id: 82f8666f-d19f-4bf4-2f97-08d6145a8a38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149673FA0A0D82E983261FDFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Cv2Z5FiksxoRC+KG9+K42dDe/8FyM93x6tRNzXgR+3R/cETLlOdBZ4WmpMZowgvU3Cj6FRZjhX9KPD0Qii/P2GYBG7KMOd+w2FCVqUXDgAn9h8fDJ0cJ1iD4dRITJCy2JNdARhB8P6sEertapdc+56rg8qkkClJNcGxQxC7s4ZZ4DiYpHfdJbxbRkmCBwt8dSBOELAFIM3jjhq69T5f6P+1wNYWs6hDaZARbnHUgiBdafQjFlLPJbuySiTSGTHKkWq0wh5xoUEVXtkh6FplPWE4l2eAxoh2grwbbR/3P0c3tIR5ec1BnmrFrtrH38jO3TN9Mb/6TZyVXAYfuunS33jOdBUI5fSp+56hTxQNC65o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f8666f-d19f-4bf4-2f97-08d6145a8a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:28.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit b509d733d337417bcb7fa4a35be3b9a49332b724 ]

The vb2_core_qbuf() function didn't check if q->error was set. It is
checked in __buf_prepare(), but that function isn't called if the buffer
was already prepared before with VIDIOC_PREPARE_BUF.

So check it at the start of vb2_core_qbuf() as well.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/videobuf2-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-=
core/videobuf2-core.c
index b3a9fa75e8e7..f7ca1fab4808 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -1375,6 +1375,11 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int =
index, void *pb)
 	struct vb2_buffer *vb;
 	int ret;
=20
+	if (q->error) {
+		dprintk(1, "fatal error occurred on queue\n");
+		return -EIO;
+	}
+
 	vb =3D q->bufs[index];
=20
 	switch (vb->state) {
--=20
2.17.1
