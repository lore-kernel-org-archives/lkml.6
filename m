Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DCCECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E868A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZKj/NHRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E868A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbeIXVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:13:34 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730115AbeIXUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARPU54gjX5pwAFj/NGm3l5AEjy/Kg1piZk98ivn/74Q=;
 b=ZKj/NHRIyKUP1+e3fZnqlf4Z461CpYYafioURZpLNwrG60Ok66EKuIcoyhOde469t+Ty2LYIaZ4U0om94oIEbSfUa2L8/LedGUebNglNtjL8O1ujVMbDLtW1HtCMsiU1UwqxPd/lB3txm+333ga6G3uE1OseowIDHFwBTK/3TlQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/76] bpf, sockmap: fix psock refcount leak in
 bpf_tcp_recvmsg
Thread-Topic: [PATCH AUTOSEL 4.18 12/76] bpf, sockmap: fix psock refcount leak
 in bpf_tcp_recvmsg
Thread-Index: AQHUVBWa0rKeReh23UqAqa1j3+7Brw==
Date:   Mon, 24 Sep 2018 14:48:07 +0000
Message-ID: <20180924144751.164410-12-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:qfHwMaHP45+ILECOGXp4hheBFBBkbPeyxu7+jak5LFe477CMFfJIV6SFGneMxAgg1lxhdY4FBl6714k9pjaG9a7cEjQ7MzX2rSe6v+G/ltFwIYQ8ziC1IyChqLZGnRf1dZZ0O/FvGfubQQciOEzv2gOni/6DsFBrznnpN+9KiZ/cIBzpj8MWBRMtWeLrdsdNdyx9m/3a8dIWKqmOt4w8XsfiroEogY9LIsNvEe+o0JJdGxRbixzhodgzFnHd5wrte4/7wiRckaRtHur1Fj+YegqcA9xA4sWXLfLtMAzVPi3yDLe9e3yvILjTZ+gbBOAYd+sKXxf/JlznW//otWsGExhPX1Byn/si1+DoOF9FY1N7KInoSWWT69uKtXLoLjyarzwr5b4cfZR29/57jqlGBFH9X/YOrH6fgwFqgGbzIvQ5Go2xR3SLakDlxZroCda8sOtys5jKHZ1KjubL/lz8yQ==;5:RYKgNpTsTwEI7HhwKU/EGgp6Ba7zdgxFsEGsOTF94ri8YKI8bIMSRy0yH/HEyezzA0q7Eg4QoLEp7/5qYpoMdRJLG2Z3DE81E3xlEKnHwMgfZZjb8DjydSU1nhZtWA7GkLE0EX5N86ElHCUKc9jbJ1t6Taj1B+jlyW1N4fVYSeo=;7:JZlBF9woIth88Q04UNHhr8g73UFME6c3FE2Oig3WCI0FhWZU+vrJeZtXE16Wy2yLdWLHwP1N917yZB6uUDVygFPtAOgY5jVGJAzQ4W6N1m2yGEAlQOajkAcG0NsyW0er4+tb4FJYp2x/Y7lCpOUvfCKF1yXzRgyrFCoa8CemwBtsWeVXTUf1LsLLvRNZmhev7JfEYMyQHDBcP3d81ICcfWKUMYLCgi0eD9jtlCxJ3g4/2Iy7x2UvVpBDy/Kwa6+m
x-ms-office365-filtering-correlation-id: 7a814fac-598f-479d-b3a2-08d6222cbdc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134CB7D9CD36D6AAC0C4185FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oyjqXaEle/TSrMimVxXNHK3+HLfBm3J9TOMWMlZTndCt82Ayyogb1ZJrNwtJKKW2vX4tEdhWJCe/+7PjEhiU0z6GThmIvjETlpxZwxPL1+5thqqbmW8+J4dTcyA8l9i8mQHpQ6Kn8q6xrd7Vpbhl+q73Ol5eVwlIMhjsVOpvUCf7bqgSQs6jj+KtQIVAenxdDVsI+iPbdBsuCYYC0giRu3fIx/wZAQAW77BNfYZLvdFTIdyaHcE9noyIk1GVdZVDb1WLEAClaHLI8DGbfRvoIy4ZzhiJWFezSU34K7anor9SCgDtCJS0dsfQzbUTZwG31rDlCRgVHN2s6w5ZH0D44IGFdVa3kmKE5WWdnagT/7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a814fac-598f-479d-b3a2-08d6222cbdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:07.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 15c480efab01197c965ce0562a43ffedd852b8f9 ]

In bpf_tcp_recvmsg() we first took a reference on the psock, however
once we find that there are skbs in the normal socket's receive queue
we return with processing them through tcp_recvmsg(). Problem is that
we leak the taken reference on the psock in that path. Given we don't
really do anything with the psock at this point, move the skb_queue_empty()
test before we fetch the psock to fix this case.

Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 7afa2a54ee34..e43730b52ea6 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -915,6 +915,8 @@ static int bpf_tcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
=20
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
+	if (!skb_queue_empty(&sk->sk_receive_queue))
+		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
=20
 	rcu_read_lock();
 	psock =3D smap_psock_sk(sk);
@@ -925,9 +927,6 @@ static int bpf_tcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		goto out;
 	rcu_read_unlock();
=20
-	if (!skb_queue_empty(&sk->sk_receive_queue))
-		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-
 	lock_sock(sk);
 bytes_ready:
 	while (copied !=3D len) {
--=20
2.17.1
