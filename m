Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87265C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eoqqx4nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0947120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeIMSH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:07:28 -0400
Received: from mail-dm3nam03on0138.outbound.protection.outlook.com ([104.47.41.138]:59392
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeIMSH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boq9ITEUCEN8G+fHWjVCx7/2IHjafyAHG9iLL5G5pjg=;
 b=eoqqx4nL3BhOUcrJNaiM9JE/Cnbx7/xibazDAxgwVYlYGMW56HgPwHtfeX4kd0rJluzd4eDkmty+7Ofo9AXuO6hjQ63a9xQsNmfNt1/mYeHw/hjcZX1IQwCGy4JJnatNnQklw1a8EYqIJ56JIKQfByjDyffdci/N5V3ZTLhTW6g=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0940.namprd21.prod.outlook.com (52.132.146.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Thu, 13 Sep 2018 12:58:01 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879%5]) with mapi id 15.20.1164.006; Thu, 13 Sep 2018
 12:58:01 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        vkuznets <vkuznets@redhat.com>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
Thread-Topic: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
Thread-Index: AQHUSrM2Jry7AtLXRki58UyKLzeUqqTtyBQAgABkrAA=
Date:   Thu, 13 Sep 2018 12:58:01 +0000
Message-ID: <MW2PR2101MB1113E44609F4094D7625B52BA01A0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180912161101.2634-1-vkuznets@redhat.com>
 <CAJZ5v0jmNFaH3JUVS9W_1ofXcD=8U8Y9enPi+j+9U=6cBVxfJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmNFaH3JUVS9W_1ofXcD=8U8Y9enPi+j+9U=6cBVxfJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:ad31:90cb:bac9:ed1b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;6:OW8cM3bPbZorlVCod3oyDGIbM85+ReGcS0zlIvoQEFtqY+yDNF466fKF4GX06yexvh2rIEelbXBeRLbJKxpvHqGzTHt09cF6gCm48G+m4tyIK4H+2kmPmGycWC+bRArQrK3fvO0aKQ5CFkPwsGNGC0lZlUx5fowZ5wwTw445PP8eEPIzCukQWGRijv3BdX7iBv1TJxwa6AFsVKUhXs10IJAU1OzEnxIfZE8A7DoZIDd79A7ZUuWYCLMSROonQcDT/1ImvwH5oltfm29XIq0tmkNBuJs7tjfPJCWRbTf9EmBuB3AOZ6f0fFyMbbqrwrVFzXFdoPspXgZaHwH4jlbOlP9DM+sk0BTdjpEj/cMW6cJr8MC+fbwLWkzmoUpg91CGacW+1jWR3s/TwhF3HXfHHBVNhHmPGLYBmUo6Im+GalsMp2ULXPw5nvOIGfCWtYNxLErvWbBUxQtjCr3pc21XDw==;5:6doE5mN+bk53axHB9l55xSELnDkmP8CINoreWXspRPI8XHONDlg05UqT4yckR3fjQXQP/aGwcPa8MV90R5DQVt4UGjpZHLQCufATz/3Fy+ufqHDtG1N867IWSbWXSZfDLuyYUGgoT1v1PSVP2jx57qprMEgTdECwKcFMXQcqJKA=;7:Qq6TopFr2KgBHQMjf0AehsTaOKTpL1TOPwL/cahSLmp3jrL7nV0RkXpT9A2aOqjFYr1eYiupHE7rW+Dre7hNMLxnrNbrdopSwNBprpqqFi5pokNZWu52XCFfGaYpGtEBZBu4SOQeEfbsVLnBYWULgN93oCQou6ICPLHXawoZaX7gRPcy3SNOAavtB2SP99rh14wJhiSBvUP2lgTnxOelnqh/o1rSOc9oZ6wO3wUDPgxvIpOjWaw3sWzWV+CUpApb
x-ms-office365-filtering-correlation-id: 84c1d403-d69b-4fdd-eea6-08d6197889ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0940DD5F96625284051F4C4CA01A0@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(376002)(136003)(39860400002)(366004)(13464003)(199004)(189003)(2906002)(15650500001)(446003)(6246003)(14444005)(256004)(476003)(11346002)(46003)(486006)(25786009)(39060400002)(4326008)(8990500004)(33656002)(2900100001)(10090500001)(6116002)(102836004)(5660300001)(53546011)(97736004)(6506007)(10290500003)(9686003)(6436002)(575784001)(86612001)(55016002)(6346003)(14454004)(5250100002)(7696005)(86362001)(76176011)(478600001)(53936002)(106356001)(22452003)(105586002)(316002)(229853002)(305945005)(68736007)(74316002)(8936002)(99286004)(7736002)(186003)(8676002)(110136005)(81166006)(81156014)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: H2YsUJNIy+aClZsifIicIGoDG2eScKj6y06VbfzhkcmWbL6kud6lrYJnHg9M7ooxCgpmx9yeyuJOOjorlt9XfNdNWESHEsWoTVQ+9tWsk3M+yPr70A1NnGq4vtgGTd18xAUAlxxd4k5aTxKJ39M/toqFKhxHIKPgn4hK/9No2AAF63dbnq5GCeQLnrPdU/z8zo5U8L0dAQPZJUyBwxpo7I1GgYOvQzUpc31ww6aqY5I7p769uJ1sSZcgbw12HNpkXeW3XJuxvw5CsdFCjSTza5LESEBog7lIFoQzMUZMKQtAobRIBPBtw06k9Ug4Kyj0E9VucpxPpD3GUleB0nXUfqcxtfuR2BJc/ujMpd1tp7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c1d403-d69b-4fdd-eea6-08d6197889ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 12:58:01.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAxMiwg
MjAxOCAxMTo1NSBQTQ0KPiBUbzogdmt1em5ldHMgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQo+IENj
OiBMaW51eCBQTSA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPjsgUmFmYWVsIEouIFd5c29ja2kN
Cj4gPHJqd0Byand5c29ja2kubmV0PjsgS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+
OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgU3RlcGhlbiBIZW1t
aW5nZXINCj4gPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+OyBKaXJpIEtvc2luYSA8amlrb3NAa2Vy
bmVsLm9yZz47IERtaXRyeQ0KPiBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT47
IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsNCj4gTGludXggS2VybmVsIE1haWxpbmcgTGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
aHlwZXItdjogRml4IHdha2V1cCBmcm9tIHN1c3BlbmQtdG8taWRsZQ0KPiANCj4gT24gV2VkLCBT
ZXAgMTIsIDIwMTggYXQgNjoxMSBQTSBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRoYXQu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEl0IG1ha2VzIGxpdHRsZSBzZW5zZSBidXQgc3RpbGwg
cG9zc2libGUgdG8gcHV0IEh5cGVyLVYgZ3Vlc3RzIGludG8NCj4gPiBzdXNwZW5kLXRvLWlkbGUg
c3RhdGUuIFRvIHdha2UgdGhlbSB1cCB0d28gd2FrZXVwIHNvdXJjZXMgd2VyZQ0KPiByZWdpc3Rl
cmVkDQo+ID4gaW4gdGhlIHBhc3Q6IGh5cGVydi1rZXlib2FyZCBhbmQgaGlkLWh5cGVydi4gSG93
ZXZlciwgc2luY2UNCj4gPiBjb21taXQgZWVkNGQ0N2VmZTk1ICgiQUNQSSAvIHNsZWVwOiBJZ25v
cmUgc3B1cmlvdXMgU0NJIHdha2V1cHMgZnJvbQ0KPiA+IHN1c3BlbmQtdG8taWRsZSIpIHBtX3dh
a2V1cF9ldmVudCgpIGZyb20gdGhlc2UgZGV2aWNlcyBpcyBpZ25vcmVkLg0KPiBTd2l0Y2gNCj4g
PiB0byBwbV93YWtldXBfaGFyZF9ldmVudCgpIEFQSSBhcyB0aGVzZSBkZXZpY2VzIGFyZSBhY3R1
YWxseSB0aGUgb25seQ0KPiA+IHBvc3NpYmxlIHdheSB0byB3YWtldXAgSHlwZXItViBndWVzdHMu
DQo+ID4NCj4gPiBGaXhlczogZWVkNGQ0N2VmZTk1IChBQ1BJIC8gc2xlZXA6IElnbm9yZSBzcHVy
aW91cyBTQ0kgd2FrZXVwcyBmcm9tDQo+IHN1c3BlbmQtdG8taWRsZSkNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRoYXQuY29tPg0KPiANCj4gUmV2aWV3
ZWQtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCkFj
a2VkLWJ5OiBLLiBZLiBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT4NCg0KPiANCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jICAgICAgICAgICAgICB8IDIgKy0NCj4g
PiAgZHJpdmVycy9pbnB1dC9zZXJpby9oeXBlcnYta2V5Ym9hcmQuYyB8IDIgKy0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jIGIvZHJpdmVycy9oaWQvaGlkLWh5
cGVydi5jDQo+ID4gaW5kZXggYjM3Mjg1NGNmMzhkLi43MDQwNDllNjJkNTggMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9oaWQvaGlkLWh5cGVydi5jDQo+ID4gKysrIGIvZHJpdmVycy9oaWQvaGlk
LWh5cGVydi5jDQo+ID4gQEAgLTMwOSw3ICszMDksNyBAQCBzdGF0aWMgdm9pZCBtb3VzZXZzY19v
bl9yZWNlaXZlKHN0cnVjdCBodl9kZXZpY2UNCj4gKmRldmljZSwNCj4gPiAgICAgICAgICAgICAg
ICAgaGlkX2lucHV0X3JlcG9ydChpbnB1dF9kZXYtPmhpZF9kZXZpY2UsIEhJRF9JTlBVVF9SRVBP
UlQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXRfZGV2LT5pbnB1
dF9idWYsIGxlbiwgMSk7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgcG1fd2FrZXVwX2V2ZW50
KCZpbnB1dF9kZXYtPmRldmljZS0+ZGV2aWNlLCAwKTsNCj4gPiArICAgICAgICAgICAgICAgcG1f
d2FrZXVwX2hhcmRfZXZlbnQoJmlucHV0X2Rldi0+ZGV2aWNlLT5kZXZpY2UpOw0KPiA+DQo+ID4g
ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgZGVmYXVsdDoNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbnB1dC9zZXJpby9oeXBlcnYta2V5Ym9hcmQuYw0KPiBiL2RyaXZlcnMv
aW5wdXQvc2VyaW8vaHlwZXJ2LWtleWJvYXJkLmMNCj4gPiBpbmRleCA0N2EwZTgxYTI5ODkuLmE4
YjliZTNlMjhkYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lucHV0L3NlcmlvL2h5cGVydi1r
ZXlib2FyZC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbnB1dC9zZXJpby9oeXBlcnYta2V5Ym9hcmQu
Yw0KPiA+IEBAIC0xNzcsNyArMTc3LDcgQEAgc3RhdGljIHZvaWQgaHZfa2JkX29uX3JlY2VpdmUo
c3RydWN0IGh2X2RldmljZQ0KPiAqaHZfZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgKiBzdGF0
ZSBiZWNhdXNlIHRoZSBFbnRlci1VUCBjYW4gdHJpZ2dlciBhIHdha2V1cCBhdCBvbmNlLg0KPiA+
ICAgICAgICAgICAgICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAgaWYgKCEoaW5mbyAmIElT
X0JSRUFLKSkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBwbV93YWtldXBfZXZlbnQoJmh2
X2Rldi0+ZGV2aWNlLCAwKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwbV93YWtldXBf
aGFyZF9ldmVudCgmaHZfZGV2LT5kZXZpY2UpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjE0LjQNCj4gPg0K
