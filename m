Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 639CFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D632086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bS3enzgi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IpS/RbS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D632086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934408AbeFLPIN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:08:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47369 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeFLPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528816087; x=1560352087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0LfFs9lJNSUXlZ2Fq01j+d+iFkQkrAbau3vT+dPX4Lg=;
  b=bS3enzgipwO42+Qcj52pUW/jO3icr+A7Huc6fTtdukFDjUJN+7YSoFZ3
   +cMpmB05VR9gXLDs1pVaFUK8AkK6UrIiAGPMwUkqIzm5HpUUjF180jDTT
   dq3Ue8Q/54+yCPZyh4yNIpFyrRnYlmOdqp6/7fjznalziBENHJsocPuoS
   vZNhxIMsQunMJeGWNnwj06jyHpZteht8W77MkJpGsSqHQRsFpsiwk/lBX
   YOVSa6MI8rXOcf+0JLxVgDUZIfaX2ozF65I3jUg+aNiMLJSzLC/sZL7MF
   Yl/B8HkHBL1XAL41/1EauEYT5NraoW/QF6OYefoJp5t9e6V2cAnm3Rt1q
   A==;
X-IronPort-AV: E=Sophos;i="5.51,215,1526313600"; 
   d="scan'208";a="82287750"
Received: from mail-co1nam05lp0084.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.84])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2018 23:08:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LfFs9lJNSUXlZ2Fq01j+d+iFkQkrAbau3vT+dPX4Lg=;
 b=IpS/RbS6WNJXOkLtQwqqJ91LXJ05T8FvRc/WMglyp3VRO7qOjCCeofhFMqSgqDjYG93DnXbrY0hrmSMWnu+AlqjnlE8MNT9lyI5684AYeulajVt1xGPvKYd/EnhLHijwIPzzWYWHbSAbxu9667I+grx8q2bvhapOIBRpW3nG0hg=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0271.namprd04.prod.outlook.com (10.169.202.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Tue, 12 Jun 2018 15:08:05 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 15:08:05 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] scsi: remove Scsi_Cmnd typedef
Thread-Topic: [PATCH 1/3] scsi: remove Scsi_Cmnd typedef
Thread-Index: AQHUAlUiMUp4cype1k6iBQXVEOM1GaRcuagA
Date:   Tue, 12 Jun 2018 15:08:05 +0000
Message-ID: <98683ad68d6d708335294d1fcdbdcc58f2eaa9e4.camel@wdc.com>
References: <20180612135311.13216-1-jthumshirn@suse.de>
         <20180612135311.13216-2-jthumshirn@suse.de>
In-Reply-To: <20180612135311.13216-2-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0271;7:7iXhcVKjK+aYUggnv+NnOTe7T6E8C4fe7lzn65IfDzYeVin2TW2lbQMsYBHE2sUf6dO9NxySFY9DgO7nNd7QdjJm1xUvYmlO6nDCn3G3bp5+0d1XmDoYeyEVIu41g2YBYZDMFnhNB+P4MToNBf9o+Nzb7rcwgu/PdspgaTuqIggJ/ucQMTBbewVNjx62EhfypsImvfk42ZqfmhGzOwDauir+GxLN0F9Ga42KLLQYvChpYTSFc+BUANie4BoSUiGd;20:L9nw5niTnhgq8er7JAD45XYFL7JY3FxkgqM5grqemA3KSOsjRhmutgFecl/wk2Sn6tdZQGEVsuwHe4iBPGobgzJnr65CVDcmiaWGRl+C6kar4gtyntTtlX+BhGQvSpuzjThdHZfaH3VKMkpOjwDY7RaYj76F02NqGeOzhgvCm1A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0271;
x-ms-traffictypediagnostic: MWHPR04MB0271:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB027160C5F2FC3CFD1F2BC033987F0@MWHPR04MB0271.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0271;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0271;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(316002)(110136005)(54906003)(3846002)(6116002)(68736007)(11346002)(76176011)(476003)(7736002)(446003)(2616005)(305945005)(486006)(81166006)(81156014)(8676002)(3280700002)(8936002)(26005)(99286004)(2906002)(105586002)(106356001)(3660700001)(97736004)(229853002)(6506007)(4326008)(72206003)(86362001)(6512007)(2900100001)(102836004)(5660300001)(36756003)(53936002)(6486002)(186003)(25786009)(6436002)(118296001)(478600001)(2501003)(66066001)(5250100002)(6246003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0271;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TJs2VcSw8uuhCHLCRph7worp5LgrHuuoSez6lqwjSLIoO0OW8iCxm1BHSAcq2KN5C4aKdqQrIXLYjBRiSJNrRnYK7+CoH7LlMyMGTnRxVlWxJMXaB4Df2hJyAmbr4AfOuAlFGj7flajILUMD3DMAZfSIMsSQidttOJuv3afCbKscovEWAfUWc3ZKJi0r7d3q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC3A014F6C62747AB2CF6DF4BDFBD47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7b7ff7b7-146f-44fe-973c-08d5d0764cef
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7ff7b7-146f-44fe-973c-08d5d0764cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 15:08:05.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTEyIGF0IDE1OjUzICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvM3cteHh4eC5jIGIvZHJpdmVycy9zY3Np
LzN3LXh4eHguYw0KPiBpbmRleCBmNjE3OWUzZDY5NTMuLjVkZDA1ZTU2NDc2MCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9zY3NpLzN3LXh4eHguYw0KPiArKysgYi9kcml2ZXJzL3Njc2kvM3cteHh4
eC5jDQo+IEBAIC0xOTI1LDcgKzE5MjUsNyBAQCBzdGF0aWMgaW50IHR3X3Njc2lfcXVldWVfbGNr
KHN0cnVjdCBzY3NpX2NtbmQgKlNDcG50LCB2b2lkICgqZG9uZSkoc3RydWN0IHNjc2lfYw0KPiAg
CWlmICh0ZXN0X2JpdChUV19JTl9SRVNFVCwgJnR3X2Rldi0+ZmxhZ3MpKQ0KPiAgCQlyZXR1cm4g
U0NTSV9NTFFVRVVFX0hPU1RfQlVTWTsNCj4gIA0KPiAtCS8qIFNhdmUgZG9uZSBmdW5jdGlvbiBp
bnRvIFNjc2lfQ21uZCBzdHJ1Y3QgKi8NCj4gKwkvKiBTYXZlIGRvbmUgZnVuY3Rpb24gaW50byBz
dHJ1Y3Qgc2NzaV9jbW5kIHN0cnVjdCAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KSSB0aGluayBvbmUgb2YgdGhlIHR3byAic3Ry
dWN0IiBvY2N1cnJlbmNlcyBzaG91bGQgYmUgcmVtb3ZlZC4NCg0KT3RoZXJ3aXNlIHRoaXMgcGF0
Y2ggbG9va3MgZmluZSB0byBtZS4gSGVuY2U6DQoNClJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3Nj
aGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0KDQo=
