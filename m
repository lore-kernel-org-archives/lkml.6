Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DF7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582A7205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nwrfMiUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582A7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeIBR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:28:05 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbeIBRXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm2unZonwBjBZM/wWPXYiRpLWtJ13FwCFRtgFk48M0A=;
 b=nwrfMiUz20JmxJ6L70RBClXrkwZbWkX8kcqhnD3j9LTw7MODOYK98SjQ22B9wTYKt61Z+h2OgQxNgWHpaKks7aZWnxNHOXGo7ihAQkneE5cOssEYN7AGPQZK2w8bTWWEtD81sg7KQu1Fp2JoPLsotNegasxNERR8Y6+odK0hk2s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 56/89] f2fs: fix to skip GC if type in SSA and
 SIT is inconsistent
Thread-Topic: [PATCH AUTOSEL 4.14 56/89] f2fs: fix to skip GC if type in SSA
 and SIT is inconsistent
Thread-Index: AQHUQr3g200UuP5E10KFn1HKMQDLYQ==
Date:   Sun, 2 Sep 2018 13:07:18 +0000
Message-ID: <20180902064918.183387-56-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:lgInOe447xhGBjD13Mm/KbwHDT6r12LUmVsd2tpAu2JMTvYv77CaLXtxy5ng4CruJqbazsO2NEVFMD5qsYSPdx22WTFcB3eT4B7kR5GJdRopuZZ/93OI++JUnwNHx++f0IoIAuM9IK/eXkMgd/KIXeY36S/1X3okKZrsdPSZe24yyPCmoGRNZ6gjjEKjSdlq4D8YK/GCIob2SM+bD0vhzt9LljzotBiWMzFCtps7FNZNwBww6piyjCoEvoEmFrIz2Y93buQDJUNCzBfxKplKMamB8VNeRJjyIUGupAiIMeaQNyQ5rx7dOrGuvAbdotj7BZ6NgECO3r0E5u5iXK+c2vEwJmDLDPCkWO/t790Qb5iYEgfB5A6hf8jviBUYc0WdL5EgZqhHIix4wGZmBz7yrvM/uDuTsMWNp7rAJoTKggYxRbQTbxV1SWmvZ86k26KJo1m/pWIPC9x8GayxGJJPsA==;5:C9vt8+DNRalY5SEUGNzxQ5/vwAPj88U79DrfqA7PEzQCiQw2YymBKcAXQfF0tjmgtOQEdYchjguN4egHav8P5DfbCQCCyNfXc21ptDYQa8LsU2LwHPfJrWyky7mYkMQzt9J6SbDnkoMVSe66tzMLSU/1RN/xtKpAL/59PWiNwiA=;7:NxFQouRhyXvU5Uh0kdnmsy6V0Wy3/jR6CLL1/9F+rpDMQUmq7doSpcLNb7fDRL4++X3MgikVGPxzAOUnZ6LWvfcSMOP4wUPgnasz38z1jfD7jm39P+XBjodoKDr/kDW2X6DbcfHORJD+E/MZikKy3KEeUTcM9wWf23TUii/9p7RJUchh61UQz74TCd23Pl27wpyGX3hp9Ff6BA5Cms724iI6iFS8BvownaNEjjSOVRI8Lca42piTjhflTZSrRr4h
x-ms-office365-filtering-correlation-id: 25df7255-7f61-454c-7098-08d610d5140c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503BBCC1C1B21ABBC4627D6FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(966005)(478600001)(2616005)(72206003)(6512007)(53936002)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(6306002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7Mx2RMXr3cPOTRM8y8AA6kjYa7mHlsluAZEqoBYBfJau0urLgCXRmR512ylV2oKScXyak3i4PfWS7cHBmmDELPzBaA497xtOKHIlgOWnzuQMGkYxTveN6nI8NrWgzcbJsVeiz2dScbzlz2JO+NviPcDFes4VZ+f39UDXWZk38hE4/Sd1wzGLWj1BE0cWR49ZiFDNvsTd1A5TwsdEXsAQAKLBebN+qd1szSWR7KNMge7aV4TQqbnjMxLPUpshvzt979hfxXhppuoyC9ExMxFmpNUD/CqM+R6gd5qxU7Zm3NnVr2m770zv2gRJ3eU9qM51zm5d9jqpghCHpLw8EDKtFcmdT6xttksQv1KUTXi5MnY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df7255-7f61-454c-7098-08d610d5140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:18.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 10d255c3540239c7920f52d2eb223756e186af56 ]

If segment type in SSA and SIT is inconsistent, we will encounter below
BUG_ON during GC, to avoid this panic, let's just skip doing GC on such
segment.

The bug is triggered with image reported in below link:

https://bugzilla.kernel.org/show_bug.cgi?id=3D200223

[  388.060262] ------------[ cut here ]------------
[  388.060268] kernel BUG at /home/y00370721/git/devf2fs/gc.c:989!
[  388.061172] invalid opcode: 0000 [#1] SMP
[  388.061773] Modules linked in: f2fs(O) bluetooth ecdh_generic xt_tcpudp =
iptable_filter ip_tables x_tables lp ttm drm_kms_helper drm intel_rapl sb_e=
dac crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel fb_s=
ys_fops ppdev aes_x86_64 syscopyarea crypto_simd sysfillrect parport_pc joy=
dev sysimgblt glue_helper parport cryptd i2c_piix4 serio_raw mac_hid btrfs =
hid_generic usbhid hid raid6_pq psmouse pata_acpi floppy
[  388.064247] CPU: 7 PID: 4151 Comm: f2fs_gc-7:0 Tainted: G           O   =
 4.13.0-rc1+ #26
[  388.065306] Hardware name: Xen HVM domU, BIOS 4.1.2_115-900.260_ 11/06/2=
015
[  388.066058] task: ffff880201583b80 task.stack: ffffc90004d7c000
[  388.069948] RIP: 0010:do_garbage_collect+0xcc8/0xcd0 [f2fs]
[  388.070766] RSP: 0018:ffffc90004d7fc68 EFLAGS: 00010202
[  388.071783] RAX: ffff8801ed227000 RBX: 0000000000000001 RCX: ffffea0007b=
489c0
[  388.072700] RDX: ffff880000000000 RSI: 0000000000000001 RDI: ffffea0007b=
489c0
[  388.073607] RBP: ffffc90004d7fd58 R08: 0000000000000003 R09: ffffea0007b=
489dc
[  388.074619] R10: 0000000000000000 R11: 0052782ab317138d R12: 00000000000=
00018
[  388.075625] R13: 0000000000000018 R14: ffff880211ceb000 R15: ffff880211c=
eb000
[  388.076687] FS:  0000000000000000(0000) GS:ffff880214fc0000(0000) knlGS:=
0000000000000000
[  388.083277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  388.084536] CR2: 0000000000e18c60 CR3: 00000001ecf2e000 CR4: 00000000001=
406e0
[  388.085748] Call Trace:
[  388.086690]  ? find_next_bit+0xb/0x10
[  388.088091]  f2fs_gc+0x1a8/0x9d0 [f2fs]
[  388.088888]  ? lock_timer_base+0x7d/0xa0
[  388.090213]  ? try_to_del_timer_sync+0x44/0x60
[  388.091698]  gc_thread_func+0x342/0x4b0 [f2fs]
[  388.092892]  ? wait_woken+0x80/0x80
[  388.094098]  kthread+0x109/0x140
[  388.095010]  ? f2fs_gc+0x9d0/0x9d0 [f2fs]
[  388.096043]  ? kthread_park+0x60/0x60
[  388.097281]  ret_from_fork+0x25/0x30
[  388.098401] Code: ff ff 48 83 e8 01 48 89 44 24 58 e9 27 f8 ff ff 48 83 =
e8 01 e9 78 fc ff ff 48 8d 78 ff e9 17 fb ff ff 48 83 ef 01 e9 4d f4 ff ff =
<0f> 0b 66 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55
[  388.100864] RIP: do_garbage_collect+0xcc8/0xcd0 [f2fs] RSP: ffffc90004d7=
fc68
[  388.101810] ---[ end trace 81c73d6e6b7da61d ]---

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f2f897cd23c9..f22884418e92 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -958,7 +958,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi=
,
 			goto next;
=20
 		sum =3D page_address(sum_page);
-		f2fs_bug_on(sbi, type !=3D GET_SUM_TYPE((&sum->footer)));
+		if (type !=3D GET_SUM_TYPE((&sum->footer))) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent segment (%u) "
+				"type [%d, %d] in SSA and SIT",
+				segno, type, GET_SUM_TYPE((&sum->footer)));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto next;
+		}
=20
 		/*
 		 * this is to avoid deadlock:
--=20
2.17.1
