Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42B6DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70E32089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lu4+WAHa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fV9RWxNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70E32089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933747AbeFLNZP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:25:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29461 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeFLNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528809912; x=1560345912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ySdrgIOc5ZJgmqarJkyIZO+ig/Sm4Uf7EvCDAgE0WhM=;
  b=Lu4+WAHaUGGKyX2XAHJQB6JkV+iyn8V1mUOVSeECKGAUxkyEMiKPRhK+
   b+Qesbq8dZCCj6cjsxnh5vbXrYN9757lKRUT9qN5ySVsknW0qUHeWKGpA
   ULtKYzSbqsfcnufQFcfoBcssSDQV0rI530aUYoQNrNCaDuEWr5G40blWy
   2M7A5H722ivlG2YmEOSk0i96DZ8hAd+zWW3bLs+Cm2LZ8x2k6PWtMssrX
   QaqDbyThhGxXzLU0uYJG6wzrVq4wfjx55ioVzG68Y5n9LVaRtyM4g0NCZ
   CFymFcaB+XmAg8HaABp3/Z0y9dS1vjgUExTbFP8q1/aNo4Ea5VbazNa7m
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,214,1526313600"; 
   d="scan'208";a="82276741"
Received: from mail-sn1nam04lp0087.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.87])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2018 21:25:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySdrgIOc5ZJgmqarJkyIZO+ig/Sm4Uf7EvCDAgE0WhM=;
 b=fV9RWxNpoPSriFAdcDtNUteH3ekuL6aEZZMt78ByYVencguAj6eu4G+PS2cwmbUgWbu9sQJAAsmrq73CjREy+VXwAbt+DoOAu/jrWrZf/RTJ+bfEDVYLCRP62WqeDjqZag4bX+p2+OgvjUdwM5eVOVaITuJPjeTvIH2FyzLq7s8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0737.namprd04.prod.outlook.com (10.172.168.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Tue, 12 Jun 2018 13:25:07 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 13:25:07 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jiazhouyang09@gmail.com" <jiazhouyang09@gmail.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: Re: [PATCH] target: add error handling for match_int
Thread-Topic: [PATCH] target: add error handling for match_int
Thread-Index: AQHUAgk4BpxYJjRnc0Ohad1ba92Ll6RcnXsA
Date:   Tue, 12 Jun 2018 13:25:07 +0000
Message-ID: <4f248c27409b49193193ca187cdd1a30f85ce547.camel@wdc.com>
References: <1528779148-42485-1-git-send-email-jiazhouyang09@gmail.com>
In-Reply-To: <1528779148-42485-1-git-send-email-jiazhouyang09@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0737;7:P6TZxpdF0s+Iz0bBI/iw1sj50GNM2t7PVCm4R8XIqasYSwsSGWNjGMnlostgoGo50ValIvogdQ1o01aT1JK1iqHbUbdwCBS4OSj3peZtwmn5uGpdUOXnVgOHk3y9JyHdwtvjihtkM8pyCmgjE3VwRxiUtFEH8BvjTo5ipxcNWhhSk47mArRrL4GYA5wbB7hVWDc+zbhcdEP6jD417CJPHSwL+AziOzHFeVbQXMD1hkUV/6JPeYFt6JK1AYQEPTND;20:/QhWr+a8ZquvFci9TzmK6gDZYySjP8hij0sfsk/uq69vv81RgOrq59WCp6nkEcj1ONcG3kJs3rMy9H1a0vXVLGeh0WMV/hEMr5m6lxpe6KHui14LvGRDEWblEfjAVQNcxY/ujtoZrIeLSMi2WkW1SqdbpLZfQwxP2+8WmQeN0gk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0737;
x-ms-traffictypediagnostic: MWHPR04MB0737:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07376D0409238DEE71BE6EC9987F0@MWHPR04MB0737.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0737;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0737;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(486006)(476003)(97736004)(99286004)(6246003)(4326008)(81156014)(305945005)(186003)(25786009)(39060400002)(1361003)(2351001)(11346002)(2906002)(81166006)(316002)(2616005)(6506007)(86362001)(7736002)(76176011)(6916009)(54906003)(26005)(3660700001)(446003)(14454004)(2900100001)(6512007)(5640700003)(5250100002)(66066001)(6116002)(68736007)(3846002)(3280700002)(2501003)(5660300001)(106356001)(102836004)(105586002)(8676002)(6486002)(1411001)(72206003)(229853002)(6436002)(8936002)(478600001)(53936002)(118296001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0737;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HPy2jnifzCdQ5pB/GzeNIPgY9LKqJn4U9RZheZPp6Z3qSFH531cHAsM82uK0Du+zFoUS//HsbfRdLX7OfGSQp+G/yAcvyoqTR+X84SMcKr3Tfz1bTLyePTiZNZAcLbtN9pbX9yxaGT+AkHV0BhdLcb/FX/NsOEH0mpPN9b6iKX5jJbRLlQBLgQcnmVRx1MoL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <98F12B659DD0244B9654A4FB4722AE9F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a2823776-5466-40ce-3e17-08d5d067ea98
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2823776-5466-40ce-3e17-08d5d067ea98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 13:25:07.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTEyIGF0IDEyOjUyICswODAwLCBaaG91eWFuZyBKaWEgd3JvdGU6DQo+
IFdoZW4gbWF0Y2hfaW50IGZhaWxzLCB0aGUgbGFjayBvZiBlcnJvci1oYW5kbGluZyBjb2RlIG1h
eQ0KPiBjYXVzZSB1bmV4cGVjdGVkIHJlc3VsdHMuDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgZXJy
b3ItaGFuZGxpbmcgY29kZSBhZnRlciBjYWxsaW5nIG1hdGNoX2ludC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFpob3V5YW5nIEppYSA8amlhemhvdXlhbmcwOUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfcmQuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX3JkLmMgYi9kcml2ZXJzL3RhcmdldC90YXJnZXRf
Y29yZV9yZC5jDQo+IGluZGV4IGE2ZTgxMDYuLjdiYzg5ZmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdGFyZ2V0L3RhcmdldF9jb3JlX3JkLmMNCj4gKysrIGIvZHJpdmVycy90YXJnZXQvdGFyZ2V0
X2NvcmVfcmQuYw0KPiBAQCAtNTczLDE0ICs1NzMsMTYgQEAgc3RhdGljIHNzaXplX3QgcmRfc2V0
X2NvbmZpZ2ZzX2Rldl9wYXJhbXMoc3RydWN0IHNlX2RldmljZSAqZGV2LA0KPiAgCQl0b2tlbiA9
IG1hdGNoX3Rva2VuKHB0ciwgdG9rZW5zLCBhcmdzKTsNCj4gIAkJc3dpdGNoICh0b2tlbikgew0K
PiAgCQljYXNlIE9wdF9yZF9wYWdlczoNCj4gLQkJCW1hdGNoX2ludChhcmdzLCAmYXJnKTsNCj4g
KwkJCWlmIChtYXRjaF9pbnQoYXJncywgJmFyZykpDQo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7DQo+
ICAJCQlyZF9kZXYtPnJkX3BhZ2VfY291bnQgPSBhcmc7DQo+ICAJCQlwcl9kZWJ1ZygiUkFNRElT
SzogUmVmZXJlbmNpbmcgUGFnZSINCj4gIAkJCQkiIENvdW50OiAldVxuIiwgcmRfZGV2LT5yZF9w
YWdlX2NvdW50KTsNCj4gIAkJCXJkX2Rldi0+cmRfZmxhZ3MgfD0gUkRGX0hBU19QQUdFX0NPVU5U
Ow0KPiAgCQkJYnJlYWs7DQo+ICAJCWNhc2UgT3B0X3JkX251bGxpbzoNCj4gLQkJCW1hdGNoX2lu
dChhcmdzLCAmYXJnKTsNCj4gKwkJCWlmIChtYXRjaF9pbnQoYXJncywgJmFyZykpDQo+ICsJCQkJ
cmV0dXJuIC1FSU5WQUw7DQo+ICAJCQlpZiAoYXJnICE9IDEpDQo+ICAJCQkJYnJlYWs7DQo+IA0K
DQpQbGVhc2UgcmV0dXJuIHRoZSBlcnJvciBjb2RlIHJldHVybmVkIGJ5IG1hdGNoX2ludCgpIGlu
c3RlYWQgb2YgLUVJTlZBTC4NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0K
