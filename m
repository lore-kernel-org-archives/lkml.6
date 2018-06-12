Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B908C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03992086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ro9Au6D7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TOhqM2RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03992086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933867AbeFLPWt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:22:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7151 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbeFLPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528816966; x=1560352966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xMVRSZypOB3hMQKpQBNMqmGC84pFQyCv4M+TuTfJxU8=;
  b=ro9Au6D7w+Eu98ffi6xTrOye5fVxJYprsrZEX72OZW7vOU5P9fGaCQgp
   vupUYnf4OpfPfVIZeXUjwAOXYAJ0pu8jdDT31FrxuUXnVFoyHsuAJauW/
   m5YH5lTAT3gOnTw63qzgQgTEVSfaCJwm6ZTLhYSsmvqRvjpLG+DkB95F7
   Bxv+s+jvTub1vtfgNFctcIhtZhWCcPXn4/LtoAVwvnsn9UANmb8x0Z+XL
   gUcsndRx55CyfrYOvfcVOEgcM7kgdkXo3tmZvzAkQzptYsGrxBTep8SYX
   k2KLitlvtHjL3R67k1IBm9or4Z7+460zoRbL3D1SEOGnZBZHXxqml4qCi
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,215,1526313600"; 
   d="scan'208";a="183582941"
Received: from mail-cys01nam02lp0053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.53])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2018 23:22:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMVRSZypOB3hMQKpQBNMqmGC84pFQyCv4M+TuTfJxU8=;
 b=TOhqM2RDAZnu0+wplKDbtJUX5+WdslT4tzGtFRakSyrx+h6uvPCzwvQjp+yPZcrtBPjO8RRKM6PqaYytSn0qDfK2X+lhYHi03w3zrLNypFnhCXrpeaKGtCCH8TEWSmHuclTPF1II5mXI5vemt9F7YbBEFXKMDh+khd1J3mxQ9g8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1199.namprd04.prod.outlook.com (10.173.50.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.16; Tue, 12 Jun 2018 15:22:42 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 15:22:42 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "jgross@suse.com" <jgross@suse.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "mawilcox@microsoft.com" <mawilcox@microsoft.com>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
Thread-Topic: [PATCH 1/2] Convert target drivers to use sbitmap
Thread-Index: AQHT7GYxbT1giKZVZkSKRt4NLDSw+qRc6ZoA
Date:   Tue, 12 Jun 2018 15:22:42 +0000
Message-ID: <da5220a5ed4bed210c31a7517389e787a3b1a01f.camel@wdc.com>
References: <20180515160043.27044-1-willy@infradead.org>
         <20180515160043.27044-2-willy@infradead.org>
In-Reply-To: <20180515160043.27044-2-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1199;7:+y7H1kbZRuEcknyhwlsMQlEj8BbGGOKx4IqxX0Ja3ERmRhvETGJvfEhkurdxJ11zSQLBHZI5QBhJ8hYE2ELj2mGhLkIakU8IpVX8XMV4vJYzUu+onLv37RRsSIzGzsSuLCMSaQNg5J3Es1POUTHeYgS5cOJz6kPw2kLlreN9j7CpSvOicgbhZh2Pq4EtHF4Hyn25zAsM7nJucIGzw5+K5OKWALdd6V9yZcgeGr8MmOnEBdNtE1GcZOyqrGHZAD8Y;20:rst0OxwP84rbQdGgYvCP/wldkwL/sJePeiGMqQGhl21v07pGlJN2cFO31pttX7G5IM7n9ZcIz2Ka07eQJZcOL3kI5gIpuwcsh4dxlFhq2/5VpKxf6tQ/+gRYcU/79h8aPolrU6rloBJrRinLFyw+q7U/ON92r9HCUxi4C/fDCi4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1199;
x-ms-traffictypediagnostic: MWHPR04MB1199:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1199A47116F89279179A9993987F0@MWHPR04MB1199.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1199;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1199;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39860400002)(39380400002)(346002)(189003)(199004)(5250100002)(14454004)(229853002)(2201001)(6436002)(316002)(99286004)(6486002)(2906002)(8676002)(106356001)(3280700002)(68736007)(2501003)(5660300001)(3660700001)(97736004)(7416002)(7736002)(8936002)(86362001)(478600001)(305945005)(105586002)(81166006)(81156014)(486006)(72206003)(66066001)(476003)(2616005)(6506007)(102836004)(36756003)(118296001)(76176011)(25786009)(59450400001)(2900100001)(3846002)(11346002)(446003)(6246003)(6512007)(186003)(110136005)(8666007)(4326008)(39060400002)(53936002)(26005)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1199;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9WpQuP2lHK8BrHx2Mlc69QV3cGtsENaS7aYygCnOOovR4zU906Bu3pMULv7LqJO/9eJBePb6Hw8/A7KsQ/kNiW/6dIds3w8uRdZmCnXCl8FJ3DNhIkYPSADGgLLgkFyCJ/hrImtOe741k/xeSrMBT44IspvWbiF+mM0A3B/pxkSLTs+9TVaBzL9mCW31jI7y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C063782DCBCAE4EAAD78091E6B6DBE4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 683e402d-dba6-4e91-06f0-08d5d0785781
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683e402d-dba6-4e91-06f0-08d5d0785781
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 15:22:42.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA1LTE1IGF0IDA5OjAwIC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV90YXJnZXQuYyBiL2RyaXZl
cnMvc2NzaS9xbGEyeHh4L3FsYV90YXJnZXQuYw0KPiBpbmRleCAwMjVkYzJkM2YzZGUuLmNkZjY3
MWMyYWY2MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX3RhcmdldC5j
DQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV90YXJnZXQuYw0KPiBAQCAtMzcxOSw3
ICszNzE5LDggQEAgdm9pZCBxbHRfZnJlZV9jbWQoc3RydWN0IHFsYV90Z3RfY21kICpjbWQpDQo+
ICAJCXJldHVybjsNCj4gIAl9DQo+ICAJY21kLT5qaWZmaWVzX2F0X2ZyZWUgPSBnZXRfamlmZmll
c182NCgpOw0KPiAtCXBlcmNwdV9pZGFfZnJlZSgmc2Vzcy0+c2Vfc2Vzcy0+c2Vzc190YWdfcG9v
bCwgY21kLT5zZV9jbWQubWFwX3RhZyk7DQo+ICsJc2JpdG1hcF9xdWV1ZV9jbGVhcigmc2Vzcy0+
c2Vfc2Vzcy0+c2Vzc190YWdfcG9vbCwgY21kLT5zZV9jbWQubWFwX3RhZywNCj4gKwkJCWNtZC0+
c2VfY21kLm1hcF9jcHUpOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChxbHRfZnJlZV9jbWQpOw0K
DQpQbGVhc2UgaW50cm9kdWNlIGZ1bmN0aW9ucyBpbiB0aGUgdGFyZ2V0IGNvcmUgZm9yIGFsbG9j
YXRpbmcgYW5kIGZyZWVpbmcgYSB0YWcNCmluc3RlYWQgb2Ygc3ByZWFkaW5nIHRoZSBrbm93bGVk
Z2Ugb2YgaG93IHRvIGFsbG9jYXRlIGFuZCBmcmVlIHRhZ3Mgb3ZlciBhbGwNCnRhcmdldCBkcml2
ZXJzLg0KIA0KPiAraW50IGlzY3NpdF93YWl0X2Zvcl90YWcoc3RydWN0IHNlX3Nlc3Npb24gKnNl
X3Nlc3MsIGludCBzdGF0ZSwgaW50ICpjcHVwKQ0KPiArew0KPiArCWludCB0YWcgPSAtMTsNCj4g
KwlERUZJTkVfV0FJVCh3YWl0KTsNCj4gKwlzdHJ1Y3Qgc2JxX3dhaXRfc3RhdGUgKndzOw0KPiAr
DQo+ICsJaWYgKHN0YXRlID09IFRBU0tfUlVOTklORykNCj4gKwkJcmV0dXJuIHRhZzsNCj4gKw0K
PiArCXdzID0gJnNlX3Nlc3MtPnNlc3NfdGFnX3Bvb2wud3NbMF07DQo+ICsJZm9yICg7Oykgew0K
PiArCQlwcmVwYXJlX3RvX3dhaXRfZXhjbHVzaXZlKCZ3cy0+d2FpdCwgJndhaXQsIHN0YXRlKTsN
Cj4gKwkJaWYgKHNpZ25hbF9wZW5kaW5nX3N0YXRlKHN0YXRlLCBjdXJyZW50KSkNCj4gKwkJCWJy
ZWFrOw0KDQpUaGlzIGxvb2tzIHdlaXJkIHRvIG1lLiBTaG91bGRuJ3QgdGFyZ2V0IGNvZGUgaWdu
b3JlIHNpZ25hbHMgaW5zdGVhZCBvZiBjYXVzaW5nDQp0YWcgYWxsb2NhdGlvbiB0byBmYWlsIGlm
IGEgc2lnbmFsIGlzIHJlY2VpdmVkPw0KDQo+ICsJCXNjaGVkdWxlKCk7DQo+ICsJCXRhZyA9IHNi
aXRtYXBfcXVldWVfZ2V0KCZzZV9zZXNzLT5zZXNzX3RhZ19wb29sLCBjcHVwKTsNCj4gKwl9DQo+
ICsNCj4gKwlmaW5pc2hfd2FpdCgmd3MtPndhaXQsICZ3YWl0KTsNCj4gKwlyZXR1cm4gdGFnOw0K
PiArfQ0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
