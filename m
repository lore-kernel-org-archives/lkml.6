Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88BD20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KGGWIkb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88BD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeIBRvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:51:04 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:39552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeIBRT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gydEDqR6uC7+PCz/h664VlSlLuApywBnfGisWRtlGE0=;
 b=KGGWIkb1k2D5AdHKGYc8E0kdz74BvQABVQ9Gkzz0hAoR2l/aiiGqKI4AHyvBvI/7H7bcx8bjhOMluKPCugdNZUmDZKSrU/s0SsS3llwqIJ10CPg62MgSSvv0oGlFuBtN7aaKFcP6yXnmEy3cBKskRnYHvRaeCvRqnjY71DBnfU4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunlong Song <yunlong.song@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 040/131] f2fs: issue discard align to section in
 LFS mode
Thread-Topic: [PATCH AUTOSEL 4.18 040/131] f2fs: issue discard align to
 section in LFS mode
Thread-Index: AQHUQr1loxtRh3HyFU6G0RMpn7HaZg==
Date:   Sun, 2 Sep 2018 13:03:51 +0000
Message-ID: <20180902064601.183036-40-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:vTWAd+DU8Vp+QkZM8nR+otpxA/6P1WMS2FVdqVQHWvvSTPytchi3RpdWIRRpRawXnrf0fLMOq2Egt8RPWzTe3QY2tv8g8p2eCH3b90KJPK+Zyu8Znva0Dq38kYMmJ2l5UmMzjdVwwg7NfyKA4Zb3D0Catpm0OxKHQ2k/zBVM+8bznD9Dt+s85Z8jVvyGZieEEsSP2Bg9k3GOMT6aGvADEPZAPw1cdjPEeZXh3KR4PKUVzxEEk5Sd8meBEfSWldea4jZD2awRmycOyQZrQuCELLKpSr2THZeFLUNIANdfAKcgdSAmpAaB/LMBOeWJ0P1NfjrS0jy694I/ms+WWQH9Mo6hoOTA+evQfpF+H2TK8dz3xAz79kXo8SzqCt18XAF/qhSSb3DrKLzWfH8MTXQ4MjTK5RwqrgK1D4T6wRxmwGFjEdDoOof2+Tq6aeEEYK1lNyWm5DkLEkRUQPhUFYfCGw==;5:45afhhJXAi9JHsZjSJggoJU9PAZVKwWczL4DdFxLmaalImeFV1LD59E57fx5gxB9zPQ3ZHMNqn+dQfRJp7NwRmqueWj7oA62xPZT2IoltourkUe/bo4InWVlNPR4aGj1bltExD4in5kgpHuKSI0CS2ywLt55yv3sA4BrJSUtgTI=;7:JA6fV+QzocP7sNqbb9IFw+r/y7VWQ09qmzFLPNKp9g80MHEsj6OJfCY/vfeG5Jd8Lawlq3VCpkVse4eEDgQYuqvfk6eudowd35CX39q8D2l8Ed/8CfQzFYW6C2Rzk7RtYpnmw9Mkk7v+RhGmu9T2pqCct6wNGhyrGr1B71zW8vFPpCu9qWp6pgkyVqupSWrDhNC5hreL0lhEGk7Ntck91Vobtf+uQaToRp8injFfuhnCQe8Oy8qTOOKB8bxf1Nf5
x-ms-office365-filtering-correlation-id: 5751436b-b87e-4581-b94b-08d610d49304
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135B0BFBCF09BCFD93899B0FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xwLMm9wC+tr67uSgvZgEh3znRTK7BX8jscIyK55Y0VLSqKfEoMH+5+3S9WyQhaoVUi2PiGvjVXt4w2MvEuupdJxIOVCafb0q7dRFSuwhQfY9RynBulvCDDkTB0C+BpR5l6HdYDTzg6MN6/LzvS3lpPbjjKeU+NhkDRVxe+Bs9flZOTYYt3xuKO0pNgs64i6WALaJljPP14LexUDt80WdDgrM5tnd2W+oU1z6EBRWX8PKkYSTuYhoNnusDAZLf8ttSeWmEmgaMCuOEjMZqtAw1JIE2LGTk8OQySc6Er3l/ffxqIPA+7w9+sn7OLVdFjEpbhF8cJqcgPB0LTwEIrxKUijcVl8Xw26OkwR2T+c55p4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5751436b-b87e-4581-b94b-08d610d49304
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:51.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit ad6672bbc527727dc8968e8d92687f55ae928ce5 ]

For the case when sbi->segs_per_sec > 1 with lfs mode, take
section:segment =3D 5 for example, if the section prefree_map is
...previous section | current section (1 1 0 1 1) | next section...,
then the start =3D x, end =3D x + 1, after start =3D start_segno +
sbi->segs_per_sec, start =3D x + 5, then it will skip x + 3 and x + 4, but
their bitmap is still set, which will cause duplicated
f2fs_issue_discard of this same section in the next write_checkpoint:

round 1: section bitmap : 1 1 1 1 1, all valid, prefree_map: 0 0 0 0 0
then rm data block NO.2, block NO.2 becomes invalid, prefree_map: 0 0 1 0 0
write_checkpoint: section bitmap: 1 1 0 1 1, prefree_map: 0 0 0 0 0,
prefree of NO.2 is cleared, and no discard issued

round 2: rm data block NO.0, NO.1, NO.3, NO.4
all invalid, but prefree bit of NO.2 is set and cleared in round 1, then
prefree_map: 1 1 0 1 1
write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1, no
valid blocks of this section, so discard issued, but this time prefree
bit of NO.3 and NO.4 is skipped due to start =3D start_segno + sbi->segs_pe=
r_sec;

round 3:
write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1 ->
0 0 0 0 0, no valid blocks of this section, so discard issued,
this time prefree bit of NO.3 and NO.4 is cleared, but the discard of
this section is sent again...

To fix this problem, we can align the start and end value to section
boundary for fstrim and real-time discard operation, and decide to issue
discard only when the whole section is invalid, which can issue discard
aligned to section size as much as possible and avoid redundant discard.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/segment.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9efce174c51a..43fecd5eb252 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1643,21 +1643,30 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_inf=
o *sbi,
 	unsigned int start =3D 0, end =3D -1;
 	unsigned int secno, start_segno;
 	bool force =3D (cpc->reason & CP_DISCARD);
+	bool need_align =3D test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
=20
 	mutex_lock(&dirty_i->seglist_lock);
=20
 	while (1) {
 		int i;
+
+		if (need_align && end !=3D -1)
+			end--;
 		start =3D find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
 		if (start >=3D MAIN_SEGS(sbi))
 			break;
 		end =3D find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
 								start + 1);
=20
-		for (i =3D start; i < end; i++)
-			clear_bit(i, prefree_map);
+		if (need_align) {
+			start =3D rounddown(start, sbi->segs_per_sec);
+			end =3D roundup(end, sbi->segs_per_sec);
+		}
=20
-		dirty_i->nr_dirty[PRE] -=3D end - start;
+		for (i =3D start; i < end; i++) {
+			if (test_and_clear_bit(i, prefree_map))
+				dirty_i->nr_dirty[PRE]--;
+		}
=20
 		if (!test_opt(sbi, DISCARD))
 			continue;
@@ -2437,6 +2446,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fst=
rim_range *range)
 	struct discard_policy dpolicy;
 	unsigned long long trimmed =3D 0;
 	int err =3D 0;
+	bool need_align =3D test_opt(sbi, LFS) && sbi->segs_per_sec > 1;
=20
 	if (start >=3D MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -2454,6 +2464,10 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fs=
trim_range *range)
 	start_segno =3D (start <=3D MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start=
);
 	end_segno =3D (end >=3D MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
+	if (need_align) {
+		start_segno =3D rounddown(start_segno, sbi->segs_per_sec);
+		end_segno =3D roundup(end_segno + 1, sbi->segs_per_sec) - 1;
+	}
=20
 	cpc.reason =3D CP_DISCARD;
 	cpc.trim_minlen =3D max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
--=20
2.17.1
