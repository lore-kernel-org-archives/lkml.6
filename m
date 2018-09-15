Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D29ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E3421476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eICBFZl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E3421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIOGq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:46:57 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeIOGqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EAN5cbtOkuNxQLVQzmIZGHFrE0Vmr8XJ57X+/uNx1A=;
 b=eICBFZl+Tv1XXZ/+3u7MCk6EuhR4t5Ob146kHHChKHoKfOVJQOFACYbWbygDUzt8OSIMQUpJa0rnNCEL7OY7kkx90zPcDWxA1LUq2OlH624E6n+p46GLEA9cZq0iYjzRkTe3D38X2IUWhupcJALAzwYFpuFz2wfLFSgiwT5r44E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/92] vfs: fix freeze protection in
 mnt_want_write_file() for overlayfs
Thread-Topic: [PATCH AUTOSEL 4.18 06/92] vfs: fix freeze protection in
 mnt_want_write_file() for overlayfs
Thread-Index: AQHUTJOauAp8/qDGYEyYkXigczo8hQ==
Date:   Sat, 15 Sep 2018 01:29:52 +0000
Message-ID: <20180915012944.179481-6-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:SeKZ5VgDg6HKpWkVd95aGbCPM1IDCZab0L7F2r6P5Ji9V51qJFLlY6ObEcuQ8G/sZsrFDnqlt2rrcn9DmZYaioHLeXGYM8FcLXo+v4vvmjWDzrYOxZ0ejxRrJJ4h0lIq7p+dNAVGHBlYuUCoD+1beucGe9TnbdUXYaEQ1g0o/7LnPONXX19zWIzXmzlxp0w6y+4w4xnkTKz7vFLW7pnewCG9XrDqIOpo8qB0BDNFyyAF/o8kLnZaDsBeUWzhM/OkN8U7o6zmKueEwWzXrwYqu3iQSkQ03SQ8OBmWFd+JQOPv/G4LJoh1QMma3NcBRpS1AbKPgOXP2DQvtcx7TXuhLx6vPpWfKkX76oliNY+NI5DqXizC+Cb0EbWAUFGQ5FrNpY9DGYvfgu4vhfH/rEK2UL1g4I148ktXMzzX69MACaXL1KVO5Ps3ebQdJsovG1i5rM6Awci8g6XOZ2ekCfMDLg==;5:9oBRwJZiHfAz2Jp0E0hK3IhaiQB06BbL8r7erw+8OnIoxCDzCrnEFPKzbH9aYoz4fvNYyHGwNIIRaZSErsxTgMYBz74L7mUqzVcbW4AfQjYUZlpjlO8Dc4Ly5M93VEPvbA0ecECBXij9xuUR+ixR1nwc/yyeSwAXv9NBrCq+Asg=;7:ZxVdzoYvMueP1S44SpKcf5GWaCXxb2o9c/1X68CuEfT0s1PiI1L46z5JOqNp0eyeUUL1UpxjZC51AHFp2zKnJFvb6ILmBpLI89hQKyDxpAWFbjwx8zbFcHs9sCWEZRmL3qvDDurcjZGuJ78ciG5qBy1v9i/G/FVrnU2tQAZhXFfbyLQEI6k/dAc/lSh94L/Jn+xjm7g+wZUZqDt9VTX7xJ8SfpagOQX4YpRHkJIxQBSleO+etJo9TxjB6rjrBHXh
x-ms-office365-filtering-correlation-id: 520e018b-43a9-4690-ed27-08d61aaabc9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08403CA97F4CE094B4729617FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jrr1tm4x+C61HyipMHqgdMkHR5oRppmj+MwREIMGBEYoe7c4ildSTYsduXyZ6xbDc4tbBsGyxMUrAuLW2NKN8QsKRR86ad3Q5ykpGBfZAxMwAdphkzedp/s+X5hdk8M+UfffQLlxBOI86zetApwwIfZOuk+yICyuQcNlMFgKR8Y1NESYYjhz1ExymkwJRFc9Cn2KO3scvcLd20aGCTraMiAxHQNEFA0Di908YlX1XjjvZgtqEor9cep+2gVo67r+WmwMRfaNL/egD/6YGycv2iTN7p6tKx8o2Q/1LaFNTPcrLG1ds62CWN89LbtlQKSYSUm/3+dtKaoQE7Zf20LWaS3uocCyFhA15dKEPmgySVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520e018b-43a9-4690-ed27-08d61aaabc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:52.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index bd2f4c68506a..1949e0939d40 100644
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
