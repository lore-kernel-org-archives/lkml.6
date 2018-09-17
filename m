Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1352FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0509214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UFOFVlXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0509214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeIQI1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:04 -0400
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:58413
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeIQI1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKq/GnTFPG42xtOW77OZ5tkHhoLwL6ZBD4OxjOcmP2I=;
 b=UFOFVlXndL7bGADXzW+7bS758E69G3G4f++qVk7FDFoCJNcCsYHo4Xf6lVyi7Fexzn4vmkZbqtRMuDGYXAplOnoB+ODqA0vk6KRwqMsyaF/++FOre9FigOs8st6vLkfEfaT+AtIwpfIPQpV+uekqbL0fXfGKqHvWEhvndmyhlFQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 061/136] s390/scm_blk: correct numa_node in
 scm_blk_dev_setup
Thread-Topic: [PATCH AUTOSEL 4.18 061/136] s390/scm_blk: correct numa_node in
 scm_blk_dev_setup
Thread-Index: AQHUTjKjZWouCmitd0e16vY5TtsEYg==
Date:   Mon, 17 Sep 2018 03:00:50 +0000
Message-ID: <20180917030006.245495-61-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:TgW1ffcJDKLUfaRWC891wSunnP/UQVuBfO3rZKV9lhWfbR//kOPneXqzaAvVAqCaA3Be0IFIR46n8ZoTVjUOhClN+y/koYlDAZUvnyhMAnUMV8x8P/v55A4epfxdFeX8DK1u9ahcY3w6OhyPqgnONRPpimQ4at96l4vtz4dqo3g2AjnVkz27jPXBQvyEMBgHWzq90+YBIKHZRjfxUwNDsh/arfuFxSdzHqrtfjiYWivqFYADrP7OZWqFYrPnbes3YR20LfdKxKBOnS6P/QBtqYmHfb2oUurQdcsrQQUGssQSRswROYewMnA6umkE69uajraWlNQXPTR4NaZGeoFYdOFfosSlPqlE1rcEwjLLVuXkRSj25oL2dh6EyKGbhedn99ah2iCkrFipro8vFR/Cwv20I+Z9DscTplEal6GS8M+6TnKE8aTzmK8g4ipVgOKjNUtHeEloiJW6JdNq+yNzDg==;5:r2oYbIBl+4QGmpSjgPKtcxVWJKDXtM7eHcgKB8oexBG5xK+c2JyLnv79zF3eZN6pxpgV1l+JcvGSAbgbHZH/dY1zWlKPn3X+QznEs7nn3CERv7iCeQIr1KAnuM/jRCVEuiBJJY49k7xBVmtTy8Zt5Tn+zZ/TwTxKDTo9UNz3n3g=;7:NO0NE63EFHvdZ/O6VCtpppB1Av054B5vd5IdSiZNEuvRNv79DKs/luoRD/Nm69dh8iG16MDQAUfz0nSPr1b5sxODwAI093SvQNdHsKBavBIQKeVDW3cxAVfZ3+LC23hqTT3RYpfHovU64OYQGtjj8ndIPCPuKhv9fRJ0Gs/SH5O9LxrpkVPGMlyW+ivORpl+C6tFTYRnzwjOboDxmfTqXkSl0uZIW5a/y+QmXm0cPh8XlCQdDauEnNv1r750TDA+
x-ms-office365-filtering-correlation-id: bf368aa0-5672-4763-6173-08d61c49e89c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502ADD73CBF29E9A2BF8B00FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(6666003)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f7PAS0TZM17ByDKM2wpFhOqQpP2MTOuXpBIN2bUBsmiS/1j60y89kQ76F3+dOxXaxqBfFVnoPBQ1MkYxl5kSwuzII6YI8pmpe1atMAe4vmALiV3x0RhoNv/zE+rPv9tyESxFnwlcMwqGRKpGR9DPx408tHRbnRvBnn/0vNNi72BNM8URoVRVYmZ2Y1oyOOWbJZVtgNzpR13BK0kYFhpZcAWjm2xeyDISGqjXhHqVBa3jC3WpbBVFTpaztlQvbtKvasuVwjzqHS8VZ49DdCLaPXThGuv4XH9DT6qPSsLZO23Y87XFTZtUan8f0gNxdWDht+lIrSoG5cYexlrD3X04qBjGAOsi4B+yj2xS1hZ96bk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf368aa0-5672-4763-6173-08d61c49e89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:50.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit d642d6262f4fcfa5d200ec6e218c17f0c15b3390 ]

The numa_node field of the tag_set struct has to be explicitly
initialized, otherwise it stays as 0, which is a valid numa node id and
cause memory allocation failure if node 0 is offline.

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/block/scm_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index b1fcb76dd272..98f66b7b6794 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -455,6 +455,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct =
scm_device *scmdev)
 	bdev->tag_set.nr_hw_queues =3D nr_requests;
 	bdev->tag_set.queue_depth =3D nr_requests_per_io * nr_requests;
 	bdev->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
+	bdev->tag_set.numa_node =3D NUMA_NO_NODE;
=20
 	ret =3D blk_mq_alloc_tag_set(&bdev->tag_set);
 	if (ret)
--=20
2.17.1
