Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF61C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4962077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NQC2OcaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4962077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeIBRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:41:17 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728492AbeIBRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW2VUHzdjg6iDnfvnbrp3Nm3+xEbsuZXErj3Hla4NFk=;
 b=NQC2OcaVhuwuznzgyR04Mw4SPD0oNUKBZ9VE6KoerxvRixVHBQDVvjPeYJpp1gd8cMpnVJHLwc+MMr580a5f6SV2Fj9JE2naSNZolvbVlWl26oKrcMbGd9Zr5giAtnITlUp3iAlmeHTheXJjScQ90JlNuAkJzyoMNnhQ//+JMYE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/89] NFSv4.0 fix client reference leak in
 callback
Thread-Topic: [PATCH AUTOSEL 4.14 30/89] NFSv4.0 fix client reference leak in
 callback
Thread-Index: AQHUQr3MeAVq5PM3l0uudiBhDhsXxA==
Date:   Sun, 2 Sep 2018 13:06:44 +0000
Message-ID: <20180902064918.183387-30-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:NjAI9e+5AhmcYyKdIIrjsbVGTmjLPToNQ5V8HwqpVy0Sn8OoUC47rNms/cQtQUyI9QYdGVFeRJWsHG3k1FUXIl3Qd8PXhA21Xtpi/IRGC1kSrjIZQWfuF7RjzQppuJ/cFoU/vJqiD7XkfjEb74j/HuHl4Jz9Ep19IwCnxQrrpI1HLMsEFJVa0qmna3/5pzBGj1X4arOsxgjgx4Tk0rdo4U8ATsW15S17mKOKlxmZYC3ZoFanGjtvARjY39FKKPZ5Tbb12v1gtglp6xJh2X4tw6DJsX0gzRHPKfEUFRbl5y4x0S2FzxVdrQXZIToBTgtNpVRUKjs6DXqyKmclKIgDpwnRSBdJA1WCdSNWWZxVU5IhcAuKQDDm6o4oJL/YcoE5TCkQvZ8ZobDaAnrTsaFxmBUxgrmjuqhXsQqfPrsJTG9I2dCjEoOCe7X6tis55LTErWPRvq9dRLc6L03lHkySKw==;5:dzZiriWjII6WA5vifSt8fZ6lOexY8U8Cz6XcFyWBpYp07aq60fR4ay+7W7RPGxnKX+aclZ3LDaZTXHCIwEx5gmLa0oHKNW0vN4BfaFnYCIuqeJAY+cVvdDOAPtjTOjTQpCXA3lxhX8GwnIx6IuDQtUSbLfFvAuWn7d7rYMewbj4=;7:ZHA7kL0zWPI8g+4wCsK3GsccZLZlKxLm3aPaZTHj84bBvR6++eoDx6xZzQ0FDuu7c/gYiE2GmlZVplhIxAz5BPV6TIY8YvweAxIiJFrwns6csq4ONOOiu+frZEbUWN0lGZxcusFlJEAK9nJ30j14sQF1A13weekXRANMT7fldBwigR8jsAqls4WJFZ6pevUeeOThO9owroM9Fpmw1zhDrMNF2qcoSHp019f/x2PsAJV0POi8Nuc8p/UmNrfgon+z
x-ms-office365-filtering-correlation-id: a77e654f-5b57-4eb4-b1f4-08d610d4fc2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085602314D1D22EA6744E481FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +Ct4vEn8tkoATWASpML7sSIN+fXxQXj8aj7rH+D2zbGeGoNng0DHtJkZhb1KxRbIZTjl+8F7r47/xo+tmZExmet7Sy2YduOxZivJkKbAeKCzbfGFj095EkaGb2vQHlVRnNkm2trtIKJCwZL0BBBOu4++/rSs0UeXpGplbW/RiUDK/i4AxpkJJGoA2STFa1gii4odzz0Pm43bCOUbvIyYpwq9q1joZTY45Q+HMTyIMdmMxa+SY02IySB5K+Cnnn2jxMua/bNqN66cOx6Wbd4qQFkzkfEC4RZzv2QXKPRfRDUEtKVNOTbxKXZnFscDfxseIo1E4bu7o2nFYh7z/ubAScLQGXDnoz9QCOPvOuNqzis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77e654f-5b57-4eb4-b1f4-08d610d4fc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:44.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 123c069429a7..57de914630bc 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -904,16 +904,21 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
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
