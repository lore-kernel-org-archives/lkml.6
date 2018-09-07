Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8057C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960732083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mn/3wef5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960732083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeIGFPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:39 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeIGFPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkbiL+8M8dIlYhpgShdMnkUG1saB8EFKY/WamTB+sH8=;
 b=Mn/3wef5fI6tixEYs3RrqYorkS+qlvQR/2ZAYX4D6P20bT40lqKz+2N1QggbFznwcYggOvVyInnEF0ShtkLlIYO0rvQ/aCMsO4Mfk6f9wxHM0aeGoux1SttNcNWR5oAlCY5M37MbPeb38Wy+uMkHQMOa5iQliuZnAmmAmHN+muk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 62/88] Smack: Fix handling of IPv4 traffic
 received by PF_INET6 sockets
Thread-Topic: [PATCH AUTOSEL 4.18 62/88] Smack: Fix handling of IPv4 traffic
 received by PF_INET6 sockets
Thread-Index: AQHURkLVVoRa9s2PDEy6SQrylBOkog==
Date:   Fri, 7 Sep 2018 00:36:37 +0000
Message-ID: <20180907003547.57567-62-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:gzBkOL+yT7C3tRIM3uy1JTTeHEA2ocwXqIFc5qFWUEHgR3OvW8Iv2Xb/7YQhUICqD5CCr2oD7tzw+UCDVMtdsR4wd/pzSaFjJrdzmHlqw3zPTCaRNWomcEZ02E9Q16T/SjREZ3IBiFIEbn0XAxDfgW4z6VRmjTJ6210e20axLm08AAYJ4lBq9bKP6uWFcauILDwpRfVa7owoy7piSp9ZfgSirpznKTd+1DAYb8hRkP+mbr09u3WqCr8oCbvM2OwMHfPpHXlEzibb+yczYZeWs5UUWWItTg5bX7dbVBbjFaDy+yakzTonDvfuT7STtpDKcB81BCfEc+83vLo6rIBkhoekgGqV5JLiS2MYdb4uFqNbD+bnxaHtGoiGZKaeegJxhUbaN1NJYNR3nmy/hY8BN3rDWO/v5Hg+YdLMDoAOwSZZjtLtPBciYFb+iZTr4UapVovDgu4VIMsmTtP5cubPTA==;5:wLXLT0jH/nO7JCDrcCGqCjpg9SKpWB/Bj32tDcK1qEFcz6nNjudO8rjWR1klMB9Fv77ZfBPf645FYKR6IowhazEDRgHi8MYj41F0ipFbdb1ZazQcRyQ5AAlUj9Tr2Qj9GfQb5WvaELzFNsfcMnmduXcb+4kFMyN4FPPmhDniOZQ=;7:AQ7N+N9nCitQXg4zHUk3bkftF6j8kBo3nWeWHbMzyI6skRmAD34MU7xi7qLRQLyXjqvWR2jLYMg75hVIDra1GX7lE5iNO3gppWPrT3Mfc2W3F88YuPgOsctTiPK8xJLfip/g+3OdGk2M9Jef/ksEa4EMfO1I4/3mb0m6utJT5d4K6ABkT5U7iYOCSQp3egnmebA7DdefV/xcQuMv2ev25WaIy/BDPCCcUn4s5jzhFAELSn63rWEnUG5iq1eUIaSa
x-ms-office365-filtering-correlation-id: 4ed73b59-9185-4949-eb45-08d6145a185f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01183F5B019B32EA854FA494FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ofPvGC504Gu4JRqvmyC+LoFWCzoY8fJ5vZb1QGAPR3E7NUf1pppSAXmx1bL3FxqwnQGCy2NYSFlGgcnzrgQIK5FbU4jucxPKEjLOIKYW2XCXy4mAhnmIXXqKng2Bb26ScRxA6ToFFGndaSFW+pRDpZveT8Cud4a1KpSg1cy17oCrVuCtifCLVK+YMNcUl7+fS9fePHmmhTFMpsvqoofK9Z45hqA5uhnC2qGr9IXdp7t2D8LjgBXenTZBDqni1DfWbey6MNyERx4jv4TtDVbsmR7/hiH4fjLXiZ7YXVVSigZ7LJqqRUr5tN3DinISaTqpBseZg4/mmal5tAsk2x3PCMPkgoZ83FiV+dzl85ayX/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed73b59-9185-4949-eb45-08d6145a185f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:37.0268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index 19de675d4504..8b6cd5a79bfa 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3924,15 +3924,19 @@ static int smack_socket_sock_rcv_skb(struct sock *s=
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
@@ -3950,7 +3954,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 		 */
 		netlbl_secattr_init(&secattr);
=20
-		rc =3D netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
+		rc =3D netlbl_skbuff_getattr(skb, family, &secattr);
 		if (rc =3D=3D 0)
 			skp =3D smack_from_secattr(&secattr, ssp);
 		else
@@ -3963,7 +3967,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 #endif
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family =3D sk->sk_family;
+		ad.a.u.net->family =3D family;
 		ad.a.u.net->netif =3D skb->skb_iif;
 		ipv4_skb_to_auditdata(skb, &ad.a, NULL);
 #endif
@@ -3977,7 +3981,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
 struct sk_buff *skb)
 		rc =3D smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
 		if (rc !=3D 0)
-			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
+			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
@@ -3993,7 +3997,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk,=
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
