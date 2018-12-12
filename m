Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316AAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8420851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jwqRC8G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeLLHDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:03:21 -0500
Received: from mail-oln040092000057.outbound.protection.outlook.com ([40.92.0.57]:52992
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeLLHDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgtmbWuUsHgDbqw1Nw8T5PW83dmPZ4K5kQcX2BlaYKE=;
 b=jwqRC8G1fPDtlRi7G8if0g90NCwN1tT9IQOS7dRi2k788IwVN43wcQXMW9v7YQy+K/I6QCzSbD3T/5kjMyDRcMQcwVRTjudo+3AOWKH3KOc5mJF+SvkjSEF4Kg6MehEJHHtpFZvw64bGwel+kYEW6cQeIWAqAQFRAmM7XAmxeMFiqkDCfDsJDezXGbgSIYOqvy8ntymlgFN0af5T4afSjoY52geVU/GP81AIY6oDbTMi88PN8GTK6SMOmaB7s16YL6495B59Be0fvojvyd5vCROKOCi63BaUhMF4hyglWWS5i8fNYqjytVDgR3EdwMrq5C+J9+Wy0isoce2YpLJwkw==
Received: from BN3NAM01FT023.eop-nam01.prod.protection.outlook.com
 (10.152.66.57) by BN3NAM01HT021.eop-nam01.prod.protection.outlook.com
 (10.152.66.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.16; Wed, 12 Dec
 2018 07:03:14 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.66.51) by
 BN3NAM01FT023.mail.protection.outlook.com (10.152.67.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.16 via Frontend Transport; Wed, 12 Dec 2018 07:03:14 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:03:14 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "markus@oberhumer.com" <markus@oberhumer.com>,
        "w@1wt.eu" <w@1wt.eu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dave.rodgman@arm.com" <dave.rodgman@arm.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v3] lzo: fix ip overrun during compress.
Thread-Index: AQHUkejA1R0pSJKjhkeGe0iCa7XE/Q==
Date:   Wed, 12 Dec 2018 07:03:14 +0000
Message-ID: <BLUPR13MB0289674CD6079E25C2A17497DFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:070B0921AC126159A7D4B0D4D40B44F194ECC2A6ECF20CF3E26BE1C42F0BAFBE;UpperCasedChecksum:914BA5DD598D07EE6B7C7879E972A9148781B992A7199D8EDEE3F72C9102D45A;SizeAsReceived:7501;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ZKQrPPZHL6YIhS+5zVzuHcL3kqAgpq64]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM01HT021;6:1SQ9xrlgouX2hWkbCCPhLYuZMcWkJeOJFt6/tF47wRHuJBuhIfU/qxsghsUyqKIL2LkOWrV2Bhjsrpm2DR1dwQtm6tcU2ngFyKPy1wPrNZxaMXPdmIRLetYxXFKGwJg2peZT4k+oWvY4Y9aAIJ7dOvzH14x7leLSglS/jvCjtUkh/VajFHa6M3e0Gjl6ojfzoVtr+h3m2+xAOoTToU0RrsvUObSuRTFwxEGJwZ1JZQZetKDkj7LIKjc+wmTmo5liAtNC4n1OWsT6q+Eo5d0j0xU0L8GruSuEDAlAVTRl5PMSvT7Ome+ZbDzz525EtlfciQs4I1oaQKyUsvPFwhgz7afs2Wb7griuqkz96bPLibn06weHWmyamXcb10dFkfkTcmo/1FRJChV0pDMOp0fi05abefGELPRAgt8ltGCjQ9QRhqtBAOKOBoKpcD1VVvJsUK5KWsgDE1MkP3+FAXJz7Q==;5:kJzqcFyGD86KgpgDdHGOUVrvSnxaDnopUkep1BlggSFOntv/RwZQsZgxjQK/xIEo2vILrUQ6gHwRHv315A1pk8YraICkxHm3jt/HCQqdhgNUmgZHE08l8RQhGU4tTTUfmnHsXB2lMlzYqqXV8sfx/Wokb5Pgl+1GtqRAUTk8oco=;7:JbIannmyzuprGRxcSUmODYB6B5qRfXmJz7PQvqHuDFVhLQHHFkwEk5K9bSu+RD9WAnLFJLsjpPV4R38VNq9azCMaxS+I91P0395dlpezWpjOuDIYGYNlTLZKjGsjHG9QT2Y56aamMOw9Va8c2zZBYg==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BN3NAM01HT021;
x-ms-traffictypediagnostic: BN3NAM01HT021:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM01HT021;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM01HT021;
x-microsoft-antispam-message-info: l+ZqDVtpQDMKwQ4wumKqKAWjAzSlHFndeG48oeVpYdVdoDTBIk4qYoFpWk7iFLet
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e330ed-8904-4e6b-b254-08d65fffe233
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:03:14.7551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM01HT021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It`s possible ip overrun in lzo1x_1_do_compress() when compressed page is
point to the end of memory and which virtual address is 0xfffffffffffff000.
Leading to a NULL pointer access during the get_unaligned_le32(ip).

Fix this panic:
[ 2738.034508] Unable to handle kernel NULL pointer dereference at virtual =
address 00000009
[ 2738.034515] Mem abort info:
[ 2738.034518]   Exception class =3D DABT (current EL), IL =3D 32 bits
[ 2738.034520]   SET =3D 0, FnV =3D 0
[ 2738.034523]   EA =3D 0, S1PTW =3D 0
[ 2738.034524]   FSC =3D 5
[ 2738.034526] Data abort info:
[ 2738.034528]   ISV =3D 0, ISS =3D 0x00000005
[ 2738.034530]   CM =3D 0, WnR =3D 0
[ 2738.034533] user pgtable: 4k pages, 39-bit VAs, pgd =3D ffffffff94cee000
[ 2738.034535] [0000000000000009] *pgd=3D0000000000000000, *pud=3D000000000=
0000000
...
[ 2738.034592] pc : lzo1x_1_do_compress+0x198/0x610
[ 2738.034595] lr : lzo1x_1_compress+0x98/0x3d8
[ 2738.034597] sp : ffffff801caa3470 pstate : 00c00145
[ 2738.034598] x29: ffffff801caa3500 x28: 0000000000001000
[ 2738.034601] x27: 0000000000001000 x26: fffffffffffff000
[ 2738.034604] x25: ffffffff4ebc0000 x24: 0000000000000000
[ 2738.034607] x23: 000000000000004c x22: fffffffffffff7b8
[ 2738.034610] x21: ffffffff2e2ee0b3 x20: ffffffff2e2ee0bb
[ 2738.034612] x19: 0000000000000fcc x18: fffffffffffff84a
[ 2738.034615] x17: 00000000801b03d6 x16: 0000000000000782
[ 2738.034618] x15: ffffffff2e2ee0bf x14: fffffffffffffff0
[ 2738.034620] x13: 000000000000000f x12: 0000000000000020
[ 2738.034623] x11: 000000001824429d x10: ffffffffffffffec
[ 2738.034626] x9 : 0000000000000009 x8 : 0000000000000000
[ 2738.034628] x7 : 0000000000000868 x6 : 0000000000000434
[ 2738.034631] x5 : ffffffff4ebc0000 x4 : 0000000000000000
[ 2738.034633] x3 : ffffff801caa3510 x2 : ffffffff2e2ee000
[ 2738.034636] x1 : 0000000000000000 x0 : fffffffffffff000
...
[ 2738.034717] Process kworker/u16:1 (pid: 8705, stack limit =3D 0xffffff80=
1caa0000)
[ 2738.034720] Call trace:
[ 2738.034722]  lzo1x_1_do_compress+0x198/0x610
[ 2738.034725]  lzo_compress+0x48/0x88
[ 2738.034729]  crypto_compress+0x14/0x20
[ 2738.034733]  zcomp_compress+0x2c/0x38
[ 2738.034736]  zram_bvec_rw+0x3d0/0x860
[ 2738.034738]  zram_rw_page+0x88/0xe0
[ 2738.034742]  bdev_write_page+0x70/0xc0
[ 2738.034745]  __swap_writepage+0x58/0x3f8
[ 2738.034747]  swap_writepage+0x40/0x50
[ 2738.034750]  shrink_page_list+0x4fc/0xe58
[ 2738.034753]  reclaim_pages_from_list+0xa0/0x150
[ 2738.034756]  reclaim_pte_range+0x18c/0x1f8
[ 2738.034759]  __walk_page_range+0xf8/0x1e0
[ 2738.034762]  walk_page_range+0xf8/0x130
[ 2738.034765]  reclaim_task_anon+0xcc/0x168
[ 2738.034767]  swap_fn+0x438/0x668
[ 2738.034771]  process_one_work+0x1fc/0x460
[ 2738.034773]  worker_thread+0x2d0/0x478
[ 2738.034775]  kthread+0x110/0x120
[ 2738.034778]  ret_from_fork+0x10/0x18
[ 2738.034781] Code: 3800167f 54ffffa8 d100066f 14000031 (b9400131)
[ 2738.034784] ---[ end trace 9b5cca106f0e54d1 ]---
[ 2738.035473] Kernel panic - not syncing: Fatal exception

crash> dis lzo1x_1_do_compress+100 3 -l
../kernel/msm-4.14/lib/lzo/lzo1x_compress.c: 44
0xffffff8dec8c6af4 <lzo1x_1_do_compress+100>:   cmp     x9, x10
0xffffff8dec8c6af8 <lzo1x_1_do_compress+104>:   b.cc    0xffffff8dec8c6c28
0xffffff8dec8c6afc <lzo1x_1_do_compress+108>:   b       0xffffff8dec8c7094

crash> dis lzo1x_1_do_compress+0x198
0xffffff8dec8c6c28 <lzo1x_1_do_compress+408>:   ldr     w17, [x9]

ip =3D x9 =3D 0x0000000000000009 is overflow.

Signed-off-by: liyueyi <liyueyi@live.com>
---
 Changes in v3: Check overflow in lzo1x_1_compress.
 Changes in v2: Re-define OVERFLOW_ADD_CHEK.

 lib/lzo/lzo1x_compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 236eb21..959dec4 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
_len,
=20
 	while (l > 20) {
 		size_t ll =3D l <=3D (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
-		uintptr_t ll_end =3D (uintptr_t) ip + ll;
-		if ((ll_end + ((t + ll) >> 5)) <=3D ll_end)
+		// check for address space wraparound
+		if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <=3D (uintptr_t) ip)
 			break;
 		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
 		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
--=20
2.7.4

