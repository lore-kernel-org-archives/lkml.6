Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA7ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A59208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ARsSEDox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A59208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeIOGw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:29 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbeIOGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l7FFa+NNkTz2KSV72ilRGjt1113iTcZO832jKOayPI=;
 b=ARsSEDoxQXKZadMOc7sxVdDAU6SE0NgDJENQCm0gsPf9y518jjFSkDPJo+rzNacGql7XTt06cyTcXA/BmHZG8FvkqgDULI13VyJVA5V4veulog0D1v3eEy9iu9J3HFAmsMCPPS08F8Z5sLMMY+/SDppyzjY/y1+gUJIS5ok4NJo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 11/20] coresight: Handle errors in finding
 input/output ports
Thread-Topic: [PATCH AUTOSEL 4.4 11/20] coresight: Handle errors in finding
 input/output ports
Thread-Index: AQHUTJRYa5aoQ2KhvUqB9Frw8bgt4A==
Date:   Sat, 15 Sep 2018 01:35:11 +0000
Message-ID: <20180915013502.180110-11-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:JFuwzEy7z/QSAZ4stXbbICYoTrFybTGF8Po1Psd4JTUUzXfa9RrjqMqD1T5pm7seTExd1oDnB03uj+aDis8a81oXMoOAmOX4C3KAn9YHI6E7NGR61DQvBPdJDqF1Vz/zHuIDAJN7KbfwgxJl6stFE1csbpYmCOd2gV5EC+g4j1adq5kOKnwLLk/QJMdUW3MqSGZo7fubTfT9acis/leT2aq8kHLf7COMAUE84yJkqmb3ZYmk9M1eEZwNsRurH+MWRhVQFmkeCwxZ4pDCNuOdjECcEZ5xmNzUREeuZXRRtFbbBfLdmka6nj8ujIXoqJB0FbMPvjTsCS+j9ggKy3Krt5kqlVkK1KJMt+/K9f9a+hsqiIH24ibEbqnDViIHix8LKORVd0bujlzvUdX1kk8HO8mdZuEARlAqxU7oSE3FW+rgyAvbNGpOBZfYOz5WxrdY9hT7/ZPq6VhlH5QFIsIY8A==;5:ymjwrj491NfHqBuJ3CgK8uRdyksJ5YtBkSGMha1qivDrv48gZHhoIm7NpQ0+2hs/vM/8ViLkkchNRb+lm/e+YvNvRIa0rgGtZp+Q0KRE4YGnMvETgpUi/BUOqa3g7UVbla8XEhTmmmb+hmu8JDl/NIbvOJjLwI+HI4FSx7LBkT4=;7:5rfzCy1bz7MDIuPJKuupki6eh+RdsmDely7tbt/2TvbZuuu1e5YD5eB7vPGV46zd7AJS9Bgz/NsEClAUian8cQqpJ0Uxgwj3+7fBmiovu90zlhjaolAY21ZdGT74/kskg8p2bUjK2wJoRW4ru19b+FD7S8cBay6FU7SPXkgj4la/ayM/bpeGfqt/AZ+nzehkXyZ3N/yNnehvK12OuCVIq3NE4/LCZux7JEmXXXBCq5R3E/KQpIEGHfyBReqYwdGj
x-ms-office365-filtering-correlation-id: 623058d2-09df-4407-ecdd-08d61aab8018
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181623BBB97CFFF2D43CD1AFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bJFA+b/6SCux5/GJKOzWnQxsFnvbIFki/7VwfcaDbsNtMcqeoaOPTG+l6U+HYVHLcm8ZHed6IgHG4hn36o+qD7zGX87VYWhnneYbXL5/39v8xfK3kK70VlmayOKmAjEIiC3BskXu9dRuFrYyQzEZnHcSzqMlqleH9DfKZieo4cowsqsfN9Vcqrpf3qeEyoXk0iijPgt9HrcQMzEyZQWEc/o1aWD53aXLx0yzQm5BkdtpXpWORJie+JOlDcQCUh7TLHXlTsHXbTqkBHDfStKTeQdqtw6t6tb94getZV4r4H2bPAxEPR7dQMuYcGNuW42oEcXcvkRiSkurvrpV3T8Mw26SszU93H6GvV4Tbm7jYCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623058d2-09df-4407-ecdd-08d61aab8018
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:11.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit fe470f5f7f684ed15bc49b6183a64237547910ff ]

If we fail to find the input / output port for a LINK component
while enabling a path, we should fail gracefully rather than
assuming port "0".

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/co=
resight/coresight.c
index 93738dfbf631..902ee6efd09c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -86,7 +86,7 @@ static int coresight_find_link_inport(struct coresight_de=
vice *csdev)
 	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
 		dev_name(&parent->dev), dev_name(&csdev->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_find_link_outport(struct coresight_device *csdev)
@@ -107,7 +107,7 @@ static int coresight_find_link_outport(struct coresight=
_device *csdev)
 	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
 		dev_name(&csdev->dev), dev_name(&child->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_enable_sink(struct coresight_device *csdev)
@@ -155,6 +155,9 @@ static int coresight_enable_link(struct coresight_devic=
e *csdev)
 	else
 		refport =3D 0;
=20
+	if (refport < 0)
+		return refport;
+
 	if (atomic_inc_return(&csdev->refcnt[refport]) =3D=3D 1) {
 		if (link_ops(csdev)->enable) {
 			ret =3D link_ops(csdev)->enable(csdev, inport, outport);
--=20
2.17.1
