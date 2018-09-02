Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C03BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7A2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZOo3KuFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB7A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeIBRpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:45:32 -0400
Received: from mail-co1nam03on0121.outbound.protection.outlook.com ([104.47.40.121]:64374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728613AbeIBRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3GennZZk6iwLZPorRnKsKC/o3+tw0M+9sRXEnBir5c=;
 b=ZOo3KuFYDZw7FQmASMVivdZP08kehHuFWJKE3TE2iy0Pr6qL0DlmRMCaD+deTiahZCEPCIbQqZqUnCCC2hbqLVgdG3Qoh0LD0CI8bMArKTLVWskDWy+cXSNPM5BZa2s4H0WDaPI3qa3A6g3ie7TfK1yf0w6EzgpiNdPmLBfhNWQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 105/131] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Thread-Topic: [PATCH AUTOSEL 4.18 105/131] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Thread-Index: AQHUQr2XCclmX5e6k0mFhCLGl6ejHg==
Date:   Sun, 2 Sep 2018 13:05:15 +0000
Message-ID: <20180902064601.183036-105-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:aGujCi5gXnO6mlJep0D0PImEvCPhg4qgQWreH+NWAdi5Svbl3Z/I3XzCAujdQlSjlJtlw6vcGnxABJj9QQW9oPub4lmnY6f5fWQ3IWy1x4YKxf+ya047G4+O7osDFPJLcfAterCH5m/M50cEIN0SISw9oChNhzyd6gifQSzfqHeb61F3Jig8Tnwz6TQvKPaKoMmNxemLtMG9GgArNayJZxAYuF6C4brIm2w7VwFUbfbuRF1ZFHelA1pan7rJFdw6XqqFklgd6dB49j32waX9lBPRP4fASIImrNJ/eWBRNl5pTjhLvlVA2rcD1n3fEvxC3bsN9LzvQQWbnJ8ReGlGnkIrbGIu1TiFNbWlkyRdbDRyQ2qYCWU8KnYsPFxfBZNJCl9S696gba0R7AqSeCip8Yw2OgBIhSeBF6+R4R5UBc3e/W/vF+sEbZdnFwP7iH0D3L4jb6tjxTHHvmwk3Au4JA==;5:LSaY9KWxOSbhcwZL2wNhNOOAGEqDeDaGPovww9NEprL7vkkbm3XXlbAgkYbV8L64uZQ89TGYIjXP3xMnWhZc9zzLyJMyZ9oAu+Ce++Yed7LBWX7X0vNs12g+NYfePrr6bcjhXbt1TN54gt++vti79WlMZHLLYhiuHepYUfw492g=;7:CVfPmL8ffDbC7WP4j/7yyXExtKlGieGftIkLFMhHe6Q4Digrz/qmVO18pQTPgA95B3ARqnCC65Ab6cdCfJm5Y8TtRxn5hoqohPRfPB3jQTy1uXY3rJPWhR8u01q7SIpO9n8ot72V0cQ5zmC9sFzn+77+ynQat+Yu//rfH6WJujKpO65461QLQGEzAnwCaAanig+FWGe9bqHF1wUM9C80VVK5qMl9RWguVZlLeWcciH4lPWciqRN7FwtiFnMRsPLc
x-ms-office365-filtering-correlation-id: 7048bf82-a0d2-4062-a44a-08d610d4c678
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01841166FA3D3D72E7F43D6AFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(15760500003)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xdcEdDaN/qWvqBkoJP9uaoJ29P21p4nUZSCfwmFQZ3DjsOP9CSa2uR3oRvZRw1X3Ra2jlWf0FPZf48zYTGJ2FKW20wwqetNXmhJXt3I317sNO1UFaZnJzfP4Zl0b9cFc9Vet3JX6WOWgdiCmI1lxJP02OLI85PUmExz3GJCXefLPCFHi3Cmgb7E2fuP+/udvE0Fr2WPp3kOVm7NDiM0fBBqAnwlt716Eal4TP5242m74hYH93kWVRUWhAfqnJtt1SRlqshiiGLupRLsOCzjBzVRcineRfLpTkxoOWJDSbcz8Q1z26qjxMB9gTQ9EuyY9bFP41+ahYrHEsfCqkKI9IzoAJTUJZ2E09PcVLl2Ama4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7048bf82-a0d2-4062-a44a-08d610d4c678
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:15.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 6880c6f78d58..73c875c81ed6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1866,7 +1866,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsig=
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
