Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EDCECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45851208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bzwUg/JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45851208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeIOGr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:56 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbeIOGrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86rPxjMjXXUxjZ2cfHTd8YJTtrAKXzTVaQ6sAIBq0fE=;
 b=bzwUg/JD6P6eEf8k4mdO20qPfztmucTgZfT9UgXNRpUrYoHxK6oJiSCG6nQH9jZXqj6yyNYSO8mWatrA26dAwpcPDiu+M2K2C736YamlZjK3gF/x0Pt9rJ8VcXc69Fh1csnxHGeozKxD8m2nrcyq3oRl+1F/gg8/TjvlYoSWxiM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 50/92] f2fs: do checkpoint in kill_sb
Thread-Topic: [PATCH AUTOSEL 4.18 50/92] f2fs: do checkpoint in kill_sb
Thread-Index: AQHUTJOsYDYjXi5lxU+Hr0m6vJKOPA==
Date:   Sat, 15 Sep 2018 01:30:24 +0000
Message-ID: <20180915012944.179481-49-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:ciy4wtYKYx+G0UJLSgXlNBw9sspd60/9Dw9aUETVX6SEYKPU+rPffya+Yb1eZT+8Uh3oVKxe1ctE2H/EWuN0vC4Dcmx1BLSq7/aB8Odg1bZEeSbezc7OlSOuNsWcXIZ7Qa48P+ig4Y8eOxRhAO2SFlLn8dGFGimTthW/ROX51/Dn3keWgEtaSHI9aNIe6YBHEashDfsPEEyQTuqHiP1yZQxxRWQNDsCLl8UVrM3vTs/ObgSBZqEKTRX5DVUmaipqoD+AisUqavuKaspus9x4kb0j7OMXrLtRPS4BCH81ZtJ590gX57owzPOfNLBW5l2V7mByfYPVFSoPwAkmdajc+7tK18DzSNoZRsmAVCUJqO+AkGsGu86IT8e68EhM7qqyqUesP982OjlnmZYzxrm+gH/CKLIb0cI0XPccdT2aZBAEOuLr7jsz/V/gqJCkJQ1xCw8tIyR4JcgvSUURCc0hAw==;5:HoCeNyAaOd3CjMXmP600+y/adtA17j9Uy+Y+b4bPYA9zJm0PwCv60g12tAg3xMdgR/jyBzOKjeAMCerbW/UnwBbirMrUP/SXOSwxYAFk3IcZPPB1tWq496vpf/cgIVSQ80sZCGhYTmDduRh394oRgVEgc+aga33B/xhofDZu8Zg=;7:NIgM2ORsr3ZYS/EimRV6Gm1MCWdUSWDiI65qAHn8UCiuNLwm+pFdvJJmx3k4XYyHwJIrMw+PKatwKH01HNUaMN2Y3k+6weoLrocmRdjWuYU3QpZHly4q41UNo7VB2K5S9B3fcy5coTA9qNywxZcHiSxBZM42dISgM0HscIq+3ZsmNt8QkLsFAPGADgLbO5tU6sIuEiaY9Yz69jgYXBgNaLYJg8ggQi4wcZaFhOTol704x28nZQmD3XJqLiAEJPOQ
x-ms-office365-filtering-correlation-id: a7a795b4-2980-4d14-9a13-08d61aaadeef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB08564D23F62A50866ADB89CCFB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: T11oToNoXcDJEKCIP3dZMbG29m3rJaxiwSwOa/6iXuCqq8AcTydWgsJPneZjuxEc9K3cupsi5t2yN/S9/BtILr6D7txEpKBNM005zXhBC6u3cj0aHuxpRl9KEEuOOgguNvLigUBUacVcclOZY5Wfb8KseUvyCIIMqwtCrVYbQjihXyRBxXmSvgbbxXcwLjF9PrNa+OefZtvVCocuzoRk/jYeOhL+RS0X3uuSlU74mIzv99iI3skZNy5NHpHOPk+1052D6d5NBj48dLh4VPflyXjuTb6Yp4RZRs807dpxQDeWG7jftP+m+QniLfcqqgpbnAV7knJC/lb+8d9xMi5+t7YDvDwJ+DhV9JEbnpA4+vw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a795b4-2980-4d14-9a13-08d61aaadeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:24.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 1cb50f87e10696e8cc61fb62d0d948e11b0e6dc1 ]

When unmounting f2fs in force mode, we can get it stuck by io_schedule()
by some pending IOs in meta_inode.

io_schedule+0xd/0x30
wait_on_page_bit_common+0xc6/0x130
__filemap_fdatawait_range+0xbd/0x100
filemap_fdatawait_keep_errors+0x15/0x40
sync_inodes_sb+0x1cf/0x240
sync_filesystem+0x52/0x90
generic_shutdown_super+0x1d/0x110
kill_f2fs_super+0x28/0x80 [f2fs]
deactivate_locked_super+0x35/0x60
cleanup_mnt+0x36/0x70
task_work_run+0x79/0xa0
exit_to_usermode_loop+0x62/0x70
do_syscall_64+0xdb/0xf0
entry_SYSCALL_64_after_hwframe+0x44/0xa9
0xffffffffffffffff

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/super.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e926ba3a..1dc6809fac38 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3089,9 +3089,19 @@ static struct dentry *f2fs_mount(struct file_system_=
type *fs_type, int flags,
 static void kill_f2fs_super(struct super_block *sb)
 {
 	if (sb->s_root) {
-		set_sbi_flag(F2FS_SB(sb), SBI_IS_CLOSE);
-		f2fs_stop_gc_thread(F2FS_SB(sb));
-		f2fs_stop_discard_thread(F2FS_SB(sb));
+		struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
+
+		set_sbi_flag(sbi, SBI_IS_CLOSE);
+		f2fs_stop_gc_thread(sbi);
+		f2fs_stop_discard_thread(sbi);
+
+		if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
+				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+			struct cp_control cpc =3D {
+				.reason =3D CP_UMOUNT,
+			};
+			f2fs_write_checkpoint(sbi, &cpc);
+		}
 	}
 	kill_block_super(sb);
 }
--=20
2.17.1
