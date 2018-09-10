Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9994BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F2E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GCWO5QGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F2E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeIJSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:40:59 -0400
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com ([104.47.36.117]:33216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbeIJSk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MbhrUztc5BVfmePyAF/5s3whA3sdmqNSGC/A2YHxQw=;
 b=GCWO5QGDfe56rPYu+Xjfl4qCHCkcf3YpDAjxa6336jfOPlBSe8vSPl55RGzuzPLNjpPoeFqHPymenjuGnPCDnMoR2IfHlx5nRDM8++vLLvZQdw+IrMtlOREdYaosmkxI7h7N5cnva2JSgFlSjMx7uWIM2JAng8M2VnL5mFDarv4=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0284.namprd21.prod.outlook.com (10.173.174.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Mon, 10 Sep 2018 13:46:46 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 13:46:46 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Topic: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Index: AQHUSQLFF/mQjCkfKkuMMO7HZfKu+6Tpf1cAgAAIDwA=
Date:   Mon, 10 Sep 2018 13:46:45 +0000
Message-ID: <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
In-Reply-To: <20180910131754.GG10951@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0284;6:s5xZzqcaNCeDlvzgKmNWVBpcXSieAWM66HLAHInIdNtSp+Lm9MGOmwiKapj+BaJ8C5BpjGJmE3u4CVWSPMug1z5fvAgp1HZaVxq4qNYx6Sx2Z5Oa8YdrUVFYEFharJsxUsW6AuA7cEWpzpsR+L1Bpu4tOBdEUWYKmmc1Um14Uqz3L/5I8RFIhl9KZp/5QaXycEWXzmADROtNAG13A4iDykgMBOPSiHqrXXfo0+v8Sul6bUC9pAJHrlSZml8diVh1K1ESQv4WD1rZgmTIFbeLWgPDez9hpPGQ9XCEr4hKFwXBRgIZGrrTlcopapE53YY2tvuoWVdsn5FmNXKza0wGNYkHXjx4aHkJiBIEb7PX88rACkeIac0CHiVuoynOhqTrLaHzAVncAMiKqTOq83oBfBS+IlY94TUtyakidb1fg03t/GnJ6+EVylm1+aYQFhm9WXRd2Vw2PklauSX0gbLp6g==;5:roibzf/gt4CpSBoNMltzsmtjZq/iJoYqDN6fuyuMrNabZlghyI+OmJf7yxIhiUdTKFuHV/UMoQSiWToaerADjrBIhqfviw/m3nzR8XteHtUC3kpI94DNw0FgrGxVzc6lWI7GcyryM2+Ww0KuozjeAqLn+LGwfy2yZrvXZKbhZzw=;7:bo06og78Lp8wFb4/RQYRGyQD9zvxQeYfI7T2d/4a6Q9JUrLsOeFZS5aaV6WPHtGanBm3bIGT4gy34HoUXtq0gUav8U2xj6gbAFY1z9FxZzpOZ9h2wFQR1oBTY+XsJ2Sjshi3vTiwQmerSaitTS53dvGUkN22ZqUvjXweOZCxBwGYMMdSc6Jfsl7WvGeAIyU+UQt9xh9Fzx30YzjO4lKPaUmk4Tmzr8YSHs3sekfcYFTbSo58uVF2p5PdkrVBKnfR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dd9611e8-a9f0-4035-2c10-08d61723d989
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0284;
x-ms-traffictypediagnostic: DM5PR21MB0284:
x-microsoft-antispam-prvs: <DM5PR21MB02844F2820B0D8B7FE59B84D9D050@DM5PR21MB0284.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(190383065149520)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991033);SRVR:DM5PR21MB0284;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0284;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(43544003)(2906002)(54906003)(72206003)(478600001)(66066001)(22452003)(8676002)(81156014)(14454004)(110136005)(10290500003)(256004)(14444005)(6246003)(81166006)(6116002)(316002)(305945005)(53936002)(7736002)(4326008)(25786009)(3846002)(6512007)(86362001)(86612001)(6486002)(26005)(102836004)(99286004)(31696002)(76176011)(5660300001)(446003)(229853002)(10090500001)(97736004)(6436002)(68736007)(476003)(2900100001)(2616005)(36756003)(106356001)(5250100002)(11346002)(6346003)(105586002)(31686004)(53546011)(6506007)(8936002)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0284;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: Z4oMdkPslC2EnyTgxIuMVevmlWpYeExdNl+QSi7jQ/H3RdYgEmL5b3Ewo5FdaHrTzan5T0AS6HWZRWrE4YfAcS/1NuS+pFiVZtQA+ub651ju5QNMtfnLIYMMH3e0izmgbjLm3Taa+0Yqa4161yL45IP4uUG5UHTP4t9TDC7F01MsKZ5PIkky6r7Xl0u+DcovOrJM7pJu+bQK4zYuq9jpS1aUEi/eim6x4X8523Fxeo5gd2LEVGv2B66J+8R1gFZWV+jitad59b2t72q4ComLEjl3cA/QnF90ww+y+OxU9kwI2fWYSsPgOhMBnDe9jj6n+76r65pWes7c0PlVgPzUvpn4xgUupeJkB+Ys9Ph4CKU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1627E19FBAC8A545A404BE0C5715B9FD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9611e8-a9f0-4035-2c10-08d61723d989
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 13:46:45.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0284
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTAvMTggOToxNyBBTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBbQ2MgUGF2ZWxd
DQo+IA0KPiBPbiBNb24gMTAtMDktMTggMTQ6MzU6MjcsIE1pa2hhaWwgWmFzbG9ua28gd3JvdGU6
DQo+PiBJZiBtZW1vcnkgZW5kIGlzIG5vdCBhbGlnbmVkIHdpdGggdGhlIGxpbnV4IG1lbW9yeSBz
ZWN0aW9uIGJvdW5kYXJ5LCBzdWNoDQo+PiBhIHNlY3Rpb24gaXMgb25seSBwYXJ0bHkgaW5pdGlh
bGl6ZWQuIFRoaXMgbWF5IGxlYWQgdG8gVk1fQlVHX09OIGR1ZSB0bw0KPj4gdW5pbml0aWFsaXpl
ZCBzdHJ1Y3QgcGFnZXMgYWNjZXNzIGZyb20gaXNfbWVtX3NlY3Rpb25fcmVtb3ZhYmxlKCkgb3IN
Cj4+IHRlc3RfcGFnZXNfaW5fYV96b25lKCkgZnVuY3Rpb24uDQo+Pg0KPj4gSGVyZSBpcyBvbmUg
b2YgdGhlIHBhbmljIGV4YW1wbGVzOg0KPj4gIENPTkZJR19ERUJVR19WTV9QR0ZMQUdTPXkNCj4+
ICBrZXJuZWwgcGFyYW1ldGVyIG1lbT0zMDc1TQ0KPiANCj4gT0ssIHNvIHRoZSBsYXN0IG1lbW9y
eSBzZWN0aW9uIGlzIG5vdCBmdWxsIGFuZCB3ZSBoYXZlIGEgcGFydGlhbCBtZW1vcnkNCj4gYmxv
Y2sgcmlnaHQ/DQo+IA0KPj4gIHBhZ2UgZHVtcGVkIGJlY2F1c2U6IFZNX0JVR19PTl9QQUdFKFBh
Z2VQb2lzb25lZChwKSkNCj4gDQo+IE9LLCB0aGlzIG1lYW5zIHRoYXQgdGhlIHN0cnVjdCBwYWdl
IGlzIG5vdCBmdWxseSBpbml0aWFsaXplZC4gRG8geW91DQo+IGhhdmUgYSBzcGVjaWZpYyBwbGFj
ZSB3aGljaCBoYXMgdHJpZ2dlcmVkIHRoaXMgYXNzZXJ0Pw0KPiANCj4+ICAtLS0tLS0tLS0tLS1b
IGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4+ICBDYWxsIFRyYWNlOg0KPj4gIChbPDAwMDAwMDAw
MDAzOWI4YTQ+XSBpc19tZW1fc2VjdGlvbl9yZW1vdmFibGUrMHhjYy8weDFjMCkNCj4+ICAgWzww
MDAwMDAwMDAwOTU1OGJhPl0gc2hvd19tZW1fcmVtb3ZhYmxlKzB4ZGEvMHhlMA0KPj4gICBbPDAw
MDAwMDAwMDA5MzI1ZmM+XSBkZXZfYXR0cl9zaG93KzB4M2MvMHg4MA0KPj4gICBbPDAwMDAwMDAw
MDA0N2U3ZWE+XSBzeXNmc19rZl9zZXFfc2hvdysweGRhLzB4MTYwDQo+PiAgIFs8MDAwMDAwMDAw
MDNmYzRlMD5dIHNlcV9yZWFkKzB4MjA4LzB4NGM4DQo+PiAgIFs8MDAwMDAwMDAwMDNjYjgwZT5d
IF9fdmZzX3JlYWQrMHg0Ni8weDE4MA0KPj4gICBbPDAwMDAwMDAwMDAzY2I5Y2U+XSB2ZnNfcmVh
ZCsweDg2LzB4MTQ4DQo+PiAgIFs8MDAwMDAwMDAwMDNjYzA2YT5dIGtzeXNfcmVhZCsweDYyLzB4
YzANCj4+ICAgWzwwMDAwMDAwMDAwYzAwMWMwPl0gc3lzdGVtX2NhbGwrMHhkYy8weDJkOA0KPj4N
Cj4+IFRoaXMgZml4IGNoZWNrcyBpZiB0aGUgcGFnZSBsaWVzIHdpdGhpbiB0aGUgem9uZSBib3Vu
ZGFyaWVzIGJlZm9yZQ0KPj4gYWNjZXNzaW5nIHRoZSBzdHJ1Y3QgcGFnZSBkYXRhLiBUaGUgY2hl
Y2sgaXMgYWRkZWQgdG8gYm90aCBmdW5jdGlvbnMuDQo+PiBBY3R1YWxseSBzaW1pbGFyIGNoZWNr
IGhhcyBhbHJlYWR5IGJlZW4gcHJlc2VudCBpbg0KPj4gaXNfcGFnZWJsb2NrX3JlbW92YWJsZV9u
b2xvY2soKSBmdW5jdGlvbiBidXQgb25seSBhZnRlciB0aGUgc3RydWN0IHBhZ2UNCj4+IGlzIGFj
Y2Vzc2VkLg0KPj4NCj4gDQo+IFdlbGwsIEkgYW0gYWZyYWlkIHRoaXMgaXMgbm90IHRoZSBwcm9w
ZXIgc29sdXRpb24uIFdlIGFyZSByZWx5aW5nIG9uIHRoZQ0KPiBmdWxsIHBhZ2VibG9jayB3b3J0
aCBvZiBpbml0aWFsaXplZCBzdHJ1Y3QgcGFnZXMgYXQgbWFueSBvdGhlciBwbGFjZS4gV2UNCj4g
dXNlZCB0byBkbyB0aGF0IGluIHRoZSBwYXN0IGJlY2F1c2Ugd2UgaGF2ZSBpbml0aWFsaXplZCB0
aGUgZnVsbA0KPiBzZWN0aW9uIGJ1dCB0aGlzIGhhcyBiZWVuIGNoYW5nZWQgcmVjZW50bHkuIFBh
dmVsLCBkbyB5b3UgaGF2ZSBhbnkgaWRlYXMNCj4gaG93IHRvIGRlYWwgd2l0aCB0aGlzIHBhcnRp
YWwgbWVtIHNlY3Rpb25zIG5vdz8NCg0KV2UgaGF2ZToNCg0KcmVtb3ZlX21lbW9yeSgpDQoJQlVH
X09OKGNoZWNrX2hvdHBsdWdfbWVtb3J5X3JhbmdlKHN0YXJ0LCBzaXplKSkNCg0KVGhhdCBzdXBw
b3NlZCB0byBzYWZlbHkgY2hlY2sgZm9yIHRoaXMgY29uZGl0aW9uOiBpZiBbc3RhcnQsIHN0YXJ0
ICsNCnNpemUpIG5vdCBibG9jayBzaXplIGFsaWduZWQgKGFuZCB3ZSBrbm93IGJsb2NrIHNpemUg
aXMgc2VjdGlvbg0KYWxpZ25lZCksIGhvdCByZW1vdmUgaXMgbm90IGFsbG93ZWQuIFRoZSBwcm9i
bGVtIGlzIHRoaXMgY2hlY2sgaXMgbGF0ZSwNCmFuZCBvbmx5IGhhcHBlbnMgd2hlbiBpbnZhbGlk
IHJhbmdlIGhhcyBhbHJlYWR5IHBhc3NlZCB0aHJvdWdoIHByZXZpb3VzDQpjaGVja3MuDQoNCldl
IGNvdWxkIGFkZCBjaGVja19ob3RwbHVnX21lbW9yeV9yYW5nZSgpIHRvIGlzX21lbV9zZWN0aW9u
X3JlbW92YWJsZSgpOg0KDQppc19tZW1fc2VjdGlvbl9yZW1vdmFibGUoc3RhcnRfcGZuLCBucl9w
YWdlcykNCiBpZiAoY2hlY2tfaG90cGx1Z19tZW1vcnlfcmFuZ2UoUEZOX1BIWVMoc3RhcnRfcGZu
KSwgUEZOX1BIWVMobnJfcGFnZXMpKSkNCiAgcmV0dXJuIGZhbHNlOw0KDQpJIHRoaW5rIGl0IHNo
b3VsZCB3b3JrLg0KDQpQYXZlbA0KDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogTWlraGFpbCBaYXNs
b25rbyA8emFzbG9ua29AbGludXguaWJtLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBHZXJhbGQgU2No
YWVmZXIgPGdlcmFsZC5zY2hhZWZlckBkZS5pYm0uY29tPg0KPj4gQ2M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPg0KPj4gLS0tDQo+PiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDIwICsrKysrKysr
KysrLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9t
ZW1vcnlfaG90cGx1Zy5jDQo+PiBpbmRleCA5ZWVhNmU4MDlhNGUuLjhlMjBlOGZjYzNiMCAxMDA2
NDQNCj4+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVnLmMNCj4+ICsrKyBiL21tL21lbW9yeV9ob3Rw
bHVnLmMNCj4+IEBAIC0xMjI5LDkgKzEyMjksOCBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKm5leHRf
YWN0aXZlX3BhZ2VibG9jayhzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4+ICAJcmV0dXJuIHBhZ2UgKyBw
YWdlYmxvY2tfbnJfcGFnZXM7DQo+PiAgfQ0KPj4gIA0KPj4gLXN0YXRpYyBib29sIGlzX3BhZ2Vi
bG9ja19yZW1vdmFibGVfbm9sb2NrKHN0cnVjdCBwYWdlICpwYWdlKQ0KPj4gK3N0YXRpYyBib29s
IGlzX3BhZ2VibG9ja19yZW1vdmFibGVfbm9sb2NrKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3Qg
em9uZSAqKnpvbmUpDQo+PiAgew0KPj4gLQlzdHJ1Y3Qgem9uZSAqem9uZTsNCj4+ICAJdW5zaWdu
ZWQgbG9uZyBwZm47DQo+PiAgDQo+PiAgCS8qDQo+PiBAQCAtMTI0MSwxNSArMTI0MCwxNCBAQCBz
dGF0aWMgYm9vbCBpc19wYWdlYmxvY2tfcmVtb3ZhYmxlX25vbG9jayhzdHJ1Y3QgcGFnZSAqcGFn
ZSkNCj4+ICAJICogV2UgaGF2ZSB0byB0YWtlIGNhcmUgYWJvdXQgdGhlIG5vZGUgYXMgd2VsbC4g
SWYgdGhlIG5vZGUgaXMgb2ZmbGluZQ0KPj4gIAkgKiBpdHMgTk9ERV9EQVRBIHdpbGwgYmUgTlVM
TCAtIHNlZSBwYWdlX3pvbmUuDQo+PiAgCSAqLw0KPj4gLQlpZiAoIW5vZGVfb25saW5lKHBhZ2Vf
dG9fbmlkKHBhZ2UpKSkNCj4+IC0JCXJldHVybiBmYWxzZTsNCj4+IC0NCj4+IC0Jem9uZSA9IHBh
Z2Vfem9uZShwYWdlKTsNCj4+ICAJcGZuID0gcGFnZV90b19wZm4ocGFnZSk7DQo+PiAtCWlmICgh
em9uZV9zcGFuc19wZm4oem9uZSwgcGZuKSkNCj4+ICsJaWYgKCp6b25lICYmICF6b25lX3NwYW5z
X3Bmbigqem9uZSwgcGZuKSkNCj4+ICAJCXJldHVybiBmYWxzZTsNCj4+ICsJaWYgKCFub2RlX29u
bGluZShwYWdlX3RvX25pZChwYWdlKSkpDQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArCSp6b25l
ID0gcGFnZV96b25lKHBhZ2UpOw0KPj4gIA0KPj4gLQlyZXR1cm4gIWhhc191bm1vdmFibGVfcGFn
ZXMoem9uZSwgcGFnZSwgMCwgTUlHUkFURV9NT1ZBQkxFLCB0cnVlKTsNCj4+ICsJcmV0dXJuICFo
YXNfdW5tb3ZhYmxlX3BhZ2VzKCp6b25lLCBwYWdlLCAwLCBNSUdSQVRFX01PVkFCTEUsIHRydWUp
Ow0KPj4gIH0NCj4+ICANCj4+ICAvKiBDaGVja3MgaWYgdGhpcyByYW5nZSBvZiBtZW1vcnkgaXMg
bGlrZWx5IHRvIGJlIGhvdC1yZW1vdmFibGUuICovDQo+PiBAQCAtMTI1NywxMCArMTI1NSwxMSBA
QCBib29sIGlzX21lbV9zZWN0aW9uX3JlbW92YWJsZSh1bnNpZ25lZCBsb25nIHN0YXJ0X3Bmbiwg
dW5zaWduZWQgbG9uZyBucl9wYWdlcykNCj4+ICB7DQo+PiAgCXN0cnVjdCBwYWdlICpwYWdlID0g
cGZuX3RvX3BhZ2Uoc3RhcnRfcGZuKTsNCj4+ICAJc3RydWN0IHBhZ2UgKmVuZF9wYWdlID0gcGFn
ZSArIG5yX3BhZ2VzOw0KPj4gKwlzdHJ1Y3Qgem9uZSAqem9uZSA9IE5VTEw7DQo+PiAgDQo+PiAg
CS8qIENoZWNrIHRoZSBzdGFydGluZyBwYWdlIG9mIGVhY2ggcGFnZWJsb2NrIHdpdGhpbiB0aGUg
cmFuZ2UgKi8NCj4+ICAJZm9yICg7IHBhZ2UgPCBlbmRfcGFnZTsgcGFnZSA9IG5leHRfYWN0aXZl
X3BhZ2VibG9jayhwYWdlKSkgew0KPj4gLQkJaWYgKCFpc19wYWdlYmxvY2tfcmVtb3ZhYmxlX25v
bG9jayhwYWdlKSkNCj4+ICsJCWlmICghaXNfcGFnZWJsb2NrX3JlbW92YWJsZV9ub2xvY2socGFn
ZSwgJnpvbmUpKQ0KPj4gIAkJCXJldHVybiBmYWxzZTsNCj4+ICAJCWNvbmRfcmVzY2hlZCgpOw0K
Pj4gIAl9DQo+PiBAQCAtMTI5Niw2ICsxMjk1LDkgQEAgaW50IHRlc3RfcGFnZXNfaW5fYV96b25l
KHVuc2lnbmVkIGxvbmcgc3RhcnRfcGZuLCB1bnNpZ25lZCBsb25nIGVuZF9wZm4sDQo+PiAgCQkJ
CWkrKzsNCj4+ICAJCQlpZiAoaSA9PSBNQVhfT1JERVJfTlJfUEFHRVMgfHwgcGZuICsgaSA+PSBl
bmRfcGZuKQ0KPj4gIAkJCQljb250aW51ZTsNCj4+ICsJCQkvKiBDaGVjayBpZiB3ZSBnb3Qgb3V0
c2lkZSBvZiB0aGUgem9uZSAqLw0KPj4gKwkJCWlmICh6b25lICYmICF6b25lX3NwYW5zX3Bmbih6
b25lLCBwZm4pKQ0KPj4gKwkJCQlyZXR1cm4gMDsNCj4+ICAJCQlwYWdlID0gcGZuX3RvX3BhZ2Uo
cGZuICsgaSk7DQo+PiAgCQkJaWYgKHpvbmUgJiYgcGFnZV96b25lKHBhZ2UpICE9IHpvbmUpDQo+
PiAgCQkJCXJldHVybiAwOw0KPj4gLS0gDQo+PiAyLjE2LjQNCj4g
