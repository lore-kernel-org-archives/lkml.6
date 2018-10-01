Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9623C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC322083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IaqFOv90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC322083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeJAHOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:17 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729109AbeJAHOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HE567iK75vO0tI0UToh/4booEnoPUbiB16cB/zOA94=;
 b=IaqFOv901WgRuvIKr+carkmw8RuUV28MoF3DFbT3wlybVzzP+gL7krnLFWooWte80WECu14R5oRG4yY8ttZ09ne/ITOGvzmS8aLf2lTqmVHAEGxQTG/pAC3ynjxJTHQgTp+pS08SfrJf3LIgBodyhMNa1y8rB8dmC6MOWRi12Ck=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michal 'vorner' Vaner <michal.vaner@avast.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 50/65] netfilter: nfnetlink_queue: Solve the
 NFQUEUE/conntrack clash for NF_REPEAT
Thread-Topic: [PATCH AUTOSEL 4.18 50/65] netfilter: nfnetlink_queue: Solve the
 NFQUEUE/conntrack clash for NF_REPEAT
Thread-Index: AQHUWR8VzyK2vxqMBECpJ2bkpI7jkA==
Date:   Mon, 1 Oct 2018 00:38:33 +0000
Message-ID: <20181001003754.146961-50-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:M0ZrpvBT0MzGOmKP3r2WIT3e7s9I8qu/K+yq5fNj/zJe2f+ydAv44VC4T03K/AS8ailvIJouETfu+gZG8+2WHZdv5BNSrOU/wGh1PRb+CbVnFScvgVQqSTOb9wuyJDZtNtJ8n0zCjBT8Vk8/JS5p9FDtWoMK4wo42KgQBTCxBPdXcvx7saXNO/iuwOoim19rnbESQuGAiLOY6g0qD1Hblbsvec8o8vHlG7D1reWCaZZ0ml2cOKRscxWvEo0bM8ejbZZ3tip/5NXhL6xRFPnyuvFRGKtxkUJfFa3nYgbQmBP1cv95SdEDnexK1B8T1em4IJfwPeOplosvYCdyA4Hr5sstGkV/iH1uhkARsbHa9ABUsi9RMDpwM9nGqeN56X4GBOOQgZDhyEP/RqxXwcseEgDJtSAWZQRoyG9Em2m9thnQWgevCeOAo+3FPnXD8bZ8TLf998i868sAm0CBsduIAQ==;5:awCrlU5iGgq2NndC070DT97KsFhtKbFuUXmXpL29X6wi9OawkeZL5jL5o/3kaboHC0wD3cuUmIZZwt6oY3afPNelX8VwxV4HdZ4oDBr3a4fOcpQZAWHMGHdiuI6mUtpuXJxoQkWfZ80pzfy1aYOi5IHbZCsq0JT3mDCjIgNXbMY=;7:zh5CJ7CPdj/Mj/uq14AHxH1zRDZVUhZ7keHWGPiG6SXBU9/E+AtyW6hPfYKo9uXkLZufe+LiGl6wEx1IgRpqisr5C1PcMpIy9xBLm+Jex5/2suYnHv8cpP9G7ztFB3uvF/G8P6wogHkpEIc5d8m/05FwrGf1X1M79J0V9l0JImGYoOFjeqbIx6drafI5Ge5Biemc8EJzJDlTLMLnow6VVAmZgT2TvT9zhyhvwkGHpVVYrscqyLDKk/JbWoHk8nvB
x-ms-office365-filtering-correlation-id: 2a63d2d6-bb5a-49a1-a587-08d6273648d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824C12C7661B2459C1876E6FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(51234002)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x+Gp9/CLx1FMeTgw2BtpDNksgT8J96knqEceihP69T/6eFKJJKpFD4TCdL0rRRj8/lw6pXUxdgF9VW0z2J6gOHRC9ICT4qPecFh7M8jAJOFb7I7KTW5A9uhkb5mqgzztpkH9TvGGEO7k1GM0Sa0yIONjigdJrEjDa8CTs01ptzsVYqxxFkncfxsNe7w1KKsIgPE3w+K6MEg5s9MVAwxYk4T08ROJTMAMlS3zY1aM53pZfzo74nsYe4c5cDkvxgyw+/niddntQ0J1npopELATLVA5qh607w1SjxJDrfZd4slT0fcastVcE5KsLC5So4Q9YpPBu/s4gmyUD3wIAkSaWnFl3E/qPz7mDHwWetialYI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a63d2d6-bb5a-49a1-a587-08d6273648d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:33.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal 'vorner' Vaner <michal.vaner@avast.com>

[ Upstream commit ad18d7bf68a3da860ebb62a59c449804a6d237b4 ]

NF_REPEAT places the packet at the beginning of the iptables chain
instead of accepting or rejecting it right away. The packet however will
reach the end of the chain and continue to the end of iptables
eventually, so it needs the same handling as NF_ACCEPT and NF_DROP.

Fixes: 368982cd7d1b ("netfilter: nfnetlink_queue: resolve clash for unconfi=
rmed conntracks")
Signed-off-by: Michal 'vorner' Vaner <michal.vaner@avast.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nfnetlink_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queu=
e.c
index ea4ba551abb2..d33094f4ec41 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -233,6 +233,7 @@ static void nfqnl_reinject(struct nf_queue_entry *entry=
, unsigned int verdict)
 	int err;
=20
 	if (verdict =3D=3D NF_ACCEPT ||
+	    verdict =3D=3D NF_REPEAT ||
 	    verdict =3D=3D NF_STOP) {
 		rcu_read_lock();
 		ct_hook =3D rcu_dereference(nf_ct_hook);
--=20
2.17.1
