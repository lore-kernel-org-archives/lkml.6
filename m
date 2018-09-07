Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A08120869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SUr/Z+d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A08120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeIGFRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:17 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:45789
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIGFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63hB7j4n0CgQnb1CTcKYLUOTuodk9Kt780MheomgtPM=;
 b=SUr/Z+d9QlUYGbeTg2BNkuNr5bKpoIvKfXZhmzEA0Mt6yWTCf1nuIVwLRz+DTntTG7YxYNQyGqh9Q1729tr3uhUeGkiGtzwqLYJ7vtuDsnOBloq2dlMYhO9lJ/+K/NyM7IvisycSzYs6FVq5pG9HMnFWCnZ9KVSjS+eG3Gk1MtA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 48/67] Smack: Fix handling of IPv4 traffic
 received by PF_INET6 sockets
Thread-Topic: [PATCH AUTOSEL 4.14 48/67] Smack: Fix handling of IPv4 traffic
 received by PF_INET6 sockets
Thread-Index: AQHURkMFH8P9Hh5PDUGfpjLR0+gCBg==
Date:   Fri, 7 Sep 2018 00:37:56 +0000
Message-ID: <20180907003716.57737-48-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:8PXsx5EdnLq1E/rpVzwG0Wam1FUK+OR83TP0wIaFoA6k4nr7tijU8vdGC1sBkn1hDOuNOYsw7EW+RfuSZZ/45bbbHCUhNZwAAbAeSZWmJuqx0k6QE3EbDN+9yQMwTIy+TWfxtMDRnAhXBb1inu0Q2ElS58M8Vz8jz2lthdy9TvBSIAUDDbJCL2I+9IlEHe3qtgm1wGn7jANoOeEgLj+dK9XJ9Zl3/dBH6xs1fbR+F2hTCaXC2q9+rQ00bxXwSI1Pyw2LPly3CSYzOe3SLwm5WaEjEyudkDM18AP3yguN90z91wrI4sfv7Sxr0bO6p3yWwpr59ST/VRUa0DaVJQic5Q3Hbgyv2UI2fYrXW/hSfJEkoVAZZQaot/pWMl8LTKe+0S2xF884TIAtlMkye1l7A3qxRuyDFPUyObohFA8Gl5g4gBBarxBY32IJBhbAM33pWMIsqY0goMM7e2AS/UStyg==;5:WTgErEqgTdgbc7YuehWUpwJsALgFnEr02cwJ2qEc0I2BTXYyOPGjHbXgTNsClIpRBzui+rdGIWpspz6LfuNZVKqu1pKwdqeOsQXF/ZwZxm6f/CRJIBiDp3N/oUEjZTAns2jVmjTExuIwtbyjT5miGFOyl6fXYDh2Wnwv59MKE7A=;7:pHt8Yng4I8dtZ0OfAnsRL2Z8W4K+T8r6awHSBlME8UlmfnpPL9mDOQW1ljQXCaOF32v8O9oInTPTHmQ/mCgZ4jmU9qHtehNcCZFMdy2C/B7xXTlERWi34kEGWv3ad7jmzMhlE81XBFrabz+eVfu2S1401uW2yIAYy45V8PdKO3f5ZcA/LHWrbO8D0Gr/uLOK2obZg+fnNMi2cIy/PyAJJbuuPmH2QeDJRwpF/7qIVi9ffVxZlZ1yv1MsrAbYjHm/
x-ms-office365-filtering-correlation-id: c5ab5e40-43dd-4071-5e4f-08d6145a4f83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839D8D2DAE8579F684FB8CFFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: J6Out4CaMsVTVDRXdPsyDB8BndLmfi3cGbuYU8lf4mq+Wdb/PGZz3fRHt7k6O5+uz3e9cHNWfAS+Z57SPXuBbMhOA0pIsvBgksjzGwn8JD/ex78o8O9//3XLVe3xlJ53p02zmX9uuS6QMO+62BglOz5hqA5t526oxhsqc1yP4rnq1k+G89crGkcgRoOvDGEb2gbBwffp7ZfCu9tZHbxo1J6ORsaz2wvvJIrezXS7DUI2yltkLUkUh0G1mT1+VWzi3aeSlpBMhVmmbd+sF3TY6cRHCuetGiuXTdmjJzDmvbT7RZe/Zggl+8NjlFs0xgIw2MPEOYekUIGZolhM6ptyg1HRmB004ByUF5jIVxCUiCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ab5e40-43dd-4071-5e4f-08d6145a4f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:56.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Sawicki <p.sawicki2@partner.samsung.com>

[ Upstream commit 129a99890936766f4b69b9da7ed88366313a9210 ]

A socket which has sk_family set to PF_INET6 is able to receive not
only IPv6 but also IPv4 traffic (IPv4-mapped IPv6 addresses).

Prior to this patch, the smk_skb_to_addr_ipv6() could have been
called for socket buffers containing IPv4 packets, in result such
traffic was allowed.

Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/smack/smack_lsm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index fdf01bfd1b07..c8fd5c10b7c6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3960,15 +3960,19 @@ static int smack_socket_sock_rcv_skb(struct sock *s=
k, struct sk_buff *skb)
 	struct smack_known *skp =3D NULL;
 	int rc =3D 0;
 	struct smk_audit_info ad;
+	u16 family =3D sk->sk_family;
 #ifdef CONFIG_AUDIT
 	struct lsm_network_audit net;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 sadd;
 	int proto;
+
+	if (family =3D=3D PF_INET6 && skb->protocol =3D=3D htons(ETH_P_IP))
+		family =3D PF_INET;
 #endif /* CONFIG_IPV6 */
=20
-	switch (sk->sk_family) {
+	switch (family) {
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		/*
@@ -3986,7 +3990,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 		 */
 		netlbl_secattr_init(&secattr);
=20
-		rc =3D netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
+		rc =3D netlbl_skbuff_getattr(skb, family, &secattr);
 		if (rc =3D=3D 0)
 			skp =3D smack_from_secattr(&secattr, ssp);
 		else
@@ -3999,7 +4003,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 #endif
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family =3D sk->sk_family;
+		ad.a.u.net->family =3D family;
 		ad.a.u.net->netif =3D skb->skb_iif;
 		ipv4_skb_to_auditdata(skb, &ad.a, NULL);
 #endif
@@ -4013,7 +4017,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 		rc =3D smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
 		if (rc !=3D 0)
-			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
+			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
@@ -4029,7 +4033,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 			skp =3D smack_net_ambient;
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family =3D sk->sk_family;
+		ad.a.u.net->family =3D family;
 		ad.a.u.net->netif =3D skb->skb_iif;
 		ipv6_skb_to_auditdata(skb, &ad.a, NULL);
 #endif /* CONFIG_AUDIT */
--=20
2.17.1
