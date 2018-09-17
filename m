Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C9ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343222147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aDOLxl+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343222147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbeIQIbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:48 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbeIQIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfP4Q8qjEyP+khkR0MsschO7G3sn1+btGxn3MbdII1M=;
 b=aDOLxl+zbvWg+mMP/2VQny7TYQUQxhIClmjmmIaKN9f2KH0unc50Uzw7TsIMUvJm1Bc5ti8gaPUOvKIeu69rkoc6uqKQJk3ORiyBuEjnVWQ5V5zKApW3sdUWZ6yajR6z7ThOsMtv90mV7Q1ka9eBAY+APrDBGsoImqm2c3kkFU4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 55/57] nfsd: fix corrupted reply to badly ordered
 compound
Thread-Topic: [PATCH AUTOSEL 4.9 55/57] nfsd: fix corrupted reply to badly
 ordered compound
Thread-Index: AQHUTjMfhuEYYz5miE+kqkSlIbt/Dw==
Date:   Mon, 17 Sep 2018 03:04:17 +0000
Message-ID: <20180917030340.378-55-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:L/Bk9c1F5FhSmMJf/PmJ64fB0vJIO1lQjw8hB4Z1KwC1BYKav93I9oLfoHx/kccVHhgOnTseUFYcXPMegG3Bxano8HI2GyJAO5/vGMk5MF8+qAIiOtmXQhOp/4TJkrC3YkGEHLubSN5S7vq89LSum/sL8wgg0T7KVl8s4GgjGv6M7TbRUpnOLM/IHSldbKUqMtcuqQwlxvzrmguz29s4mQfsU+kJD6hAMu6vj0EqYVculrSi2YMe9GrvpZOEngM3RJFlEVBPFWctdCz+7Es9N4DvzCrwt1nh7v8rnBz8DhYQvyfJU+BqwF9QwWy40vlRFrQpy1vJ+1ixdxBnGcH9qlCFLTAcyy/UVZZstrd+hR3Gzp8KfIfktvt3MfI983Ih9k3L6F3bW2lZwspXdStU6EJAJSlNuA0zOS4j3rOuJlGV6ohb7v5k95xQQb/1jWXv03m8OvDULIr7dL6UjtuQZA==;5:34XBwgHohWTmHc5NA3m8XwlBOjGK68NlPmA/LlPOXD7wBiKrT5A+03sKqLMPMqOtZVuAWFL2oYRhgbwLN/su0+kMuWM/dZSR3FkNPnfJyl0TCLnOTlYaXRGmTD62gCOqBiouBuhaKJ7xwTsXTF3TBxnFGqQRKvNyDncJ1jnDljo=;7:j2z+nm/p6iDTvi2keGEYodM5pRm6aCWNzstDhdps8mHe2+LImbDWejY/rzAz7j4z8BuZSQpOMJqrc0vLwCdxD7xjaxo5F/E3MQ6/dWQMacWDVloOqh1Rj0h/PdvATHwfA/cTcPUvVe8NOMZQfAa6zRTCv5rLIWGAUY3rxtErI98T20S1wc4OR2yfYez6X8h+/LphhqmgKAIYIify/J+pGPDPs9anl7nkbQOwgj9Oez2YOEtiPujy7/Wn9bVZAugw
x-ms-office365-filtering-correlation-id: 6c3d1f32-3c0d-4fca-d46f-08d61c4a8f51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01665B3E7682041B1D825791FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: TD6l8ckoqmSUTG+bq2z/DEcg5Gx92DbWJb3q0cUmJ9oHflRBsfxgVTuZpDWJdPuP358ktrQG+3LtOpQ0wfXX/slPeF6MHQJOXP3vy9i7Xtu1uIO0/kFSTEuRyfDdgX65eMi7UMmT6ZwBk8iVK/qHhpb3bHYPuQOGjPHBaszClDBxkUHStG9mXPfZwTbXx3P3clyMuNxuKbFnwSt1RHux22rCY1ET9jkM71EWL/EJTGnJpQF1KHnfsY3H9xxK4VqmrBRIpxqHdYQNFiez1E2CpbZZfMOq9PqUvTE+XrE0V428r7yRvsItc1K0x0dekwjDpKfFmGK9WLHhc7ZqA4hNQMRM3f3IjlQlwU6hnPdHv+g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d1f32-3c0d-4fca-d46f-08d61c4a8f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:17.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 5b7b15aee641904ae269be9846610a3950cbd64c ]

We're encoding a single op in the reply but leaving the number of ops
zero, so the reply makes no sense.

Somewhat academic as this isn't a case any real client will hit, though
in theory perhaps that could change in a future protocol extension.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eef0caf6e67d..e9495516527d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1725,6 +1725,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp,
 	if (status) {
 		op =3D &args->ops[0];
 		op->status =3D status;
+		resp->opcnt =3D 1;
 		goto encode_op;
 	}
=20
--=20
2.17.1
