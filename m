Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE7DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF5B2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Md4QH35r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF5B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeIXVFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:07 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733212AbeIXUvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATjAgFmO4AOn4bhIB3NkS5e4G0w3SnL7c83vqqRmxfM=;
 b=Md4QH35r22jMCaubpqrK0zqSBa5LGkgCEHgfymbfMOYcZVVc7htcg/sT8p/+87BdTXxztkJcgD9cAROEiv0ji5jWhRevlig9eINSqi+LnVowRrktaRTvTqUS+eEs8Noa3GhTUDg+QyPOUcMc8Zb+hBJ5Q3FkIzmjNF3KlvY/VT0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 46/76] RAID10 BUG_ON in raise_barrier when force
 is true and conf->barrier is 0
Thread-Topic: [PATCH AUTOSEL 4.18 46/76] RAID10 BUG_ON in raise_barrier when
 force is true and conf->barrier is 0
Thread-Index: AQHUVBWoG2X23mUZZkybAsIgMhcrNQ==
Date:   Mon, 24 Sep 2018 14:48:30 +0000
Message-ID: <20180924144751.164410-45-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:jPwJ+gRsEc+rDW/A+3VJ3NgxXSbbQBh026zq0l1ZomCbs4b844DNxmNOsjtO3MGeXVV2sOwB8SOwmYPGnMSVgD/EhOS9n7FA1+Pf2InIVB6gw3ylHZaC2ikyZsMsLt+fMMfbr03moNbwbLVrvXe+VBWA2friflisiUGV4j5I5i2Z3q4M2SUGp9L7chHAKR0jHCfgG44h11rXhnfh9s2EmmXwZWfybyVCx/ZRP102db/9NI/phypmk1aGLszSoLLItPGmvVecX4nQr/FiHMzsug+agz+3M8VXdO+qbJaDYyh9zoEhufLO4icIF1886sFJvPgFxEpwUBv+HCqZ9Z057lix1wRfY/8DXWKy8oEG1CourwEuB+Z7Jol1qw/3YOVzosoGRF2hN+MKuoSZ5qgk8RQ3nYwoLhR1AqAiHLaJCUI9EtV7tI1BQGl6aSTlE6G+CdvgVNhVmqFw6Xe2zu1yEQ==;5:ryS9QN60kkoiptrtZgg+NNX1c9xWdhHqVpvfMlwxV0LfN0Jwbna9VVvddCyBY+joGfoQkwKqbHGcKXxuwLbSFkBnWwDIw2R0JvjLTphfMpvTT/XGBvbi6YLNInxEiIoUCSnGMEfg56iMMccIVxqEtiVlfeygqAcsP5y8NPGF6hE=;7:cGdqu8WEmqCSMil4DHTkTJY/dKaW6Xj6Wqj4TFQMoszFJxu/wGbj53xEb7mYasLBXxBBPu1Jn35WuVZy3L7zVzTTQ+yfZNgx5giS8wSoCYxW/2E24u58u4ye6mlbozbyyiqqqIwUL5DVuGdLvk19Zl1LXT5f/SqhTsrQAzeMNZ++E6AvlvoHp1JW78fnMagqpX7CreV3d1LFzEDBEm1f0Tq9q/VauPSSLegIWzVfxUyat9Z/WciRJv5RQTKJ/BLf
x-ms-office365-filtering-correlation-id: 5d47e3b6-edff-495a-696e-08d6222cdb1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855AEEB308B111EA3C49E8EFB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U7oo8XQKuY9fPBu0B1A/7q0zA5MTUBg4J2uBdMTyEhJEwFaRTl5OnBDgkc3XkalJk40j4xmkZiM9HazBVdywurX9zdLafVQBz8Np9VnrjzBSyrXVPFRme0PiQm8uXglUJid8uAZD/etlvSxmncsZTibAA7FONakMYjODMX88jGqBNUkA8vxttBCHeLCtFCC0HREYCMB4ZtvLfz99aMLbI1iHrr7F+4ElyUC4hIHLnGomIFXsAQuSheoY4a7YFjoebC+QvFo//6YVSqz8cK21m+CA7FZ5UPFnu8A9h4+wURxCoYwTTr9FosBVi7t6XJ3ZTrvjE6YWdTwzAEOJJtWs8yRXnQIBYfXgaXunOAzEE8s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d47e3b6-edff-495a-696e-08d6222cdb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:30.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 35bd3a62451b..8c93d44a052c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4531,11 +4531,12 @@ static sector_t reshape_request(struct mddev *mddev=
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
@@ -4631,6 +4632,8 @@ static sector_t reshape_request(struct mddev *mddev, =
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
