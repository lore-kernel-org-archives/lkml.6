Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385DAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3952098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nfx/Fap+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3952098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeIXUwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:24 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:17682
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387576AbeIXUwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np20EJDi2X5/vmU2XxHa8aXDNPRvgxQlUk6V2+1jpnY=;
 b=Nfx/Fap+BbhVuCNXu/bCDWL6EUrrWugb4siVLKQEUXP/so+6EQrnRDQMWbMtB3EHI2Op7sB5jSq5wfyAaBZ6P7QwjBrhgns/zM4POkuy7zhzEkFCgVFllcgCOuRD1z3yHkEO5KQoZpUmyKNMRoLtRo3JP9zaTS0FAbpD3bo+Tys=
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
CC:     Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 74/76] ceph: avoid a use-after-free in
 ceph_destroy_options()
Thread-Topic: [PATCH AUTOSEL 4.18 74/76] ceph: avoid a use-after-free in
 ceph_destroy_options()
Thread-Index: AQHUVBWxzLo2qU2yIkCMYJATJIWzNQ==
Date:   Mon, 24 Sep 2018 14:48:44 +0000
Message-ID: <20180924144751.164410-73-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:9j7L1JFWZw6hxcDU+BJJrndYCTjTnPfvk9DfAgie8iTAMz462j01wH039WJhiSbXRHWTbiG8hyk+Sr+HUWIJDLG1qtzdjMlzPzjo8mQGEYVmbWsHD/pu9U6hk0rLT1oFoK6pjpzywjOdfSgv9+OuK9jTHMV0qyDIEhIp1encwPLimCPKjCLku+p5sjdecF3vLsAUEEzXvooOnLSHF832Iy9+CzN2O6+H6YsGHlNdzoHClpP9dEsZvWYSJkcsaKco3AgkuEyZ+z76hPk4wp1MqNJMp2HpyurwWC7GZJ/QHOjg/ZRb6KizAwjONRNKLWGjOCLCX65zRjmLibg/bPLAUxMYsLmOGIIC2njbdUKLTiQWfqRe1nmY4QOJxecSex659lRNgCd1lT57oXDdikiWPeROm9iCqISnUas3vC3G8cgO4JU0LmLLrki1G4A05/GnKsS24Gy7AnTiSQFqXQGQfw==;5:v3y6fDHzlGydoOfAW5ln2enBaUU8AWO+ImB60Mj7G4Kks8pDHgkocVMrSeFQYDwd4b9xbU+q9VsoRZ41In26GjmoktJvyv3n8/Km5Lh8jQMiOB1CO/DZlUsZcWSkrOG2OQ607miCZ3bpK14GLVTTR9SO0ma+wWoJRRPFc6gGpi0=;7:kgwfyb6XAgzAhoR0qNwQi5ZTLLlLpo2btyEbtUXFkfAg4C4keu0wI4YgSJrzpVmG8wJVYOz46KHd6bhPIsvzHqnaDWmJLoQowzHGXfildEt9nAcrDBeY0UJSrq8bMtZ1iEGZcZT2mMOp+zv/M3qMYp1f5xtun8T/i0shqz7e/9n3D7fBZSqQKK3yvD+VagovH2hErgm/7npSggVYGCQMZfmRInmraKVRD9n0etOKhplSkWeWJdaZCRNwYprICJx5
x-ms-office365-filtering-correlation-id: 9ee485ed-b533-4cd5-c75f-08d6222cf3c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04701D54A7F85BA331B9C736FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(39060400002)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P2wzRjW0NEHZypnEcN7vrrh6fVJ5EFzUrLoj7eZfEscTcJxWAqzes49eYenbjmojY8cg6IPz5S/TDH1ujwfJx5DmvatQh/ER3bYBLgZZfuWjrAcXK+h4+qUXKMr1rEYBA4+ZLvMSc43bSkXcmPZQW+GMxDR2wkKommHQpMxEKX+YQ8h1jvVWTM5WgJaLb6G7QBsPFpdsiEcW125od+TtW7CXKM6nw8/Ac/Mq+heDPbp4g9mzzPKkLjy8twRbfZkO4jSaRj1wR/ejgdVaSUlRPUaD/mrBntv1+iKGjeNFeIn6f5OG9OapIA5Ms9SyiL7EN7LG+WJ586WT9UOBsbfY56Zls2h+OPc1KucHBAQ8PSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee485ed-b533-4cd5-c75f-08d6222cf3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:44.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 8aaff15168cfbc7c8980fdb0e8a585f1afe56ec0 ]

syzbot reported a use-after-free in ceph_destroy_options(), called from
ceph_mount().  The problem was that create_fs_client() consumed the opt
pointer on some errors, but not on all of them.  Make sure it always
consumes both libceph and ceph options.

Reported-by: syzbot+8ab6f1042021b4eed062@syzkaller.appspotmail.com
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ceph/super.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 95a3b3ac9b6e..60f81ac369b5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -603,6 +603,8 @@ static int extra_mon_dispatch(struct ceph_client *clien=
t, struct ceph_msg *msg)
=20
 /*
  * create a new fs client
+ *
+ * Success or not, this function consumes @fsopt and @opt.
  */
 static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *=
fsopt,
 					struct ceph_options *opt)
@@ -610,17 +612,20 @@ static struct ceph_fs_client *create_fs_client(struct=
 ceph_mount_options *fsopt,
 	struct ceph_fs_client *fsc;
 	int page_count;
 	size_t size;
-	int err =3D -ENOMEM;
+	int err;
=20
 	fsc =3D kzalloc(sizeof(*fsc), GFP_KERNEL);
-	if (!fsc)
-		return ERR_PTR(-ENOMEM);
+	if (!fsc) {
+		err =3D -ENOMEM;
+		goto fail;
+	}
=20
 	fsc->client =3D ceph_create_client(opt, fsc);
 	if (IS_ERR(fsc->client)) {
 		err =3D PTR_ERR(fsc->client);
 		goto fail;
 	}
+	opt =3D NULL; /* fsc->client now owns this */
=20
 	fsc->client->extra_mon_dispatch =3D extra_mon_dispatch;
 	fsc->client->osdc.abort_on_full =3D true;
@@ -678,6 +683,9 @@ static struct ceph_fs_client *create_fs_client(struct c=
eph_mount_options *fsopt,
 	ceph_destroy_client(fsc->client);
 fail:
 	kfree(fsc);
+	if (opt)
+		ceph_destroy_options(opt);
+	destroy_mount_options(fsopt);
 	return ERR_PTR(err);
 }
=20
@@ -1042,8 +1050,6 @@ static struct dentry *ceph_mount(struct file_system_t=
ype *fs_type,
 	fsc =3D create_fs_client(fsopt, opt);
 	if (IS_ERR(fsc)) {
 		res =3D ERR_CAST(fsc);
-		destroy_mount_options(fsopt);
-		ceph_destroy_options(opt);
 		goto out_final;
 	}
=20
--=20
2.17.1
