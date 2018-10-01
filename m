Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266DFC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0642083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ctCi/AtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0642083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeJAHN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:27 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:27216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbeJAHNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDGtWSsz1uKwUJKbWsfaPdQnlXibaF+rVTyH8OtmPJk=;
 b=ctCi/AtETeH1myfBavWSMgw92t40KEv7bvFEAbnjFLCfN3CySZdvurqhNI+MTqoGi1sGYa8u2ZtogjRK/BXRKKQoquDcINenFBiVM21wSCMPKl+pxUTOTxlf/LgaoFnIPuyrEPNzTaUhEv3ill6lc0MoaOmCo9Pmr4pxu7Nc4P4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vincent Pelletier <plr.vincent@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 08/65] scsi: iscsi: target: Set conn->sess to
 NULL when iscsi_login_set_conn_values fails
Thread-Topic: [PATCH AUTOSEL 4.18 08/65] scsi: iscsi: target: Set conn->sess
 to NULL when iscsi_login_set_conn_values fails
Thread-Index: AQHUWR8FJ3vE9+f22UOxFpKpoOR/xQ==
Date:   Mon, 1 Oct 2018 00:38:07 +0000
Message-ID: <20181001003754.146961-8-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:8i6BWZxt5P+926LZX2JnqhdZ9W3/vwLhyAz3pP9QpWEIcgING4+L1vMBvkV1/vKpdua3esxaP+yMsVYGqzGZPHgv+LNIRL7znuJVzO8zw0g7lyvNmmxP962nBGU2w7DxP0fboLkL4mAaT5/4Y+O96zha9anLJHCYpFstz+ryilqgMecjggKwj4CblwDgGrN5Bwzg9q6LKxrS/DZIo74GT7syARJI7qQT/e3192R+ySy4uaEZ/g3K/ejJ8XcI6lf1uEZ7zm51j+tBfQ+qflUuyvUcg+EPQ0UJXVjYFSkuTWxG58r1MQ8Eh7g/5fTeTQNfrMPDKQ9fccsXDUdKB+qrfhIclqjlQBREbE/sPyVT7LAImU5DoIApYBqdcYKEeZzbcMG8gT/Kb52qmEPqdEM3tQmZagabi3LpbY21u7x1F1q3c7F1IQd91NcV9h7RdV/ndUUTNpIm0IhdwfjNMeLumg==;5:TTEFXDRJy6AZTG7fUPGVkSsxsa7SUdLbWGTbtXiF0fQX0NCMDQEKxSDlr4PsKyvw3CUpGok4DUfO1lvfNfbiloB7PRouICoPKWFvnIlM886DkcMVbPFLTaMXbxm4PYwjhcefFRB6B1bW7mLFNZm6O3qXASXrBVtMvh+x9Qh3DCI=;7:aCC575DW0YsdSyGlK4xohv+NOLLs+HyYaJH047na/Na3VeHvESJi1xz48eIwTegX2oHIVGdkDcoJKKZi6pFDU1Q8ymFq+RYAjz0rAxCb5708XliOwX+/CBhhB15wmHu3v/bwUfcp9iV7jlEzvm3QN+B0dNqCfBAq1wLXkK0K9dAVu8DI7s+1DFUrYxtR3xYzFD7uQb4hgqRQfr3XhWMrX5cgWPL1DYlSJ/O4zAm1WcI74l3+XZHxsDkaxQbhXB2d
x-ms-office365-filtering-correlation-id: 725408d0-76b0-4ecf-fdba-08d627362810
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469C6F389F1444EF421CF22FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(275809806118684)(17755550239193)(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(39060400002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P0m6NB5nrvq0qfEty/t4i0Gszp/zxO5tpbHQKKeMVLgOHPR2VQCxPCtx6ycfPHHZJ0ZIhsJjPz8fS5XIOUwiID8dorEKGcHAvWMWgmgyNolqRsu1rL7nL9RJAsZVVZLamQGCeEv3i7cjNtdbs5zxkVqaneiVl70Mu2p3Er/u7wcCCkPySDeOQZJmWYs6mqssSGy4gbblRAvbAfVEs/Kg68pvz8L9b9Uzz2aP1I9zzbuJHykMAprbfSzQpfFqIUf77mtIin9dE0MqqrU7FRSfTZW8nUvLQ/TJiE4MUvenvEVrq3R6rMeT7LBhp7V+DaapOlfG7PnCdTdskXkbBu9E/74aNhsSSZ0CfYg1eO+aTUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725408d0-76b0-4ecf-fdba-08d627362810
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:07.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Pelletier <plr.vincent@gmail.com>

[ Upstream commit 7915919bb94e12460c58e27c708472e6f85f6699 ]

Fixes a use-after-free reported by KASAN when later
iscsi_target_login_sess_out gets called and it tries to access
conn->sess->se_sess:

Disabling lock debugging due to kernel taint
iSCSI Login timeout on Network Portal [::]:3260
iSCSI Login negotiation failed.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in
iscsi_target_login_sess_out.cold.12+0x58/0xff [iscsi_target_mod]
Read of size 8 at addr ffff880109d070c8 by task iscsi_np/980

CPU: 1 PID: 980 Comm: iscsi_np Tainted: G           O
4.17.8kasan.sess.connops+ #4
Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB,
BIOS 5.6.5 05/19/2014
Call Trace:
 dump_stack+0x71/0xac
 print_address_description+0x65/0x22e
 ? iscsi_target_login_sess_out.cold.12+0x58/0xff [iscsi_target_mod]
 kasan_report.cold.6+0x241/0x2fd
 iscsi_target_login_sess_out.cold.12+0x58/0xff [iscsi_target_mod]
 iscsi_target_login_thread+0x1086/0x1710 [iscsi_target_mod]
 ? __sched_text_start+0x8/0x8
 ? iscsi_target_login_sess_out+0x250/0x250 [iscsi_target_mod]
 ? __kthread_parkme+0xcc/0x100
 ? parse_args.cold.14+0xd3/0xd3
 ? iscsi_target_login_sess_out+0x250/0x250 [iscsi_target_mod]
 kthread+0x1a0/0x1c0
 ? kthread_bind+0x30/0x30
 ret_from_fork+0x35/0x40

Allocated by task 980:
 kasan_kmalloc+0xbf/0xe0
 kmem_cache_alloc_trace+0x112/0x210
 iscsi_target_login_thread+0x816/0x1710 [iscsi_target_mod]
 kthread+0x1a0/0x1c0
 ret_from_fork+0x35/0x40

Freed by task 980:
 __kasan_slab_free+0x125/0x170
 kfree+0x90/0x1d0
 iscsi_target_login_thread+0x1577/0x1710 [iscsi_target_mod]
 kthread+0x1a0/0x1c0
 ret_from_fork+0x35/0x40

The buggy address belongs to the object at ffff880109d06f00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 456 bytes inside of
 512-byte region [ffff880109d06f00, ffff880109d07100)
The buggy address belongs to the page:
page:ffffea0004274180 count:1 mapcount:0 mapping:0000000000000000
index:0x0 compound_mapcount: 0
flags: 0x17fffc000008100(slab|head)
raw: 017fffc000008100 0000000000000000 0000000000000000 00000001000c000c
raw: dead000000000100 dead000000000200 ffff88011b002e00 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880109d06f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880109d07000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff880109d07080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff880109d07100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff880109d07180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
[rebased against idr/ida changes and to handle ret review comments from Mat=
thew]
Signed-off-by: Mike Christie <mchristi@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/iscsi/iscsi_target_login.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/isc=
si/iscsi_target_login.c
index 68b3eb00a9d0..c8bc99727e85 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -310,11 +310,9 @@ static int iscsi_login_zero_tsih_s1(
 		return -ENOMEM;
 	}
=20
-	ret =3D iscsi_login_set_conn_values(sess, conn, pdu->cid);
-	if (unlikely(ret)) {
-		kfree(sess);
-		return ret;
-	}
+	if (iscsi_login_set_conn_values(sess, conn, pdu->cid))
+		goto free_sess;
+
 	sess->init_task_tag	=3D pdu->itt;
 	memcpy(&sess->isid, pdu->isid, 6);
 	sess->exp_cmd_sn	=3D be32_to_cpu(pdu->cmdsn);
--=20
2.17.1
