Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96011C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4682A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PnPz7YBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4682A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeIGFjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:39:42 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728091AbeIGFOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=illqL39iomz/rTma/yjJHq77MK4qnrFt8qpf5pZVJW0=;
 b=PnPz7YBe3tHCsGOW/VAoJLZKnbibzH1TP4rHdq0nSEprBHlYRw126+Zdqewk0T71Vn7ba35dm3nxlKAXFIUPTjbnznoRG+ESSYujG5lGxGdOaCsJqVI1uh5Keb8ZQ+UtLp28i+RvAdRU4m0+DeI6A1cZhe8N1V+AxkzPrTexGPQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 27/88] media: videobuf2-core: check for q->error
 in vb2_core_qbuf()
Thread-Topic: [PATCH AUTOSEL 4.18 27/88] media: videobuf2-core: check for
 q->error in vb2_core_qbuf()
Thread-Index: AQHURkLGfbmwX2o1PEyQf4OaJzPr3g==
Date:   Fri, 7 Sep 2018 00:36:11 +0000
Message-ID: <20180907003547.57567-27-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:dW4KIwNw5IBLUUrPlojSDr0cZdQMGM4E0BZXAvHpIywxdptdf+GYfln8KR8aoG0+b2SVriLm7S3Ut5gExpNksYuPFX8y6y5tG8k38tP1KPdaT2HGu1bFwwGAsbQChXbWGB2qryH530DUnUhD/uBxvmOOKchfVdbeEgqMCKPJb5fSyUYpaqFZXncMkVRn8i97wLtdzzK9RJ/nH877tXIut8ztYP5U8MsCYj5AC9IU8MDrhQr9usC3mQaowXSvxH5zOmNcqhbWUWh4G9lTT1qJckzBEHWcYz3qjFCvCQhSoBgRXNxi9+2FuqiekdxW29Guro0vT7b1OuR4Qv+ER/1FKXdwX4Ns3Afrpox6oKOTewBbtivaLv27G3Kygmnr8N712tCHORlD5ug8KGtVsy44KZNndtLDhSQbD1cq9x02YzJluF8ydvy+TYfvNYj4k6u1ItLUzW9ggz6ppZqF+S248g==;5:Ee1/BpYJ28Y7LRdqPcXKMqycQHh5gk2b+cr/ilKWc5PRtz+hO6scaxMEXDORrqZuHZ8OpU1/hc+ox0D7vcNnsebPQ6tbNIq0whGXQNB4A5EugFs/58nnsO/OJxEz6nwoNuhQwMsJo6DSt2z4jDnbT+ZY8OdCMdzvTbhTGpZYR5Y=;7:mdIQH5zXbUu6+34DZN5V6eIVAtiQ01tKgtWX4Plzbem6qzYIHDSDs7uD+z35e8/JTCtLrgYMkLKKkcaTHdlVrzWaQMggNF+Gm439pQGbSQFuca83yWmR+kZ91q5i5F/bsc8EWy1L5japyC56Spgp7Z4eIr5iLnpAE0GTizvptKhcBid00FIJbjWBi6SzT4YOpxSO2CfBDwk1b0VmoTqaAPanj6w6hy3utAgOknBQOHuUC+OJ5PJ7OJNS7fAZaJ+w
x-ms-office365-filtering-correlation-id: 815eee95-3cbb-47c2-b77c-08d61459e91b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB08249C6D2309CF1316C317DCFB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 3lvCoS2CPRthXBMUQV6wIePP3Ha50ZAMRHjYm6XF7o0VeDwvW7mabQkarIHgMuOWQzVZU261y967WWC7hxMKuT/kQ65KEBDjWA/F5K0DHAV1cnGFb0RxZW5RESFii9hGvx2ktYrlUpTyAbkmZp1fmm5LYF3rCJ6SzAmD5EORxk2UftdwviBcYau2HTTeNUImjaz5ak9Yqm4cXYzLl0K0mmrTFr8BNYbDG9UCauVwppey0YyYtST8p1hPJC+OPoKYqrKakNwDZwYZ63l4UW21O6JNIfc8AiOqTnX4rKYi1DDc9ZpVYkKUEz+lU1hR7r0w/vqMLqxM/x8LkGgGXQnPZZxwgkjht0MpYRuao6l8B44=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815eee95-3cbb-47c2-b77c-08d61459e91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:11.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit b509d733d337417bcb7fa4a35be3b9a49332b724 ]

The vb2_core_qbuf() function didn't check if q->error was set. It is
checked in __buf_prepare(), but that function isn't called if the buffer
was already prepared before with VIDIOC_PREPARE_BUF.

So check it at the start of vb2_core_qbuf() as well.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/medi=
a/common/videobuf2/videobuf2-core.c
index f32ec7342ef0..5653e8eebe2b 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1377,6 +1377,11 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int =
index, void *pb)
 	struct vb2_buffer *vb;
 	int ret;
=20
+	if (q->error) {
+		dprintk(1, "fatal error occurred on queue\n");
+		return -EIO;
+	}
+
 	vb =3D q->bufs[index];
=20
 	switch (vb->state) {
--=20
2.17.1
