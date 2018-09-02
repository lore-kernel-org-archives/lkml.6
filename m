Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B2C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C922077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cLaJBMrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C922077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeIBRV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:29 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:27886
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728623AbeIBRV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMOufrWGfTvazR6zrqOPxMi3MDh5/GsOwlJyZvafRVk=;
 b=cLaJBMrU0by4hrEv4G7DAi0tYIl8bd+Hy7kHsJd+dnemEkjjB3lCbvNvFINr9s1Bv89kGH5FwOGYDfzUQjLtsskRJlZwo8kI1qJcRfFKqHzs0dyOUgTj/mhjWblK2OGI1GvvpmfdY9Odb6jPzDfWCIzvGmlb94lw9EqU3QIIK5Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 107/131] f2fs: avoid potential deadlock in
 f2fs_sbi_store
Thread-Topic: [PATCH AUTOSEL 4.18 107/131] f2fs: avoid potential deadlock in
 f2fs_sbi_store
Thread-Index: AQHUQr2YSTEWyBgPaUOZBCXr+cMhiA==
Date:   Sun, 2 Sep 2018 13:05:17 +0000
Message-ID: <20180902064601.183036-107-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:Uy+26EzHWwS3xrJb8DueomUxEWmVwuAXWiyK4Gyrje2pBwwfctglUtpL0EYRWbERscOcv9DG5U9cOhetnjpK/JK0JiI8dTY8qzGFpE2KSyTg1+O0mdYJTz3riOPiaR2D89OVVNOdkw/Glrzw2YGuLgFPTMCOYwXtTs5QRRO0ixRybnsb3LDmwBlQ2vWEQ31hGaAHzY8pNRv5ROUu6cX9/OiCzCx80dV4kmKy/7EMKBz3ZG9pa6xdfEi1YfMn/rVY1g4QfwRHOqENmff7U6GFPVL0XMX5Ns9qjbGpYqEAaVbjPOWqn3ANIfHdpSE6aDw0895/d8ghfMt9UstqEbg5iQ7hmgu7mb+rQ4vtmeSPowUNjFHbnUv4q8lO3XyGRfZncrbt95o0/IGtnjlaulrx4IKDGWMhzafKejEWey8DDXQvWuBRLXW12+nE5BBwsA6siYfbrSAVtyWFGCIp71ogpQ==;5:SxyxLsB+OBqlWiLA+nVEp8PZAoJhPuhpIyEVfOve7c6Mv1Ker7HjXhsI/NOZgH007LShVnJjuvro1Zeqp7vPeKhLbJBtgufMpbt7b5ZSdc23WixJ5qF5Pra5VcF//XAen/OmpkRbzzZCSeMA+c76bj0jfESY90uNBiyGe8aX68E=;7:rU0L+pcFZQgBtpVSg8nfSuSRsIOJKulrnQWs1B4+Bg5tXjxgfft252mMQXUu85K1alTpGo3uz6ciMlOXmEce1u+j+5oMusPR/wGzVmTolY1V5qihczOAN9fT6LPBTN7Ql63EUzOthUo5gpRNqf00uZQBXbFRvxWzN65z4qOOIULgUyg1FwrUBKbdcVXw67cFip3Z19ukq7dGb1P/RKyJGe57p535U3dUqOl+92Tbbj5N55vhm01p14iQtsBrC94d
x-ms-office365-filtering-correlation-id: 9ede1b19-c582-45e5-0ce2-08d610d4c6f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018405A6BF78753932554FD8FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: obzTffhml8VunTdWWlcC7EIDX5WlG4r+FbAIQNFwf4HMR1KxpNGFh448viFeuYi96PV8Xn22aFCYh68a6uEtWC/d9oASpU+x8b+g0D/8w/V7cZyBLpsosMPH3QuS8Ycxy2agYdhBkpUo1VvZYcFCGjQeqapGRCbStfaBLvtIbW0n/CUkLg1HD0qMU194xW9L9PTAXwdYmvtZ4RZ3Ei9fu7KXfnyifSteF4bsBcri2yvBvablq8M1kBdWXoRpC96nBl6uijqpve/e8RLwGe2nA8ogRaMQl8rMstwA/82lV9hJQcAVQo6UDF2fJwMn9HhPYo7qFYYibVp3SW4gR2KNX4RVe32+a1XFY3mH3i47PoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ede1b19-c582-45e5-0ce2-08d610d4c6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:17.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit a1933c09ef84c2fd187e05b560ddc6e1267d6508 ]

[  155.018460] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  155.021431] WARNING: possible circular locking dependency detected
[  155.024339] 4.18.0-rc3+ #5 Tainted: G           OE
[  155.026879] ------------------------------------------------------
[  155.029783] umount/2901 is trying to acquire lock:
[  155.032187] 00000000c4282f1f (kn->count#130){++++}, at: kernfs_remove+0x=
1f/0x30
[  155.035439]
[  155.035439] but task is already holding lock:
[  155.038892] 0000000056e4307b (&type->s_umount_key#41){++++}, at: deactiv=
ate_super+0x33/0x50
[  155.042602]
[  155.042602] which lock already depends on the new lock.
[  155.042602]
[  155.047465]
[  155.047465] the existing dependency chain (in reverse order) is:
[  155.051354]
[  155.051354] -> #1 (&type->s_umount_key#41){++++}:
[  155.054768]        f2fs_sbi_store+0x61/0x460 [f2fs]
[  155.057083]        kernfs_fop_write+0x113/0x1a0
[  155.059277]        __vfs_write+0x36/0x180
[  155.061250]        vfs_write+0xbe/0x1b0
[  155.063179]        ksys_write+0x55/0xc0
[  155.065068]        do_syscall_64+0x60/0x1b0
[  155.067071]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  155.069529]
[  155.069529] -> #0 (kn->count#130){++++}:
[  155.072421]        __kernfs_remove+0x26f/0x2e0
[  155.074452]        kernfs_remove+0x1f/0x30
[  155.076342]        kobject_del.part.5+0xe/0x40
[  155.078354]        f2fs_put_super+0x12d/0x290 [f2fs]
[  155.080500]        generic_shutdown_super+0x6c/0x110
[  155.082655]        kill_block_super+0x21/0x50
[  155.084634]        kill_f2fs_super+0x9c/0xc0 [f2fs]
[  155.086726]        deactivate_locked_super+0x3f/0x70
[  155.088826]        cleanup_mnt+0x3b/0x70
[  155.090584]        task_work_run+0x93/0xc0
[  155.092367]        exit_to_usermode_loop+0xf0/0x100
[  155.094466]        do_syscall_64+0x162/0x1b0
[  155.096312]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  155.098603]
[  155.098603] other info that might help us debug this:
[  155.098603]
[  155.102418]  Possible unsafe locking scenario:
[  155.102418]
[  155.105134]        CPU0                    CPU1
[  155.107037]        ----                    ----
[  155.108910]   lock(&type->s_umount_key#41);
[  155.110674]                                lock(kn->count#130);
[  155.113010]                                lock(&type->s_umount_key#41);
[  155.115608]   lock(kn->count#130);

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5344e21853b2..bca1236fd6fa 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -287,8 +287,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	bool gc_entry =3D (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type =3D=3D GC_THREAD);
=20
-	if (gc_entry)
-		down_read(&sbi->sb->s_umount);
+	if (gc_entry) {
+		if (!down_read_trylock(&sbi->sb->s_umount))
+			return -EAGAIN;
+	}
 	ret =3D __sbi_store(a, sbi, buf, count);
 	if (gc_entry)
 		up_read(&sbi->sb->s_umount);
--=20
2.17.1
