Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6969ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716A9214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EiVfnTHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716A9214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbeIXUyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:00 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731084AbeIXUx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+k6R4Fgn+eqcYYIDDiJE83Rop6/I3ULv2MS3LR9gmE=;
 b=EiVfnTHOsidsSq6zMoYUeNYMZHya0KQC3woDAczRyWNUWnuFunMWLXRxqROANiRr6f6B0OtfyPsgBGUMdQBoYmRWt07dJqJAJJ1zDvJlPdKuVlJ3+vSVuaIWmgRHioFqHxg3mONOsq+DSPwdPj3AxUM2Epjyi9CUel5WpYnupIA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 07/18] RAID10 BUG_ON in raise_barrier when force
 is true and conf->barrier is 0
Thread-Topic: [PATCH AUTOSEL 4.4 07/18] RAID10 BUG_ON in raise_barrier when
 force is true and conf->barrier is 0
Thread-Index: AQHUVBXXUm36IVavNUqfnYbd3wtBxQ==
Date:   Mon, 24 Sep 2018 14:49:48 +0000
Message-ID: <20180924144942.164688-7-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:G0JKJDmyZNy5B7V1m/ffStIZ++uXhn8rZTULxorZBDUxOxyWsfceV+CTGd3juhlNs+R2k6uvXKjN6qUQiAHd1CSalmo+JSDSU8SUzz3wqDcI+7aqOXd5PQiF6jsm1FrGXrM0rl3MUuIPVYBQg1DWxQnmGcWYYNqcO1UaJSyCB7xCtv+LAhlfwL0FQhplO5WfD7RAIi26Lu5YxkZRFD/lgpg/ACrY5sxB0HjCso8U4hE5XXG1GV35J7HqE0PZUi8zsRVVMW8EQFJtJwbaaoUJXMZAJP3lo1vIzANnxvonrHQrAEi/VINkdZ0cVIIAFDNd2ROIUZyci1/e3VgXrW5H50mDoHpYG6JkoAaoQ3pZhWuUC9KeBosdkOYJeZH9vaiBA0sht9+8cbh+vGovOy/boc+06zTmnciOwI/76+4HrgnSLEgeIeG5cnocE0UOuSi3nGOCTa/ASnzDg4obQ+6CiA==;5:qyIPk0pXboMLaCOXiAboFOhs6PsSvFhxOEKU73h1fF/ilT7pAF6vOMLHnL7d/QSjKxSQCDtU5G4ZNESX50k3FyMQP7bmKRuacl7MU5A13N3So2YFMrhLpEkl5jctWnC6z7pFhGEJYYduAnjoUgl+E3wjmU3OL33JW+fA+3cqi30=;7:YZK8xkh1A+az9P92XEjzHx7jCWaq17LjTBqMm5/05Zm8wP9DqXVplbWqBarJGbSMDCd6DoaViAWSZJj8DSsk1LWasFNy/+I1nXTPjBQLgYX3NQ6FzwkZvPDj+gDaosO/kkewhmDTr8H9MX+PYZiOebluve63BHSHIAyfJqfWvEeQ8uX80bUdHEtbmiKFrnaDBzPJEokcSwABC8wOrp+pjKb7xwyCa9uHR0rVJBEfFLEtz40CuRZ+Er5xUj1t7QD4
x-ms-office365-filtering-correlation-id: 5b9a98f7-95fa-44c7-b319-08d6222d293e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08216BDB9367C9B1CDC71070FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(575784001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JB7Liw2tmg891L56ADTT4LvkzAvPqbLptKxa34IuNaK62670Fe3n/4DwAVVTG/tLKkoYRMNK/Cmt0KMungrzvhDK8aBmReenMGwqCdxJRP4iq3w7wDi1Q0IQusM/7DBFUmcjLAAGnCAu7kCOXFFkCUxrpk3m4o+6Tw7K8IChwUiKniQeLUUrH2Z1JlC1CwwhBAmISwLE1OjOORjFAM4N14wRMI/D9BbNHKwFhZuZ1pJRmKPs6rTic64w+ZrmIhfziKixXXT9fckWnZUuE9J19XeldzdGIe6tmczdXYQRwFQQ4D3JtAnLWprkKYPCtedWrkSPgX0pN1gY9XMKtNLteYMKB79h/KNpnQ93kJ99qwQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9a98f7-95fa-44c7-b319-08d6222d293e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:48.9169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Ni <xni@redhat.com>

[ Upstream commit 1d0ffd264204eba1861865560f1f7f7a92919384 ]

In raid10 reshape_request it gets max_sectors in read_balance. If the under=
layer disks
have bad blocks, the max_sectors is less than last. It will call goto read_=
more many
times. It calls raise_barrier(conf, sectors_done !=3D 0) every time. In thi=
s condition
sectors_done is not 0. So the value passed to the argument force of raise_b=
arrier is
true.

In raise_barrier it checks conf->barrier when force is true. If force is tr=
ue and
conf->barrier is 0, it panic. In this case reshape_request submits bio to u=
nder layer
disks. And in the callback function of the bio it calls lower_barrier. If t=
he bio
finishes before calling raise_barrier again, it can trigger the BUG_ON.

Add one pair of raise_barrier/lower_barrier to fix this bug.

Signed-off-by: Xiao Ni <xni@redhat.com>
Suggested-by: Neil Brown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid10.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8a731bdd268e..89111d455b71 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4336,11 +4336,12 @@ static sector_t reshape_request(struct mddev *mddev=
, sector_t sector_nr,
 		allow_barrier(conf);
 	}
=20
+	raise_barrier(conf, 0);
 read_more:
 	/* Now schedule reads for blocks from sector_nr to last */
 	r10_bio =3D mempool_alloc(conf->r10buf_pool, GFP_NOIO);
 	r10_bio->state =3D 0;
-	raise_barrier(conf, sectors_done !=3D 0);
+	raise_barrier(conf, 1);
 	atomic_set(&r10_bio->remaining, 0);
 	r10_bio->mddev =3D mddev;
 	r10_bio->sector =3D sector_nr;
@@ -4445,6 +4446,8 @@ static sector_t reshape_request(struct mddev *mddev, =
sector_t sector_nr,
 	if (sector_nr <=3D last)
 		goto read_more;
=20
+	lower_barrier(conf);
+
 	/* Now that we have done the whole section we can
 	 * update reshape_progress
 	 */
--=20
2.17.1
