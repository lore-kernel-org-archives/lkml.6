Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE24320857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cYNpynhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE24320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeIGFQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:36 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729874AbeIGFQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN45VkYdg1b/+Wg9zNHd99H51W2sEt80dvemib1S3Qk=;
 b=cYNpynhDOELOdWVG9uRcG6LFxBMCDURcYCA/M7bpXYxNsgM7XJO/DfvjWI4p0Qx9hYmduTkdhd1CPI8pg8o0sOyix78EK1xxszpAdyu18DwFG97EWOHEfR4rNA7Nr8Epdbu8D1qGPlZBjF2ynF8ZOiVJn8h6vWroZixwSkpFGdA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/67] media: videobuf2-core: check for q->error
 in vb2_core_qbuf()
Thread-Topic: [PATCH AUTOSEL 4.14 19/67] media: videobuf2-core: check for
 q->error in vb2_core_qbuf()
Thread-Index: AQHURkL3TkNlsO5Jv0eIVTjAjXv0nQ==
Date:   Fri, 7 Sep 2018 00:37:33 +0000
Message-ID: <20180907003716.57737-19-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:2dpee4Xm//QMBUFdPlrSzNnz9A88JcrDQj3OyCnnjg+WkbNGU0z9vhy2tfL4dmlSaWM02aIwFUhgly44iLJu+WsvTOb8PyMN5XkaAgmZ1TPjGPiRl+sgQ66mi48LErzaKogbi7kHObsU3SrmJB6JUpupeOZRvEru9pbMlYoGBhnPN3DdAzdW3H5nsRjifirFEmlX38KOw/OVt7CEwKo+jhBqjZzupoY7BMDFuwHfbgJkgHEauLOECI4c4+31S/6ly8gOvOngd9pL6yCIj9xtKZEYDibCeYi7+VxbofAYuipUL7iMASpNC/dwSy0gbPGIsC2NVt5tw4f7m8SeEzp/jZNxMlOFnfWjiLgozkgLtgRFGasF7W0K+5sLFl983LWZg3AZZkR55h379V7WJV97QAn68C6DjkKv7cGJlra6XPMCyyZoMoin933FVB5D1KUYxa7Ed05o8OOcXP+U6J6ITw==;5:nj+LnntT82YhQWHbtsCysib/InJPKJZFM6P7vr9nyDX94KcAV4xvdY1Y8dqU2zhHuaX7ieI9aeCTSH81wrR/kIqD4jjJfNAb10IwVORYbn8Bt0Hdpq+bgci54I+dCwkGjkNFA8FaaivHfIluGwXRUhD3T9KyIupJsKQAuilvkCQ=;7:9oxxdYzfnnTHikbR6awDiJPUWedptF2TBPNjSyVsWeVe5lnV3lSKLOY7UowJTmHUTSqJrECpxJ5oSKOkcVkmBlfUPaYgZNeCZZnz1Cqfl4NhzKugmXHVVcQ5w25JrQUxSC7LfucCLCu5rhS4h8eIda2f1bB++qRUJVvBRpBChbBxWru8mgrOaTp3T+rpvullxWEnJVrYnyaR9H/QWuEr6z29xmJLIq+CFkAiAeYvIZwweYxfouDPhzdPSibt0LzC
x-ms-office365-filtering-correlation-id: f27e6cba-ac7d-4bdc-01f7-08d6145a3552
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075724C8D4C8600A5C791A3BFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ki6FIFOK/8a2KsFzxP5R2bDcR5A1aFSiwSdKaEY8ESqPKgYi+ApQIUzKsxRxfAUwV79Pq9o+sz/ARsiVR+BHcoJYQ9DGeRGCVrNG5JZPNGcz00wCYlxFV4v7PMupDJnBUk/IGsJ6d9u/zEKfMpknviP44Jcf9ZGU+xNrGCAJVQFty29OrOZbKRF+wpDe7mTxm5lXE7fdgQmukmv4CuNWaD7NwAqf3jf1YHpRHY1ZRlXizmxo+knX5RI/7eup60xJsC6dXkHb613o3DJkBQ/T7l3emU6SOQ19cecaRSldTZquxdDcJMeE2LLByjjnJHcAxR8c8TipxCLZh4pZt++pIuZ1D0kZLNhO0TCVfT3h2N0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27e6cba-ac7d-4bdc-01f7-08d6145a3552
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:33.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
 drivers/media/v4l2-core/videobuf2-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-=
core/videobuf2-core.c
index 2dbf632c10de..43522a09b11d 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -1373,6 +1373,11 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int =
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
