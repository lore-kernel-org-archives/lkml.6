Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C90C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E49B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o0+HjM9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E49B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeIGFT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:28 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeIGFT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWYlWIXFkoDw3JopFLqWzfK13sI1HEBvVvHu1P4Ayeo=;
 b=o0+HjM9v26yZiKywP1BkRx8FD3hAAqkTlxcAKmYX+bmuQa/44PnOAoc6G3vS9og3OhFZ2igevsoefS03D8v+LflmoGiDuX5KeIGlFyklzql/ZGvKch6bEbQ2Z8TUQguPLIntpeYeWFvWZ0eraL8NG4VyLLt7KxqWE5MWO7vMEVw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 30/43] Smack: Fix handling of IPv4 traffic
 received by PF_INET6 sockets
Thread-Topic: [PATCH AUTOSEL 4.9 30/43] Smack: Fix handling of IPv4 traffic
 received by PF_INET6 sockets
Thread-Index: AQHURkMfB4kn7Dc490e8yt6M+zH5mg==
Date:   Fri, 7 Sep 2018 00:38:40 +0000
Message-ID: <20180907003816.57852-30-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:KR19dkuYeLKvus0OTc5jwnNyu4lAfP9e4u5fME5buiF94nSPyxEmvSu4eIdSCMUXETOJfWR1jGMb5nvCmIxwxO4zObIkSI7mi7uaJq7i0xuMLXHymqAkrJffb2tDCm06X8PFN+j8ZIm8wVES2Gep6njkNUYNcb9j7vG3RIHMKLkkmSK/1yeg+KXqrR3Dw1CR7coD5DoAAAtsMWwIneMXIM+O8gDbzs4jFT2Nkl0bF7MHXmrZXiJ9l9KqYWnLSwDClYPG7h+YGM1axz10Cock6H1wm8ZbQwqdyUOezhga/OnNUd64l4L59mwfOylwFTonOsoqwskpU1XnJ/+U8zwPmJ7fw0qUlFGJmU+P82oc5fgu9vWtmWNPn0Fse//TBV1MIVvdn30vkeRwLoHDezufzsnPLZfFoNunhwU00d5whgRlxCo5Ka9whd17dT/hPdvw2N+weZoPy9aF8SlxlEKv5Q==;5:tajDSj07V3mckigDVkOSxob7XYNdTwGjgc11X2hoBqTafddDW44xxyfLs2ctoO0MneSvqXz7RlxyZ86PD1buMhimpMkxPms8NRvGXO1JE9S8Wm47+nUSrFC9WhefYVNRnDHTv5EFXDJb02JT3iZ6nwOMLCe/9Wd8szoLhDD6XCw=;7:4cL5wQLYMXv/MMcofMrwP2i7DLXkJCfecRzFuvxdo4lD9+32vQugn+AF2FY11sk3XZTa/fj8SeYbUZuLtZpFMOb3fDRR8XCydAZvzMmSmMZGTkRSVSWFi5RGgz+OINbs9mN4lkgCi6hFxch4Y1cLbcc9cduuaxtvug6WDYanUsgL2uiPYJXKem1tVWxcFOW24rqw/xuKZ1uitDPWmz/Om07A4+H8Am3C0p6+lKHGk47l2cLLZMIUSrnX9t8nLa2i
x-ms-office365-filtering-correlation-id: d2184a19-a04b-4bb9-03c3-08d6145aa052
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694F78D054BBDE73921C1F9FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: spkNZ/0tKhb3sZ3ktDx8b3PdDQ0IIFDo9xiPCl+DhKqNlVv+pbsovKEYtz5VbYyZePMV3tEx/Og1h7EjhaAMKhtWjeGpDLVYuln4BQ4WLmSlLKnP/FFYz3azV6Bwxv6q/JrobS56JwRB7bEgkx/po9ni0qGPsO+K8Xz/SbNwDLI0atBSeCeY9NjVnxn1HCYIowhdkPZiTil5y2VQ/fbUMnaQqzYfsvvJre79n3BM8l7jfeQtZVqB2Zf5l6kKcr7GX+esp2t1uwhz0OgsDZ7bzGyizmg3MLpq9nCbmqwGjo+9N4vORErZhH4ZkMVDBqkaLxirf2x9U1eqmHle53i+FLSQdhFF+F6CMAE4NVtFQF0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2184a19-a04b-4bb9-03c3-08d6145aa052
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:40.2404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index ca3ea985c100..fb7c534fb57d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3966,15 +3966,19 @@ static int smack_socket_sock_rcv_skb(struct sock *s=
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
@@ -3992,7 +3996,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 		 */
 		netlbl_secattr_init(&secattr);
=20
-		rc =3D netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
+		rc =3D netlbl_skbuff_getattr(skb, family, &secattr);
 		if (rc =3D=3D 0)
 			skp =3D smack_from_secattr(&secattr, ssp);
 		else
@@ -4005,7 +4009,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 #endif
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family =3D sk->sk_family;
+		ad.a.u.net->family =3D family;
 		ad.a.u.net->netif =3D skb->skb_iif;
 		ipv4_skb_to_auditdata(skb, &ad.a, NULL);
 #endif
@@ -4019,7 +4023,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 		rc =3D smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
 		if (rc !=3D 0)
-			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
+			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
@@ -4035,7 +4039,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
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
