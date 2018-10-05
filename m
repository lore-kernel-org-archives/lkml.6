Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165BFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703D12084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ZV/1fEZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703D12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJERO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:14:59 -0400
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:26160
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727535AbeJERO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHGEbYAjVMiwN6sCUiB8FRohesyt4CSmrbsQElNpklU=;
 b=ZV/1fEZoSKN7sEAKW34bRacdg09BOSRS3kIESj9twlNXg4U9Yt1Ki/+Um5I5icnPHf345B0TUpgEXPCqqDSXHWqCC7pYD8IiK3pCL5q0T9lKzU2K3OXkALve13a80kdNTxT3k+07CEHyLcFF1PCjjcxgzSrjdLhnsE7oiBA9Zmw=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB4872.namprd07.prod.outlook.com (52.135.205.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 10:16:36 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::8057:24ac:d594:6f3d]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::8057:24ac:d594:6f3d%5]) with mapi id 15.20.1207.021; Fri, 5 Oct 2018
 10:16:36 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: KASAN: use-after-scope in ext4_group_desc_csum
Thread-Topic: KASAN: use-after-scope in ext4_group_desc_csum
Thread-Index: AQHUXJR/cP5Refn5uUq4/pFkL4/NFg==
Date:   Fri, 5 Oct 2018 10:16:36 +0000
Message-ID: <20181005101629.GA21469@hc>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.49.35.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4872;6:yPQLYjswWhneBLABoD4h3FOGAef18qo9+SCSSfJPXR4EZz8q0g9powAwU6hAkmBLa0/14PE1dFdB4vGMxTpZKne9OrA8/M0xYkm1Yqk9g7G/ipTsEx0EcjmM35TPWYHO9MF70D7BDv/BqH7FyuLNwDwbJjGtqCTGtuwMGoUsezjrvSwrrL4Q9kTif1kRoNTv55AzTDPQBNyDhwSn50CQrpA7Bqoy649Nei0QG1Xq9472FFz6ZAeQGanFXlI6KwaHpqQJzZGt+EKqsQ9W9JLCuQz95SHSR/k5SqykDUDuRMkXm+P/OcssWTwrWvM74OBaj8lnk7jGxTAZ7qhMgMHoOTpR83w38q0x2mSBQPPFNasYUcwMIWAb4/NdZPWswYeQQH5V7pNVFKHdeC7vfL7SqsHtNHaitQBBRkmQmt+pTCHnReaz3iNTZnSlCvAw9Frp7q+G6CZQ/snvo4DmogirbQ==;5:+XdeoUtuuZSnF8qw7j5fl+mUILzszWt+HeR812Z37T9um29hHskev28hdoBEexUQP5E1lRuknAsD4GJg0/uPfYgM3Fs2RRkUMWbFdFh+n5KSRTAbpcuW6RNAmMt+J4w/F72kOotJWCESViFr6gYewbEZVVG9q0xO0nDtPb1BdM4=;7:P3yCOnDrBiYg6cQWBYmAUjKp7ntvkIbCsWqOpzNMthcxBmybjKw45w1McUy00BL5uSiMMAiW1bZJtAh/wq6jSI5nln8OZcsDeEy11I0HrhjRaMQKNC4CzvB/HuoYOlO7lrZxFfp3oVK9XNlUGpeGku3L32ipm6gOjxpwyj12pUfuMCivSMApjZdQVSp/DVnGhEyZu8SApuLWVYPCc5o4n7VL+5RseGB0pS0Hd1TwtAQvkF8QjyXyqofttXG/IF87
x-ms-office365-filtering-correlation-id: 700c9e28-4169-422b-5382-08d62aaba19f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4872;
x-ms-traffictypediagnostic: BYAPR07MB4872:
x-microsoft-antispam-prvs: <BYAPR07MB48720B4B0493F3EB9904A18891EB0@BYAPR07MB4872.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:BYAPR07MB4872;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4872;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(386003)(102836004)(256004)(14444005)(26005)(6506007)(44832011)(4326008)(25786009)(33656002)(53936002)(6512007)(9686003)(186003)(486006)(14454004)(2171002)(2900100001)(6436002)(476003)(478600001)(68736007)(6486002)(105586002)(106356001)(72206003)(5250100002)(33716001)(110136005)(54906003)(52116002)(71190400001)(15760500003)(71200400001)(7736002)(316002)(305945005)(5660300001)(97736004)(8936002)(8676002)(81166006)(81156014)(33896004)(1076002)(86362001)(6116002)(575784001)(3846002)(66066001)(99286004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4872;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rE1pAD6UrJLnE/0xK/5HJpFx0jNBodNGnhArt1g8nlFAAMPK32L/V7/qBGAUfZDnBf6UW5pDOuNroZh3F1ps5Fa0adwmRm8mcbeZ+tLHchSeVsH1Rx1PwDlccuMDckJT6nu4jLFlemXRSYIILF6/S7TYQmWHfx4rygTfN9D8nUC0dZu7o7dsaiOrbQTRljZYl5J+Y6E5nJHH6ELKTK0LvIc3lT3Wvh+mkraAbbErDGTW52Br6PtYP2ut7yq+vH5F8cmV/OI4nTDV9dJUyDHi0NlWDwQ0AeIHueKn+r/b8wf7zfxH34HeCPZMxt2vFAhuwiOlocOQdcY0l+ThicUdRUJIyE+YRQLQyEH1RKgsRHU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E63CAA46ED95514C9EE9A3CF338A4964@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700c9e28-4169-422b-5382-08d62aaba19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 10:16:36.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting below warning when I enable CONFIG_KASAN_EXTRA=3Dy on a arm64 T=
hunderX2 system.
As far as I can tell this is present since KASAN_EXTRA was introduced (4.16=
).

[   64.547333] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   64.561933] BUG: KASAN: use-after-scope in ext4_es_lookup_extent+0x130/0=
x980
[   64.576105] Write of size 4 at addr ffff80222d81f0ec by task exe/4075

[   64.592044] CPU: 102 PID: 4075 Comm: exe Not tainted 4.19.0-rc6-jang+ #2=
9
[   64.605690] Hardware name: To be filled by O.E.M. Saber/To be filled by =
O.E.M., BIOS 0ACKL018 03/30/2018
[   64.624750] Call trace:
[   64.629666]  dump_backtrace+0x0/0x360
[   64.637024]  show_stack+0x24/0x30
[   64.643687]  dump_stack+0x12c/0x1b4
[   64.650699]  print_address_description+0x68/0x2c8
[   64.660152]  kasan_report+0x130/0x300
[   64.667509]  __asan_store4+0x84/0xa8
[   64.674693]  ext4_es_lookup_extent+0x130/0x980
[   64.683623]  ext4_map_blocks+0xe0/0x990
[   64.691330]  _ext4_get_block+0x130/0x2b8
[   64.699211]  ext4_get_block+0x40/0x50
[   64.706571]  generic_block_bmap+0x104/0x178
[   64.714977]  ext4_bmap+0xc4/0x198
[   64.721636]  bmap+0x54/0x70
[   64.727250]  jbd2_journal_init_inode+0x2c/0x208
[   64.736355]  ext4_fill_super+0x5080/0x5c90
[   64.744587]  mount_bdev+0x1e0/0x228
[   64.751597]  ext4_mount+0x44/0x58
[   64.758255]  mount_fs+0x58/0x1b8
[   64.764740]  vfs_kern_mount.part.2+0xc0/0x2a8
[   64.773495]  do_mount+0x7a8/0x13e8
[   64.780327]  ksys_mount+0x9c/0x110
[   64.787160]  __arm64_sys_mount+0x70/0x88
[   64.795043]  el0_svc_handler+0xac/0x150
[   64.802749]  el0_svc+0x8/0xc

[   64.811521] The buggy address belongs to the page:
[   64.821149] page:ffff7e0088b607c0 count:0 mapcount:0 mapping:00000000000=
00000 index:0x0
[   64.837249] flags: 0x1ffff00000000000()
[   64.844959] raw: 1ffff00000000000 ffff7e0088b607c8 ffff7e0088b607c8 0000=
000000000000
[   64.860527] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000=
000000000000
[   64.876093] page dumped because: kasan: bad access detected

[   64.890278] Memory state around the buggy address:
[   64.899907]  ffff80222d81ef80: f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2=
 f2 f2
[   64.914426]  ffff80222d81f000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   64.928945] >ffff80222d81f080: f8 f8 f8 f8 f8 f8 f1 f1 f1 f1 f8 f8 f8 f8=
 00 f2
[   64.943463]                                                           ^
[   64.956759]  ffff80222d81f100: f2 f2 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[   64.971278]  ffff80222d81f180: f8 f8 f8 f8 f1 f1 f1 f1 00 00 00 f2 f8 f8=
 f8 f8
[   64.985795] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   65.000312] Disabling lock debugging due to kernel taint
[   65.037509] EXT4-fs (sda2): mounted filesystem with ordered data mode. O=
pts: (null)

I'm not seeing any issues like filesystem corruption or misbehaviour that c=
ould be related
the warning.

Is this a false positive? Any thoughts?

--Jan
