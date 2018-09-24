Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A96C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445B52087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bcquHsrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445B52087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeIXUzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:55:17 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731346AbeIXUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhM9JsurRxCQbypWW54QlGCC2HhzwntBT4OROeQRuJA=;
 b=bcquHsrR7q5mEGmgDGlG5PEGcUd9bcQHXlfAgkuMlCrnChb5GzYhIIcnO+NoB2HIYBIvry6nRsTJm6Q13vUTUCFvGcb5WWb++QB0DkVFn6CJWsJYAJspOia3DnUdrGQO9kAfOUn9TLAKniXGFpb5kt60zy+ZAAuEXRlFLjpOnmg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 05/13] RAID10 BUG_ON in raise_barrier when force
 is true and conf->barrier is 0
Thread-Topic: [PATCH AUTOSEL 3.18 05/13] RAID10 BUG_ON in raise_barrier when
 force is true and conf->barrier is 0
Thread-Index: AQHUVBXkTY7iKKR1ekOWfu64h+fptA==
Date:   Mon, 24 Sep 2018 14:50:10 +0000
Message-ID: <20180924144959.164754-5-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:jaiOO/o4fckKpeErWZCQBvpVTH4xY8ZVfbltGMrrqY6ST1mPegS+YFK+wM3Uyu9aY5kWTXJLGY8JaUCpPx6Gkix/Ap1P4lTYFwbiLFSxOyZdzWu/s3vKy5JOd0Oq/VGw6B4qRhLENVNnMY0oAHK6qfXGGKBsAqJm4iReLSv6SBz7YvSUS2Xes2qD/sDK+u27e/FCb6h4Mh2ReZumKQB6vu9BjOSPOHFyXevKoIlDwtsZcBLCgeXynewO5Vi+ls5QEEjn6T3ZNtEL0QPRBPfS27KfAiY1FhvPvfNLe9E9eC/hB1deu6398gMb8yb41Yvz+WnwF25+VxKdb4fcvK9H0E7nkwieoczOzXVjFIshrQ92jfAbgLxaqB79GBcfry+JE6AxJpqR3SVUeaXHWnnJNXzqfdIBwUr4jFrwle74GHa6k0OB8gv+N1cogc5UWmP2eErOJ/tJIJ6GLW6hZpxO5Q==;5:eNZhTuezc7KsxwJWTZn/qwlyECZa3Z30ikOr/TFQ21IbgkNYMvznNzF67J2J2GGBUwgUQc+XBmYiTKozlUB33Om8bXFv4/IjxZAggNKLUQdTt5evjPu0HSNqx7uI7W4AhiQd1EGVxjGolAl5RF2gkNVPh7B3zp2FZ0VQblI2i2k=;7:gs7p8PF96rphOvY1OYKp0pIL0Y/XbVrp3nln00lNQMsA67r9tNvRgXiBzHM0P8IXFzb6MW1RRWQL/MidLIPmgim08j73Qsp9d5kisL+YqCXlQ7DjMCU1JFGINn/wBuSZPvq01DKF7Te1/Cio7V+QTYXejMApXXBW//DN2784McM4ll2KF8DsIus5nWYZiNddWsv5mto6UiRoaEf/kLl8Fm+xFFvx3K7vQRy5neF3NAC2mNFtOsdFFDVnEYdcnx4t
x-ms-office365-filtering-correlation-id: 51f653f8-2046-4cd0-f5fc-08d6222d4194
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631FA7366C5079007E20B02FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(575784001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8cte/2ge2YU6Qj0LX29HptgY+/9NLOU17mUHZMogJ/ETpWM/TjMrdxlagzpclPELBwldRl/thRpRBVCJWJo/w25Clzqu/NI+k9ubOsgQx7IAimm3ZF/La1VP5Wd/MmNIMD3WqbNmuZ/OVhmS6wIXtaXL7P7LUEhWT5xi2ml9ZbgnBw6kqrpN2UUOQg0sWlwirD+Zel65App4UM84LexZBB2huxia+UjqXXUsgP+S/BjP3qB9BI+MnIY9jml4DmEoTEH51Fh3dW7ViwAaymHyt/dbjaeE2J6e5uTvyRG6DgjBqjMYz7N3cTCoc7vjhMrXspg2J398pOmWYNQ9SAcQEnGfQ8HmCFAB4uyQurahtBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f653f8-2046-4cd0-f5fc-08d6222d4194
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:10.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index bd26567248b3..d09e227a7213 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4423,11 +4423,12 @@ static sector_t reshape_request(struct mddev *mddev=
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
@@ -4532,6 +4533,8 @@ static sector_t reshape_request(struct mddev *mddev, =
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
