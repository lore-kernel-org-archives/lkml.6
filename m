Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C411DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74384208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Io8n0k7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74384208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbeIQIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:55:14 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:64704
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbeIQI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frzDO3wrSePMoXULaTKEoOg1DObffLkyuOHWSn45JPQ=;
 b=Io8n0k7+Nxa8tDsSWH+WZ4AEMwF5CRtHKK/8oDbmbZ2ha0lDQSiH6izt7hGOcSkKnU6uGUSY2kgydmae+Jxmh+8w4eqBkn8roEe5tvUp749F+JV9C+3RRy+eDWh5YSOIESiDA9/ftk0MK+xYHOtBGmAhO49W3fnnZFVVFFVoFSk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 098/136] RDMA/uverbs: Don't overwrite NULL
 pointer with ZERO_SIZE_PTR
Thread-Topic: [PATCH AUTOSEL 4.18 098/136] RDMA/uverbs: Don't overwrite NULL
 pointer with ZERO_SIZE_PTR
Thread-Index: AQHUTjKxl1C2KG7EB0Osj3S81Nkljw==
Date:   Mon, 17 Sep 2018 03:01:13 +0000
Message-ID: <20180917030006.245495-98-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:20KSAFcI6aLlygneapcPsx455Ax210NwafmPryC9F2Y1lw8wvz0vprWYNwPZxh2IbjqdzhUOvkEkX58o4KwtNyz3xNLEQW6KWyt0Tz5Sjwsc1GcS4Xc+IZduxRGbo9liV1gydSvHt0lyfZESjxf9mKODd5hY64jfnICvMW8m/yB2ooAdPJ8SmtugfeRtQrN5ncKZFHKMWBPBv4bEjzHxZXbAot3tErXjxHrowvdBGsEIl/sQ+ByG/PcKBlfI/IqF2SludaWuDhVZW4BxaJ3Iv5Qy4pu7d+C/2Cl94/y9bnYH7KY9M5kkaNT1wHJhgpQ8eNZnCaBiuZDXk2zA/VFh/AJavMbWfb9Ww7hM7XaMCy2MgrZ6sh5OYQapTMe/PTbvqJW7CI1FR/yOtv2sbKwb5LLpRjHyqbByiFnInGNpbUNgsWhCr39eGhFS4WD6SSmKp5ccyC7Cwy3YXMJN5tRtwA==;5:SrOwXnslFw5BvRQwEijrCzKsKmiyTqo8ahJfEEl/Xp9az0dS7F6jr4u0slotkMvYnnXKOKAgG3Da4DdeBayGUljHRLD1VWCt98qiZ0MZDUdmBVQNZx0MVd1IcR64O6DGiGq+7/fL3vJzLvpDtuVVqVLQexkiEUc0pBu413uNf2M=;7:IOfiScf4yOqGeEKXZGuz914xXiROy6a3rlp+fw5dUErFIXG+0ig938wVHzouOd9UKsMqna7k5Kp2AAmlOaqAstciEr9WOdDZbVidbj/rHuiH6CxITBIJfLxoZHcGBKQaZ9Qir7b6ezhS+gh+RHlyMTP0ujjwtJ8vkzmFU+cSXC0Wbr0DZ+v1jT16duXc+6zuqbuRyl8biJN6zJvORbl1lLHbBlUBj994mW4L41L3nPpNj5wA6N7vRpEegfa8n+Wm
x-ms-office365-filtering-correlation-id: f5a4c53e-1e30-45a1-4199-08d61c4a05b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790231A6806CF0B9A118AEDFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: D5AUfg6/X7sO7CL/MifwZyG4o9OKqJU0UqwkhjrXXVfjgeFb5tE40BswiPRov2dP2XLG9dMz1rHaWjXYRSoBDBDdEsjG19MkLxys4SrjVDTGzwOZiGY/6R0jWitBy9fdZxDIM7OIbiCDpfhtkzxfcDZBXgsf956igdA5OccPS1AIKydD0dz0dOF0Yq1KC5NmuwrNKCoTXwjKRD2lO+NzN3cMfEO2xIpI2V8SAl0K065WyCS7TJ2n/yx8G6oBmuvfVaUsW6Jq28TXyC6Aq/GPv5ENV0hmog862SqraqzWqyLX8Aq6ET1qc7LqyN46+aUzJfBGufYDD7keGBugnYzdupzkUcbqTNBahcF3GVaGChA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a4c53e-1e30-45a1-4199-08d61c4a05b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:13.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit a5cc9831af05e658543593abaee45a29d061bac4 ]

Number of specs is provided by user and in valid case can be equal to zero.
Such argument causes to call to kcalloc() with zero-length request and in
return the ZERO_SIZE_PTR is assigned. This pointer is different from NULL
and makes various if (..) checks to success.

Fixes: b6ba4a9aa59f ("IB/uverbs: Add support for flow counters")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core=
/uverbs_cmd.c
index 583d3a10b940..0e5eb0f547d3 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2812,6 +2812,9 @@ static struct ib_uflow_resources *flow_resources_allo=
c(size_t num_specs)
 	if (!resources)
 		goto err_res;
=20
+	if (!num_specs)
+		goto out;
+
 	resources->counters =3D
 		kcalloc(num_specs, sizeof(*resources->counters), GFP_KERNEL);
=20
@@ -2824,8 +2827,8 @@ static struct ib_uflow_resources *flow_resources_allo=
c(size_t num_specs)
 	if (!resources->collection)
 		goto err_collection;
=20
+out:
 	resources->max =3D num_specs;
-
 	return resources;
=20
 err_collection:
--=20
2.17.1
