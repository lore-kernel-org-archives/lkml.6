Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046AAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A671620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HyOE3L2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A671620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeIBRUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:05 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbeIBRUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z97DUnlLayCXIRW72ux/DkXnC5qOgL1cRyAOgSmWh0o=;
 b=HyOE3L2Jf0VhzKrMQ21B6B9cQq4NXHMUhfuBSOX+rlmDob/oat2JQjrLnpyEUjaNf+rK0PJQPcBavVPJ97T1zMMQBqYpeTl1sP6kbPSJ532sskcKnfJE28ZTAHkeRdryFSbz3NoOY8q7YjlHvPQn14u0S7oHsLQPyr+K3aMh3xs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 046/131] NFSv4.0 fix client reference leak in
 callback
Thread-Topic: [PATCH AUTOSEL 4.18 046/131] NFSv4.0 fix client reference leak
 in callback
Thread-Index: AQHUQr1pvocWmaotLU+R3o9cxzP9hA==
Date:   Sun, 2 Sep 2018 13:03:58 +0000
Message-ID: <20180902064601.183036-46-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:8IBjzpbtv3avq+/ppWRUdJrodS4JEa8jz7Yys2LWd6Qo6goX5N4YozbtV0hhg70kajN4gIIlYLrvpLUWTfqo/0mh04x42xymlAbmXF2E8/Z0i6KOCyfeFt5RmH0P4m3xMHR1TJoaVZdzjohPztP7WXaY/vtKJgMZrfoB+sHEoyVJQPD2NKk5bSn5nhlhI3cOo3XYdV1+Zgiiio9Kq1MBourlaTHUF9Mho16VVsXdzxQGXAnydopLWL5FiIjlwCG9Qpz9/pmU6Qkwj2w2nEg0U6OoChXSAuDbi/ACgd7sxyvlEN5GF8DZOftS8Jtrgk2ulhgtKuKzJ2AEdkzKAwU1jHt32sx4Yfpl/HAHb9imv9zuptF0xlC/EDH/ZSuumjetV1yQRFIAwBpl1F10kNrOX7/2gUYYOINL2g+5nEFl1mYal9pIVqtZyGVnytDPiG1Vd2iZPHMoG7LWSe30pKlwMA==;5:uWgI2msBWdelDHvdoi8pdCxZmggughvGyPiNyNpR5NKrnbrejgLTKsJApd6TaPhYTGqVWK27xvspibzmYuAY5PpVgs0e+xrBQCqAYSUH31nEyw5X9OM6QBVdox/wIXpeCw9nVjTfz/azO67zc0H2wHvMVs256y5EB3SCKI8sfvU=;7:45QEJ7Zb+XxT1GQjVKEZ6lzcxEXLBMCROGrXdaQt46dFQ8mcnB9xrzbUAQ2lebIwXmnu90CIT7Bv+rhiilx2WZdp4E4+5+FfenQ60zVLHEZQbF3gn0gg07IDYVL3YxCL4j2VhU1mDw1rnX4Ll/py/maMpOrfNFMS01VExsQqx0pwuUNGPEtmyuOgkycijfBn+tLpJ4stHcaZrGmMXi91CvxV42KUf+0Nlvq0453oKxoTdesjm2LViQZ3wl4MOYxp
x-ms-office365-filtering-correlation-id: 32741e8a-e8aa-43b8-fae1-08d610d49461
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135E6548E3067AB7A0400C2FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X/LEVpXDsFUSG0vH1FHBqQI3n/OtDxIj3Y0nsFV6PPRcSoLOE7opRXHluP8C3C6j1ipHc9BEWNCGgWEXZBuVrkEgQ6azpVb2VCMAdFZ6SFx10TkEQCE9r7+5V4mJtqNVxNYTvHRrgnp77xSqxSf7GkunFLANFdLRMr+vPjDu+rS9Yw/XSfZ3LyecRhUtoFRNjT3e6FpKyOY1yayidAW8WIvORU6CF+5ib1VI5vMQ2tZxWSVsegrFYrE6yD9r6pKi0/M/k307S/EDc7Jzyu+giNF1joO0GgeyHlsB3W++ZRAADHa8zOSMEppj43zPzU/vO/KCFg7eXCxepWgVLp4uCzwkwhkZUdY5Ozhb277H3aM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32741e8a-e8aa-43b8-fae1-08d610d49461
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:58.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
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
index a813979b5be0..cb905c0e606c 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -883,16 +883,21 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
*rqstp)
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
 				    rqstp->rq_argp, &xdr_out, rqstp->rq_resp,
--=20
2.17.1
