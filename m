Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EEFEEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C8208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C0oAIans";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CwsxXxbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985C8208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934255AbeFLPMF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:12:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13544 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbeFLPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528816323; x=1560352323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XliueoHzx4lUz8KeTffIlfXiXlgcPkjZKeRq+E69IZY=;
  b=C0oAIans+JJ+Wi4kCtbpqVKDM5LiuRg+e+b5e0jqnUgo0EhuzXLKPgNJ
   jSOTv8gPP2g3n7LxAcwAhsinx/G+GSUevbIuafAf1XbCBbIWJyn6wCwu7
   JMq54bICs3GXUgXejuSUx6et9Px3YousoWG9bs5S83DYJJAzrqXFO3TaQ
   bicgIWuq0adVZE+E4BXeuNFsUsZOxlywV70wfQN315A0JNjL75sY41ERO
   RCptGvPWkuP7pQz6qOK9AJjYVUEs/1gNpGbR2yP/rKjFEi12CQkwrK2UN
   uktPT/pLzlNh2oED0Hr3iJIkGQFC6MCtcrHB+89oH6WiFdzpySWEbbiB7
   w==;
X-IronPort-AV: E=Sophos;i="5.51,215,1526313600"; 
   d="scan'208";a="82288126"
Received: from mail-sn1nam01lp0120.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.120])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2018 23:12:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XliueoHzx4lUz8KeTffIlfXiXlgcPkjZKeRq+E69IZY=;
 b=CwsxXxbDAu7vu8jAWyiuN0zec6GEMRWwJJD00qBemrMJjNPSkhiEw5UTnHIwHRXFxNLCP0uo/GOFLmZr8UIp7mq9b3BAv2mxviTOG2H21EvNuAXwe162lTdUXY1+9ruiXPInusHUZRjUVXlqQh3mk7U36elGRkubY7XyPiAcRZw=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0415.namprd04.prod.outlook.com (10.173.48.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 15:12:01 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 15:12:01 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] scsi: check for equality of result byte values
Thread-Topic: [PATCH 2/3] scsi: check for equality of result byte values
Thread-Index: AQHUAlUiO9PStzHAh0OHQehroj6zy6RcusCA
Date:   Tue, 12 Jun 2018 15:12:00 +0000
Message-ID: <45da3041af0060a0a914e04d4870182f640e7d9d.camel@wdc.com>
References: <20180612135311.13216-1-jthumshirn@suse.de>
         <20180612135311.13216-3-jthumshirn@suse.de>
In-Reply-To: <20180612135311.13216-3-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0415;7:HxgTs8grFqkZyYz5sfQAC13ihsgHAZHhxCVAR3aq+No+KhSTInkXCDaA+QZDvlcFwBVbMKw8gpW9/epoY15YbwtbPCESR4vb6FZG+zEZMojRjH9aj4k0EDk47DlcLhKN/Zqy96IFIUv/JF0WeRbjHy426xK9o2xHPPfwNE7qDmOeynPMHc8Od5HHGreVGRgVMr4Hm2MOSMR48/qTtmm+HOmEslBqGzQVUTUKIyxQU30qP24OhU5xn0aRqF3G9OEA;20:Nx573si56Rb1yvUtxtfD05JkkKYTaiaGV8LirDTIehe3XXzDXHSSBn2PpFCXDR+Uv/4CKEVOHxPoYIL4TyqIjvTfEr9qRQwlLW+0zFgNCTJmVqjsbuJdSRmnEhsMFGcAK5H2nLzQeqppqKlMM7mNIiuig+hJJJiBJHPjzfQ3Mgk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0415;
x-ms-traffictypediagnostic: MWHPR04MB0415:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0415E26831C33AB434CFF447987F0@MWHPR04MB0415.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0415;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0415;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300001)(86362001)(8936002)(6512007)(81166006)(81156014)(26005)(118296001)(25786009)(4326008)(6246003)(3280700002)(8676002)(6506007)(2906002)(3660700001)(2900100001)(97736004)(66066001)(36756003)(53936002)(76176011)(186003)(110136005)(99286004)(486006)(6486002)(5250100002)(106356001)(14454004)(446003)(229853002)(476003)(478600001)(316002)(2616005)(6436002)(11346002)(2501003)(102836004)(72206003)(305945005)(7736002)(3846002)(6116002)(105586002)(68736007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0415;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: I3smZy+5PuK0AC4xzsU3lTy0aAiMuW8Gp0VOdcBe4L9oCZIpheFGFW915f27q13WiBj4MDJUEKI/WaJCvPBYDVhmbuwBWNwai4YOG/omslQhu12DOlM0QMPsrCMBx+gB5rBSE7H/xQAe/01wSYRI/LoaswoBRzWpkN0T/R25QzzRskualB4TE9RLueBJpN2o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <15215FB1BD6740439EBB4A3FD62DE0E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a61906c9-1c75-42cb-862c-08d5d076d923
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61906c9-1c75-42cb-862c-08d5d076d923
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 15:12:00.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTEyIGF0IDE1OjUzICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IC0JCSAgICAgfHwgc3RhdHVzX2J5dGUoY21kLT5yZXN1bHQpICYNCj4gKwkJICAgICB8
fCBzdGF0dXNfYnl0ZShjbWQtPnJlc3VsdCkgPT0NCj4gIAkJICAgICBDSEVDS19DT05ESVRJT04p
KSB7DQoNCklzICJzdGF0dXNfYnl0ZShjbWQtPnJlc3VsdCkgPT0gQ0hFQ0tfQ09ORElUSU9OIiBz
aG9ydCBlbm91Z2ggZm9yIGEgc2luZ2xlDQpsaW5lIG9mIGNvZGU/IElzIHRoZSBsaW5lIHNwbGl0
dGluZyByZWFsbHkgbmVjZXNzYXJ5Pw0KDQo+IC0JCWlmICghKGRyaXZlcl9ieXRlKHJlc3VsdCkg
JiBEUklWRVJfU0VOU0UpIHx8DQo+ICsJCWlmICghKGRyaXZlcl9ieXRlKHJlc3VsdCkgPT0gRFJJ
VkVSX1NFTlNFKSB8fA0KDQpQbGVhc2UgY2hhbmdlICghKHggPT0geSkpIGludG8gKHggIT0geSku
DQoNCj4gLQlpZiAoKGRyaXZlcl9ieXRlKHJlc3VsdCkgJiBEUklWRVJfU0VOU0UpICYmDQo+ICsJ
aWYgKChkcml2ZXJfYnl0ZShyZXN1bHQpID09IERSSVZFUl9TRU5TRSkgJiYNCg0KUGxlYXNlIGNo
YW5nZSAoZHJpdmVyX2J5dGUocmVzdWx0KSA9PSBEUklWRVJfU0VOU0UpIGludG8NCmRyaXZlcl9i
eXRlKHJlc3VsdCkgPT0gRFJJVkVSX1NFTlNFLg0KDQo+IC0JCQkgICgoZHJpdmVyX2J5dGUodGhl
X3Jlc3VsdCkgJiBEUklWRVJfU0VOU0UpICYmDQo+ICsJCQkgICgoZHJpdmVyX2J5dGUodGhlX3Jl
c3VsdCkgPT0gRFJJVkVSX1NFTlNFKSAmJg0KDQpTYW1lIGNvbW1lbnQgaGVyZS4NCg0KPiAtCQlp
ZiAoKGRyaXZlcl9ieXRlKHRoZV9yZXN1bHQpICYgRFJJVkVSX1NFTlNFKSA9PSAwKSB7DQo+ICsJ
CWlmICgoZHJpdmVyX2J5dGUodGhlX3Jlc3VsdCkgPT0gRFJJVkVSX1NFTlNFKSA9PSAwKSB7DQoN
ClBsZWFzZSBjaGFuZ2UgKHggPT0geSkgPT0gMCBpbnRvIHggIT0geS4NCg0KVGhhbmtzLA0KDQpC
YXJ0Lg0KDQoNCg0KDQo=
