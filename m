Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80716ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA9520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ayd4R6Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA9520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeIXUz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:55:28 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:27672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732069AbeIXUy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EMNf38C/1suW6JNuqi0p2aP3xJncFqymQ0djtbZgK4=;
 b=Ayd4R6NfWiywwbUg5IMfMw8McnhZa9BoGgvMYqdBOTT5ASH9/Ef23NBEB/c6tywz8RfPRiEaP/f+ryp1amT2N9MKWXU7E9oFrCdPOjTVX4cLRxjysA4AcfFhKdKGtE5eGjcEwTerwZWJR2DdKcV9siwjkLU+Q2fTBoNZyy4ady8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0136.namprd21.prod.outlook.com (10.173.189.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 12/13] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Topic: [PATCH AUTOSEL 3.18 12/13] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Index: AQHUVBXmLCnsDIoIr0WcqvhPuHCxfg==
Date:   Mon, 24 Sep 2018 14:50:14 +0000
Message-ID: <20180924144959.164754-12-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0136;6:7JUydOd/pEEcNIq+sF2DBkAnLnPogKVnnF1OiOePCI1UQUPHA2R6StC852F2ADqCESmGCdE2q5yasoO1BPD6NZjxeIW1Ev4JywSVhL6gDJv5COi31gk6guiqQQeXjNbBtmc0ifFFVeYYztGLxH5KdX4XCHeLJITOpuY1B3aA7QiNoE4yCQVP0NGeeBLOVacblUakZwrAHEa3vtN8Jgv8zxF2T9T3mMHOOSLppmmH84dtqVGAsK3LnlzP2J9/Cg9bZMK0yPp16Xnr3NTcChkFQoxJCJ+NVa7RKmobMcjwhiLf9RveMSW9rzIhMqThdmRz0qEgN9xNfzqC/OlGw8O+AuMWxP7SvP2G+dIWN22dYu9ygNc6+zPDIucWL9Uqn0xhc3nzenGHQypX3T7xT5/sM4z275r2z6At9LFt5S4K9VHBxUcg7sthUoS3okeSztTjdJfb8NvXuwNAifs6O0FrAw==;5:gtgA6BtGh2sAy7IDxdgZfLbOfyT9VMbg6/wCbFBbXdXs2/h/vFkCPjTx7eBcU3yrDPiOt9LmUMFlLJhEyp6Na8dJ5C3Ds3JqcMFtnjypN+6Vm5/QT/PtsmVO0ZHlSOyz9fT8H3mvuMBgz7pd24H2qkqX9SfPwgJ3mloS9YuWfMA=;7:n66N/N1iZ9KL13ArIqiJzTo+xXUMHMJIl5RiXGxk/tf+bXag2gxu80ly7+IuVnOljXpfH61Snay56uEnq7BtXr12HlFsfjM9zoh0s90x0kNWBG9E6Z56KZNKmrVaMonYd4Ugla14DjQIkdN9+rOf4pmahg8ZVwDtkQ4OIDBbH1F7TBcHghgiAKx8J9IWcMFRPyvsrGu9O9d0SPGnfwq2nkJBv5Nzdd6UFijoGqg+hdoAZo+4Oli5gObNtcnkJRNv
x-ms-office365-filtering-correlation-id: a09c1946-dc84-4267-4f4f-08d6222d4381
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0136;
x-ms-traffictypediagnostic: CY4PR21MB0136:
x-microsoft-antispam-prvs: <CY4PR21MB013627920883DA6735894B10FB170@CY4PR21MB0136.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0136;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0136;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(478600001)(6436002)(2900100001)(2501003)(6666003)(5660300001)(102836004)(26005)(6346003)(86612001)(86362001)(97736004)(186003)(6306002)(71200400001)(305945005)(14454004)(1076002)(7736002)(106356001)(5250100002)(966005)(6512007)(72206003)(6116002)(3846002)(10290500003)(6486002)(105586002)(53936002)(25786009)(71190400001)(8936002)(110136005)(99286004)(54906003)(8676002)(316002)(68736007)(81156014)(81166006)(22452003)(2906002)(6506007)(217873002)(4326008)(107886003)(76176011)(486006)(66066001)(256004)(476003)(11346002)(2616005)(14444005)(10090500001)(36756003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0136;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 69FV1+6yYCkQEu5fAI1McetY9iaK7YFdcIqgpK31sGX3lsSHtYZXHGQqcL/GorbdZ/Ynt6zityy/1cSQHJZ8uvvelfGwryUFpSlfeee4Wy7uX1oFOzFu74zcLtvvW931HA7ErtzmbkXejThnhKTi/hp26LkagRNuTPYCEs0RJLQXDJr6dnSvowZzmZU5kR+U2pGy7jcJLwxogoE0LNYffcmYqO/T/OjZ+nlu7SSLKB5CtvGSN13utjYwWHEWOVsqLpEPYBsvSqMYCfPHuUTx3zp/lvISu1bTMirkGgSEeYj7cc/kCt1h6snUkdxEhpUkurCSuTbh/Rv+xy24WJCzMuSCOHTz/uVKVNVUFeXn5tI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09c1946-dc84-4267-4f4f-08d6222d4381
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:14.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 904506562e0856f2535d876407d087c9459d345b ]

Currently we get the following compiler warning:

    slabinfo.c:854:22: warning: comparison between signed and unsigned inte=
ger expressions [-Wsign-compare]
       if (s->object_size < min_objsize)
                          ^

due to the mismatch of signed/unsigned comparison.  ->object_size and
->slab_size are never expected to be negative, so let's define them as
unsigned int.

[n-horiguchi@ah.jp.nec.com: convert everything - none of these can be negat=
ive]
  Link: http://lkml.kernel.org/r/20180826234947.GA9787@hori1.linux.bs1.fc.n=
ec.co.jp
Link: http://lkml.kernel.org/r/1535103134-20239-1-git-send-email-n-horiguch=
i@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/vm/slabinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 808d5a9d5dcf..c75c42281a73 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -29,8 +29,8 @@ struct slabinfo {
 	int alias;
 	int refs;
 	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
-	int hwcache_align, object_size, objs_per_slab;
-	int sanity_checks, slab_size, store_user, trace;
+	unsigned int hwcache_align, object_size, objs_per_slab;
+	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
--=20
2.17.1
