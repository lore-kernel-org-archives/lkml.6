Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B292CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E819204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="EaBxeQXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E819204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeKIE2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:28:04 -0500
Received: from mail-eopbgr810082.outbound.protection.outlook.com ([40.107.81.82]:13760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbeKIE2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUwj9xoRds0rEIbnOVcYtCiG7Jcd5xaGN5wAzkXFvVY=;
 b=EaBxeQXCP4JVJG+ChvudN1T3EwBWSvc9blbrNQy/Rs/A0WJBy1FxNzu5aoD6KiRCtoknI1dpl/DJUtuGf68MJz7S0ZYuDRmPW1AHR0oP4vchsV5BKM+L8yvw5GQbT2DgkXfhmxDpDlHLpTFAyNoQ5POeyKKF2IfdzPTXXeUhD8c=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0656.namprd10.prod.outlook.com (10.163.135.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Thu, 8 Nov 2018 18:50:32 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%4]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 18:50:32 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "nkela@cisco.com" <nkela@cisco.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Thread-Topic: [PATCH] jffs2: implement mount option to configure endianness
Thread-Index: AQHUdhzsqXgjqeVdYEqFu2rUs5D51aVEBd8AgACWlYCAAAK6AIAA6gMAgACks4CAAA24gA==
Date:   Thu, 8 Nov 2018 18:50:32 +0000
Message-ID: <0cb565e18874070df969c5f5d05083df5075dfbc.camel@infinera.com>
References: <20181106214928.40020-1-nkela@cisco.com>
         <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
         <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
         <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
         <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
         <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
In-Reply-To: <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0656;6:vjElIdQ8rsktnGNTrp7jmQQRNX87RUox4ouFzbFvQiMwkpqR5X9xXz8XFyZRPhsstLgoMBWqnB5OOVPgedVZb9yg0cyeUHWy3QwcWlxB2OMCBRDhAc17dC2ZExsR2p632ht9BpjMjriltLbkT1VsnldNngoSCxkvWpDnZZf5o/HnWpu03N8U9R3YpMZdGHO1Y0lfyxYx6LH7XPm+gCJiusgDM5+t3T+xCfpOcqO3iu5xcDzOZRojnfDgQdSbDTwJiZKx94IVmRdzT4HpBLLaH4rONEySWX9vd7RNFV9H7rjvXPBWpyNQEgdimHlLhaeRfdFzgsSmuLZzyQgmCou50wpZVBh6I+z2uHtSk0vQd6DPxzoH+ig+xXHRW+lZsaO9Bl/2ncLYOkurGxyb5ZxXEaML30TpaJsdnaLEqjtcH9T+usURqSdkgU6l3oBBjlV50aKMFm2EvoWFRdgmk/oVXA==;5:lrtnoLH08EbCRSKK19UgHf6VXFnGfWrA9+hlM1/bEA5I0DFwW/lI5nko0psjLitSUR43bdAX3kD8f41u7hLFVN80S8dSZ6uunEtdXIWTFl2MVgMofE+8GL2dYiuFq8Lyj4pw+d/BcUF4r5YMTADNOhUzzkTpYY41lFDTA1vRAYE=;7:h8HzoQyGcNJ6TYko8cgM2chx7G7JjIhBQtmnl8suCno2VVsDNahY9HczbKUnFSRYwjmisU+VrT+c8batpwPByBNVytivLtT8IPK1Ow5BgUn+yqWgvleezW1DQ67C5CiqU9q4j2GhvUA2Kabw7bd0zA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 994f4e9f-7bd1-4457-0994-08d645ab0fc4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0656;
x-ms-traffictypediagnostic: SN1PR10MB0656:
x-microsoft-antispam-prvs: <SN1PR10MB0656C597773C7873E8F486C1F4C50@SN1PR10MB0656.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR10MB0656;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0656;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(51444003)(54094003)(199004)(189003)(14444005)(5024004)(5660300001)(476003)(110136005)(39060400002)(446003)(4326008)(486006)(36756003)(7736002)(256004)(14454004)(86362001)(93886005)(106356001)(8936002)(478600001)(105586002)(26005)(54906003)(2201001)(186003)(316002)(2906002)(53546011)(102836004)(81156014)(2501003)(81166006)(6246003)(97736004)(66066001)(53936002)(8676002)(6506007)(6486002)(72206003)(966005)(68736007)(6116002)(305945005)(2616005)(11346002)(2900100001)(76176011)(118296001)(6512007)(71200400001)(6436002)(99286004)(229853002)(71190400001)(6306002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0656;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7l45R2tQniwM1oxGfKEbSJ70lmj50Z0wrGOVC0MG82qUpnjdyCUGZ9+Wuq6cFLogGPxrW0xShFgfCVd0s7DuR8AaQr9ED03d3mnEH1WTRUQpaQ+unTqLx+cnTU1WGh7+bmx0lxWOZjSjnRC5h9VG47gcEdR/y8INY2JPwpvfwbZ/l1sF53MdeHtvrPWxq8Snl/C1iKxiZ6MrKA93N+p+tpwJl5qoPPQv6pdmuU4QsZhIBXzaLD8OtV6ekL3JQS/EISx1MiqmMpTD8RILXkq9SvOSwbe9NlwDlG8DL9+6lcbibUc32UdDP680MJNpeLGncVf1jtuW/xbqUCe22zsoyPL0UDNKULV5DQkwWd4voWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <18E30B9884B9F147AAF059C5BC6143E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f4e9f-7bd1-4457-0994-08d645ab0fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 18:50:32.4492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTA4IGF0IDE4OjAxICswMDAwLCBOaWt1bmogS2VsYSAobmtlbGEpIHdy
b3RlOg0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRo
ZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4gDQo+IA0KPiBPbiAxMS84LzE4LCAxMjoxMiBBTSwgIkRhdmlkIFdvb2Rob3VzZSIgPGR3
bXcyQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gICAgIE9uIFdlZCwgMjAxOC0xMS0wNyBh
dCAxOToxNCArMDEwMCwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KPiAgICAgPiBPbiBXZWQs
IE5vdiA3LCAyMDE4IGF0IDc6MDUgUE0gTmlrdW5qIEtlbGEgKG5rZWxhKSA8bmtlbGFAY2lzY28u
Y29tPiB3cm90ZToNCj4gICAgID4gPiBJIGhhZCB0cmllZCB0byB1c2UgY29uZmlncyB0byBzdGFy
dCB3aXRoIHZpYSB0aGUgZm9sbG93aW5nIHBhdGNoIGhvd2V2ZXIgSSB3YXMgYWR2aXNlZCB0byBo
YXZlIGEgbW91bnQgb3B0aW9uOg0KPiAgICAgPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L3BpcGVybWFpbC9saW51eC1tdGQvMjAxOC1Ob3ZlbWJlci8wODUxMjYuaHRtbA0KPiAgICAgPg0K
PiAgICAgPiBKdXN0IHNob3cgcGVyZm9ybWFuY2UgbnVtYmVycyBvbiBob3cgeW91ciBpbXBsZW1l
bnRhdGlvbiBoYXMgYW4gaW1wYWN0IG9yIG5vdC4NCj4gICAgID4gU28gZmFyIHlvdXIgaW1wbGVt
ZW50YXRpb24gaXMgYWxzbyBub3QgbXVjaCBvcHRpbWl6ZWQsIG1heWJlIGxpa2VseSgpDQo+ICAg
ICA+IG9yIHN0YXRpYyBrZXlzIGNhbiBoZWxwLi4uDQo+IA0KPiAgICAgVXNpbmcgbGlrZWx5KCkg
Zm9yIHRoZSBuYXRpdmUgY2FzZSBtaWdodCBoZWxwLiBTdGF0aWMga2V5cyBtaWdodCBoZWxwIGEN
Cj4gICAgIGxpdHRsZSBtb3JlLCBidXQgY291bGQgb25seSB3b3JrIGlmIGV2ZXJ5IGZpbGUgc3lz
dGVtIGhhcyB0aGUgKnNhbWUqDQo+ICAgICBlbmRpYW5uZXNzLiBVbmxlc3Mgd2UgZW5kIHVwIHdp
dGggdGhyZWUgdmFyaWFudHMsIGZvciBuYXRpdmUgdnMuIHN3YXANCj4gICAgIHZzLiBydW50aW1l
IGNoZWNraW5nLg0KPiANCj4gICAgIFdlIGFsc28gbG9zZSBhIGJ1bmNoIG9mIHRoZSBvcHRpbWlz
YXRpb25zIHRoYXQgd2UgZ2FpbmVkIGZyb20gdXNpbmcNCj4gICAgIF9fYnVpbHRpbl9zd2FiIGZ1
bmN0aW9ucywgd2hpY2ggbGV0IHRoZSBjb21waWxlciBzZWUgd2hhdCB3YXMgZ29pbmcgb24uDQo+
IA0KPiAgICAgQnV0IHdlIGNhbiBoeXBvdGhlc2lzZSBhbmQgaGFuZHdhdmUgYWJvdXQgaXQgdW50
aWwgdGhlIGNvd3MgY29tZSBob21lOw0KPiAgICAgSSdkIGxpa2UgdG8gc2VlIGEgcmVhbCB0ZXN0
IG9mIHdoZXRoZXIgaXQgYWN0dWFsbHkgbWFrZXMgYSBkaWZmZXJlbmNlDQo+ICAgICB0aGF0IHdl
IGNhcmUgYWJvdXQuDQo+IA0KPiAgICAgSWYgaXQgZG9lcywgb25lIG9wdGlvbiBtaWdodCBiZSB0
byBqdXN0IGJ1aWxkIHNlcGFyYXRlIHZlcnNpb25zIG9mDQo+ICAgICBzY2FuLmMgZm9yIGVhY2gg
ZW5kaWFubmVzcywgc2luY2UgdGhhdCdzIHRoZSBjcml0aWNhbCBwYXRoIHdlIGNhcmUNCj4gICAg
IGFib3V0Lg0KPiANCj4gSSB3b25kZXIgaWYgdGhpcyBmZWF0dXJlIGlzIHJlYWxseSB0aGF0IGlt
cG9ydGFudCB0aGF0IHdlIG5lZWQgdG8gZHVwbGljYXRlIHRoZSBkcml2ZXJzLg0KPiBBbHNvLCBp
dCBtaWdodCB0YWtlIHNvbWUgdGltZSBmb3IgbWUgdG8gZmluZCBzb21lIGRldmljZSB0aGF0IEkg
Y2FuIHJ1biB0aGUgdGVzdHMgd2l0aCBhbmQgd2l0aG91dCB0aGlzIHBhdGNoLg0KPiBJIGFtIHdv
bmRlcmluZyBpZiB3ZSBjYW4gc3RpbGwgY29uc2lkZXIgbXkgZmlyc3QgcGF0Y2ggd2l0aCBjb25m
aWcgb3B0aW9ucyBhcyBhIGdvb2QgY29tcHJvbWlzZSBvbiBpdD8NCg0KSSB0aGluayB0aGF0IGlz
IGEgZ29vZCBpZGVhLiANCg0KIEpvY2tlDQo=
