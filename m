Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60688C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2313521736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uZgrua8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeLXHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:40:49 -0500
Received: from mail-oln040092003094.outbound.protection.outlook.com ([40.92.3.94]:6228
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbeLXHkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fTIZfUTQRy7hKA8nbxTir2f0yMHRqr/CGCSc0vOrh0=;
 b=uZgrua8+8z7kFmRkFyxSs/AFn2yJqHutISExus3W8+WCrV69EDKIEPIOei0Ty7KYwgXsmUv9n48V6rLUSPUt3hcORiJCRgXLnk8zjZP/qTVuBU7L6LbchNsrJY91Z/EnnXGxyBhtYbINHK6xc5SU0ewsOz/bn0pOc8JxCd7hC34bMD+fy+++Zw3W9i6BcZBdxv+JGsb8XNiBDmWIeexcqjoryZIUza4AX+B4Rnk8Xw2xLFJoHCN6uT5ckvQYSwA0ZzxIlRIXuTOO4YhuvMoszxJbOgcF8UAbTnofFaWmVoiFLi4f2liy3nD4B4t2Cl7O+0rrBKRHHym3qzzDtO7uRQ==
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (10.152.72.56) by SN1NAM02HT203.eop-nam02.prod.protection.outlook.com
 (10.152.72.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.13; Mon, 24 Dec
 2018 07:40:07 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.72.53) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Mon, 24 Dec 2018 07:40:07 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1471.018; Mon, 24 Dec 2018
 07:40:07 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear
 region
Thread-Topic: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5xw==
Date:   Mon, 24 Dec 2018 07:40:07 +0000
Message-ID: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:4EFE77640C80CD33279EF659EBDAFDC1C95E9DCDAF0F537FFF15560276981D29;UpperCasedChecksum:56AE35C92D0C2DF820DB43D24FD15C59BCA30A03B07CF0B71551E581164692CF;SizeAsReceived:7716;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [1KRx/a/iUWbB0u1t3ZBHXfQmyLLOJ0gr]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1NAM02HT203;6:eWIJtcjri+bQjIInk6Zh/N8HvGtDmWsytRSneoxEqXXMjee5Maj6t0TZx6eTfMN6Fls1pgfMCbOtZ6LG2CK36pSqTuzQpsJjXVceKMhCY0m3jyFr95Mh0zPV1yCa3aUegUnCTbYNMVEGS5Laqqtb1Qk7ahxveQjTffSLY7FoC77DwXa7n4LxRUt9OLeKVuMa4YTr02kobwTRPIpR270Biqd0jN8Qb5FZ8xgjGLBN+ClOCyTA2CjhC8N5544tlob3DOGj0zpw1EYTcUYUjzwFsliwPE/oO65J7qQNY5Sx9gLFxpANDIBGXCLi4dt8G45oMjvVw194MQnMSh3SSuPmHuSTh/+uGi9Aq5TP/qpUtjtOQ//92GED/mCE9BokPB+x3F5oan9GDXx/I6iQEWzdXQAtZP8kyvqvByZv8DXI0p4aUJVIL9iGeBy1eCLEU5BIcvpDiDI8NPHQI88A9n+8cw==;5:XOq6zTrjTQkRHq2vnxUSESUlIlWhpWLx+1gqYPobcqbueiHojsgRDPYkedQaXQrYpco4aTZg60MQ5S9tW8HPr9jpdxb0+GarK4qMxHeIIxMLSP//adqYgd5PKoC2Xe8EgX72Uv8WVs8g6met54/NsjT7lRYG0mDtbdFZ2jblZGM=;7:+eortijbhLtkzKWHFkwndXuAFZc4KE6pPQgba5+pm+JXotNNasfqR2F/JdhxE0dKLaMmhi2qYZ/UEDMmXlh4cJ9LqfqpDRWvZSHMctA6iGGfMxsqSu52BzzvS3tsjHupKfIrDTuRmR/Kcf7WCkgvhg==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:SN1NAM02HT203;
x-ms-traffictypediagnostic: SN1NAM02HT203:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SN1NAM02HT203;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM02HT203;
x-microsoft-antispam-message-info: F6tI8UGNfG8+j6n3z8JmUkSV093+oQ+4SDuMV+PaMKuiD8Rncpite3O3ytV6B6ni
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cc479a-75b6-4754-f23d-08d6697305e3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 07:40:07.0902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KASLR enaled(CONFIG_RANDOMIZE_BASE=3Dy), the top 4K virtual
address have chance to be mapped to physical address, but which
is expected to leave room for ERR_PTR.

Also, it might cause some other warparound issue when somewhere
use the last memory page but no overflow check. Such as the last
page compressed by LZO:

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

in =3D 0xfffffffffffff000
in_len =3D 4096
ip =3D x9 =3D 0x0000000000000009 overflowed.

Always leave room the last size of ARM64_MEMSTART_ALIGN region
in linear region.

Signed-off-by: liyueyi <liyueyi@live.com>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0340e45..20fe11e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -439,7 +439,8 @@ void __init arm64_memblock_init(void)
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
 		u64 range =3D linear_region_size -
-			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
+			   (memblock_end_of_DRAM() - memblock_start_of_DRAM()) -
+			   ARM64_MEMSTART_ALIGN;
=20
 		/*
 		 * If the size of the linear region exceeds, by a sufficient
--=20
2.7.4

