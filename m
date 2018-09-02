Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D090C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09A520837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oxy1Xan8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09A520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeIBRbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:21 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:4252
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729513AbeIBRbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty91niWOHxKfTHf7+OrzvFdl4OnsNATjS9CGN8AZcBE=;
 b=oxy1Xan8e1oC5dbLTyEI+Trw51o54zUUP/BCCoD01khmxApRoXvCuQwYhzwD2dP6u/bDZLhS3zubUquabhh5Xpuc9sOMWZ2wGShZmlNfb+rknepxqp4+hproBRX9TWXAN+4Xl2ZLF9E9DtZwmtqjX+ty6sJy8eXQu1yjIv67O20=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 46/62] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Thread-Topic: [PATCH AUTOSEL 4.9 46/62] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Thread-Index: AQHUQr70yDjy3kIJYE25OO6Igcz5DQ==
Date:   Sun, 2 Sep 2018 13:15:00 +0000
Message-ID: <20180902131411.183978-36-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:jfhbAlEO+AYfRB6bBXlYTVEjMQw1H3de8+3S5U7heayVtmNFlBhKrUHvgUkW84h1AAte4V/6lt2GRrxcxT3YqNJx4r9NQKJH55EOBkCtn2pIvusXAcY4sHwLXBfxECTBihk8kXpjMg1ZBtoplzHBrcJ/qKybASqkKzf23BawqOtfAdkVPn4Dk9R8+K9faqpDDwrCjjUat09MjbYJKUIKzh4+KKknMgnwTRjknKA47apatfuvznRL45fgbJpscbCc91lRWc0As/aYGMD6z9kXdp8MPl8EwyDMDIpGtQPsNEN607WtOl8DJ2q8ry2SPosxWo8aEx6wAAmdMq1CBPVcIfYkuVF/XEsYg5jFLhfeUPvTw7OzTHxI16LTP6F+r8ELOgfGz+LL85QvVidWUTYx4KSuaEzqFIqHsFqTen3E0CALRoNmkJNlRX+GfJsxOhvGCpskYeZtK2QQ1hVYcLosHQ==;5:MdmYX6VROQrePIAHT98MmSJ+GyX2eqjxtHAEtRnrKjIBpdYDQR199gj8iwHYXoBh++c1sn1JJ30Bnn35zkobouiPdKO+zBTRk1Gzbh1cMEjVgzR1CZ21gmFRmmh44HHngZkGjRgKUDBEKG4K43nHP97RMFKTMMn7PgL91FnjsBo=;7:KUM5sCOQqCcP5hYY0QTROnEPVuXUrnXny+R69zUidtEmVN8CwsPWAY/l173M9sqI07jxprslaTlaiL1TThPAkEF9Qw3GIxEI4NESFyOMPsYEHqnXOa+e7WbGlKAZ4K96N6x3mLzxr1FSroHnddfx+8TRa3SNtSCb/YNYImdl386J+Y68ePo5jtfWHVJeLHhQpVyPd+/0A0YLvrQR4KpSJ8iMJa/j5R2kVzJqFf5t8m3EbkKwG01da5WuAlxhNA7v
x-ms-office365-filtering-correlation-id: 0789344e-d86e-4bda-6d2a-08d610d62765
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741DA53C9806BE2C076DF4CFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(15760500003)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SRaDLv2swFQbW4VI/DzXTpytQBPPqk2KIoK6MIc9xPgDe22R0BCrQCMCkHEpX9p/VhdBveWsiYeThSXUTG3R2ouUwy+HuvVh/U24yQlCqlZ7Mj2z05gQ8Sg0hNrLncBTJd6kqXUoOwIIvexc7FcRRLQ5BhoPaQisFqOEklY8LNoIHFqLdccOzcvoScTRtpgEBoHUA1G08otLsDBchQwnORnSPgFUPimB4OgnoGUzeRMxvlXOM/ayY5kzWDDgmM/pJPI+s6XQ0cjEcqBdls1zGKlyMs8L4jgjCNLSTaxVibkRlyRNfLvMOx509sSv9BVlMQr90ojOu49RICL0eWJTm5VZ+luCGObkvbgAD19qzqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0789344e-d86e-4bda-6d2a-08d610d62765
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:00.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2a96d8ad94ce57cb0072f7a660b1039720c47716 ]

"ret" can be uninitialized on the success path when "in =3D=3D
F2FS_GOING_DOWN_FULLSYNC".

Fixes: 60b2b4ee2bc0 ("f2fs: Fix deadlock in shutdown ioctl")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7d0e8d6bf009..594e6e20d6dd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1665,7 +1665,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsig=
ned long arg)
 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 	struct super_block *sb =3D sbi->sb;
 	__u32 in;
-	int ret;
+	int ret =3D 0;
=20
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
--=20
2.17.1
