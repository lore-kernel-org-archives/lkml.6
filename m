Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD0C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5416A20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D9IwZ5zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5416A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJAH2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:28:19 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:62504
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728617AbeJAHN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZYRsltRvLzt5cYbWGY5I+E+w+Mq3IQvZae3R2E6e1Y=;
 b=D9IwZ5ztSUP3EufgQyfCBye35GlfX6aFxKoUOfqmLCXCAMwFKNzHX+9SCON8H/fvy3CSLHIrAQzLnKpFRchXB4WVUUxp8GO78OSwqMIHhwMfUHm6z79WOOBRubk49CvfYv+sgJk2q1PM64CjxLzMxDn+LDknVelaZ8ljGaLlcCY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 17/65] netfilter: nf_tables: release chain in
 flushing set
Thread-Topic: [PATCH AUTOSEL 4.18 17/65] netfilter: nf_tables: release chain
 in flushing set
Thread-Index: AQHUWR8JLjrRkEBnvk2uRnojKR221g==
Date:   Mon, 1 Oct 2018 00:38:13 +0000
Message-ID: <20181001003754.146961-17-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:MVsm0cyBh7snJY5nObGWZS/r/llr4/ea8G8ky49G6VW3l6N0JVAGcYj9EIlmIiOpvBbLJ10IwPDVzQDwNJdwsA1LCgRR1iQUYNPpLRqxl5GHKlrJ6r5RTfH3slS2TQ0CUSNu6jLBKpeR/BzXJvbnszVpQF+P633wpgUBgd7wty8WBth9hqc/Mx3LGqlwkSUR4G1FkX9CZbPF5dr9EELbw6W5N4tMx/A6/a0xCTOOvYB4P8OwaiELgO2rvttSJZZsjk1PopYkL82HNuVHucHJSVjEgvUQo6MpOC85B8+VAyOL8Cqrr1ljfBs1Xa70g6gUShsVCQsa3fxjk0bKZr9lmloAXSJbAjHga4xhxcZpvCylBOIQ33/qXiPH4Pq32CTJfLQl2TaET5BN8936Krc9/lRIo2yNjOJWztz+Zn48garEPcnOICEtFOlLrHIaMn1rl8EzGi0gBq4PGspJ7HgrLA==;5:/Nvil0OYmY1DlMM691NLs8nQTQkOytDQm7uWKsU956mFvofWfkaW9GWrP/fggOfjTpK90UZRh8H7v37euFLjao2ccBZjVkGga/kVqcsGNzpiVHkKksuWTGuRz9yPu62NAkd4g3/08MV04Q8EtU5Lz7W7xkql/KKORvrhnlItfTk=;7:DImbzYiUgMYyWZx5Be44wkGGwhyanZXoH6uKeud1Llf57kqQ5fTSoQCm9HImtX0D4Mxvn5CInpl/wcu/f7IxT4G+Bv8OleQT5Glz169EiyJ1Dvlw7IJprYfNQO+IuQePstTMzccBjJwYrA7vqL+gukkirINMkl6lWoY14BtPmJrIIhPmFgy8tepZFJ2io9UP5y5LW5j/wzLTiLwi014cjgqycHVnMAS5PnjwVxo4t9H2wr5DPKF6Hn0YCUxNVrch
x-ms-office365-filtering-correlation-id: 44f992b7-4758-4761-b3f2-08d627362bd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB04727E8C75E175E10B510F43FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(39060400002)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JeXlCzysRiVFNqPzJ290vFTk2ed6EZOPf5Ph/B0pK+bINb5oUq0RB7xuOIEWaMgNg7dxS4KfidrQWx1Np8asmUHuB7L7JaWR+ReCSMHSUdxdPEtI8R4eWc6N270N+uL8xGEXms3xLPg49/K5m6y/v8cRluEzxyQlzRBDfoPAQDt8Nmbu3LMuqEUXND6wmY58NHs15IU8XMd5zJcjVRuUh3O3HG2/W+LQ+/gVXJ/nWmhKUGxrXR8jK2kvCB9hI6W2wT1dD/j7vsBoBSW/SWdlzq+KZYZsoQHc5E+NDV90sAVdzoTO+15RQxsBF03kB+tYH8HgUVJUha6LrH+bKKicGPqbmyYy18ShngV1Jl/U7zQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f992b7-4758-4761-b3f2-08d627362bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:13.5254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 7acfda539c0b9636a58bfee56abfb3aeee806d96 ]

When element of verdict map is deleted, the delete routine should
release chain. however, flush element of verdict map routine doesn't
release chain.

test commands:
   %nft add table ip filter
   %nft add chain ip filter c1
   %nft add map ip filter map1 { type ipv4_addr : verdict \; }
   %nft add element ip filter map1 { 1 : jump c1 }
   %nft flush map ip filter map1
   %nft flush ruleset

splat looks like:
[ 4895.170899] kernel BUG at net/netfilter/nf_tables_api.c:1415!
[ 4895.178114] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[ 4895.178880] CPU: 0 PID: 1670 Comm: nft Not tainted 4.18.0+ #55
[ 4895.178880] RIP: 0010:nf_tables_chain_destroy.isra.28+0x39/0x220 [nf_tab=
les]
[ 4895.178880] Code: fc ff df 53 48 89 fb 48 83 c7 50 48 89 fa 48 c1 ea 03 =
0f b6 04 02 84 c0 74 09 3c 03 7f 05 e8 3e 4c 25 e1 8b 43 50 85 c0 74 02 <0f=
> 0b 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02
[ 4895.228342] RSP: 0018:ffff88010b98f4c0 EFLAGS: 00010202
[ 4895.234841] RAX: 0000000000000001 RBX: ffff8801131c6968 RCX: ffff8801146=
585b0
[ 4895.234841] RDX: 1ffff10022638d37 RSI: ffff8801191a9348 RDI: ffff8801131=
c69b8
[ 4895.234841] RBP: ffff8801146585a8 R08: 1ffff1002323526a R09: 00000000000=
00000
[ 4895.234841] R10: 0000000000000000 R11: 0000000000000000 R12: dead0000000=
00200
[ 4895.234841] R13: dead000000000100 R14: ffffffffa3638af8 R15: dffffc00000=
00000
[ 4895.234841] FS:  00007f6d188e6700(0000) GS:ffff88011b600000(0000) knlGS:=
0000000000000000
[ 4895.234841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4895.234841] CR2: 00007ffe72b8df88 CR3: 000000010e2d4000 CR4: 00000000001=
006f0
[ 4895.234841] Call Trace:
[ 4895.234841]  nf_tables_commit+0x2704/0x2c70 [nf_tables]
[ 4895.234841]  ? nfnetlink_rcv_batch+0xa4f/0x11b0 [nfnetlink]
[ 4895.234841]  ? nf_tables_setelem_notify.constprop.48+0x1a0/0x1a0 [nf_tab=
les]
[ 4895.323824]  ? __lock_is_held+0x9d/0x130
[ 4895.323824]  ? kasan_unpoison_shadow+0x30/0x40
[ 4895.333299]  ? kasan_kmalloc+0xa9/0xc0
[ 4895.333299]  ? kmem_cache_alloc_trace+0x2c0/0x310
[ 4895.333299]  ? nfnetlink_rcv_batch+0xa4f/0x11b0 [nfnetlink]
[ 4895.333299]  nfnetlink_rcv_batch+0xdb9/0x11b0 [nfnetlink]
[ 4895.333299]  ? debug_show_all_locks+0x290/0x290
[ 4895.333299]  ? nfnetlink_net_init+0x150/0x150 [nfnetlink]
[ 4895.333299]  ? sched_clock_cpu+0xe5/0x170
[ 4895.333299]  ? sched_clock_local+0xff/0x130
[ 4895.333299]  ? sched_clock_cpu+0xe5/0x170
[ 4895.333299]  ? find_held_lock+0x39/0x1b0
[ 4895.333299]  ? sched_clock_local+0xff/0x130
[ 4895.333299]  ? memset+0x1f/0x40
[ 4895.333299]  ? nla_parse+0x33/0x260
[ 4895.333299]  ? ns_capable_common+0x6e/0x110
[ 4895.333299]  nfnetlink_rcv+0x2c0/0x310 [nfnetlink]
[ ... ]

Fixes: 591054469b3e ("netfilter: nf_tables: revisit chain/object refcountin=
g from elements")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f5745e4c6513..77d690a87144 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4582,6 +4582,7 @@ static int nft_flush_set(const struct nft_ctx *ctx,
 	}
 	set->ndeact++;
=20
+	nft_set_elem_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) =3D set;
 	nft_trans_elem(trans) =3D *elem;
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
--=20
2.17.1
