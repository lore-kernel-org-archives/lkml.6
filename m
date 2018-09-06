Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6905DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E13A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZFlDMbGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E13A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIFWBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:01:07 -0400
Received: from mail-sn1nam02on0105.outbound.protection.outlook.com ([104.47.36.105]:27879
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbeIFWBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN8QBZAJorNOa2HC2cwUV+Zy8ub8REgTxefhPio1eK4=;
 b=ZFlDMbGpGLIfgOq3VJdVM5/dhUzb4e5tJQOiHwBzvkrplHV47pbya1rdnw7UdHqTM+n4LxTCo04tq+2H4dc+E7+9URmrv7HFYWlnQNcbkg71nT30pOXMZ67dFMYp1E8g2UFuBCxS9/O25Rr7clS77szl4rfQSfe7DJMkaXhpZgY=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0139.namprd21.prod.outlook.com (10.173.173.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Thu, 6 Sep 2018 17:23:56 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Thu, 6 Sep 2018
 17:23:55 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
CC:     Dave Hansen <dave.hansen@intel.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Topic: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Index: AQHURV1NzbtPIVbq00mlNM0Zm0ByOKTiv36AgACaFICAAAQQAIAAB+YAgAAW1ACAAAWuAA==
Date:   Thu, 6 Sep 2018 17:23:55 +0000
Message-ID: <253d702e-aa68-878d-716b-85002a9d9387@microsoft.com>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
 <20180906054735.GJ14951@dhcp22.suse.cz>
 <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com>
 <20180906151336.GD14951@dhcp22.suse.cz>
 <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
 <20180906170334.GE14951@dhcp22.suse.cz>
In-Reply-To: <20180906170334.GE14951@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0139;6:zDnOnU/rNn3j2MdkFF41vRjNY3dTJ2PK8X9Hj9WxETqVcmOlGH2lCNQ7GY6qJy0gKfTRhcG10DTU7md8v8Jum3pvvyx3vGmRB/VdMwdMAsCJI108ncir0CiG7KBCdOaCYuilZKXnjU9f4XEq6vuXDQl5ZK0d7i9mlXt/WyZFAu7KdwLxyryCKbuCWGXbnI+XOQLI1qcnb+hHMDmMfWJwtiCNrvVHUh8/479nGdE/Assbc19kSDNX4SU7mu2OES7/G6U1DgAk3lXqX/0NFF3Nj6zbtQr8IyqFRJYKv3kobUu9MiclS2+BcAaZMHhksYOJKPuGrDo/p54uAb8U8RuXGqhyUlyyaarB6ZZSy3wNzMdPKG5esf3cIIeXL29K0APpLz880z446s5GNyH/RlBQT8gTRjE14LWMry/4pshwi02ojGlpPWSkByKyZ/n81/kl6RyKHYuaOM+xx0TYGNR0pQ==;5:f0LzSu/pL0QhnymlxTJm/9r82hmAtprT8bQxoh3uUJNS14nTuFhR2hgyvq4kcXlxqOEHHePUupWAmQ6+/4ebpRfpCg/p0E5RI8jpBVQw+74QEXfbRhDFH/LzXmQqW/ekHq80uSj0styga67mYY5CqZwbhC7SDYqADLCfhtotEYc=;7:EcMIQN0V6rwT7f11q5KH75pa6zHFWK9dHjEer4IfumubmE4gNv64udcwcwz9hMZmlwtLaCvnBItWYSghsJxTYZabpcPgLjCZpSjJRzBiak9zEcE9r3ebfqEF26Tgu2WsPKec318Rj+YqxeRWDOjxR0xUBLcfvJnwPDWg0oUuO5DgoZlIW5I5LIT5BA7W3xeRzFt0f4LM4uYHo1Rxlf5Xdm70G0dhky6ltC5QeKoGXqQkQFFd4/Pn45ZJvdDKjWIZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf2298e9-a518-4ea5-71d6-08d6141d8657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0139;
x-ms-traffictypediagnostic: DM5PR21MB0139:
x-microsoft-antispam-prvs: <DM5PR21MB01394B26BEB988154D62FA7F9D010@DM5PR21MB0139.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0139;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(316002)(110136005)(2906002)(6246003)(25786009)(10090500001)(4326008)(6506007)(53546011)(478600001)(10290500003)(97736004)(2900100001)(102836004)(99286004)(54906003)(8936002)(81156014)(81166006)(72206003)(446003)(31696002)(66066001)(53936002)(39060400002)(256004)(5250100002)(22452003)(476003)(486006)(93886005)(86362001)(14444005)(2616005)(11346002)(6436002)(305945005)(76176011)(3846002)(6116002)(6512007)(6346003)(86612001)(8676002)(229853002)(6486002)(7736002)(186003)(105586002)(106356001)(26005)(36756003)(68736007)(31686004)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0139;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: oPxVoNQyvknxlFsMaNKmFbmh6s0hYERej1nQRvk0ic7aqzZ6ChI6mQKFq+PJqLlwFPfa4YaZy7H3Sw/eWypNFLTSAqDA/2idvbu0kjxH3dIPqD+QpIcReSiWXTQuq6UXZZMNIy7WFXF4UP8TktGnpyTo27HrkRux8ZPpq1e5Zd27y+61HYfbB+CXYT1gNdRVfLNVr/rv/sYul4grxV3llhfEe3FO2pYWpK0SAd0e2rVlEKxfMrhHwjzS8wDEckw6wVQZ5WWh4nTuITjqb6Z288dTxxPHhYOgbhOgKnC+w+3/ggirDE1F48WTcL+eH64ZjSDLhGlckhhDsFFSTcFMkI4uaD+r7RRdbE9X7atnCDw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C57372D2399DD40950C1BD0611D1F55@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2298e9-a518-4ea5-71d6-08d6141d8657
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 17:23:55.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNi8xOCAxOjAzIFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IE9uIFRodSAwNi0w
OS0xOCAwODo0MTo1MiwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPj4gT24gVGh1LCBTZXAgNiwg
MjAxOCBhdCA4OjEzIEFNIE1pY2hhbCBIb2NrbyA8bWhvY2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0K
Pj4+DQo+Pj4gT24gVGh1IDA2LTA5LTE4IDA3OjU5OjAzLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+
Pj4gT24gMDkvMDUvMjAxOCAxMDo0NyBQTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPj4+Pj4gd2h5
IGRvIHlvdSBoYXZlIHRvIGtlZXAgREVCVUdfVk0gZW5hYmxlZCBmb3Igd29ya2xvYWRzIHdoZXJl
IHRoZSBib290DQo+Pj4+PiB0aW1lIG1hdHRlcnMgc28gbXVjaCB0aGF0IGZldyBzZWNvbmRzIG1h
dHRlcj8NCj4+Pj4NCj4+Pj4gVGhlcmUgYXJlIGEgbnVtYmVyIG9mIGRpc3RyaWJ1dGlvbnMgdGhh
dCBydW4gd2l0aCBpdCBlbmFibGVkIGluIHRoZQ0KPj4+PiBkZWZhdWx0IGJ1aWxkLiAgRmVkb3Jh
LCBmb3Igb25lLiAgV2UndmUgYmFzaWNhbGx5IGFzc3VtZWQgZm9yIGEgd2hpbGUNCj4+Pj4gdGhh
dCB3ZSBoYXZlIHRvIGxpdmUgd2l0aCBpdCBpbiBwcm9kdWN0aW9uIGVudmlyb25tZW50cy4NCj4+
Pj4NCj4+Pj4gU28sIHdoZXJlIGRvZXMgbGVhdmUgdXM/ICBJIHRoaW5rIHdlIGVpdGhlciBuZWVk
IGEgX2dlbmVyaWNfIGRlYnVnDQo+Pj4+IG9wdGlvbiBsaWtlOg0KPj4+Pg0KPj4+PiAgICAgICBD
T05GSUdfREVCVUdfVk1fU0xPV19BU19IRUNLDQo+Pj4+DQo+Pj4+IHVuZGVyIHdoaWNoIHdlIGNh
biBwdXQgdGhpcyBhbiBvdGhlciByZWFsbHkgc2xvdyBWTSBkZWJ1Z2dpbmcuICBPciwgd2UNCj4+
Pj4gbmVlZCBzb21lIGtpbmQgb2YgYm9vdC10aW1lIHBhcmFtZXRlciB0byB0cmlnZ2VyIHRoZSBl
eHRyYSBjaGVja2luZw0KPj4+PiBpbnN0ZWFkIG9mIGEgbmV3IENPTkZJRyBvcHRpb24uDQo+Pj4N
Cj4+PiBJIHN0cm9uZ2x5IHN1c3BlY3Qgbm9ib2R5IHdpbGwgZXZlciBlbmFibGUgc3VjaCBhIHNj
YXJ5IGxvb2tpbmcgY29uZmlnDQo+Pj4gVEJILiBCZXNpZGVzIEkgYW0gbm90IHN1cmUgd2hhdCBz
aG91bGQgZ28gdW5kZXIgdGhhdCBjb25maWcgb3B0aW9uLg0KPj4+IFNvbWV0aGluZyB0aGF0IHRh
a2VzIGZldyBjeWNsZXMgYnV0IGl0IGlzIGNhbGxlZCBvZnRlbiBvciBvbmUgdGltZSBzdHVmZg0K
Pj4+IHRoYXQgdGFrZXMgcXVpdGUgYSBsb25nIGJ1dCBsZXNzIHRoYW4gYWdncmVnYXRlZCBvdmVy
aGVhZCBvZiB0aGUgZm9ybWVyPw0KPj4+DQo+Pj4gSnVzdCBjb25zaWRlciB0aGlzIHBhcnRpY3Vs
YXIgY2FzZS4gSXQgYmFzaWNhbGx5IHJlLWFkZHMgYW4gb3ZlcmhlYWQNCj4+PiB0aGF0IGhhcyBh
bHdheXMgYmVlbiB0aGVyZSBiZWZvcmUgdGhlIHN0cnVjdCBwYWdlIGluaXQgb3B0aW1pemF0aW9u
DQo+Pj4gd2VudCBpdC4gVGhlIHBvaXNvbmluZyBqdXN0IHJldHVybnMgaXQgaW4gYSBkaWZmZXJl
bnQgZm9ybSB0byBjYXRjaA0KPj4+IHBvdGVudGlhbCBsZWZ0IG92ZXJzLiBBbmQgd2Ugd291bGQg
bGlrZSB0byBoYXZlIGFzIG1hbnkgcGVvcGxlIHdpbGxpbmcNCj4+PiB0byBydW5uaW5nIGluIGRl
YnVnIG1vZGUgdG8gdGVzdCBmb3IgdGhvc2UgcGF0aHMgYmVjYXVzZSB0aGV5IGFyZQ0KPj4+IGJh
c2ljYWxseSBpbXBvc3NpYmxlIHRvIHJldmlldyBieSB0aGUgY29kZSBpbnNwZWN0aW9uLiBNb3Jl
IGltcG9ydGFudG5seQ0KPj4+IHRoZSBtYWpvciBvdmVyaGVhZCBpcyBib290IHRpbWUgc28gbXkg
cXVlc3Rpb24gc3RpbGwgc3RhbmRzLiBJcyB0aGlzDQo+Pj4gd29ydGggYSBzZXBhcmF0ZSBjb25m
aWcgb3B0aW9uIGFsbW9zdCBub2JvZHkgaXMgZ29pbmcgdG8gZW5hYmxlPw0KPj4+DQo+Pj4gRW5h
YmxpbmcgREVCVUdfVk0gYnkgRmVkb3JhIGFuZCBvdGhlcnMgc2VydmVzIHVzIGEgdmVyeSBnb29k
IHRlc3RpbmcNCj4+PiBjb3ZlcmFnZSBhbmQgSSBhcHByZWNpYXRlIHRoYXQgYmVjYXVzZSBpdCBo
YXMgZ2VuZXJhdGVkIHNvbWUgdXNlZnVsIGJ1Zw0KPj4+IHJlcG9ydHMuIFRob3NlIHBlb3BsZSBh
cmUgcGF5aW5nIHF1aXRlIGEgbG90IG9mIG92ZXJoZWFkIGluIHJ1bnRpbWUNCj4+PiB3aGljaCBj
YW4gYWdncmVnYXRlIG92ZXIgdGltZSBpcyBpdCBzbyBtdWNoIHRvIGFzayBhYm91dCBvbmUgdGlt
ZSBib290DQo+Pj4gb3ZlcmhlYWQ/DQo+Pg0KPj4gVGhlIGtpbmQgb2YgYm9vdCB0aW1lIGFkZC1v
biBJIHNhdyBhcyBhIHJlc3VsdCBvZiB0aGlzIHdhcyBhYm91dCAxNzANCj4+IHNlY29uZHMsIG9y
IDIgbWludXRlcyBhbmQgNTAgc2Vjb25kcyBvbiBhIDEyVEIgc3lzdGVtLg0KPiANCj4gSnVzdCBj
dXJpb3VzLiBIb3cgbG9uZyBkb2VzIGl0IHRha2UgdG8gZ2V0IGZyb20gcG93ZXIgb24gdG8gZXZl
biByZWFhY2gNCj4gYm9vdCBsb2FkZXIgb24gdGhhdCBtYWNoaW5lLi4uIDspDQo+IA0KPj4gSSBz
cGVudCBhDQo+PiBjb3VwbGUgbWludXRlcyB3b25kZXJpbmcgaWYgSSBoYWQgYnVpbHQgYSBiYWQg
a2VybmVsIG9yIG5vdCBhcyBJIHdhcw0KPj4gc3RhcmluZyBhdCBhIGRlYWQgY29uc29sZSB0aGUg
ZW50aXJlIHRpbWUgYWZ0ZXIgdGhlIGdydWIgcHJvbXB0IHNpbmNlDQo+PiBJIGhpdCB0aGlzIHNv
IGVhcmx5IGluIHRoZSBib290LiBUaGF0IGlzIHRoZSByZWFzb24gd2h5IEkgYW0gc28gZWFnZXIN
Cj4+IHRvIHNsaWNlIHRoaXMgb2ZmIGFuZCBtYWtlIGl0IHNvbWV0aGluZyBzZXBhcmF0ZS4gSSBj
b3VsZCBlYXNpbHkgc2VlDQo+PiB0aGlzIGFzIHNvbWV0aGluZyB0aGF0IHdvdWxkIGdldCBpbiB0
aGUgd2F5IG9mIG90aGVyIGRlYnVnZ2luZyB0aGF0IGlzDQo+PiBnb2luZyBvbiBpbiBhIHN5c3Rl
bS4NCj4gDQo+IEJ1dCB5b3Ugd291bGQgZ2V0IHRoZSBzYW1lIG92ZXJoZWFkIGEga2VybmVsIHJl
bGVhc2UgYWdvIHdoZW4gdGhlDQo+IG1lbW1hcCBpbml0IG9wdGltaXphdGlvbiB3YXMgbWVyZ2Vk
LiBTbyB5b3UgYXJlIGJhc2ljYWxseSBiYWNrIHRvIHdoYXQNCj4gd2UgdXNlZCB0byBoYXZlIGZv
ciB5ZWFycy4gVW5sZXNzIEkgbWlzcmVtZW1iZXIuDQoNCllvdSByZW1lYmVyIHRoaXMgY29ycmVj
dGx5Og0KDQoyZjQ3YTkxZjRkYWIxOWFhYWEwNWNkY2ZjZWQ5ZGZjYWYzZjUyNTdlIGhhcyBkYXRh
IGJlZm9yZSB2cyBhZnRlcg0KemVyb2luZyBtZW1vcnkgaW4gbWVtYmxvY2sgYWxsb2NhdG9yLg0K
DQpPbiBTUEFSQyB3aXRoIDE1VCB3ZSBzYXZlZCA1NS40cywgYmVjYXVzZSBTUEFSQyBoYXMgbGFy
Z2VyIGJhc2UgcGFnZXMsDQp0aHVzIGZld2VyIHN0cnVjdCBwYWdlcy4NCg0KT24geDg2IHdpdGgg
MVQgc2F2ZWQgMTUuOHM6ICB3aGljaCBpcyAxODkuNnMgaWYgaXQgd2FzIDEyVCBtYWNoaW5lDQpB
bGV4YW5kZXIgaXMgdXNpbmcsIGNsb3NlIHRvIDE3MHMgaGUgaXMgc2VlaW5nLCBidXQgQ1BVIG11
c3QgYmUgZmFzdGVyLg0KDQpQYXZlbA==
