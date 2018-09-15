Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E78121477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fM+EpYy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E78121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeIOHF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:05:59 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728535AbeIOGrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk5h5aUwViK00k7ESoZ68vmNxluziOYBTpQq2cPcmtc=;
 b=fM+EpYy89/2cKL3YtYRa/LwFL5LvMvPMHIElQXB2WgvIpOlH7U7FejEP8OZH3eBaz+dV/y9vDUckIizOIvRMrBOs4ikzmEedfI6sApvn6ZgS53PVhOixwK0IjCuv+RLEHKtokADdU8Ulmtt4MuhLjcUCq0+GtNJYY9eIKQYmnWs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 51/92] tools/testing/nvdimm: Fix support for
 emulating controller temperature
Thread-Topic: [PATCH AUTOSEL 4.18 51/92] tools/testing/nvdimm: Fix support for
 emulating controller temperature
Thread-Index: AQHUTJOtWQsfJbJRN0uisMsAICSYrw==
Date:   Sat, 15 Sep 2018 01:30:24 +0000
Message-ID: <20180915012944.179481-50-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:aaqxgkA70ktiiGnE+IXOkkGO3vsL50Ku3DsBcM9vVVOcOkIgjdtlPCNNjpizvcCKhnJ8wZKmJNU4zqLxO4uq9dnyd2oelXMgf88WclVYFb6leru0GdQD5uZ1AbG/xopq+pV0QBeEQcYxoTl468Zh14vx3e2S/QuAmzLGVOL2dNDpWjBm0WhZEQ7UMV6iYD2pCphi+s3mJkcDHjc77RZuS84VwNS5ryk44YL7WALKV4Ua9/AhpvujJ5yP3BbtNTVJAER8zOXaEjn6NawnhFPKNIqt8vmYX6FK96bYrzPR/0ZGf2f2lKO1IuT1+VrbE0CSyMRkOzMjTUePG1o8TZPCGQnWcNkq5iiwiFyebjvxB+pES5/tgvK2f8AayICZdwg4A1v6TRW3TXM7NpCex8CDzcMw4lR4kZhvd+rrlQP8h9FPs0ZnIXyQhYQzr4CUuIci0FhYDGg5oMWE660DFREtoA==;5:ZnwGHwBYSB9VQrTmeOB1fx60O6a+gWnfbE62r1nN+4m+QqQQg1FI4qlecW2VVzTfRFtacVD25JFU1d9chRIw04MmSBRVy3m9dtlIDdsyiwGQ4h42oCNoBG09HVlIqCiRxGrsVpht8d6Ko676oHB4h2wyrGvjyQdPh2U4U3lXGYo=;7:FqJnOSsMdB/pjIGSS3pJp9V4GOkG7CcXtDydQiI1Uwvn+X5z3rmxc+Zyp6KPSotXR/4ScSvtV01hswixWc05qdrUzZmxx4b6ewRKGz0LKpwuJVkTgTlX/WsB/FUwNTzKl6pu3bio5rdIu65PHv7dxMQhGappGrpBgtBX6yx8GVQPJa1E5EletFirwHsgqetTcaTttl2o1u68GVnb+bs+HgQ88xHmhlc9a8pNjLgwHVDuFhKj+dM0u/LiDDFkYoSS
x-ms-office365-filtering-correlation-id: 93c5eb1a-ba5c-4940-dc41-08d61aaadff5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856BD4C8119C7F1E7A380F2FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rsYrz2qEVcfZifzUfqLoTZHCjLUeAaQ5UlSPY9uifk11iTYL+CGNsIx1ny0E/u3pQLBJX4NewUCUEko6KhxmOGFobNUJFeDxsDQ5ae/Ju4xSqYEi2/1oxxAvSuT6FaeJXllmL8sQN9iTXEYURhqur0bIdGqZcZYkM7KMs9wKfGx3TTT/dtc6BNX5kuytMOByioKkJqRhboEEU3cjtr84Ez2DZkkQ0QIU/6K7ll54VxvtfJPhcWRgtHAmbb1D54PPCy0JOPsw3v7aIEinxSy4Hhd+KweOfF3EflG0LGU/wFjYYNWEXP1g2bAOJ9dKZRaYwYo5LOGpkTGNU+CeJj/SYyKIXa2aiBJT+YWRH1Fwyrs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c5eb1a-ba5c-4940-dc41-08d61aaadff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:24.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit e5d772fbe7685aae0dff99f3b54158a0ec32155e ]

In addition to populating the value the payload also needs to set the
"controller temperature valid" flag.

Fixes: cdd77d3e1930 ("nfit, libnvdimm: deprecate the generic SMART ioctl")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/nvdimm/test/nfit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/n=
fit.c
index e2926f72a821..94c3bdf82ff7 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1308,7 +1308,8 @@ static void smart_init(struct nfit_test *t)
 			| ND_INTEL_SMART_ALARM_VALID
 			| ND_INTEL_SMART_USED_VALID
 			| ND_INTEL_SMART_SHUTDOWN_VALID
-			| ND_INTEL_SMART_MTEMP_VALID,
+			| ND_INTEL_SMART_MTEMP_VALID
+			| ND_INTEL_SMART_CTEMP_VALID,
 		.health =3D ND_INTEL_SMART_NON_CRITICAL_HEALTH,
 		.media_temperature =3D 23 * 16,
 		.ctrl_temperature =3D 25 * 16,
--=20
2.17.1
