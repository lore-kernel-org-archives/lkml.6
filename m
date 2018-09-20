Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E80D21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kh/9mdpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E80D21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbeITI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:49 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387629AbeITI2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flB6mcgQgBeDedo4WdV+O4QBf9GR6Y//mZCwPkd4FU8=;
 b=Kh/9mdpmXKAZpv+hIKAJifPEGr3zeHmmC1g0ydM0eKDIxf4HsZmaas2rN3ibrp/rpu+aikvLr4RXm8r4pK6T4qdxuN+CYg4Uihzf1NwkN+THNPTz8l7S8nBkxCmCNpIp2+2dTZM7b0t+4cAmMt+stKcAlOFqvp3t9dLxRR5aPz0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 14/56] bpf, sockmap: fix sock_hash_alloc and
 reject zero-sized keys
Thread-Topic: [PATCH AUTOSEL 4.18 14/56] bpf, sockmap: fix sock_hash_alloc and
 reject zero-sized keys
Thread-Index: AQHUUIxKh8HEP/Pj00e3dz/LRLwkDA==
Date:   Thu, 20 Sep 2018 02:47:37 +0000
Message-ID: <20180920024716.58490-14-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:GvVoswYpKHLZaIWdYNv5em7KNlfbYKqmAVPnkSmfv+SD75Dlt/a/GU9xpaVHuLlWSVZxqyzjc4Y/kAKrxteKHHxyeew+iGVMMwRpN4+dGGZ14wcd4+MXNrTS6U4fUzqkB5vFnLOUF6f723ZVbClPP39KkIbzbz3whJHBSlXX9X9P6XO3/4qXzWIq/mYF3uiPjQXC2BApqD51/ryNykGyvHWdQPE+5XJu8rhk3TvM+6JdgTzn40RGSBiiRBvnDEJDWhfqLk1EvqLAO3KGUgkVP5MsTVawLp3OGJCxnbzHDbVrWTmYQD4/Yyraiwv9cL5dwf+dNZ3/CIElXGL5GSpMWq8Ys4mX4xWlMzJwoZKbTJPBbACZ02C9g/XVM6UoT/IFrYLqX0a+Sf93BtNCj6Kj1SLg03hU7qnTPBNgtcvQPuVKwbvfT5cGKLyyy5HzXILQP3m3XMTioF3yQWgda7tNGw==;5:4xF/4al6JqfJyRLjE0ZDXeWhKMvPOw+qUHHDs2LEqbpnZj9OY3JM0SF5CoEvKuSrRgHg96Lg/OC2DUfYle1Cozx1Hd5OQuW1JXIb119kgBsJHE4fc7BKZjOpYazJ6CyjkHJyomgJLuDLqVgySNfOrZmKjbqRoKsfp6UjOSMbCx0=;7:lEstSCw50Feg5LoO1RPY53KJqKt8qvlcRCG3jBA0EXFDZ8aRPprzdBDpr9SlJ7rfO2NTrh7BSyYJqpZqCS2WoLlhOa1/vLSqgqZU7+qcVTYIjCbohVEXr+TpB1OvMbRZcFs4hl+etbxYlUDR0Ekfe7umYPWJJwYV82C6yLhOz+3LGnE5mCSpSeDV4EFEAywC0XutSYpFhOzBmwTGf1IVwmtx5yde+dylV+5KJcbawid9Zk777XE+cIKDD0kiWjVx
x-ms-office365-filtering-correlation-id: 21e061b2-35ee-48c2-94fb-08d61ea36cb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082279FE91F71E7DC9769385FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(575784001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MHC8WzB97amsBy28q19FWjcIO9S3S9jerbdgYWYtzRZTbp+VXiE//F4a3pZsx2X0cd/IyuqkKMFQRRaOeEMP0+HqGw4LxjvloGrt1zyhrslSjADn75P0ZJjdsf2Uz8B+8QU+Tz4qrNuna1P10nGX+nyxa394q2m854r4IirZXaLnBFmCsKSEwqnrHQxcAYKAf1+xx2EMK1LQX8vvOr+Dj2htETOxJqj+NIjxdORd5rqAtBDkQfetjdXzQxZHoQ4kC3nVQ+8cV/JVWH0+VDXl0buWAL2QGkTyZvb7GS82JJXLKxMXtTB14TL9xA1EIN1aB4ztEW4sUTr9sb0bpYME9w1llcW4CK/E7tDRPFcfiAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e061b2-35ee-48c2-94fb-08d61ea36cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:37.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit b845c898b2f1ea458d5453f0fa1da6e2dfce3bb4 ]

Currently, it is possible to create a sock hash map with key size
of 0 and have the kernel return a fd back to user space. This is
invalid for hash maps (and kernel also hasn't been tested for zero
key size support in general at this point). Thus, reject such
configuration.

Fixes: 81110384441a ("bpf: sockmap, add hash map support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 58899601fccf..dd87d930f036 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -2143,7 +2143,9 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr=
 *attr)
 		return ERR_PTR(-EPERM);
=20
 	/* check sanity of attributes */
-	if (attr->max_entries =3D=3D 0 || attr->value_size !=3D 4 ||
+	if (attr->max_entries =3D=3D 0 ||
+	    attr->key_size =3D=3D 0 ||
+	    attr->value_size !=3D 4 ||
 	    attr->map_flags & ~SOCK_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
=20
--=20
2.17.1
