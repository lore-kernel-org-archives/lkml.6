Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8290F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TqKl3ULZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8290F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeK1ScL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:32:11 -0500
Received: from mail-oln040092001054.outbound.protection.outlook.com ([40.92.1.54]:6272
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727285AbeK1ScK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS4cE4lgqTzlpvGIov1sGO+QHp2S3E0fWRpjgmii27I=;
 b=TqKl3ULZsTkz0/anXyzAZNRJlL41n7poDCM/FbCuyDMMfg5hM0kS/ANxhwNbYaEKFsN+6TdJThbFYo90Uzb+hdwALJquU3NMa0cTM5NgJrM+Sn1esGNhTcZI+Vax8SVz6BKyXYhj5mTtFu1Tmf4sCbitTTuhJLGNtk5Wsz/4apSZ+lvhY93/N3UJYD5oSOb+svD/4LL0w2Xk3UfIkAcM2toHQMlGJ8ZjlO5AN+49Nn6Pukw/vr0bS5lN+sTUXUICTnhx+SpsFoZjYBn1mE1MrJ1SbLwF0XZfu1IalhKZ4A3r7YQHfgvBLNHLUZ5/pVYbtLSBl741HEiqZ+xCO48Z5A==
Received: from BN3NAM01FT024.eop-nam01.prod.protection.outlook.com
 (10.152.66.53) by BN3NAM01HT122.eop-nam01.prod.protection.outlook.com
 (10.152.67.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.10; Wed, 28 Nov
 2018 07:31:27 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.66.51) by
 BN3NAM01FT024.mail.protection.outlook.com (10.152.67.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Wed, 28 Nov 2018 07:31:27 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::eccf:c550:ed97:f1e7]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::eccf:c550:ed97:f1e7%7]) with mapi id 15.20.1382.012; Wed, 28 Nov 2018
 07:31:27 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>
CC:     "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0g==
Date:   Wed, 28 Nov 2018 07:31:26 +0000
Message-ID: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:203:2f::32) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:2D7E30862D31ECC9381E81D3C6B5B48B47006F576BA212DBF3BBF4308B4F2A14;UpperCasedChecksum:E812E2B6C43D4599BA5FC2CB6C49E277FC4EC1D84BBFE638B4C481E801593433;SizeAsReceived:7410;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [1LqSV58cWuNh/MWVxIdK6Zvj/qNFAaAq]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM01HT122;6:BreRzjtwx9bXnB9fDUBYBeOOseE+P6GIT/75n4l5NF/qH8C0XRsMHlqQkvIGOMNIw8u/CU37967ILZjPsmiMH0Rzr8x6om4p0+PoVMB+6PyhkOQteTj6WhVRQKfyGMu2c7DPy1X5KpvQNGUJrnE0NjzTDyBYugSWq8CJHBVBsuuglE2Rp+I6yvL1K0r579eY+HZAEXYFlgt6+18t51J7Q7eWKwneoDNTOQGGTkzVRoA7/4MlxhpBamoOQuC7zRwPvKNChcjoMUU86bbvo7k+JDN8c4HHfJamP/KfunrJfOop8WMc6Lq9Ys7qGzMBHaRiSiTzo2t8cBpZnIzria0dKMAwsCp+dy1YPyqTYx6TKErx+IxhctHdK1vGaKVpTHHYLyT/vsWXdCg5kruTElNmpDeofZR2RXxlnaYu2src2KpZdcNVxw0mI/Md+Oh2sZjfht3mZQDWB4LYD0e4Cg/9bg==;5:glrJzoA/cbl7ubJMG9XVvPqTPRBexDZGD1fRJxyfmKxIMSNJ3uIC/st12fOA3lVTA5bJjOgsic4CuOBiLhO+dOWr4guOG4Sqdr4KyAFanH9yRxWx8BfwL8odb68FI3JNOa5mptxZiS+yQ8KypvRAKMY2JqOXVGkZr1rajaykP/0=;7:ufqo2fRwOpWEOZTRw+j1KGlerMxQsac98TgmN9yJvkcw7sei+/4My/81qAoJvTzFy25qTF9qm039NYkQUG1Lh2cc9MuKpzMicnPwL0xGSKnT1xSwbup0/cfI+T5MRK2C60hMHMk31NPl2miHYBonrg==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BN3NAM01HT122;
x-ms-traffictypediagnostic: BN3NAM01HT122:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM01HT122;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM01HT122;
x-microsoft-antispam-message-info: Pmp/0kh2t7RVc2yCA+fvfFxgP9g+JiOzPRNtOWZLhNseTJR+vKgZXbW2ZZ+0b6lt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: f60280b1-aa3c-4cd2-cd3b-08d655038193
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 07:31:27.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM01HT122
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
 lib/lzo/lzo1x_compress.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 236eb21..b15082b 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -17,6 +17,9 @@
 #include <linux/lzo.h>
 #include "lzodefs.h"
=20
+#define OVERFLOW_ADD_CHECK(a, b)  \
+		(((a) + (b)) < (a))
+
 static noinline size_t
 lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		    unsigned char *out, size_t *out_len,
@@ -39,6 +42,8 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_le=
n,
 		size_t t, m_len, m_off;
 		u32 dv;
 literal:
+		if (unlikely(OVERFLOW_ADD_CHECK(ip, 1 + ((ip - ii) >> 5))))
+			break;
 		ip +=3D 1 + ((ip - ii) >> 5);
 next:
 		if (unlikely(ip >=3D ip_end))
@@ -99,7 +104,8 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_l=
en,
 				m_len +=3D 8;
 				v =3D get_unaligned((const u64 *) (ip + m_len)) ^
 				    get_unaligned((const u64 *) (m_pos + m_len));
-				if (unlikely(ip + m_len >=3D ip_end))
+				if (unlikely(OVERFLOW_ADD_CHECK(ip, m_len)
+						|| (ip + m_len >=3D ip_end)))
 					goto m_len_done;
 			} while (v =3D=3D 0);
 		}
@@ -124,7 +130,8 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
 				m_len +=3D 4;
 				v =3D get_unaligned((const u32 *) (ip + m_len)) ^
 				    get_unaligned((const u32 *) (m_pos + m_len));
-				if (unlikely(ip + m_len >=3D ip_end))
+				if (unlikely(OVERFLOW_ADD_CHECK(ip, m_len)
+						|| (ip + m_len >=3D ip_end)))
 					goto m_len_done;
 			} while (v =3D=3D 0);
 		}
@@ -160,7 +167,8 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_=
len,
 				if (ip[m_len] !=3D m_pos[m_len])
 					break;
 				m_len +=3D 1;
-				if (unlikely(ip + m_len >=3D ip_end))
+				if (unlikely(OVERFLOW_ADD_CHECK(ip, m_len)
+						|| (ip + m_len >=3D ip_end)))
 					goto m_len_done;
 			} while (ip[m_len] =3D=3D m_pos[m_len]);
 		}
--=20
2.7.4

