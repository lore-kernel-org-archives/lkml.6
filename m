Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76EEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761D92077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QOcqkNC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761D92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIBRrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:35 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728365AbeIBRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrN5XQxrc20y+6to7hED/qTn+AJqoPBqB141r1Hk+u8=;
 b=QOcqkNC1SbQYTcjQvNxTfmk3x0yqyK5IBHXVkf+1LPjV6w5/vioDqVt7i0PbB1z3hDmjfo49beM89tjf6L/mh8RQRrjCoZ5IvCPEu6Xvwvja4SKng+iHU+eRLji9eHFIjuldu/1DkN2FaK5vD5dmcY2pNJwzLgQCJwKWAu4xasU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 086/131] f2fs: fix to do sanity check with
 reserved blkaddr of inline inode
Thread-Topic: [PATCH AUTOSEL 4.18 086/131] f2fs: fix to do sanity check with
 reserved blkaddr of inline inode
Thread-Index: AQHUQr2KjyEYH0pckEmf0SoqbfPQTA==
Date:   Sun, 2 Sep 2018 13:04:53 +0000
Message-ID: <20180902064601.183036-86-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:eyxsrXyPSmH6zptliRLpFB5x7boX0WQhw/rDBcnKExBq3ZxtXodlyNb9OI38WfkRmG40OFHk3tbCcoUM1QY4Mz1zPEhDJGKwFf7lYgCffEd6vd8NJ9Jf7iLMX8XedDyLD5+mrDlMB9u6f2/7EPNxZ51dkkUcIhs2R6YwYSuCApHPwptjWZMShmgFyF1cJYRtgIKceyZV3I7/s7DcIKi7s1GvAw5zShlNwKcJKx+iRGuQow2/CVClf+MF9lM+JeVA5xrBKg/bpeYod5bp99SQiVuuHMJ6oe+fA6VyTryV1bCa+hrhjurUkyiCPBQpr6toL3TYLk1ZUkB2ClBJI+/xKmAYT/NUnlkQnPhx/wix0fpTCe18J9wh28sSpC5dvPWXet0ZnKycHfxTR5pHcyuWXgwEXelEyRwAgTDzUKBjet2kKIWP51JKfNRUv5Y9YrNdp9f1jjh6wge0/Nlg5qYYSA==;5:evsEvyy4MBvIWhSDPBHDqyKG/Zv7FbhbogOMRAz8hzhQVvoBuPoMK3Hpcl8jVQQ58wDCQt3ezsCeloM7ldtzfro0PzW46SMfrNbnNmkkbfIUvODmgfUF3dLS/yD9nJmC+TP+AhLjzr34LFqzWG7tFcWz2mBWpeKh737AXwnWwIQ=;7:L+sdxXiy2dCxgQK2CB+SR+s4BVUesF30PhO8jINceAl+J6+L7qPP2OIMgvVD1UNsbojxdbJrBehM+STi0CSJ057iub2FOM0J69ZZz79l6HXlTPELFOiRv/UIiQIj/Tu3ZJQarj+L5NRKHcULGsgmVAt2FT/CD2zhy3SbG1eu2BqMmWN/0lPwJpXb8Uzd4RzdhNb6+js3sjqOvUxr2d5p0lE/jWfGcu+dKTfdLVDVn42PAQFShpkqG+GxRn9E37C2
x-ms-office365-filtering-correlation-id: cd41f362-4091-4e84-263d-08d610d4afe5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741D8859662CF9AC716CC52FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(108815179253565)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(6306002)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(966005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uY2KCRCUr0XR5xcoUNn5umVXhq6y+nY8DzjMSl2y608ajv6cKHf4yOtsek5OsbFKo3+wUSfmRduAeNI+eGeKNJRRjNXHurrM8T7sfFC0M6WLAFSLddahVfpzfrr2TXM02+36DZ79EgIHXuGn2R17dyOrnIhVoSZElW5sM8pRhVK5PHgQDJjhEDp99fbql6rAo0PP+LLwNy3NdVkbNpE6v/kSSKYUDPuAymP58vtSSuu3H3wWEE+Y0dVzTGe2a4XaFYvkSC+8UbK8nKT2jIw47VGlFslYyM9azNP4ABqO2SsRAM4KqRSGsbR0miP1fr/4bDDGeOK29snoMYqMpCdIDvcNPO7KltZQ0KAlq8EZywI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd41f362-4091-4e84-263d-08d610d4afe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:53.3098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4dbe38dc386910c668c75ae616b99b823b59f3eb ]

As Wen Xu reported in bugzilla, after image was injected with random data
by fuzzing, inline inode would contain invalid reserved blkaddr, then
during inline conversion, we will encounter illegal memory accessing
reported by KASAN, the root cause of this is when writing out converted
inline page, we will use invalid reserved blkaddr to update sit bitmap,
result in accessing memory beyond sit bitmap boundary.

In order to fix this issue, let's do sanity check with reserved block
address of inline inode to avoid above condition.

https://bugzilla.kernel.org/show_bug.cgi?id=3D200179

[ 1428.846352] BUG: KASAN: use-after-free in update_sit_entry+0x80/0x7f0
[ 1428.846618] Read of size 4 at addr ffff880194483540 by task a.out/2741

[ 1428.846855] CPU: 0 PID: 2741 Comm: a.out Tainted: G        W         4.1=
7.0+ #1
[ 1428.846858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1428.846860] Call Trace:
[ 1428.846868]  dump_stack+0x71/0xab
[ 1428.846875]  print_address_description+0x6b/0x290
[ 1428.846881]  kasan_report+0x28e/0x390
[ 1428.846888]  ? update_sit_entry+0x80/0x7f0
[ 1428.846898]  update_sit_entry+0x80/0x7f0
[ 1428.846906]  f2fs_allocate_data_block+0x6db/0xc70
[ 1428.846914]  ? f2fs_get_node_info+0x14f/0x590
[ 1428.846920]  do_write_page+0xc8/0x150
[ 1428.846928]  f2fs_outplace_write_data+0xfe/0x210
[ 1428.846935]  ? f2fs_do_write_node_page+0x170/0x170
[ 1428.846941]  ? radix_tree_tag_clear+0xff/0x130
[ 1428.846946]  ? __mod_node_page_state+0x22/0xa0
[ 1428.846951]  ? inc_zone_page_state+0x54/0x100
[ 1428.846956]  ? __test_set_page_writeback+0x336/0x5d0
[ 1428.846964]  f2fs_convert_inline_page+0x407/0x6d0
[ 1428.846971]  ? f2fs_read_inline_data+0x3b0/0x3b0
[ 1428.846978]  ? __get_node_page+0x335/0x6b0
[ 1428.846987]  f2fs_convert_inline_inode+0x41b/0x500
[ 1428.846994]  ? f2fs_convert_inline_page+0x6d0/0x6d0
[ 1428.847000]  ? kasan_unpoison_shadow+0x31/0x40
[ 1428.847005]  ? kasan_kmalloc+0xa6/0xd0
[ 1428.847024]  f2fs_file_mmap+0x79/0xc0
[ 1428.847029]  mmap_region+0x58b/0x880
[ 1428.847037]  ? arch_get_unmapped_area+0x370/0x370
[ 1428.847042]  do_mmap+0x55b/0x7a0
[ 1428.847048]  vm_mmap_pgoff+0x16f/0x1c0
[ 1428.847055]  ? vma_is_stack_for_current+0x50/0x50
[ 1428.847062]  ? __fsnotify_update_child_dentry_flags.part.1+0x160/0x160
[ 1428.847068]  ? do_sys_open+0x206/0x2a0
[ 1428.847073]  ? __fget+0xb4/0x100
[ 1428.847079]  ksys_mmap_pgoff+0x278/0x360
[ 1428.847085]  ? find_mergeable_anon_vma+0x50/0x50
[ 1428.847091]  do_syscall_64+0x73/0x160
[ 1428.847098]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1428.847102] RIP: 0033:0x7fb1430766ba
[ 1428.847103] Code: 89 f5 41 54 49 89 fc 55 53 74 35 49 63 e8 48 63 da 4d =
89 f9 49 89 e8 4d 63 d6 48 89 da 4c 89 ee 4c 89 e7 b8 09 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 56 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 00
[ 1428.847162] RSP: 002b:00007ffc651d9388 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000009
[ 1428.847167] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fb1430=
766ba
[ 1428.847170] RDX: 0000000000000001 RSI: 0000000000001000 RDI: 00000000000=
00000
[ 1428.847173] RBP: 0000000000000003 R08: 0000000000000003 R09: 00000000000=
00000
[ 1428.847176] R10: 0000000000008002 R11: 0000000000000246 R12: 00000000000=
00000
[ 1428.847179] R13: 0000000000001000 R14: 0000000000008002 R15: 00000000000=
00000

[ 1428.847252] Allocated by task 2683:
[ 1428.847372]  kasan_kmalloc+0xa6/0xd0
[ 1428.847380]  kmem_cache_alloc+0xc8/0x1e0
[ 1428.847385]  getname_flags+0x73/0x2b0
[ 1428.847390]  user_path_at_empty+0x1d/0x40
[ 1428.847395]  vfs_statx+0xc1/0x150
[ 1428.847401]  __do_sys_newlstat+0x7e/0xd0
[ 1428.847405]  do_syscall_64+0x73/0x160
[ 1428.847411]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 1428.847466] Freed by task 2683:
[ 1428.847566]  __kasan_slab_free+0x137/0x190
[ 1428.847571]  kmem_cache_free+0x85/0x1e0
[ 1428.847575]  filename_lookup+0x191/0x280
[ 1428.847580]  vfs_statx+0xc1/0x150
[ 1428.847585]  __do_sys_newlstat+0x7e/0xd0
[ 1428.847590]  do_syscall_64+0x73/0x160
[ 1428.847596]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 1428.847648] The buggy address belongs to the object at ffff880194483300
                which belongs to the cache names_cache of size 4096
[ 1428.847946] The buggy address is located 576 bytes inside of
                4096-byte region [ffff880194483300, ffff880194484300)
[ 1428.848234] The buggy address belongs to the page:
[ 1428.848366] page:ffffea0006512000 count:1 mapcount:0 mapping:ffff8801f35=
86380 index:0x0 compound_mapcount: 0
[ 1428.848606] flags: 0x17fff8000008100(slab|head)
[ 1428.848737] raw: 017fff8000008100 dead000000000100 dead000000000200 ffff=
8801f3586380
[ 1428.848931] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000=
000000000000
[ 1428.849122] page dumped because: kasan: bad access detected

[ 1428.849305] Memory state around the buggy address:
[ 1428.849436]  ffff880194483400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.849620]  ffff880194483480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.849804] >ffff880194483500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.849985]                                            ^
[ 1428.850120]  ffff880194483580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.850303]  ffff880194483600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.850498] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/inline.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 043830be5662..f882de2ede95 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -130,6 +130,16 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn,=
 struct page *page)
 	if (err)
 		return err;
=20
+	if (unlikely(dn->data_blkaddr !=3D NEW_ADDR)) {
+		f2fs_put_dnode(dn);
+		set_sbi_flag(fio.sbi, SBI_NEED_FSCK);
+		f2fs_msg(fio.sbi->sb, KERN_WARNING,
+			"%s: corrupted inline inode ino=3D%lx, i_addr[0]:0x%x, "
+			"run fsck to fix.",
+			__func__, dn->inode->i_ino, dn->data_blkaddr);
+		return -EINVAL;
+	}
+
 	f2fs_bug_on(F2FS_P_SB(page), PageWriteback(page));
=20
 	f2fs_do_read_inline_data(page, dn->inode_page);
@@ -363,6 +373,17 @@ static int f2fs_move_inline_dirents(struct inode *dir,=
 struct page *ipage,
 	if (err)
 		goto out;
=20
+	if (unlikely(dn.data_blkaddr !=3D NEW_ADDR)) {
+		f2fs_put_dnode(&dn);
+		set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
+		f2fs_msg(F2FS_P_SB(page)->sb, KERN_WARNING,
+			"%s: corrupted inline inode ino=3D%lx, i_addr[0]:0x%x, "
+			"run fsck to fix.",
+			__func__, dir->i_ino, dn.data_blkaddr);
+		err =3D -EINVAL;
+		goto out;
+	}
+
 	f2fs_wait_on_page_writeback(page, DATA, true);
=20
 	dentry_blk =3D page_address(page);
--=20
2.17.1
