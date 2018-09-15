Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B20220866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BO5CndHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B20220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeIOG51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:27 -0400
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:5202
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729614AbeIOGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrOOwdNm912MZK9I/CxFzuVnkSqEOw8ShtuAh9+Xliw=;
 b=BO5CndHn1uhRngpXEn/J6wRzBUTwCSKNqE3ipWiePDe22cUpjInXa7oG1DEv1EeAswQLBUIR5LCpiAj/4PRzW4G9dzqgjlyxXz3q+ooHLIkdj03HgpIxD4VgnMgPzNexzDI5Oyu1/rikPZU8/5yJVI1rgZ48UoQ9MrtWr24TVHc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/34] configfs: fix registered group removal
Thread-Topic: [PATCH AUTOSEL 4.9 08/34] configfs: fix registered group removal
Thread-Index: AQHUTJQ/HhKTGx3Hhku6RKLQVwOtxg==
Date:   Sat, 15 Sep 2018 01:34:30 +0000
Message-ID: <20180915013422.180023-8-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:/nGPr84CLFgCd8KIDjj7uUaddQQLRtuOHgQ9SuM8jwruKRjt78SQwrHrM7BzyX9TkivmLyk/aKNDWqkoRSZxGlyNhu2tjcQ1aG/LDYy5x8mb/YhZ1FMaTDdLx+P5KpOASgnlCEIrhU9fXOxMmiodoEFJNqrqNvOA+inwVneQ1l2H0x9uHAyhW00XtXRjIxnG6wDBvKKBkhIkWLd6s7wSWatOPWdoaDV8CcnjKAcaeQ6QSsC3bMkoF0i7lDFstmpK30QRkJX1VTuIHhotINJ7nZ9nWErcTBe99tNF5SwVhFgGdoO8k9MNMnxZsvMjIK6Fv//lXKSrs9jICH6NWRUb2xMfHgQiXLiuz62g58HmxFYjntGFxy7dxPyVq3k5ZTQLZpAUIVpnpeYCxIxXa4TKiI/ZGK6C1gLG8zIjf5I+Vj32eyi36YpTH687LWOmfCPfNCqTGpT17QNHqGGx5u6/ig==;5:7qdlW1Qp3timEkIg724VJ1CljfGYxPLFMwYnoBcR5saYHnE6JtnH5Swc4c9M2rNMMZYgo9gO0Gz+8/9BiUUvWbTCT9OJTQ05c+uqgoppFjQwzWh/C5PWdr4I072FUnXsAoE+IzYs9ve+OTErcSwftIQudYCgJWa4a2obRnvg38w=;7:tuVSnewL29b66VuVot/yMZGbTtrnBWYrsGJWxLaYCAjEOdHNz07BodJ4wE4RiwE6myb9QcqafnyqL7BTpc6B1hTA6W3U6cReEZ9Djs0/lNo/CyGSguL24xJUdyYA1/1GkL3G3ViaI3P4+ZIS5DnKakBls2Lf6c1M67CSdfm86hW9qk/3n1qefy4xao128tpOJ/1Q3BoanYICT5ANghaWVgd3bgYjcEKnb9KpxwBxe8xeR7ohoyFPS41GL98GxNwK
x-ms-office365-filtering-correlation-id: 180d3413-e8de-43ca-d308-08d61aab6220
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A2913618970BEE81AC4FFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: el2Wc+iWnCumePz5r9rAWbVdv8LVJ2VCpJl971DR2Cu7rwcab3FdySNPA72sIueqbMm+RUuOJRAMFPDKqDzzHJP3Vg5pmUBMF5kXCDyX+xL55Z4qfXceB2qgDWSGZxYqTTWnqI/8xaoK0JyIax0qUOHgbNO5MhXAbfvbL4U5d3q1czv+T4i2S46zE+ceMwVKGc85vjVxjJfeai2XcWPwIY3qyVA50xB8tKvGt+apkcoQfBofyhTABSTpIYLACAeozsuLyI+fgp4MnsAZMrXYFxeRdcz6RYfXHlE5TwxTLSdTUAROc9plNRHgO2LOXtqT+FGvQOWE21WXD2ROkQdBP/ELip8Of+SFEkzpT/bV77k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180d3413-e8de-43ca-d308-08d61aab6220
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:30.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
