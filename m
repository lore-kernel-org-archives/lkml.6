Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D4BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BCD20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LMw2RQ+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BCD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeIOHBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:01:33 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729138AbeIOGtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrOOwdNm912MZK9I/CxFzuVnkSqEOw8ShtuAh9+Xliw=;
 b=LMw2RQ+ddo8zzqhkN9xVNs5kkYZgegekJFEW11G9oiTODPVUU3zaGjwv9XCwLHRk++oPN5FwYuJbjKLip+7eK3WgVgPJ1Ooekvqr/J/+jNlNKFLU4kE1wwJ18cpO8u4AmOFI5M9ThL9x10+aehFo3mhJEQLuht/CV+YsRqCJKLI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/57] configfs: fix registered group removal
Thread-Topic: [PATCH AUTOSEL 4.14 14/57] configfs: fix registered group
 removal
Thread-Index: AQHUTJP80Q3braqajkit1er8X8DhCQ==
Date:   Sat, 15 Sep 2018 01:32:37 +0000
Message-ID: <20180915013223.179909-14-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qzmW1hjowTNfBdiz67BnqC9g1OlAnAQZrACviraE+e40NDBTC/APfIN0z0Fm+1WqgBWEDqlBZ8rJkkLmUPiBIhf4g+RsmzdyVI15tBoAl9VXmM65Ri8Bo4nnRLs54UBc19djoG4cStGgfnvhnG8JmQTC0/LuE7fokBA3m19vwIDcKME29QEjgDRzdUOW53rVoMJE1KOXG3ZZhh8u0BIEu1neBQ5xj7DSLAFv6DkQ0MD86FXBfgsZGGyovYSHzfcVaMQZ8tDOLVhAsyAE2ET40vTlCfZ+N+53ElQWF1YoUbZSck2Y9HBE0NdNIJ5Q99J/XBOzhp1MWNm8EesPjJznRQWM0qdifBzYvRqXIq87SysnnKVIaoCzA1OrE3vb2GoV9n5GawMD9h5IOaIABZA/Of/w2OzIY5WhKS0LSNFt38o7eiOUy15i8b1Gf/XfJDfM1UG3kcH1v40MDhxyhADB+w==;5:LwXdEOrHOKCSUrClm2vjroS5cq/4iiy8xCdYqnwKryVXFRyx4dvJjPi2+kmVuvAxN42Q/s9DVhl277FnpHUCbLqvOJ+VFr1x88IUbkR3vz3mZWYZBl3+RvUWZ5igB5X6Mk+CAvNLjigzHYWsKGRZd7sf1EoCRkA30rQ37woXvJs=;7:4MeAC52XEHEuPsatj+TXdpqc0E+8q//M7x+RYbS8xmbsBNVaoqgxgAHqyFDtUnAujxS+jhsjgUKvqyUZx2FKBeJHDIhiULLLDessPPSKLGF7+jWi/K/PWmE3GFO5NAk93YZqFDmR9+stJ9YIuRcAVH6IAomQRAVPl65F2OguPIhBxvaqegkfLhqOB5R+tjxm4Z5YIgK2W/hJn572rPJ4ya9BUyw1fmrTzIb8IW/I2B1geq2mKTcMo+AigCegg/Kn
x-ms-office365-filtering-correlation-id: 8142a98b-e5b9-436c-3cd1-08d61aab1ec2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082298C76070406E78E902EAFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LrlDCYTxpFpZJCnqf2IIzZn6mpadN9RRC5/d64HBqhlI7QwmG15D0RMaPUt5/gwuEzOUO18Ob0dWuAwAuVeHft+ZO15cyLDq0h+YkjRSlSbb1IsOS/AY9C/49Wv9iqeDcly+MFcpquuRFp69dv6aiFcbkdnmzqzy0N8+IRQIEwChrJk2wXLPUQBk4goGnoWBckvHVlPPepT0ET5z6GDrCMnhNj3LbkPtGd5liEfZFt7o3r8+Q4kkbWrJiVSe1Oeg2iQYv/a2owXxDXfm0E54/z65zRMm99djvLysinZWQ1v0p/QXlN+nsbhCFJj9AFFWSWd+0UDskJ+cLpumcFLxr0bqmsh88g5MW/SUQkzzroE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8142a98b-e5b9-436c-3cd1-08d61aab1ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:37.5873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit cc57c07343bd071cdf1915a91a24ab7d40c9b590 ]

This patch fixes a bug where configfs_register_group had added
a group in a tree, and userspace has done a rmdir on a dir somewhere
above that group and we hit a kernel crash. The problem is configfs_rmdir
will detach everything under it and unlink groups on the default_groups
list. It will not unlink groups added with configfs_register_group so when
configfs_unregister_group is called to drop its references to the group/ite=
ms
we crash when we try to access the freed dentrys.

The patch just adds a check for if a rmdir has been done above
us and if so just does the unlink part of unregistration.

Sorry if you are getting this multiple times. I thouhgt I sent
this to some of you and lkml, but I do not see it.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/configfs/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 56fb26127fef..d2a1a79fa324 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1777,6 +1777,16 @@ void configfs_unregister_group(struct config_group *=
group)
 	struct dentry *dentry =3D group->cg_item.ci_dentry;
 	struct dentry *parent =3D group->cg_item.ci_parent->ci_dentry;
=20
+	mutex_lock(&subsys->su_mutex);
+	if (!group->cg_item.ci_parent->ci_group) {
+		/*
+		 * The parent has already been unlinked and detached
+		 * due to a rmdir.
+		 */
+		goto unlink_group;
+	}
+	mutex_unlock(&subsys->su_mutex);
+
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	spin_lock(&configfs_dirent_lock);
 	configfs_detach_prep(dentry, NULL);
@@ -1791,6 +1801,7 @@ void configfs_unregister_group(struct config_group *g=
roup)
 	dput(dentry);
=20
 	mutex_lock(&subsys->su_mutex);
+unlink_group:
 	unlink_group(group);
 	mutex_unlock(&subsys->su_mutex);
 }
--=20
2.17.1
