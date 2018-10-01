Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812CCC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA7F2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P+ZSmXYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA7F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeJAHOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:54 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729458AbeJAHOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hUnzLi9spOuu04RntSDladZz5kP5l3zXP3/Z91V9Lw=;
 b=P+ZSmXYdY6+uA670BwUXXsAUykbqZg2p2JONuTP+rwROtnGiN8d3eGySdHIZEjdJSQDlYa00UNoJlbTfF7FtMDEfWfyIcqK+GLu4gonQUdAAqoxk2e4oPjgMsaebRu2lYiQLb+kJAWAEMNyqppDxhS96YpoXvj9IdU+UqOixB+o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vincent Pelletier <plr.vincent@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/37] scsi: iscsi: target: Set conn->sess to
 NULL when iscsi_login_set_conn_values fails
Thread-Topic: [PATCH AUTOSEL 4.14 06/37] scsi: iscsi: target: Set conn->sess
 to NULL when iscsi_login_set_conn_values fails
Thread-Index: AQHUWR8io08DaSLzRk+dsfenYdYupw==
Date:   Mon, 1 Oct 2018 00:38:56 +0000
Message-ID: <20181001003850.147107-6-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:F8XyI6HsZk5dCkKHs3DjRK1LCAtINHk+ivKEgCWbQKfzjpZQKAdYk14sEUOFhpnBwMuWR7PDMBqdwwbs4I8lyWKwpXkgVWxz9tiUSIBrUWg7BCk0W2Q2uBHKHN/0AWydKDTw7vtw2Cu6WccTb2pcZhoB4k4w+m481rYmx7yQEzPzB+qK1vkaZnPxX6YwSMs1ajK1LTJH8FagYvBoUnMCLmk5syHV4Osq1epIxJ2TgU2klntAvoOCWNTwimTotFw+SU3jMG82/X4RqVz9EgROdrxtOZDTe+U6Ggfj4A6E7Bx0Fj3jXwFp+Yp/jsvRkrvc4OaELe0bDOXlYIc1ShfimIpGlos+ACqKJDWhsFE2l0iLku+/MPHM+R3a+0Vt5ANC4rmJQsCGrfHvoiOwKT5W5zEDE63lj1vy53MBgbmE8rK6QwANti7z5B1bXlXXrocKzlxesuD96eolhLxfoiP2LQ==;5:I7uMgp/YFfO/ooPy/iQKVrZHgzDQt010jJz89ILGdab2blpTXOk/nJBnhJBKm21CYJSKOtRWBQa6OxakNqc+btFb3CdwlHPeFnG4piTvSD9rpn+2tH3T6QSMOADbNpSCBa0vs4iFHYvUUIk3DcdSfRjwSztU8zxFJc8RaFCxXDI=;7:qDXXatVO/F4WUX0Ues+B/2Xg6DK9gRbB9/nxTSuLxTr8yz7FTRSLvSom87SeWLk15QaIdzBevzLHTQy7XDgn2tcA2ZiiVUtXHme6WJGPm0sBWGbM3QuSbPgke28fgyiKrgwUbk2P+HMk2sBXcpGGhnSGcB0P5qAyogRQbvHRJu2hwg+jeF6u203HZwBRhlm4v8zRrTlpdb8qpBuhoThjDIIWwzvs80slFQ46OMXE9gbW9ghasP+JsRdIbJ3spbDF
x-ms-office365-filtering-correlation-id: fc04292f-a3c2-4602-fa63-08d627365f36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696DB51E92E75AD65A73099FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(275809806118684)(17755550239193)(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(39060400002)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RxSzgjodpIYT05gqyS+4LodK2raaLGlSiyK4KZ9QJQx0JSqi7lrX0/cT+bEk/SpjXwPhXxTowvlJxwoJKfbhqYgDilymNMpTfr/rJ9LKVnUmDffjQ3SEcEQwaaGRSOMHEGAT6X/njkxmPM111nsm6BE/1Zhbn0hDInTI0Fs4ieou9xZ4ZT/mHKBsRlMYcQKzmCdPHMc8bHzPg6ZOGDC0NF0Y48AO51pAsV2Vv+l9ns6skS684wr23n/01mJ9WOw/nIudWrdEscp5ZW6SE592lMrmAzvmOqGprLe46E3mMcaqiQsMhlajbZYW25jKcySayTgE1+2t9E82f/+5qFEtiNNoK9fsfFu6HItW3deJpLE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc04292f-a3c2-4602-fa63-08d627365f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:56.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index 98e27da34f3c..27893d90c4ef 100644
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
