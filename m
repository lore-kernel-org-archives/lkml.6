Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F5CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0C720881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BMnzU77M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0C720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeIJUVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:21:37 -0400
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:46400
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727856AbeIJUVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNwKZjtj3denxtgjkZxOGwE8Mo48meZIxqJNj5BNQnE=;
 b=BMnzU77MIfyTDFb4Kk6gvocUlmwDTqSxMQirbiDbZn7i9A5wXqWyasBPmIXwNSVXm9A7Ixc63X60F472wwKmhnqgnuPuSE3V2OFFyAH+EzEdk/5mkujDKbyb5oNt9fbm7ly33RHaJR32HSsO+qOlpxgs1kFNxtAoG9dwu+C7MXY=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0700.namprd21.prod.outlook.com (10.175.112.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Mon, 10 Sep 2018 15:26:55 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Mon, 10 Sep 2018
 15:26:55 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Topic: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Thread-Index: AQHUSQLFF/mQjCkfKkuMMO7HZfKu+6Tpf1cAgAAIDwCAAAOzgIAAAx4AgAACaQCAAANSgIAAAtsAgAAMlQA=
Date:   Mon, 10 Sep 2018 15:26:55 +0000
Message-ID: <abf84f61-82f3-e3d5-2e6e-82a11cb5dcf5@microsoft.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
 <20180910135959.GI10951@dhcp22.suse.cz>
 <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
 <20180910141946.GJ10951@dhcp22.suse.cz>
 <CAGM2reZ5OD9SRW8j9iaQAk9jpr86pF2NqpBjv-dxH+1vJZs0=g@mail.gmail.com>
 <20180910144152.GL10951@dhcp22.suse.cz>
In-Reply-To: <20180910144152.GL10951@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0700;6:iwCEi4pRhWY6zQ2VAiem3YRj0VQREN5E/FnN2PAjwIHV8LPmWwwBP/a7mV9YtP55/t7FfRXXl0e7hdkTl3+2C1YIq4r3tU2cWqflOVkS1dDHyfADFsHaXjHHSkaMhRE9TTyW6f8PYM2gSARGi+d49CpyKiJUn2Q41ZGJDJDutj/ELNQ+mm2XvTfciane9eyRZbDmGqIPn18zM+IJzJynFGZDpJ9xv68ULTWdQ43JCHM6kOxdsiDFT7eGeqynkNIL0Cyn9lcBh264So3t82k34HwIOsyXX0kasfOC6+qhSLmBweBjoMxcHLSeKUmlYlDKrC42NIxCkNf4ZDfoF6W/cdJS/duQAdpDHJ+W5Vp8h+koX04+HQjTNJ+0BfAdaJMc+9hQVa41rj5G8gqtwE+9/8QQVU3AD3qQLtjLpirgTd06hmvhEIJUeJQHkWAIPerJsMH9p0KiX89iZtu8adeeag==;5:NTb4N8H4FiboDgPmiTrH7sssDenY4VUQ4U4l5ocZWdM1Y4dB76Zg33yNqRP8t6FXH9vGxU5NXQz4ZBevNMSmb9AfwWi9WK1v+rM9hQIm0EW6M1tfilSK7UL/yx2lPPjyi4BQqTqtpMyKivsrX5lAVmwWWLT29iDQLFgbSKo1/TA=;7:f6oPXioUfhOrf1M/60a82bHoToIuuYxLZ+iXqtTN/AKxs9tStjpM8ZwSuXXbn90HQ36+HAJsChgPF8NAA4RqcnBZl1bNrsFacN6GP2CGSwBgEOooKLSpl1B2LSdpgSxvYPKz6Y3bU4zyt8xn0qCfydCTE1cYLqQOMknwmoZGvFi0U2I/XoL2fjiAfwc8yqlHMMiZY/tvseG6nviI67QbJ9gpEB40RRXu5flkIlaWSCUdojdfa0Bo+vWUj7NklEtO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a412446a-3a05-42ec-cc58-08d61731d747
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0700;
x-ms-traffictypediagnostic: DM5PR21MB0700:
x-microsoft-antispam-prvs: <DM5PR21MB0700BE2AAC7D38231D42BC019D050@DM5PR21MB0700.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991033);SRVR:DM5PR21MB0700;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0700;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(396003)(39860400002)(52314003)(199004)(189003)(6512007)(106356001)(2900100001)(6116002)(3846002)(97736004)(6486002)(6916009)(229853002)(6436002)(486006)(446003)(11346002)(6246003)(4326008)(476003)(2616005)(256004)(105586002)(25786009)(14444005)(53936002)(76176011)(66066001)(2906002)(68736007)(8676002)(478600001)(316002)(93886005)(86362001)(7736002)(22452003)(305945005)(99286004)(86612001)(102836004)(72206003)(36756003)(26005)(54906003)(6346003)(5660300001)(186003)(6506007)(81156014)(81166006)(10290500003)(10090500001)(14454004)(5250100002)(31686004)(53546011)(8936002)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0700;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: asP5btew9prv5mlp2BhAcFLEBTIXPn4bpH8rl1t8H3zpbdc3iSY3FjfrT2cI40NKnkm94dDG6FFuNFOn28l076E5geeiUEtgQdVBKSIJnlr9I1/C1NjgUSAchzYt05yrY3nSiYLgqj/F0q4OjZS7VL9vlbCacCHofrAHEh8EUmLvEI0Kf/tI1VbwbCBx0UUrx7abeRitk3NhE5v8aHChGIbPpaIw5aJKJ9VU24l54rE9evlRD8DRyjd/wGL3fIAC2dA3fZFcMxPHk6sTZzzyp9k4zxpnM8tuyrUYhXakq8IdKjgr9gCxlwCaC96FOr+8T6cyCfNNot27V4NxgSJSMXTzbBmckwG7vXVRtnLCTsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C67F38B6F25441968EDEFB545BCD62@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a412446a-3a05-42ec-cc58-08d61731d747
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 15:26:55.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTAvMTggMTA6NDEgQU0sIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gT24gTW9uIDEw
LTA5LTE4IDE0OjMyOjE2LCBQYXZlbCBUYXRhc2hpbiB3cm90ZToNCj4+IE9uIE1vbiwgU2VwIDEw
LCAyMDE4IGF0IDEwOjE5IEFNIE1pY2hhbCBIb2NrbyA8bWhvY2tvQGtlcm5lbC5vcmc+IHdyb3Rl
Og0KPj4+DQo+Pj4gT24gTW9uIDEwLTA5LTE4IDE0OjExOjQ1LCBQYXZlbCBUYXRhc2hpbiB3cm90
ZToNCj4+Pj4gSGkgTWljaGFsLA0KPj4+Pg0KPj4+PiBJdCBpcyB0cmlja3ksIGJ1dCBwcm9iYWJs
eSBjYW4gYmUgZG9uZS4gRWl0aGVyIGNoYW5nZQ0KPj4+PiBtZW1tYXBfaW5pdF96b25lKCkgb3Ig
aXRzIGNhbGxlciB0byBhbHNvIGNvdmVyIHRoZSBlbmRzIGFuZCBzdGFydHMgb2YNCj4+Pj4gdW5h
bGlnbmVkIHNlY3Rpb25zIHRvIGluaXRpYWxpemUgYW5kIHJlc2VydmUgcGFnZXMuDQo+Pj4+DQo+
Pj4+IFRoZSBzYW1lIHRoaW5nIHdvdWxkIGFsc28gbmVlZCB0byBiZSBkb25lIGluIGRlZmVycmVk
X2luaXRfbWVtbWFwKCkgdG8NCj4+Pj4gY292ZXIgdGhlIGRlZmVycmVkIGluaXQgY2FzZS4NCj4+
Pg0KPj4+IFdlbGwsIEkgYW0gbm90IHN1cmUgVEJILiBJIGhhdmUgdG8gdGhpbmsgYWJvdXQgdGhh
dCBtdWNoIG1vcmUuIE1heWJlIGl0DQo+Pj4gd291bGQgYmUgbXVjaCBtb3JlIHNpbXBsZSB0byBt
YWtlIHN1cmUgdGhhdCB3ZSB3aWxsIG5ldmVyIGFkZCBpbmNvbXBsZXRlDQo+Pj4gbWVtYmxvY2tz
IGFuZCBzaW1wbHkgcmVmdXNlIHRoZW0gZHVyaW5nIHRoZSBkaXNjb3ZlcnkuIEF0IGxlYXN0IGZv
ciBub3cuDQo+Pg0KPj4gT24geDg2IG1lbWJsb2NrcyBjYW4gYmUgdXB0byAyRyBvbiBtYWNoaW5l
cyB3aXRoIG92ZXIgNjRHIG9mIFJBTS4NCj4gDQo+IHNvcnJ5IEkgbWVhbnQgcGFnZWJsb2NrX25y
X3BhZ2VzIHJhdGhlciB0aGFuIG1lbWJsb2Nrcy4NCg0KT0suIFRoaXMgc291bmQgcmVhc29uYWJs
ZSwgYnV0LCB0byBiZSBob25lc3QgSSBhbSBub3Qgc3VyZSBob3cgdG8NCmFjaGlldmUgdGhpcyB5
ZXQsIEkgbmVlZCB0byB0aGluayBtb3JlIGFib3V0IHRoaXMuIEluIHRoZW9yeSwgaWYgd2UgaGF2
ZQ0Kc3BhcnNlIG1lbW9yeSBtb2RlbCwgaXQgbWFrZXMgc2Vuc2UgdG8gZW5mb3JjZSBtZW1vcnkg
YWxpZ25tZW50IHRvDQpzZWN0aW9uIHNpemVzLCBzb3VuZHMgYSBsb3Qgc2FmZXIuDQoNCj4gDQo+
PiBBbHNvLCBtZW1vcnkgc2l6ZSBpcyB3YXkgdG8gZWFzeSB0b28gY2hhbmdlIHZpYSBxZW11IGFy
Z3VtZW50cyB3aGVuIFZNDQo+PiBzdGFydHMuIElmIHdlIHNpbXBseSBkaXNhYmxlIHVuYWxpZ25l
ZCB0cmFpbGluZyBtZW1ibG9ja3MsIEkgYW0gc3VyZQ0KPj4gd2Ugd291bGQgZ2V0IHRvbnMgb2Yg
bm9pc2Ugb2YgbWlzc2luZyBtZW1vcnkuDQo+Pg0KPj4gSSB0aGluaywgYWRkaW5nIGNoZWNrX2hv
dHBsdWdfbWVtb3J5X3JhbmdlKCkgd291bGQgd29yayB0byBmaXggdGhlDQo+PiBpbW1lZGlhdGUg
cHJvYmxlbS4gQnV0LCB3ZSBkbyBuZWVkIHRvIGZpZ3VyZSBvdXQgIGEgYmV0dGVyIHNvbHV0aW9u
Lg0KPj4NCj4+IG1lbWJsb2NrIGRlc2lnbiBpcyBiYXNlZCBvbiBhcmNoYWljIGFzc3VtcHRpb24g
dGhhdCBob3RwbHVnIHVuaXRzIGFyZQ0KPj4gcGh5c2ljYWwgZGltbXMuIFZNcyBhbmQgaHlwZXJ2
aXNvcnMgY2hhbmdlZCBhbGwgb2YgdGhhdCwgYW5kIHdlIGNhbg0KPj4gaGF2ZSBtdWNoIGZpbmVy
IGhvdHBsdWcgcmVxdWVzdHMgb24gbWFjaGluZXMgd2l0aCBodWdlIERJTU1zLiBZZXQsIHdlDQo+
PiBkbyBub3Qgd2FudCB0byBwb2xsdXRlIHN5c2ZzIHdpdGggbWlsbGlvbnMgb2YgdGlueSBtZW1v
cnkgZGV2aWNlcy4gSQ0KPj4gYW0gbm90IHN1cmUgd2hhdCBhIGxvbmcgdGVybSBwcm9wZXIgc29s
dXRpb24gZm9yIHRoaXMgcHJvYmxlbSBzaG91bGQNCj4+IGJlLCBidXQgSSBzZWUgdGhhdCBsaW51
eCBob3RwbHVnL2hvdHJlbW92ZSBzdWJzeXN0ZW1zIG11c3QgYmUNCj4+IHJlZGVzaWduZWQgYmFz
ZWQgb24gdGhlIG5ldyByZXF1aXJlbWVudHMuDQo+IA0KPiBOb3QgYW4gZWFzeSB0YXNrIHRob3Vn
aC4gQW55d2F5LCBzcGFyc2UgbWVtb3J5IG1vZGVseSBpcyBoaWdobHkgYmFzZWQgb24NCj4gbWVt
b3J5IHNlY3Rpb25zIHNvIGl0IG1ha2VzIHNvbWUgc2Vuc2UgdG8gaGF2ZSBob3RwbHVnIHNlY3Rp
b24gYmFzZWQgYXMNCj4gd2VsbC4gTWVtYmxvY2tzIGFzIGEgaGlnaGVyIGxvZ2ljYWwgdW5pdCBv
biB0b3Agb2YgdGhhdCBpcyBraW5kYSBoYWNrLg0KPiBUaGUgdXNlcnNwYWNlIEFQSSBoYXMgbmV2
ZXIgYmVlbiBwcm9wZXJseSB0aG91Z2h0IHRocm91Z2ggSSBhbSBhZnJhaWQuDQoNCkkgYWdyZWUg
bWVtb3J5YmxvY2sgaXMgYSBoYWNrLCBpdCBmYWlscyB0byBkbyBib3RoIHRoaW5ncyBpdCB3YXMN
CmRlc2lnbmVkIHRvIGRvOg0KDQoxLiBPbiBiYXJlIG1ldGFsIHlvdSBjYW5ub3QgZnJlZSBhIHBo
eXNpY2FsIGRpbW0gb2YgbWVtb3J5IHVzaW5nDQptZW1vcnlibG9jayBncmFudWxhcml0eSBiZWNh
dXNlIG1lbW9yeSBkZXZpY2VzIGRvIG5vdCBlcXVhbCB0byBwaHlzaWNhbA0KZGltbXMuIFRodXMs
IGlmIGZvciBzb21lIHJlYXNvbiBhIHBhcnRpY3VsYXIgZGltbSBtdXN0IGJlDQpyZW1vdmUvcmVw
bGFjZWQsIG1lbW9yeWJsb2NrIGRvZXMgbm90IGhlbHAgdXMuDQoNCjIuIE9uIG1hY2hpbmVzIHdp
dGggaHlwZXJ2aXNvcnMgaXQgZmFpbHMgdG8gcHJvdmlkZSBhbiBhZGVxdWF0ZQ0KZ3JhbnVsYXJp
dHkgdG8gYWRkL3JlbW92ZSBtZW1vcnkuDQoNCldlIHNob3VsZCBkZWZpbmUgYSBuZXcgdXNlciBp
bnRlcmZhY2Ugd2hlcmUgbWVtb3J5IGNhbiBiZSBhZGRlZC9yZW1vdmVkDQphdCBhIGZpbmVyIGdy
YW51bGFyaXR5OiBzcGFyc2Ugc2VjdGlvbiBzaXplLCBidXQgd2l0aG91dCBhIG1lbW9yeQ0KZGV2
aWNlcyBmb3IgZWFjaCBzZWN0aW9uLiBXZSBzaG91bGQgYWxzbyBwcm92aWRlIGFuIG9wdGlvbmFs
IGFjY2VzcyB0bw0KbGVnYWN5IGludGVyZmFjZSB3aGVyZSBtZW1vcnkgZGV2aWNlcyBhcmUgZXhw
b3J0ZWQgYnV0IGVhY2ggaXMgb2YNCnNlY3Rpb24gc2l6ZS4NCg0KU28sIHdoZW4gbGVnYWN5IGlu
dGVyZmFjZSBpcyBlbmFibGVkLCBjdXJyZW50IHdheSB3b3VsZCB3b3JrOg0KDQplY2hvIG9mZmxp
bmUgPiAvc3lzL2RldmljZXMvc3lzdGVtL21lbW9yeS9tZW1vcnlYWFgvc3RhdGUNCg0KQW5kIG5l
dyBpbnRlcmZhY2Ugd291bGQgYWxsb3cgdXMgdG8gZG8gc29tZXRoaW5nIGxpa2UgdGhpczoNCg0K
ZWNobyBvZmZsaW5lIDI1Nk0gPiAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZVhYWC9tZW1v
cnkNCg0KV2l0aCBvcHRpb25hbCBzdGFydCBhZGRyZXNzIGZvciBvZmZsaW5lIG1lbW9yeS4NCmVj
aG8gb2ZmbGluZSBbc3RhcnRfcGFdIHNpemUgPiAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9k
ZVhYWC9tZW1vcnkNCnN0YXJ0X3BhIGFuZCBzaXplIG11c3QgYmUgc2VjdGlvbiBzaXplIGFsaWdu
ZWQgKDEyOE0pLg0KDQpJdCB3b3VsZCBwcm9iYWJseSBiZSBhIGdvb2QgZGlzY3Vzc2lvbiBmb3Ig
dGhlIG5leHQgTU0gU3VtbWl0IGhvdyB0bw0Kc29sdmUgdGhlIGN1cnJlbnQgbWVtb3J5IGhvdHBs
dWcgaW50ZXJmYWNlIGxpbWl0YXRpb25zLg0KDQpQYXZlbA==
