Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A19CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3896820876
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R7iDH10k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3896820876
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIGFY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:24:28 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:11972
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730499AbeIGFTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIKgLxZqgjslImYEWHdzQaL10r7b51aVc/HwxkPKA2o=;
 b=R7iDH10kccc3Sk9KFAvuVAyeOSBZA/U6UOHEdpBUPZ/Gi+VxzGpnV2rHIuurlGyOklSDCMUaKWpOXPeYauFzmG0+VjeCEU41sqL35otVQTqGREcXiI10MJKX9R0apFstB/iR5EuPKiXkX/efYJftbfoZNtUv+M5/91ONSv+PF3s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 11/30] media: videobuf2-core: check for q->error
 in vb2_core_qbuf()
Thread-Topic: [PATCH AUTOSEL 4.4 11/30] media: videobuf2-core: check for
 q->error in vb2_core_qbuf()
Thread-Index: AQHURkMtY8qyerApHUqWeRRjUaenGQ==
Date:   Fri, 7 Sep 2018 00:39:03 +0000
Message-ID: <20180907003853.57942-11-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:0kfLPE8881Lxd3eI4e6nwxUM2gjn5P33LGpTpXPl+tlhfN2Q1nXgKBtB4FmP5kFJe585uCjnA3g5LIehwb/6XLZExNO1wJwv78hk9KKNd4+85RFqV9BNaOru6cmJlvls+nH3KHE7BJmivc+GU1wJ4BYtE+Kiv/Pa8JUoWNDJYxYbfYj25GAa7JNHAWR+Jv3Huy3j2m2F8BRQRWKMBdSL0lzPDsIFfCt18CnkLy+0dyDA6/OgOh+6KaN3FYh+CuY5T6/orsQLwil4MI/2EWt/IODzcEtsD3M04oKombhYYqst59W52H2RJfyoHYh52auFD8SZxWLMFxZSRXqyRyQHmaE2xp1rg6YVtO/jxLC+c6tVUeTdOEUqTAr3AoO9q2orr5/Bn63bqpfQmMVdNWVADdIZc9V4ogsxHnZg/MKOKTEArM6QmdD5y/l8gAnw6YPlbGaVGw4PI6e0ZO4uMWIt+g==;5:R0/eOYbbQUg6b6eltroiEF+xw1f6dt4c7I+N/r3vIOGK+Ehu9o84R6jV12vR+C2I6jlmEb+CqK1VqXXnSgOmLCNDMVGSsr2uea9kO/7DltX3foAYIkEj1DIVOaF7OTAH4wxDq0rsT+dgFiRhQa+bEAj0FyO9geEj26pIuSfOu40=;7:9eVVe0KQHYrE6mNDYdTDGnQmYKWq+spJ0BlSuiM8/8SjzYVCYKYZMTGbQOgfJmzraiyEp6kwYzb+rjVCh7dr6b0ew24Ci3W3OZi1Ov5uyvunvxXtcR6EHOJYKGm3fieWYAf/ORrSGE/BF1DzY2rSUTw+nvp0VFJBVO4mQxzhNuEf6xuzh0ON4hVhsgY1bF0DFG4jQIKxq7P9lR256CAznNHhVEjth9AFsyeIoESurOrpkpKNfNgPTpxRAE1WZL5T
x-ms-office365-filtering-correlation-id: 674f7653-1a20-498f-24d5-08d6145aa6a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757CE732CF567B1B55AF232FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ViAZnthzSEpfND7iZbw+QLUF5wR6QyRiQJY2OHLbwPzfsSDJmDcWZb0Tmf7K4JyFm1dd7f1kfDf9hGeBA+Rwzwfb2GUAf9mmqHQrDPa8iGnGcNAbqRIaMOhOSyAGYF+Bp0y+8QNEGgGOCYw/IwR0r2PF8i1Ov7tK76p6NdMbfr9LM7TwI5JBOPZkc7w+dC0ZWOqGvZtJvqSs7Ndf9vqF4y0Kmyw2H4OvAc6KUIAReJ4+wfOx6TpiKQIqoUEH98Ue30k5yR1kmluFJc9AaP1O6s/pf+9TCKRKGgI8ATu4os9EQM3ZWoIYA1l84fn99g7LENemwZzSfroCo/Q8q4I4Y0JrnrHuFbubYMYNDQwKuy0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674f7653-1a20-498f-24d5-08d6145aa6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:03.5877
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
index 0c1a42bf27fd..1c37d5a78822 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -1366,6 +1366,11 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int =
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
