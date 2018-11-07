Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EAFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D0020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D0020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeKHG6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:58:41 -0500
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:48398 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKHG6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:58:40 -0500
X-Greylist: delayed 9257 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2018 01:58:40 EST
Received: from G9W8454.americas.hpqcorp.net (g9w8454.houston.hp.com [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 3FF274F;
        Wed,  7 Nov 2018 21:26:27 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 7 Nov 2018 21:26:27 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 7 Nov 2018 21:26:27 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1137.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 7 Nov 2018 21:26:25 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f97c:ef55:e88:5488]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f97c:ef55:e88:5488%8]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 21:26:23 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Subject: Re: [PATCH] libnvdimm: Fix __nd_ioctl() to check error in cmd_rc
Thread-Topic: [PATCH] libnvdimm: Fix __nd_ioctl() to check error in cmd_rc
Thread-Index: AQHUdssWhGjFmxE4w0qPR3FT5Fym76VEtC4AgAAfSgA=
Date:   Wed, 7 Nov 2018 21:26:23 +0000
Message-ID: <c5ef03e6652130a2a548511074b824cf7e25100d.camel@hpe.com>
References: <20181107185241.26982-1-toshi.kani@hpe.com>
         <CAPcyv4hE49JiFdaM_L0+KPQayZ0qRYokNRPxD5YuwCCp4fzkqQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hE49JiFdaM_L0+KPQayZ0qRYokNRPxD5YuwCCp4fzkqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1137;6:HGXkDjAr2T2D+xOu8aLM80ez8BIvDMLz7W3E3c9kGrlrhl3UeDHEARS7QSVAJrNRT6Tu0ZLadq/8QDBhhBAaodeww1jIuUQ152H3RBMAI0co0GqdLBxOmzMC51y8GVp9GILDp4TW98YZQ4tEqo8rGlCtFfsB+SsjYaH8NjaDo++BQaYboHH4Bv6Hca6Ohha7pLAvpwERPd9xAdyujfp9UxflO4gH1Pw9MoVWxSDh5FOM/89ijuZpge3bdqZqrrm5w9KjW8ih3pavM03kfYzguktlH/Ea3r6vfNLy8l5y8/mWxJ6P/eLY5jEqntRyVFcRqJEM20VCOREI1FChhW21DtD79p0X+S8HSgTCvP+lpwXiqr/ricLFVSz9u53TAmp8kHJZ5soLhHW2VwpaP888qZOh0BRPv2ZYxeEm9BWxg7qFCQAtGMT+jQHu4hnSdtK2UINSa8HadU/KlRWPHul/ow==;5:hodDXHeSj+y+Xf8uKR22Zpp9EpbwMSvhwaNEPAz3cJ60GvKn3Nl7gj3Ir2XeuYMNkwl5TtUbu4HISSwgkoFdefPWLDo6j7Xq/2bhuJ7z7eiAmte+tQJ40GV/rULwxBupMX5RSF0eXVmm4sGjh+vhl290zfajrpU6TUl2zfPMA8w=;7:ZKlUrgdWsUpKGQpJcc7HG3zTKaHn86dvXo8S8i3vBroB80dfBWeZxPqR8UZHqYxI3/mX6acW4dpH9DQZZHtW6Zp+rc32m3Ykc2ZI/M+k0EE8McbZs1qEMnxN4ArCn1cvW/Nf7PTFryQFit9gKbrv7Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(8676002)(2501003)(305945005)(25786009)(105586002)(7736002)(3846002)(81166006)(8936002)(81156014)(6916009)(6506007)(102836004)(26005)(53546011)(6116002)(2616005)(11346002)(446003)(476003)(76176011)(486006)(2351001)(14444005)(256004)(106356001)(2906002)(4326008)(478600001)(97736004)(68736007)(118296001)(14454004)(71200400001)(71190400001)(53936002)(6246003)(36756003)(2900100001)(86362001)(99286004)(66066001)(5660300001)(54906003)(5640700003)(6486002)(186003)(229853002)(316002)(6436002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1137;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 84d136bd-75fa-4fe2-f7d1-08d644f7ab34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1137;
x-ms-traffictypediagnostic: AT5PR8401MB1137:
x-microsoft-antispam-prvs: <AT5PR8401MB1137A3D299B5CE3DAFE5034A82C40@AT5PR8401MB1137.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB1137;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1137;
x-forefront-prvs: 08497C3D99
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e/lcEidvMDaYRDRCxNuXN18Q8HWUmLzNpNbCMhaxV6FDkHopR3XNL/aQO4p0MBLY/iAXHm6GCFCECpkrWVEzPCpuf3BQ8uaSmC3UjvMrru5Sy8RZF+SKcZRSG0p2v+2LgqABZ9OqUWhWhI1ficMQjdX+DjLXwYspQEOSVq+E1u4t20uRy2jCMTgyKSz9tU4GI9HMbZ3rYF3L7p/kNmMMzr0OtzEiXVr4osfIi9Bp3vjZhxvddZm28DWOCC8rGGKWJwQm/LOss9gOPxaV4Zz+uSjuuDh4b89FsIoIGYoUIm1YnsMfAEggVWjN1b/dYmpvc75RpY7knt2zl3K4AX+UMIf3ZYLN3B9NsbGGjPOx6Dc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B23673BCFE56C4083813217C85D7534@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d136bd-75fa-4fe2-f7d1-08d644f7ab34
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 21:26:23.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1137
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDExOjM0IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFdlZCwgTm92IDcsIDIwMTggYXQgMTA6NTIgQU0gVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBo
cGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBuZGN0bCB6ZXJvLWxhYmVscyBjb21wbGV0ZXMgd2l0
aCBhIGxhcmdlIG51bWJlciBvZiB6ZXJvZWQgbm1lbXMgd2hlbg0KPiA+IGl0IGZhaWxzIHRvIGRv
IHplcm9pbmcgb24gYSBwcm90ZWN0ZWQgTlZESU1NLg0KPiA+IA0KPiA+ICAgIyBuZGN0bCB6ZXJv
LWxhYmVscyBubWVtMQ0KPiA+ICAgemVyb2VkIDY1NTA0IG5tZW1zDQo+ID4gDQo+ID4gV2hlbiBh
biBBQ1BJIGNhbGwgY29tcGxldGVzIHdpdGggZXJyb3IsIHhsYXRfc3RhdHVzKCkgY2FsbGVkIGZy
b20NCj4gPiBhY3BpX25maXRfY3RsKCkgc2V0cyBlcnJvciB0byAqY21kX3JjLiAgX19uZF9pb2N0
bCgpLCBob3dldmVyLCBkb2VzDQo+ID4gbm90IGNoZWNrIHRoaXMgZXJyb3IgYW5kIHJldHVybnMg
d2l0aCBzdWNjZXNzLg0KPiA+IA0KPiA+IEZpeCBfX25kX2lvY3RsKCkgdG8gY2hlY2sgdGhpcyBl
cnJvciBpbiBjbWRfcmMuDQo+IA0KPiBTbyB0aGlzIGFycmFuZ2VtZW50IGlzIGJ5IGRlc2lnbiBh
bmQgdGhlIGJ1ZyBpcyBpbiB0aGUgbmRjdGwgdXRpbGl0eS4NCj4gDQo+IEEgc3VjY2Vzc2Z1bCBy
ZXR1cm4gY29kZSBmcm9tIHRoZSBpb2N0bCBtZWFucyB0aGF0IHRoZSBjb21tYW5kIHdhcw0KPiBz
dWNjZXNzZnVsbHkgc3VibWl0dGVkIHRvIGZpcm13YXJlLiBJdCdzIHRoZW4gdXAgdG8gdXNlcnNw
YWNlIHRvIHBhcnNlDQo+IGlmIHRoZXJlIHdhcyBhIGNvbW1hbmQgc3BlY2lmaWMgZXJyb3IgcmV0
dXJuZWQgaW4gdGhlIHJlc3BvbnNlDQo+IHBheWxvYWQuIEF1dG9tYXRpY2FsbHkgcmV0dXJuaW5n
IGNtZF9yYyByZW1vdmVzIHRoZSBhYmlsaXR5IGZvcg0KPiB1c2Vyc3BhY2UgdG9vbGluZyB0byBk
byBpdHMgb3duIGNvbW1hbmQgc3BlY2lmaWMgZXJyb3IgaGFuZGxpbmcuIFdpdGgNCj4gdGhpcyBj
aGFuZ2UgdXNlcnNwYWNlIGNvdWxkIG5vIGxvbmdlciBiZSBzdXJlIGlmIHRoZSBmYWlsdXJlIGlz
IGluIHRoZQ0KPiBzdWJtaXNzaW9uIG9yIHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbW1hbmQsIG9y
IGRldGVybWluZSBpZiB0aGUNCj4gY29tbWFuZCByZXNwb25zZSBwYXlsb2FkIGlzIHZhbGlkLg0K
DQpJIHNlZS4gIEkgd2FzIHdvbmRlcmluZyB3aGljaCBzaWRlIG5lZWRzIHRvIGJlIGZpeGVkLCBh
bmQgZGVjaWRlZCB0bw0KZm9sbG93IGtlcm5lbC1pbnRlcm5hbCBBQ1BJIGNhbGxzIGxpa2UgbnZk
aW1tX2NsZWFyX3BvaXNvbigpLiAgSSBhZ3JlZQ0KdGhhdCBhIGNvbW1hbmQgZXJyb3IgY29kZSBp
cyBuZWNlc3NhcnkgaWYgdXNlciBzcGFjZSB0b29sIG5lZWRzIHRvIGRlYWwNCndpdGggaXQuICBP
SywgSSB3aWxsIGxvb2sgaW50byBmaXhpbmcgbmRjdGwuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
