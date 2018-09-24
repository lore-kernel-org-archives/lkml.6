Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018BF2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P72x5FIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018BF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbeIXUwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:23 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:31232
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387825AbeIXUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Azw1qP8KSfKDeQOdh/tvXPKaCgR+uoySUhjuWqQ/HQ=;
 b=P72x5FICrFQXUPvRnf/FILPhh7+6xRXKpJN0Cfb9r8N9LMEgwKgx/zNBg1DZlUaBl33fnwgLxZgnN87FtPHtdgRH0mNyfzB8Tro4URMa7Zji7KOGu7UvXAzdOui6V0x7rMYqpeqANJHvku3BxIoL425B71bol3j9jFwNdXc02D8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 76/76] afs: Fix cell specification to permit an
 empty address list
Thread-Topic: [PATCH AUTOSEL 4.18 76/76] afs: Fix cell specification to permit
 an empty address list
Thread-Index: AQHUVBWxJr564bmS7E2URthhgDXW6w==
Date:   Mon, 24 Sep 2018 14:48:45 +0000
Message-ID: <20180924144751.164410-75-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:tbje3Vxl5Ig6gv6MIUEFzB3c6lol0ovFCdeat1UIEiCbhMAqshf/9Um86ccZWKaTTLCT8uF2HXMDx4UpsyYkPsn9BmpFEEBfFaeCq1+YyR5BXKqeQsIwFDvgvp9BZ2i77nfCy9PMRaIVP/Yn+MD009WhK4UjXpsWdTbWds7Yy6g0aMMmSd9wczgvY3BMN1Fa4BZhmm0lAjibwM1KEu/xUcZ/wHALoHzI5mlh+2k+agReRtV0ltS1KoTcmQQw/pqbzF3HRfzInhfuO1+HV8ZJMieTTFtMOoFKBNSwcMySPBlh8g/SZbTpYtnFu9Bbd1/6/L1fcP+tnhYOgmDx+SCn10SIrt0pb23lKMkfI4UnrtlAZajD2n3Cgo7B4WXNK15eBjFfyC2OR/RB1aOOaRFxmSLef3r0jOYNZXwllyALT4btV+Mn7I1eQmRToyKY6f5z60aBHZZ6+OD/eKZi547CvA==;5:SzmmPLmOfdfWVapNIeCQ6bAHqjVspjmseF13NOI6OxKX1bg/WoGIHBxttZhi1PSZbQuyFpoxuX3rGwik6tp1ybo030dNQxH+dRSjqpNQXClFLoNs/PHdQlWOEbPJZ+hhetucfVcFlqkyiEeBcIZwBKub9oHt7DEC1iOobWWY/BM=;7:QQ0rak7dnyTMrYk7WPpnJ5RG3jdns5ejihLOUR5DcYMkDCwpWgymT/vwkNhybA9QfxEPeVgRgzPq+s6Snf9a8KaVn5TbV76eyJrg2OOTE0P12A5IRL4sB6PoWXHZQDX6Dd13cxojY7y1/Vtk3o7Hql9nhqB6QpVzLNUnTAOG3d1LQnBI2FRhNMddPr7Yw0miyapf3Z9VToXTC+OveRbx5wiabMCReoXKGAvAppBkK8TRGO/VQHt7mQU6WOuGpmM1
x-ms-office365-filtering-correlation-id: 82115d6e-1068-4dbc-b16a-08d6222cf42a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470F617250294AFD128781AFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: suUDYQQPtMyma7z0CRa974TXXULwFaJICS7xtzV6Sk4/Fy1zkUdAW8dcNjILFINyUqtafqM6J96FIhPZNlf2UWFaKc3I3MT3squa4BlEx0T5Va80kKgoUSOPfeiO6I6iZrMCmGFicxqTd8PXzTNxUTGaQkXJdHyqgpnPo4lc7b5hF4cm/fO4djgts9cIARsBQiCgW9Nvobi31fKzm3ZOzdzIbX3pyKWUojKoH1EL0NjYb+wFhrSYUMs+ONGHP4qXmnHsdWWsXl2/kIkv2pNt6qq3lWXdVOGozH5xoIFW4srBiWSCJvFVxc0z+Zj7HjxjtoY1ohVwLEcXqutr8ppmLFiQARQ4Ya+4LjAz031DJTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82115d6e-1068-4dbc-b16a-08d6222cf42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:45.7839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit ecfe951f0c1b169ea4b7dd6f3a404dfedd795bc2 ]

Fix the cell specification mechanism to allow cells to be pre-created
without having to specify at least one address (the addresses will be
upcalled for).

This allows the cell information preload service to avoid the need to issue
loads of DNS lookups during boot to get the addresses for each cell (500+
lookups for the 'standard' cell list[*]).  The lookups can be done later as
each cell is accessed through the filesystem.

Also remove the print statement that prints a line every time a new cell is
added.

[*] There are 144 cells in the list.  Each cell is first looked up for an
    SRV record, and if that fails, for an AFSDB record.  These get a list
    of server names, each of which then has to be looked up to get the
    addresses for that server.  E.g.:

	dig srv _afs3-vlserver._udp.grand.central.org

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/afs/proc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 0c3285c8db95..476dcbb79713 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -98,13 +98,13 @@ static int afs_proc_cells_write(struct file *file, char=
 *buf, size_t size)
 		goto inval;
=20
 	args =3D strchr(name, ' ');
-	if (!args)
-		goto inval;
-	do {
-		*args++ =3D 0;
-	} while(*args =3D=3D ' ');
-	if (!*args)
-		goto inval;
+	if (args) {
+		do {
+			*args++ =3D 0;
+		} while(*args =3D=3D ' ');
+		if (!*args)
+			goto inval;
+	}
=20
 	/* determine command to perform */
 	_debug("cmd=3D%s name=3D%s args=3D%s", buf, name, args);
@@ -120,7 +120,6 @@ static int afs_proc_cells_write(struct file *file, char=
 *buf, size_t size)
=20
 		if (test_and_set_bit(AFS_CELL_FL_NO_GC, &cell->flags))
 			afs_put_cell(net, cell);
-		printk("kAFS: Added new cell '%s'\n", name);
 	} else {
 		goto inval;
 	}
--=20
2.17.1
