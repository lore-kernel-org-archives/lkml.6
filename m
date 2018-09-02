Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B88C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EAF2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AmkPDVH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EAF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeIBRsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:48:15 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:63944
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728280AbeIBRUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L404+KQ8nRscLk63EdGfMoTmIYBRM8PNY2LO31lM51k=;
 b=AmkPDVH92glB1gMLylp/LIqej3BnjYsH92LeqxcPT1Leo9Eo8qCqIJZ6T3x2AHhevOX8LQQcRHTYd0AC+XR1S4atKrsvA0d15SFUx2+DUEa9+f4dDg/H+J4/Urb4MCJf9va6S23717BkTyZmN02mB9+hKMX5ebRCGeWx1BHpX6Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 083/131] f2fs: fix to skip GC if type in SSA and
 SIT is inconsistent
Thread-Topic: [PATCH AUTOSEL 4.18 083/131] f2fs: fix to skip GC if type in SSA
 and SIT is inconsistent
Thread-Index: AQHUQr2Hqx581D5JFU+WdgpLAagUGg==
Date:   Sun, 2 Sep 2018 13:04:48 +0000
Message-ID: <20180902064601.183036-83-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:3FglhL8Yy3ae/wENqzrj/MECJYkQ0nvIuera/E052r9ViLU5VUVsoEklQOWr3owW3wXDV6SS4ItAkD4Hgt7EWz4KKluXuga5Q7q51QND9pqEJb9ISj/q+QJn4H/dfjzxwB9ccuDocHIL13SFU5/FOu3P/qDp4Vk2USUeCMjptmWE9yzIr6S5iXJWm2kRNt4hN2SAMBmeC6iMYszN6xkxheS4Aorq/GB0iUA2xAFqbfojDOi11CrCaxBGxT2jI7s2O5Pj1+1cuRGkcvWZl+vG4HW1QJBNpDlKQR5QGpTyw9hO3kyc4BBNj7z4afZwIbJh/OxG69EmseoSDUxNwuVEtuO7kJhDcZgg+BOrwV+LY/m7xWlljtDJWBxXrHrRgR59wb6i3b76/0ndH/yU00yX6iivL0NVmQpgNZIeEwwU/2Za9Zuy7bwX1eUIMJl00YSql9X2qG4E0W3nlEbHjblvjA==;5:rje0i63e/pEsxXnV/y4DtwZ1Z1+d/L3V67aQ5OSVm4/ju+cybDRO/VBd4kOfPmXlekQFpl/BBNo4x2DKff0dVaW7lt5PgUBn+7zKyixlvEWO/fvqdzy1WR14gqHMdQUgMrzj9rSPo6/dSp0MYvvNulk3IlVhdMUf1K7PVIP5dq8=;7:esKRVCtpOA6VA14ZVwzsYSCxDBHTSRiyDDcmSt5muJbiE2ubVsZFyT4KiigS98OsboxFwN1h0H759mRzPghtazuZZQgpUp5j4WkehJalb9ATWuoA0EwpbflqcNJCNbavejj3t+3P0rkFmeco00yB3hf5FO9BH+JhaoGNKuPR8X3qyLIiLwF9EuZ8+u8HlxYkMQjNYcWqcjtZ3HOq/U6vwtCN8NU9WmtB/kojIOZvRwice3KNJP9pN0TXiTvB8vhX
x-ms-office365-filtering-correlation-id: 3a8b0d4a-a22f-48af-7a53-08d610d4af27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074177BE193BCA7A20D3DA57FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EircwxFs9DO5gv+U6SsbzqM8igqyzQLmDRaOSA5ABHEmmceIQiDlfI5n32J9BR3WNomug+xioePo3tJ7QSRChbpcKMdkqZcoThkLEoWwLT+qvR4nR/5HOvs4PRwFYynB1Vt+19wLPrAa4L/D5wQzHo2AU0r2uehEATes6uIUB2EKJRqUpaPLCMUh/L3aXRgA3aYAv7wfxOI3iYztJHv9PTN/VRiebgUabRT57F4kaaF1bUbG81c7Lc+o4ctRZ55v3H863n3NDDgnZMnahOmtPBiHTnD16SQAmrKlZZZg8sRbnAYGD3xKX5LqbSpa0aNFc9JJn0Kxd2vgdPS2CnjONKizY37KdNF0J0DmJsdk9aw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8b0d4a-a22f-48af-7a53-08d610d4af27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:48.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index 9093be6e7a7d..37ab2d10a872 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -986,7 +986,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi=
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
