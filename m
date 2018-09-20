Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B2521521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fV3K4q4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B2521521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbeITI2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:51 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731731AbeITI2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INZ2iYT9wiG3o4JIB/oyOuzwmXg0hkPxbyoV4KgeaDU=;
 b=fV3K4q4V/2RusbV9oRK8kN7lmsaNgTdN+Zgi2/RPokZN8QsQczuRuWbu1W0pq67kumKEc2fRjilypAb2D7ZE0/nO+FZMl4peE/B+40OjX2Rftsn//Qj0GZRZYhhBs6IM0Svt0U6Q6cOLr4v0R8AdftcP5U4waqrT+oYnPKF0KWw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 15/56] bpf, sockmap: fix sock hash count in
 alloc_sock_hash_elem
Thread-Topic: [PATCH AUTOSEL 4.18 15/56] bpf, sockmap: fix sock hash count in
 alloc_sock_hash_elem
Thread-Index: AQHUUIxKxrX6aYKpg0SrGXFLQk8owg==
Date:   Thu, 20 Sep 2018 02:47:37 +0000
Message-ID: <20180920024716.58490-15-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:oCdCJN9kNEcCZHjUmtrW5+t+gbX+06U0WOI8MkIesvVcgYo+uBCt+vX5qWrN+RH8VrdE+pJwzKqhKsNo8L5DQPmpDBePL+CkpDs5hAz/0K+27/oQKXiRLdYiir4PTM/nUsPnhFRfKEJMysef4tFEw4Wl53jlbWf8UpiSMziftSs5EqGZN5Rt0wQWBjO82VUIhBDa4bHzgoRh2pjblMKzvOarnmDZGyvVK8aRksH3SzQBB7YPqXQlyL+Z+Dr/2C5oluY5dlJh9nIq1a5VuTvfnQf2I5koxcHr9xAQ9oaEkGnb0Kqb+xGHsKta28DBWeoKAOhgFtJqQI/oxihFQtNCd9qj5RFWSj0OShAntcRvh62Aii2pxqSC+aZvXLzyINetPhRJbYGjVHU1HBXuFlu6IQojOvF7FYsoqiAzZxo+kK8mE1aFq1Q3q1C1d82ITE7hkHlfSNWuE/naIcOkxzpBIw==;5:0XU4M8bu9Mk352CHliBqsePchsgwLVKzI3cWytG5OEvrSZIbNDDbydT6lG9x1FkBI8AupSWkblmVbsb3wuz1onb+SAm6CgT+nfZqz28Svul6HO2pHqNJJ/zD2Xs0D6HHwZmGQk60v2sIDu2IjBM/t4gEsKJ1evQC0xv0Phe+TVw=;7:CkgP9W/DNvEhelC7c5ueQyW8nUMPw+SYJetmakWH1hr2DYwUZyiOo7SBGnh8AlU4tzwi0MDqh4pqlpZ+pSGS7/oWCgTAA/ASkdqQhwUEH+tWGIbopEeaz26KKK82iWjQb4ZTd+6/OcMcxy6zfhHGtYb6sxeY8cfDD2QFmaIhg13D9TbYtnXlbvRbPRs8TeKxgW1tUo1dHApbMkLRRQ8Bi6RrMB3kdcihMZvaYlr37kaK9sc4Kgz8U0AKqC7tSTxF
x-ms-office365-filtering-correlation-id: 092a7e28-6416-4ad9-8ee6-08d61ea36d35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822A5D979F92EE9001A3260FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EeWwiOhL3DfEje8QIN3rJ+J8xABnhZTBsDS5379yVqXj/1fcDj145nn3YKYeOmDK3HIyNNinlRFRclGetsgRyqga0RLhqzhDvjQhGo+ISDzss7lS0YAFIqmuUL4wjH0xGbJ+weYotuOMU+qln5Fq2dLZoZFkpggUsDBwomgaUHlx/aoADDGPN7UCR5YU1USXyxb7+O7NUimohkn6F66xEx7kixjkzxwqiilNLOL31mNRJhYNNQcIInb433f6gv2jxxLcuYfiehNO1nzjpXrUlbmwxfQ68dY7ttTyQX/5Bu3rAigs/LG+TEAOdimurabQYLTtPREczBl7QBOk8s2y0npAN9FzmwzyxvaLmo0m+ik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092a7e28-6416-4ad9-8ee6-08d61ea36d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:37.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit eb29429d81e31b191f3b2bd19cf820279cec6463 ]

When we try to allocate a new sock hash entry and the allocation
fails, then sock hash map fails to reduce the map element counter,
meaning we keep accounting this element although it was never used.
Fix it by dropping the element counter on error.

Fixes: 81110384441a ("bpf: sockmap, add hash map support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index dd87d930f036..e7f65afc4e24 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -2272,8 +2272,10 @@ static struct htab_elem *alloc_sock_hash_elem(struct=
 bpf_htab *htab,
 	}
 	l_new =3D kmalloc_node(htab->elem_size, GFP_ATOMIC | __GFP_NOWARN,
 			     htab->map.numa_node);
-	if (!l_new)
+	if (!l_new) {
+		atomic_dec(&htab->count);
 		return ERR_PTR(-ENOMEM);
+	}
=20
 	memcpy(l_new->key, key, key_size);
 	l_new->sk =3D sk;
--=20
2.17.1
