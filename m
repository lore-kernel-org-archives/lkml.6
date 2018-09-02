Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A6C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6D20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hq1TFkd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB6D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeIBRcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:11 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:63162
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbeIBRcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3tpgex+dR4GZmBSOKHK5CW43L+g5WXiv+/cMu/A3gk=;
 b=Hq1TFkd7GDwV7l85gtKBBa8ASV5GA/y/QNf9AbzoidXvNblJEzYDFGRn/+5OkIDwp8b4WYcCNzdxCXOfj1OcCMRrlHVi9o5LMBiI6+pjnQFI96oyBUCY+SaIxlpAAAW7pVoTzQXPr7W7R38MmTyeq4ofxjJrLEhZQUJO4T7fdt0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 13/47] NFSv4.0 fix client reference leak in
 callback
Thread-Topic: [PATCH AUTOSEL 4.4 13/47] NFSv4.0 fix client reference leak in
 callback
Thread-Index: AQHUQr8S1M1YHyW7+EGegcZ6D5KZ9Q==
Date:   Sun, 2 Sep 2018 13:15:51 +0000
Message-ID: <20180902131533.184092-13-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:e7M/omYfOK/+ANSA1e1R7EWyvptrgA1TBAPPKMRtzG/JPQkt4xtipAxFGhyroR8fc3COMN3EdODxeZGV+N3ZuqeeiTH49cM8Jj+N37UIAy5JuCJeChPKhiktOi+t2lIv20tKYswLv+KbHXLdes4vYRV/siw6hO0fQ0G7go/bX3Z5nW5MeMUzocLoeH7cN87/1BtvmvBsZlJe9yMoXuIwWAStUMjvnL2jMvPT56d6StPQS2UGiIGFPoPgnQOcX3MDxpQEHfMJq7yeK3HyyHNki3oZGsCuUAw1aIdty5tqKDJvEHbMjCGuvrymuE4KRnyWG0j/K7OllKZk4STxhK5rWbqZGmspJ5Mu+xLZbQTdJ+ra50lrRpyM31nrsx5sh8Z5D8YJKXCSfUHwXQz3hq2ojYZfLikz1LE5KDGnQBg6tQE1f7evra43xz8kJqysaqquKzBUjP91kTpB7tz5miQQZg==;5:C/x6Mr2wwq9qvsTOR9+dEWhoLJJGgNUrTqk+k6AnHg6Tb2qpgLcGXZ4cIpnsmRVIl6UgiiQrdvDDO4q02QnW0Un6V6lIhI/I9sifYnmpoYtTWwGkV9qpFubdhplmbaIvjYoWPRYt2sVy0ko3Zx+mvwMLM+Dm0TtIITgnCG8thiM=;7:uVihttsF6Yz5TsuZUChaiA8TcEBwOYOZepqQgIRaX7oEL1DE2D06z4fSp2P0q+d9L33HGa735pJhuQ7xf8uxXUv/g3/EBoMc4RE3ErZ8W9ER2abkzeyr0awm/7Mo2boDhK6LSWTpIKR6fqpn6zTwuXaRIRtV8aQUzkVkmTeAuxu0zB3qoCSzGmvlLCXA1uEfQc2BItSaqwE9xVheTf+JjGEv55+HeMbrjDQglADycv0vg0E6exBrQlBmi4hYrU9F
x-ms-office365-filtering-correlation-id: edee4663-d88d-4a9d-404c-08d610d6463e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629E191D8E19E84BF9BC33BFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XV4oMfLsB/fz3/sO3JefNQLYoJZew/qpgw3vRQkTFN64mZAgds+UNzJkauCEmVZHeaJ7CChdmFGM3W6ebXc8uc6YQIwvQnhUa+A5ef9VXIgJ7LkWKpRwv3/nNDQJcHlzK1nbHzKxqBToSJQcLWRWeM46+B2K46ccFDYteJ+Cw9fvhr/UDnsbp0zDJ9lu1Q0MxoEr5gSpwD9NrjWPf93sj3bJKqDaehFQ9zzjMTq9wabtYnD2enDD0vW3NvpV/M/5vfGOd99nRxTBa/UtJW+nQ/dRHkXwMxhIX9E0EH5+GSH42ICBZiG/F9vBEQK8GPA8GzD7T0qmt0u9V5azFLny+QZhIm5GgvIUEjt5KVuwaKM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edee4663-d88d-4a9d-404c-08d610d6463e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:51.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index e2e857affbf2..0647cb1ede56 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -911,16 +911,21 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
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
