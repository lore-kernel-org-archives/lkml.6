Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B531AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6881621476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ae7J1Mjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6881621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeIOGtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:35 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728374AbeIOGtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6lJKMOykwV2LCkHqDKWYlWIgUJ10bPmvf9AS8TVXrk=;
 b=Ae7J1MjbNX4aESbkxxT4ajwV30OEQjB2uGx9fm48QF+ar4pHRxzQGQPUCD2GLivgf387NrqlZ8yN3uwGgx0BPCS++C1qXyK/kJTYgMSvRl+bkGEpTQcOyPF55+82j0VVT8sDF23nRiiaB6F6rwHXxo+MtJtFG/n3QUqi23NBSCM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/57] vfs: fix freeze protection in
 mnt_want_write_file() for overlayfs
Thread-Topic: [PATCH AUTOSEL 4.14 06/57] vfs: fix freeze protection in
 mnt_want_write_file() for overlayfs
Thread-Index: AQHUTJP4W7Kfaq9H4UWwHTJoIhV4QQ==
Date:   Sat, 15 Sep 2018 01:32:31 +0000
Message-ID: <20180915013223.179909-6-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:267zF3FtAmPv3Ve4XMuRdhcfhyMMDFv7lXEGmui2rheq74o3g1G7x+zzyS8GY/JMuGajH1YtyqCs2c02gBoaTEuJYoCIMsiZ9SUJyXIT2RkpPg9ptyriMR1GSQ82xAH+z7rcfilIC15MzNc3CnkFMVC9D8ZAW0x3QVm0+KezDXcArxySUHo2HBPcwU55m7IyljaIuYCl3rpKk9UNH9FyYelaqe9HQVgz/sPCRUu27sHTOTTKnqeX4jNFb/gJbIqJMJxja8Re4OgmJ8tRfMWdOz4JIB4yzbDF4jMA1H/gRDY7alID6yt4nZWY89j+kJJAAlQS9i1+jXN0erQhMY5BlSgzOtdUT3mJ/j/30PdX75SOWoOS7LiNhd8u1N+TPQKWY9diNn2rXgCFcpBPdA9ZTqm8cFdQpA4IAkpNLL9uhcKheHKEMVCG9Ybe34tc+m5SpLnMbR9KQaSoXdy0TYK6EQ==;5:wm3wBjk8e7Yia5DyES78ly4/Q/aottnCQbSaZUVf3sHg9Ag9GeRaP9TiRjxyuJFJcVPCdlSH+NjTkwKTstbbQSmyuHBzqsY2OlE3lxwzNMpqIGeOXBr0l/wLuRu5BhbR5ggIqWYQmMVquqUekZVxdLCD1g0oINwoO5TXXvqjE+Q=;7:ESaEO1W6rKq9JzIm0KV9TGJW9l/Gt+4dHwUUjxZs+uexvAfkLFHikp6AjXW7Zfq3W3BB/qzeO/NHsh8o0BbjoO+ezXotY/WngA/AGlztDdW+tDkxOM77/r/Kq12U2C2ScW3heHFYesfCsyexunF8E7NipStpiwqAq2GzPM+BlcmhE2Sb4btNoVCXpEzCGcF0TQi5NA7EqsB2RAbGOptHXvcRReSwLvuIySFc6WUq7nt3VMtr2NzUbI/wPXgl9nIY
x-ms-office365-filtering-correlation-id: 2d9d020b-6be4-42bb-11fb-08d61aab1aff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01176B5B4C182CA4AABAE7BAFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 410/bNrrqnwHdFWewmlMSy/m0kQIh9GoviyWmIMsrcPd21sNOgbChSUWjyUatVk+2Vt1FCd2NNe1r4rWxXqPbzAt0uIG+I0Oq80nyb2nk19UgEs8gc71gugzjqWTLAcKVJxgT0Y7XsBIirxVo15oRGrHPXXm5OzflprchkyO9rMR2nD/LGg/JgCjltKC1APMX4R9nmSfqixpvdrGviicb9lfHiUghvlRody+NP/mXaSMCb3BpZkk3MjSjXIlQHebDBe0jFoMZIh7vV5UYi7kull47tNC6UzeeJy6uxoO5Bh5iCXo9VIEeZhX7p8CX2UD0jeFhQAva5hvC5OwvKAGlGOyfB3N7wFjQ1zsBobixPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9d020b-6be4-42bb-11fb-08d61aab1aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:31.3220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a6795a585929d94ca3e931bc8518f8deb8bbe627 ]

The underlying real file used by overlayfs still contains the overlay path.
This results in mnt_want_write_file() calls by the filesystem getting
freeze protection on the wrong inode (the overlayfs one instead of the real
one).

Fix by using file_inode(file)->i_sb instead of file->f_path.mnt->mnt_sb.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9dc146e7b5e0..3ee3ee5819bc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -446,10 +446,10 @@ int mnt_want_write_file_path(struct file *file)
 {
 	int ret;
=20
-	sb_start_write(file->f_path.mnt->mnt_sb);
+	sb_start_write(file_inode(file)->i_sb);
 	ret =3D __mnt_want_write_file(file);
 	if (ret)
-		sb_end_write(file->f_path.mnt->mnt_sb);
+		sb_end_write(file_inode(file)->i_sb);
 	return ret;
 }
=20
@@ -540,7 +540,8 @@ void __mnt_drop_write_file(struct file *file)
=20
 void mnt_drop_write_file_path(struct file *file)
 {
-	mnt_drop_write(file->f_path.mnt);
+	__mnt_drop_write_file(file);
+	sb_end_write(file_inode(file)->i_sb);
 }
=20
 void mnt_drop_write_file(struct file *file)
--=20
2.17.1
