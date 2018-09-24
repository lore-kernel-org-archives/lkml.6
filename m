Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5659214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CcTJMZG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5659214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeIXUxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:31 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:36480
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731073AbeIXUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnQuVKkXWEgJMoUF5mHnTYTgkd+J9Vz+Vhz52Flrq5Q=;
 b=CcTJMZG5LaIqJL4tZ+pTCd0pbstD5FAh7lOK6lRLYL74jnij5TxlXmQL6aOYtnnzcGZc41CEqEZq3BGuOCG+WLZ6YT80sCKFBfK31iHgnA1oMmQBZkzg9AuTkaOKVU8Mzv7tl9cIShbOJjHkAiu0lce2vY9gSlghs4Cav+jX/FM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/23] RAID10 BUG_ON in raise_barrier when force
 is true and conf->barrier is 0
Thread-Topic: [PATCH AUTOSEL 4.9 11/23] RAID10 BUG_ON in raise_barrier when
 force is true and conf->barrier is 0
Thread-Index: AQHUVBXMRuoAVAofVUmemDfhI0q+Fw==
Date:   Mon, 24 Sep 2018 14:49:29 +0000
Message-ID: <20180924144919.164617-11-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:Yk1mSWzK+JLc4RfIWmnec6yraZ+JLEyKMfPzCJtuLFCRtzlNhI4VhTl07RNhjA7Ilyzr+t7wu9+n4ldwzURRkiPbOhfqT19xArW7V624b2MFpRh8cdwtJLSDM3I7c7rmyc68LM0FMJ60XFknc0Cop5vMkIsVfQK0pl69O/5D6hf3uRuQvCOlgXQpv3H3OeohDlIT+OFCJfQ7lT3p1WBnQwKMp2p+kzobRwE5nBeNQI/vVduXL/koOa77dKpW9+6q42mi06zsGCWsV1a4jzVgDStbZaRGRq2b+opUG8pXcwmStjDOR/G1zXEsBbD9kl9Pfe6iGQBuQNJvp80B8R1dk3SOV7r5jY381Vt9Vy1+s97EDxug+KFMKTS2GtGGjrhJyXY0p7wKwqMYLxZdxtL4cWblw//WufFw5E7VFWJDHpwtljjFVKnGAF60O/Vf+kiAkeddwyE8T1ChYtrSj1q6fA==;5:bTssaW5vjwqKPl8Y4PdiCh7syhvMe2MZyqKpWIp3dqq0+EgDoeg1AgAFw+l2if7f29dGTHsEKfJoV3TiJ2vaRNux/r9+uZNayGVHWAYc8uly8JLl7IsYd82yOBiKZ0w/9Sn9Dhelmu/nc+2DHnhrJGJ7i92fZVd7SawUj+Clz7Y=;7:BHVBMpLc83rJRIyuliLEiGCSv9isWMkGyR1dunQBb/AQGKN7qelihdJqbD7gWy4mxAekQ+SlEPpCN7samGu2oV50G9dkcTmhKMLyVXawX6bywc4Q0g2PivAR7c3pUag1ttor8aSY0BuHK2WYbqmD/vIoumqYKYJoV4FgmdoKj568nQ4Vj3H6t5PA6cRUax/vkL9e03Z2kLbcAeCbSLQFPfpVx3pGuJjSyBb/wWvOVlJoad4Cs/xbHFtAMcYZ6rLB
x-ms-office365-filtering-correlation-id: ebc79bca-abde-4379-d553-08d6222d2337
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181DB47D6C934A7C2D890BDFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JJa4XWg94iLPqQVurHgKwVVrs3fEu8nHZIv8YdI0JRx63MMe1l2EhspqlnHt4vZSRw4dosLjbTMYgTXR/n0/JXIq5Cqu3eV0gD8RXRjUaDrjkQoFs1HsDMutalUFfUzRP3o1DxOU4mEmEMw9G9Gf90xsM/xYub9EkD7gndDU8TuD2OZAPrUNgVSk1E5Q1vi8Wrc0tTOFbkJbqDerrhKf7+zkqCorIEfQpx5+Mb7ai37jGHfiyEqYC7Y1laHx1AoRNRNKW9c7804DZs/vUvMcSrxOaX/dwMejfNqotcNTtvBiR8QjJJDIjiqBFbSn92X5vduSGnEVdIBXxxMiQpqabp5UCtRPIZfHBSz5rggGFFo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc79bca-abde-4379-d553-08d6222d2337
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:29.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 6da66c3acd46..b3046063402c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4381,11 +4381,12 @@ static sector_t reshape_request(struct mddev *mddev=
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
@@ -4492,6 +4493,8 @@ static sector_t reshape_request(struct mddev *mddev, =
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
