Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B90ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16DA208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cr0NF49P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16DA208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeIOGrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:02 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727994AbeIOGrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP2Oe2MegqDSbJ49WzHNDZdTIjmac0zir9EcLUCQr0M=;
 b=Cr0NF49PJ6cY6cgUEBo2FbncjL4FkXJRhaBcOY7nxv9xZ2fwKRJNeegyNpZoa8nKCP0tjWj7lmQA8/JI9xyMjQ3U6QCOdVhSIY1gyE7LZOSC+TxiksJldcauOslbKtizVq0UINNAbh5fLVfEa1fdnjIn3apPyVIrzHI3upNeF7k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 18/92] configfs: fix registered group removal
Thread-Topic: [PATCH AUTOSEL 4.18 18/92] configfs: fix registered group
 removal
Thread-Index: AQHUTJOe1Iokif4qfkuaJGl1Mcl4bA==
Date:   Sat, 15 Sep 2018 01:30:01 +0000
Message-ID: <20180915012944.179481-18-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:jM06ChQ4vfupB837avYrnnU8wMZJENNo1ooVumWI35TLTpxU+hcVjdl5+CaGN32kyz8+GSUtdmEYEujmjOJnLsNSYNwJwatWUz+eYNlLJ5zBLNufyMn+45rLBKAOR/p0GEu6CY6aG+ZAUozjLtf4z8RcN+T+zw4GPVyswA4Z9GexB/s/ovkPLoPP9c10IBb0rgln70rgBLiYJYaTAQdPzd0dcw0/FmzWo3B4GjK8q4kl1i4IRakn10SwX8mLcf5ivhbCRlOlPE+0nM8jZpo64xWtAPX5bFEDc3Mbu2SdW9GPskxtsfDmlqWZaae/ij4GoBlX0Fkz+6BudLhO0dT8XkMIglFGQb62qUozktuM/u2x6NYCu1VhcSzc1nDVjuDTNAvRH8Mj0wvSfzjTluKYpZnWI5PLwlObPMgqMYlFi880noUD1OxjGfemdfu+LVbTwTtQnToV0u4K7Gd+CagMmg==;5:kzq/U+DIu5GiDmKXLVXQO2EGambpKe0BxUW/9ec9M2x/uOCyb6ZfpACmQHq8ibwXvoWIqnQET51TbpHmBbEUjH6H7YkeGMGjzznENkkevXOGirvaHX3Twqe+qfH2fsKOT04y1S8hebvIvR49urTuy+hQBRs/1ofWRoBipu/DExg=;7:PqCNpLx4xACvYEJWeYBc77sJNSpzroeTupVd02WrghgQmo64o97vT/4NqNEOE1Vhs6wlqSNWW+9A4S4O1uVmaI9/YUFpbkgh+UX59L5zpeb2RGSKy/YJC1WOQFuDnfLJDIdQi2yTZDWsfVd8+ZayqIOrlqwRxmBi/v+Tr1R1LKIX9JnUXTaAlMzUtLsP7qprPzLb5j81+lMAk25yWxaiRNvHjoXPC7gcM9hoNN4/JL8N80gL+bpyPxrwhotJv/1V
x-ms-office365-filtering-correlation-id: 57ae724f-723c-4dc7-d95b-08d61aaac17c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824D65C575549C2BB2EDE34FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /LS/kNkCRdMzSqjN2yrIGuXvExvp2e2H4gafubaxc/bL1DsME80+n4kR4PZNEo+hJgeoGNV8R9vgbmEU8Jo/Z7NBQIJ3bjSol/9JGx2StVnBKFCC0qWzCPZkHFzfB5YIH7UewDBnqtXQd2+3LcdA1WaniR8l/S7rYqRFKCLL9i+bpad4/iRgOCWcZW2vOTSNRUR0dBsLVQlmLmln11dZIf5Ihy/0REAwvXdqb8HOpsy8BLx1NBwwJ5pjs7hjfSBny1pq6U4C47mA6qXQZpnA2lR1x6bXxh6NO3EAsEE1p2JxWEqvsTcWEGcGr0rcoYW39/yE6aFf/6RnULh3PcP1PajXWHbKo6srACcDUf/rauE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ae724f-723c-4dc7-d95b-08d61aaac17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:01.1201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 577cff24707b..39843fa7e11b 100644
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
