Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510D720871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XsDmV9y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510D720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeKLGau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:30:50 -0500
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:60048
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729849AbeKLGat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCm/TUxAZ4Ix6Ido4C5cGWs6/jzeqqJtcfqekFJybhI=;
 b=XsDmV9y4nUu/0DC4icrvKAMoT3e7YKuU71YtlxQfkZdMxNPWElnLHn07DgcejjpajFeArVdsF9P3LzdZfM8WKQ9tLZrM5cSVr6Z2hLhay3GGhQWUbZ0oOVc6lkbXzcITZL6BVcHe88KRcysoGplSOP1/kmNeTdX98Wnby6wEKu0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4968.namprd05.prod.outlook.com (20.177.229.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.12; Sun, 11 Nov 2018 20:41:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.018; Sun, 11 Nov 2018
 20:41:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Damian Tometzki <linux_dti@icloud.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Thread-Topic: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Thread-Index: AQHUeYjbLsK1w/h4IEOngRVarOSwtaVK8bAAgAAY/oA=
Date:   Sun, 11 Nov 2018 20:41:11 +0000
Message-ID: <EE807A54-7B4B-41B5-8140-2565A7B2D51A@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com> <20181111191141.GA1996@Ubuntu-DTI>
In-Reply-To: <20181111191141.GA1996@Ubuntu-DTI>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4968;20:oL33UZt6iWJr/LcG7YZ7oCdAUTSnQauQIuOctYHtAM/1OX/G551K1FEUmnpTVjDF5YkPMQPrhXvaHipNieecuOhvrzlB90iHZMgn5gSKSeqXLdfU4P6txf+HVa0A0TcJnF09MsUKw5ijLakxc8eFoGHGsft0IivvwzzrIYeGPTk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 812e769a-750a-4f70-8dc2-08d648160480
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4968;
x-ms-traffictypediagnostic: BYAPR05MB4968:
x-microsoft-antispam-prvs: <BYAPR05MB496807C2EC8BCC65A12A5986D0C00@BYAPR05MB4968.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4968;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4968;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(36756003)(25786009)(99286004)(6512007)(305945005)(7736002)(2900100001)(6486002)(6436002)(186003)(7416002)(97736004)(81156014)(39060400002)(54906003)(81166006)(229853002)(33656002)(2906002)(11346002)(446003)(486006)(2616005)(256004)(86362001)(14444005)(476003)(3846002)(26005)(102836004)(6116002)(71200400001)(71190400001)(8936002)(6916009)(83716004)(76176011)(4326008)(53936002)(82746002)(106356001)(6506007)(66066001)(66574009)(105586002)(14454004)(5660300001)(68736007)(53546011)(8676002)(316002)(6246003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4968;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iDbmFHXq+jkxonaIc2btPRiqYOheLvPdjS+fZsjSSOV8M2GeDYhLmBz4saK9Y26F2hV9v7eZU88BsBC6W09Eeqskmk90QJXRUl8svm3azfKAYgvLERC4Un4z10VKdYri72SMM8RKv39okIxOhc8FwrowTJ3ByjtaaVXtUqfn2j97UfXRZ3u7aSS8r9y2H7M0c3PDXYTr/dmUVtnbyon4k6f04lckFBMwf47UbXDmBu/voDCdpi7sOjMZBbIyTt9BET97Ec9SONKD/4t4j8gAcPHAwe8ZPer5HaLAc5UL4Hh9NWFlRYcD0FDPQQ4m43redWY229yAuzxmX97sqG1jowiT3xvY0kAjJVNvuWAyoqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <79E1045839A2304DAE046622E192A113@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812e769a-750a-4f70-8dc2-08d648160480
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 20:41:11.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFtaWFuIFRvbWV0emtpDQpTZW50OiBOb3ZlbWJlciAxMSwgMjAxOCBhdCA3OjExOjQy
IFBNIEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gQ2M6IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPiwgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4s
IHg4NkBrZXJuZWwub3JnPiwgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4sIEFuZHkgTHV0
b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiwgS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5v
cmc+LCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+LCBEYXZlIEhhbnNlbiA8
ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiwgTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVs
Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8xMF0geDg2L2FsdGVybmF0aXZlOiB1
c2UgdGVtcG9yYXJ5IG1tIGZvciB0ZXh0IHBva2luZw0KPiANCj4gDQo+IE9uIFNhLCAxMC4gTm92
IDE1OjE3LCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gdGV4dF9wb2tlKCkgY2FuIHBvdGVudGlhbGx5
IGNvbXByb21pc2UgdGhlIHNlY3VyaXR5IGFzIGl0IHNldHMgdGVtcG9yYXJ5DQo+PiBQVEVzIGlu
IHRoZSBmaXhtYXAuIFRoZXNlIFBURXMgbWlnaHQgYmUgdXNlZCB0byByZXdyaXRlIHRoZSBrZXJu
ZWwgY29kZQ0KPj4gZnJvbSBvdGhlciBjb3JlcyBhY2NpZGVudGFsbHkgb3IgbWFsaWNpb3VzbHks
IGlmIGFuIGF0dGFja2VyIGdhaW5zIHRoZQ0KPj4gYWJpbGl0eSB0byB3cml0ZSBvbnRvIGtlcm5l
bCBtZW1vcnkuDQo+PiANCj4+IE1vcmVvdmVyLCBzaW5jZSByZW1vdGUgVExCcyBhcmUgbm90IGZs
dXNoZWQgYWZ0ZXIgdGhlIHRlbXBvcmFyeSBQVEVzIGFyZQ0KPj4gcmVtb3ZlZCwgdGhlIHRpbWUt
d2luZG93IGluIHdoaWNoIHRoZSBjb2RlIGlzIHdyaXRhYmxlIGlzIG5vdCBsaW1pdGVkIGlmDQo+
PiB0aGUgZml4bWFwIFBURXMgLSBtYWxpY2lvdXNseSBvciBhY2NpZGVudGFsbHkgLSBhcmUgY2Fj
aGVkIGluIHRoZSBUTEIuDQo+PiBUbyBhZGRyZXNzIHRoZXNlIHBvdGVudGlhbCBzZWN1cml0eSBo
YXphcmRzLCB3ZSB1c2UgYSB0ZW1wb3JhcnkgbW0gZm9yDQo+PiBwYXRjaGluZyB0aGUgY29kZS4N
Cj4+IA0KPj4gRmluYWxseSwgdGV4dF9wb2tlKCkgaXMgYWxzbyBub3QgY29uc2VydmF0aXZlIGVu
b3VnaCB3aGVuIG1hcHBpbmcgcGFnZXMsDQo+PiBhcyBpdCBhbHdheXMgdHJpZXMgdG8gbWFwIDIg
cGFnZXMsIGV2ZW4gd2hlbiBhIHNpbmdsZSBvbmUgaXMgc3VmZmljaWVudC4NCj4+IFNvIHRyeSB0
byBiZSBtb3JlIGNvbnNlcnZhdGl2ZSwgYW5kIGRvIG5vdCBtYXAgbW9yZSB0aGFuIG5lZWRlZC4N
Cj4+IA0KPj4gQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPj4gQ2M6IEtl
ZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPj4gQ2M6IFBldGVyIFppamxzdHJhIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50
ZWwuY29tPg0KPj4gQ2M6IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gLS0tDQo+
PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9maXhtYXAuaCB8ICAgMiAtDQo+PiBhcmNoL3g4Ni9rZXJu
ZWwvYWx0ZXJuYXRpdmUuYyB8IDExMiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+PiAyIGZpbGVzIGNoYW5nZWQsIDg5IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0K
Pj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZml4bWFwLmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9maXhtYXAuaA0KPj4gaW5kZXggNTBiYTc0YTM0YTM3Li45ZGE4Y2Nj
ZGYzZmIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9maXhtYXAuaA0KPj4g
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZml4bWFwLmgNCj4+IEBAIC0xMDMsOCArMTAzLDYg
QEAgZW51bSBmaXhlZF9hZGRyZXNzZXMgew0KPj4gI2lmZGVmIENPTkZJR19QQVJBVklSVA0KPj4g
CUZJWF9QQVJBVklSVF9CT09UTUFQLA0KPj4gI2VuZGlmDQo+IA0KPiBIZWxsbyBOYWRhdiwNCj4g
DQo+IHdpdGggdGhlIHJlbW92ZSBvZiBGSVhfVEVYVF9QT0tFMSBhbmQgRklYX1RFWFRfUE9LRTAg
aSBnZXQgdGhlIGZvbGxvd2luZw0KPiBidWlsZCBlcnJvcjoNCj4gDQo+IC9ob21lL2RhbWlhbi9r
ZXJuZWwvbGludXgvYXJjaC94ODYveGVuL21tdV9wdi5jOjIzMjE6NzogRmVobGVyOiDCu0ZJWF9U
RVhUX1BPS0UwwqsgbmljaHQgZGVrbGFyaWVydCAoZXJzdG1hbGlnZSBWZXJ3ZW5kdW5nIGluIGRp
ZXNlciBGdW5rdGlvbik7IG1laW50ZW4gU2llIMK7RklYX1RCT09UX0JBU0XCqz8NCj4gIGNhc2Ug
RklYX1RFWFRfUE9LRTA6DQo+ICAgICAgIF5+fn5+fn5+fn5+fn5+DQo+ICAgICAgIEZJWF9UQk9P
VF9CQVNFDQo+IC9ob21lL2RhbWlhbi9rZXJuZWwvbGludXgvYXJjaC94ODYveGVuL21tdV9wdi5j
OjIzMjE6NzogQW5tZXJrdW5nOiBqZWRlciBuaWNodCBkZWtsYXJpZXJ0ZSBCZXplaWNobmVyIHdp
cmQgbnVyIGVpbm1hbCBmw7xyIGplZGUgRnVua3Rpb24sIGluIGRlciBlciB2b3Jrb21tdCwgZ2Vt
ZWxkZXQNCj4gL2hvbWUvZGFtaWFuL2tlcm5lbC9saW51eC9hcmNoL3g4Ni94ZW4vbW11X3B2LmM6
MjMyMjo3OiBGZWhsZXI6IMK7RklYX1RFWFRfUE9LRTHCqyBuaWNodCBkZWtsYXJpZXJ0IChlcnN0
bWFsaWdlIFZlcndlbmR1bmcgaW4gZGllc2VyIEZ1bmt0aW9uKTsgbWVpbnRlbiBTaWUgwrtGSVhf
VEJPT1RfQkFTRcKrPw0KPiAgY2FzZSBGSVhfVEVYVF9QT0tFMToNCj4gICAgICAgXn5+fn5+fn5+
fn5+fn4NCj4gICAgICAgRklYX1RCT09UX0JBU0UNCg0KVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtu
b3cuIEnigJlsbCBzaW1wbHkgcmVtb3ZlIHRoZW0gaW4gdjUuDQoNClJlZ2FyZHMsDQpOYWRhdg==
