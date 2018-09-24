Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812BDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB332087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tq5d8hsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB332087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbeIXUxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:04 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388427AbeIXUxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zywJVXz2lX+uMiOVkfYD4nfzgIfDqKmq/x0csupW7oI=;
 b=Tq5d8hsnG0SlMPusEMoxadCZjg4SHEbkbRtkpSxaABvG34yHhO+kCScWml1Oo0vpA0oI1oycFOeG22PQUjXIFKSjEAQ39oeUC1LScE5Haf2mR0vc/JKcFxoEo5HWe3QaPxXcGcwAWOd0EzpsfSx4epGlDYYBBLOMGcBoIASlfMc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:50:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 35/36] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Topic: [PATCH AUTOSEL 4.14 35/36] tools/vm/slabinfo.c: fix sign-compare
 warning
Thread-Index: AQHUVBXC6LCA6G9CFkGVFetp50hh6A==
Date:   Mon, 24 Sep 2018 14:49:12 +0000
Message-ID: <20180924144851.164533-35-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:BRbCliPAqefBC9wjEryQChhy2PvbyuaGEFc+Hbeod+RhgJXQ0BCA7PYd+9l2M9j10ck/EYFNHYolvdQFlVIxBkNOdJP6mx0KGkfv5ZKNZ7DJ4em4seaZpxYS5Tjqij0lLnQ/3NKwRDip9eWySLjoX3qTNKmxdhizFJ1MA2uljgcyj7hdC7QGITRD+8avoSJSvOn0sIFo4GH9d3BRANqo2AtZioyiQRkiL7NXhTiDSiVUlRGwvle8WG8sVHSWP3baZI4COIdP+ZFnS7k7vX+WCmfUadGp5W65jN77h7G+4yyDfG3VzsnDm2bEj2B79nKGMXsyOf9Ba/HsJscLIJ7RonVZCaPlJ0YkyohZ+CvNVFRb3dUQkBSfnfvU9Et/e0V2ZDyBm2J6hU9dQySsu7eDKU1AVflTykrWKBqTXBtpBYz3JAqM1uBmKpLsQ0+CDuIljdGb9+ZfhHUiX3OR3MrH6A==;5:rl71YOXeVeolmcKlF0xwdvlScMpxvqhywKAdQLJtrdi3zKkdhg+CrdTIy7eMiSpKyr9vaLiQXXqfU0EPaxrX5jHBwj7ldj0HHP+CSoCQYBj7aifBhDRiJC40XeIGmtGNFN5tETXeDRaAlhW+be9BNUKgzsBIXk4GK/p3SNznOFk=;7:rIhv6KGw1uOdo+UlEN+B4c6rkXHAcW2ZZilLQJNaoCTIatyHQPALiEE+dSwaSR8cez/tHGlTVkmtsnPFBmXw2zn34xqHDwOC9AOs24AiPIuTEVDb8v5gZ2w0sNlrxPSi/RrSpslsvu2t32irNWblPbPv/bT/ZPAqeJJbSYnpFW1B7WfgBud8QElo0RUpFrHkNMyAQ4nBtxhGowQp5AMDOaAcLpnLTdldWdWrQmqpvSQBWp60U8ZOD8vQX5MmoV9P
x-ms-office365-filtering-correlation-id: db468e98-3228-43b9-1641-08d6222d0e80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744E2ADA8160DD9EE052338FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(575784001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(6306002)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(966005)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CeJsPUOK+0aITdsYlXY/bV0bTOu9ryALVrnmuwQVwqSHNwCi6ebrd6hgJcOqfLJX01+X64IFkdIzPNdl0HfARmV0BOMgg/hj1irXHctUzAm3PRo8+2XOp1gfW/iCVMtI/3oIyxHSEGB1bs1Eb5GSajCpj/8A1RpDeQemQ+qR8gi/nm6MsDdhaxFb80LmiZ6D5l0PUpGRU3tMy7fYHQkENsQ+hAkUaLtF+8s0da4YTLk94bmm8yayYVxyXY9Mic9eBdpWBbsdq+5D15t0e0GqQydwrv6Ct70TAGgowiGWLsIZZx5C75WLrOphQ072tk8MvNz0VCFix05q9NorMjVST/VByYNwruoEOHvW5ZDeXTE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db468e98-3228-43b9-1641-08d6222d0e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:12.9963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index b0b7ef6d0de1..3fe093254385 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -30,8 +30,8 @@ struct slabinfo {
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
