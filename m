Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA60C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1826205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U6Tt6VCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1826205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeIBRaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:10 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik6SpO58p5pokZiKRUq4jCCKnZk5JZmNxh6SBtZpwVM=;
 b=U6Tt6VCjUBjLyziu5v44r6btsuvzgqdDMXpKPC9Mz7xIPqTFXiS0z+iu89BtKffCnhie0Oe6F10jRT2lbTyD7eQScwxFFYhnHkl5o/Nww7JPfSTsxHrsnTBRsEdW/5mFzfhit7nsEEpp+PDtK75PS5nT+NPX+MThi4DMA9lon9A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 15/62] NFSv4.0 fix client reference leak in
 callback
Thread-Topic: [PATCH AUTOSEL 4.9 15/62] NFSv4.0 fix client reference leak in
 callback
Thread-Index: AQHUQr7cb3d/qPydKEe/rnfhDXb02Q==
Date:   Sun, 2 Sep 2018 13:14:20 +0000
Message-ID: <20180902131411.183978-5-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:6bryn5m9CA9VHp12JEW1xObtZC0oZDhyAAxI2C+d0nFMOzaOMSY4XSrXxqCYYGY4XRKnmBVW4cIMhWGfxzGavg4D4ElYUcbK0QK4bs8ji9s42GOwKZBGzEA+zouQeTg+kzRooyi7GVUq6FtphzQODTmcN4nNhM/6KxmHMW0d9fx4tlSgdjWzP6jErnz7UwdqbLfZpRHf3KUrhxOw3AX76iTn2hGexMyoIHu1AfE2k1YPSo9rGWcqH2NE5/2blRTuJjgMKbxUUZ1Wd4SvJ3towq04QlLS2GRxEh6w8l9j++8ldT1oV3JgfBzlN9wtBO2SfFLuXkib/FVAaHiwx5kFHZ+XLJxaczA1adK0pEJB4IQfpruz3xB6TpP85J4NAQsfU4xZbvJpXwr6ChgYFiXgaQvQnugb5/epArMiiRkZezSTL44EbOoVswsPbyFg5r0Gc35X8wQtvmfFPtfUt7Nk0A==;5:kFfWfNzi3EgCXsHfi6h9kriibSoE+tV+0oWdgmfuOGUQeN7oiEW9sLScZA3mc4Lh/b0qMzD/LsN2JXBRjb78PgzDZLz3MvtyEOyE69QTOu5wufWuEJmZYyv4/U4AKHlsSp+dG/YIERRiEeOR2jciFbqa4ENcK4aXbVEn0f9AgbQ=;7:m4J7/JWKCiME+4jybSnOaqBELGx93R0BezgvKQw9Jpdu9ML7zMVaNqFofiubhtaBc61TGZFoNRnPdBb7xd5ltkNIX5NRXf3YljYrBuU77Uh1eVpzh99xksUsvQrHd2Jy7geBlFWch733xdlUOcIzwn1gELDaJKJRRnKzc02XtJzrdcmo+NrGfqsl1zfrd1Qmy0YkgB9S1ljjQVdX3mUPe19pYaMSxg5jBo6Q1Sz5o+8b/4TIWD7fwhnH9aezKM03
x-ms-office365-filtering-correlation-id: 7ee9cc7f-44f9-4a62-4756-08d610d5fea1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01204844060DE4E424815FD1FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NXDtS0jw2J1xwHhmRutlJAhysYY8tLDDW9MN4jJNWHn9V9YAgIc8DjslwPG/IGGKiJ5wl5WYHo8YSWf6o53ZS0dG9UxjZQ3pEH/qKq6VjDLl7bmmx1MhHt4O0m3ehqSZMhBMdlNvR5iGAwvns3r+6ahGzwwKbOs3uQ9QM9QcNc/9qxcz7a7Tbt1WncZJKPXoscbM0c5nCd4LKc7eAJNEXG5ps3pqZTuXXaXEqPuVdt9V+o5pY4+0aEn/4Mpko919MB1F2pByUBl2kt+JEpcLC974pYEF1SemMKQRC2hts/2OOb0O2GlxrCSUsY/KnpUFHwGWvNGt8ZATL3tJrBpwQwgVFVAMOsdtm0prGi6TTvM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee9cc7f-44f9-4a62-4756-08d610d5fea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:20.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit 32cd3ee511f4e07ca25d71163b50e704808d22f4 ]

If there is an error during processing of a callback message, it leads
to refrence leak on the client structure and eventually an unclean
superblock.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/callback_xdr.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index eb094c6011d8..67903eeb2ca4 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -968,16 +968,21 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
*rqstp, void *argp, void *r
=20
 	if (hdr_arg.minorversion =3D=3D 0) {
 		cps.clp =3D nfs4_find_client_ident(SVC_NET(rqstp), hdr_arg.cb_ident);
-		if (!cps.clp || !check_gss_callback_principal(cps.clp, rqstp))
+		if (!cps.clp || !check_gss_callback_principal(cps.clp, rqstp)) {
+			if (cps.clp)
+				nfs_put_client(cps.clp);
 			goto out_invalidcred;
+		}
 	}
=20
 	cps.minorversion =3D hdr_arg.minorversion;
 	hdr_res.taglen =3D hdr_arg.taglen;
 	hdr_res.tag =3D hdr_arg.tag;
-	if (encode_compound_hdr_res(&xdr_out, &hdr_res) !=3D 0)
+	if (encode_compound_hdr_res(&xdr_out, &hdr_res) !=3D 0) {
+		if (cps.clp)
+			nfs_put_client(cps.clp);
 		return rpc_system_err;
-
+	}
 	while (status =3D=3D 0 && nops !=3D hdr_arg.nops) {
 		status =3D process_op(nops, rqstp, &xdr_in,
 				    argp, &xdr_out, resp, &cps);
--=20
2.17.1
