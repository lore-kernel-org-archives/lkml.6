Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D722E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kamdoXjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D722E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbeIXVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:00:25 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:27262
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388258AbeIXUwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nllL7VAdht3WkkvAkZmwwJlrhTU7q7maoORhDGNsTPc=;
 b=kamdoXjqDfGa4QurulcuyN1+AP/5L1QHkwrjMrGHTm9Nf5kr5atafqEGxJPR+icjnC9L0PHoQoEbfkvBton3EnL6FVE2RgHolsLh8Yu/f+ZRPSl0e2oAbTizndcRBKLQ/ssGHr6Bh7ALTlR2ixGW1Kliy9l3fEZh6TGMAdqGKbQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 23/36] RAID10 BUG_ON in raise_barrier when force
 is true and conf->barrier is 0
Thread-Topic: [PATCH AUTOSEL 4.14 23/36] RAID10 BUG_ON in raise_barrier when
 force is true and conf->barrier is 0
Thread-Index: AQHUVBW+d9VkKTfrO02k4MTvqrp+Gg==
Date:   Mon, 24 Sep 2018 14:49:06 +0000
Message-ID: <20180924144851.164533-23-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:arOaFJJsT9lweUWSUp1GpTEDGlJRnBEIY3jfYhA0vWW2cJInKhAHlduYZi9aAP4v6kpE90ZtaVt2IB5aZGEf2rVJkqt20VeUq3OAV+L2cDaAFu6jHIWyjSDyxEmyCObhMwndy9e/gmZMF5be1/VCSDzkKErVf6dh7MD9ie/vijQFVdxdAk51SSV/idtyOG7o27hbqb6vQukSfjTGqku7ZrWsrtnAvndqYfRBGQ5r1vl9poIRplRN6G6y2fsMXEBkaTr3GXvTfH08KtpGDpNqENN7KN4MzqxS3msPfyQq++lrp8dyzy/GTLnE9HSlXcJBc55yiM8Xr4F+CzSb0y5MTIVxteVBEevH2mSbPmb5cQJ8zmGBPnk9Gpty6mfN2f/mdYXCp4s5oBZrvXD89mWL2fDEv1lEg5FrPQgscJNLKDXRQXa82qa64SRntakwJ6RL2pCGd1ZKIxTydZBSL9vDcg==;5:cTORdIt2Q/XIYDHM15d84ZElVCYJouDel6RSOASSe0u88nf/LeFfGNMkpjF112s/rcxQ6Ck+RSO+bH7wLQtJFI+AQlK+sIYI9ix8X8oMga+Vw0nP7SdaoV7yHCZ4JVaepLuYtKPmZ4hBO4Ie+2I6hpyUUez+Iv0iCfe4ipDUOc8=;7:SmqVJYxk/pYqK9CXZhENH3V9kHm7JhINecd+w5B5Eb2t3eOSjLYWljCqJez6SDOCHicN42VKDEDDgZ3pblptHK7DUVm3ND2/EVY+c1N352Gf1psI9rABDDLujCVKgFLgEjcumK8fUVRZQqZQ6BLFe8erxwZXaU7Inzdxj/m2DrdG10Fe/WTD+x9sF+Ums2EQrDzooZnCJWREiC56RcNMLplsXxsHN4PX4bO+iCglnVxkzyk2EnhxbHwgWXY+eWMh
x-ms-office365-filtering-correlation-id: 76098b70-0443-42fa-6700-08d6222d0b2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04701EDE989D9D22C4380BE9FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ob6DJxCrYTfDymM1XiF+jCmrrhxuhna+fZGn1DamOg+PFWDXSkklQiKwsivdqoIoGzh+YwaVmodzrHwRrEyrelaiQQGbaEINmWoHWuMWfWOrqQmxU4w1fHhG7R5HHz2oBiGuRrPxKBC88RR5jVtd7Ln6Hiju7m/Rb+B1Goud3XwDGAhKv+koXDRGCGfdIQAiE80tSU5i0ExPjBsZv/kQrR4aZS0BbDnWQUeb75KsnYoQdqwNAk8UNZp+cWXzINVcZQ4Zhfppf9IXPUOs5uYYAhY98DcSDum/l5jaH/KUuqJUumEph8+CAEtpl/aTrjaQ2Io+0jVSWrECfERudsS1sUaxgO1RQ4B9I9sSbMSWJQg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76098b70-0443-42fa-6700-08d6222d0b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:06.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index 262a0f0f8fd5..927b60e9d3ca 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4394,11 +4394,12 @@ static sector_t reshape_request(struct mddev *mddev=
, sector_t sector_nr,
 		allow_barrier(conf);
 	}
=20
+	raise_barrier(conf, 0);
 read_more:
 	/* Now schedule reads for blocks from sector_nr to last */
 	r10_bio =3D raid10_alloc_init_r10buf(conf);
 	r10_bio->state =3D 0;
-	raise_barrier(conf, sectors_done !=3D 0);
+	raise_barrier(conf, 1);
 	atomic_set(&r10_bio->remaining, 0);
 	r10_bio->mddev =3D mddev;
 	r10_bio->sector =3D sector_nr;
@@ -4494,6 +4495,8 @@ static sector_t reshape_request(struct mddev *mddev, =
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
