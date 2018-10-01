Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F3C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F9D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JOGK0NmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F9D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeJAHXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:23:33 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbeJAHO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0m8JlOftfARkiPWUtb3CRlwE5agtmTJSA3xdWRwXSU=;
 b=JOGK0NmPmpA/n9VKJzw9xUJv3YQ7o7zLsH3DhxSIcINbU1VfpWfbvwFoTUOEPgJyBfwquFc1N88i30ShRVyaGiz+ZxVbI6Lnl9sxCypxCi17TQIM8tbhF6xHepm1ZujSyJll7tFoUX3a//BVA5MdyjvdIuJwt9Z/DKKqXqVDvH4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/37] netfilter: nf_tables: release chain in
 flushing set
Thread-Topic: [PATCH AUTOSEL 4.14 11/37] netfilter: nf_tables: release chain
 in flushing set
Thread-Index: AQHUWR8ljpNkaafxHEeFBKBAx+v2TQ==
Date:   Mon, 1 Oct 2018 00:39:00 +0000
Message-ID: <20181001003850.147107-11-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:WgAmDvjV1QoCJmUoVe4zPVyw14egT9y06RtQFRxb5c/I/Y/RFUCNyuB0PoREAuCnY3/C5NPUQZtV8POP6n0tNXHZ7IoODC1t7Q4mDIp4gXlKgDlWJQuFG83IzYpBi7T55qRKcofjBFq/WtDQjbrQcLy9tehX9QnS9mD0XIgN4etgIiKp+xeFJ9/17krwme1w5nybEO1o5xrceBiyR8sg/1lTZUJoy2TDcCFlO8NB4/rIWwT/4L6Z2M8kFo29B9QH6CeuLeEdBi635rbABv2YUUnsxBVkykpSOs5n4LKqMAvoLQOinFwEnosv2sjNMV8Zp0zzdwt4Kj2+d2cdnHFPOOXZdupUuLqAU5Bfmpdp9USggMoU6la0T/yeyX8Uq8T8NttZ8qqh6F8tGbv5ZpvM8UrLh7ngtkftcVR3GGk14yEY2NVmvHAFgHnYvMWhdhIwAZh3j59k/anqZrtoDkgXAQ==;5:orYmCg/c9D/3kaiFIpnfDLMP+pl4lvMlAnr9Ufb08IlBAHPjt4kT9Dl4p1nTfyt9TmC1D9TXGYyey4GWfASFdQ94gCTDqDl+t4V8W/RnMs3l3BbhcRokVDMY5OJz+vEJD1oo4IlQNZPnrA+/PHS88CwK7Ti2r8ALPKPN6aCoLjQ=;7:6jz7ZaG5SKRAm2UXnXsZgsAssPd3R2+Hjf04zOAyz5e1JOy9MdwjeTJGm/kLARlhbiszZ7E/LuoYcO69rtjI8yf5sWCpG5/sPfg0C+kcJWQ0Hluz8IrE3CB7mfA2Napb48ulovU7IoWMWrG66PImRwZkg5n0J/EWmZIf77/geLTEo2oIJI9+aafwd21mf6dDFsF4mawTglsnvpSFTz7So//JEwV70H9EELO3tzzdE3CYVkuscqJddZfNWH9GL2tK
x-ms-office365-filtering-correlation-id: 14b6e108-fcf4-47e0-50cb-08d627366036
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696521394339C81C9CD0A21FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(39060400002)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BVu8v41kJwaKaGeyRvHZ0CYc7J01EuC5Cv0XVsJXXd0ySTUfQKqE6C7V/H9PQawNwcWbXYa8fC96F4HE9YGuT9cV5Tn3AWa4u3iEe2QmsD+BBBt3tORscHRdwYWKtzDdII6fmuEqXMUS3qWbHoQLA/giu1i7pwO2mXUH90wVHMqYYJLicwq4yV3RB74MRPzMysOj17GK/scMb8rSEOvIy0qhkyaHEsbFHtzfEeKWsC7vFkRvlJMueCDBO8M77o/3h75oZCxxYuTzaEYWkI9k5iXqnJ7m2EoSuibEcuRnlZeZYGQpbZZKiVe/ovF/CMY0zmK0qaUd0Tjx2U7CGNJzNLPFTrRh6MML6+VHyaUtw6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b6e108-fcf4-47e0-50cb-08d627366036
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:00.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index 742aacb317e5..3ae365f92bff 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4250,6 +4250,7 @@ static int nft_flush_set(const struct nft_ctx *ctx,
 	}
 	set->ndeact++;
=20
+	nft_set_elem_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) =3D set;
 	nft_trans_elem(trans) =3D *elem;
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
--=20
2.17.1
