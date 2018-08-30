Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F7020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RLa6A/2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F7020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeH3TsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:13 -0400
Received: from mail-eopbgr720108.outbound.protection.outlook.com ([40.107.72.108]:24800
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeH3TsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWQZhQnfro09Kf+NmZdflZcb9zpyGWUMyGxLq5+pUQA=;
 b=RLa6A/2Kln4D1Gzstk42AHZ43K6sT7Jah0lrsCFL9ZrilIIb90H509QrvSNM2GD0vIJc66D0lRaCuSM1JtP5gEiZyKs31Y2LRGP78EnvWakqpUMQXLpq6n0AQLb4hL1rqY38jKrE5iTdeIRj8ZCRxyjcttUxTe+Z1MCHcIOyo7M=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0826.namprd21.prod.outlook.com (10.173.172.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 15:45:22 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 15:45:22 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Jiri Slaby <jslaby@suse.cz>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
Thread-Topic: [PATCH v1] mm: relax deferred struct page requirements
Thread-Index: AQHUO35THenIpiCqSkCG824R6tGAM6TYZnEAgAATfYA=
Date:   Thu, 30 Aug 2018 15:45:22 +0000
Message-ID: <87516e50-a17c-6c80-e9b5-ba68eda9ce33@microsoft.com>
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
 <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
 <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
 <83d035f1-40b4-bed8-6113-f4c5a0c4d22f@suse.cz>
 <c4d46b63-5237-d002-faf5-4e0749d825d7@suse.cz>
 <7aee9274-9e8e-4a40-a9e5-3c9ef28511b7@microsoft.com>
In-Reply-To: <7aee9274-9e8e-4a40-a9e5-3c9ef28511b7@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0826;6:moiJFU0UEkgshIJitUOL/VLloNdqnaLlGt0n6aajmkpckjz2WEBeGT6J1WoYb2pl+6W2+lHmjAchnhhwipAclEcy6DXJQv6IY5wG3VRXREjeJUvmTP2zotWCEuNi5awouyonstzH2iSsED+FK19xS+FCSeVgghdelx+tdHhd9B2jhB4qD+FmGNvM7IEn1i1kmJHWdtAh0jLakgkZcDkW4dwircLIxYcU0FGlsP2p5ICMJM8fDiCFwXGyz3eDHWOG1zF7aaaEGDIIGzSOfsK/6uX3T24OewZpMPKdSmTN8ncsK4CMXfegumDivDgOrKbT3onyccBq23tS/WUwBwHfVPF+irhuKDWuFXBipt1PwoQqRB/Ft9FrOsc70pBPSAeHg9ZglO1GHHYCPXmIdORDFePTC2RgWnjG2dHDSM59FhFoXDnqHysjGEp9MvWl/9mFPWj6t6X8I9ZmZbLPfcF21A==;5:oWCrBFxm+iCnXx0Q4y47vC8EPvbGEi7+tpjmFT2/PctAkSJqTRqMYMHaISGj++GiRdG4Eg/zTKaexejbwElxtX1WC+PyHrxY570yfb1jHnLVqmrCzcZrhO5aEV/lkKS6ykyCX1EL5klQlO4TO4zdp+bqyOJzU0ktg26PUMO9900=;7:UVzrT4chlQbZBDJl0JCMJ+SgFIb7xb+VTYW4ygI2unja/Ts7Dd38h7e/g2TdxlSc7UlMHN1HVU9MFdpfIBQWx/t8mbu87mGa78IO/LrwPvYtVYoASt01lmwAqz34P7YLOnag2YDoyJ1JmaoJ2DMVflL37v8r//5e/NI0odzMoRMkddp9w/YVtSt9LB+lr+n0bRGfwnEDggS5GZhxOvS3+6AUy70lUvjJcXBcZ9OO+UURbbE9enMVaDKndQhSDLKW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f243061d-2c69-4aa3-01c5-08d60e8f98c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0826;
x-ms-traffictypediagnostic: DM5PR21MB0826:
x-microsoft-antispam-prvs: <DM5PR21MB0826787E08A45F385DD64FB79D080@DM5PR21MB0826.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(211171220733660)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0826;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0826;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(68736007)(3846002)(6116002)(7416002)(6486002)(86612001)(5024004)(31696002)(99286004)(36756003)(305945005)(7736002)(14444005)(229853002)(72206003)(86362001)(446003)(478600001)(54906003)(6916009)(26005)(186003)(6346003)(486006)(2616005)(10290500003)(11346002)(476003)(345774005)(2906002)(8936002)(53546011)(6506007)(102836004)(25786009)(81166006)(81156014)(93886005)(53936002)(76176011)(97736004)(6512007)(14454004)(31686004)(8676002)(66066001)(6246003)(5250100002)(4326008)(106356001)(2900100001)(105586002)(5660300001)(316002)(22452003)(6436002)(256004)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0826;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: L7fCMP7YUbCv3T5ZByDAdwD9ovn5VZnU/NUVwuLj/ntSACvVFzK7qjrIX9u7zbf1AiUkN1fHIPHIUpFeq6Xbwe/HnASL92gKurwBNq7mUpklIq6lloXNlVKrNaRd5nR9Mp7ptfAkNTkZI0mdB1J40T9fnDVfasWBXCNtKpjODZeCRLwRo4STWbDyaZ80iC0GinMz6FzgGDElS1bW1ipvi8VSwaXUvKmci1CY3SKu2Kf/+uXJkAsnR0xoRpajMhfyYLQpKgZjVZ/NZ+ODSyl/VCNwW6BO3agwRxfnpOj0TQWrUsZ8jkwbpPKwAnKLQdfO641d6md1C8VLFnOvbv1JzpLStOPyL3M6t1a1oywwmTE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9951558AA4DCA24C902267BF4B6EC0D8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f243061d-2c69-4aa3-01c5-08d60e8f98c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 15:45:22.4563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlyaSwNCg0KSSBiZWxpZXZlIHRoaXMgYnVnIGlzIGZpeGVkIHdpdGggdGhpcyBjaGFuZ2U6
DQoNCmQzOWY4ZmI0Yjc3NzZkY2IwOWVjM2JmN2EzMjE1NDcwODMwNzhlZTMNCm1tOiBtYWtlIERF
RkVSUkVEX1NUUlVDVF9QQUdFX0lOSVQgZXhwbGljaXRseSBkZXBlbmQgb24gU1BBUlNFTUVNDQoN
CkkgYW0gbm90IGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgcHJvYmxlbSBvbiB4ODYtMzIuDQoNClBh
dmVsDQoNCk9uIDgvMzAvMTggMTA6MzUgQU0sIFBhdmVsIFRhdGFzaGluIHdyb3RlOg0KPiBUaGFu
ayB5b3UgSmlyaSwgSSBhbSBzdHVkeWluZyBpdC4NCj4gDQo+IFBhdmVsDQo+IA0KPiBPbiA4LzI0
LzE4IDM6NDQgQU0sIEppcmkgU2xhYnkgd3JvdGU6DQo+PiBwYXNoYS50YXRhc2hpbkBvcmFjbGUu
Y29tIC0+IHBhdmVsLnRhdGFzaGluQG1pY3Jvc29mdC5jb20NCj4+DQo+PiBkdWUgdG8NCj4+ICA1
NTAgNS4xLjEgVW5rbm93biByZWNpcGllbnQgYWRkcmVzcy4NCj4+DQo+Pg0KPj4gT24gMDgvMjQv
MjAxOCwgMDk6MzIgQU0sIEppcmkgU2xhYnkgd3JvdGU6DQo+Pj4gT24gMDYvMTkvMjAxOCwgMDk6
NTYgUE0sIFBhdmVsIFRhdGFzaGluIHdyb3RlOg0KPj4+PiBPbiBUdWUsIEp1biAxOSwgMjAxOCBh
dCA5OjUwIEFNIFBhdmVsIFRhdGFzaGluDQo+Pj4+IDxwYXNoYS50YXRhc2hpbkBvcmFjbGUuY29t
PiB3cm90ZToNCj4+Pj4+DQo+Pj4+PiBPbiBTYXQsIEp1biAxNiwgMjAxOCBhdCA0OjA0IEFNIEpp
cmkgU2xhYnkgPGpzbGFieUBzdXNlLmN6PiB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IE9uIDExLzIx
LzIwMTcsIDA4OjI0IEFNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+Pj4+Pj4+IE9uIFRodSAxNi0x
MS0xNyAyMDo0NjowMSwgUGF2ZWwgVGF0YXNoaW4gd3JvdGU6DQo+Pj4+Pj4+PiBUaGVyZSBpcyBu
byBuZWVkIHRvIGhhdmUgQVJDSF9TVVBQT1JUU19ERUZFUlJFRF9TVFJVQ1RfUEFHRV9JTklULA0K
Pj4+Pj4+Pj4gYXMgYWxsIHRoZSBwYWdlIGluaXRpYWxpemF0aW9uIGNvZGUgaXMgaW4gY29tbW9u
IGNvZGUuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQWxzbywgdGhlcmUgaXMgbm8gbmVlZCB0byBkZXBl
bmQgb24gTUVNT1JZX0hPVFBMVUcsIGFzIGluaXRpYWxpemF0aW9uIGNvZGUNCj4+Pj4+Pj4+IGRv
ZXMgbm90IHJlYWxseSB1c2UgaG90cGx1ZyBtZW1vcnkgZnVuY3Rpb25hbGl0eS4gU28sIHdlIGNh
biByZW1vdmUgdGhpcw0KPj4+Pj4+Pj4gcmVxdWlyZW1lbnQgYXMgd2VsbC4NCj4+Pj4+Pj4+DQo+
Pj4+Pj4+PiBUaGlzIHBhdGNoIGFsbG93cyB0byB1c2UgZGVmZXJyZWQgc3RydWN0IHBhZ2UgaW5p
dGlhbGl6YXRpb24gb24gYWxsDQo+Pj4+Pj4+PiBwbGF0Zm9ybXMgd2l0aCBtZW1ibG9jayBhbGxv
Y2F0b3IuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gVGVzdGVkIG9uIHg4NiwgYXJtNjQsIGFuZCBzcGFy
Yy4gQWxzbywgdmVyaWZpZWQgdGhhdCBjb2RlIGNvbXBpbGVzIG9uDQo+Pj4+Pj4+PiBQUEMgd2l0
aCBDT05GSUdfTUVNT1JZX0hPVFBMVUcgZGlzYWJsZWQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZXJl
IGlzIHNsaWdodCByaXNrIHRoYXQgd2Ugd2lsbCBlbmNvdW50ZXIgY29ybmVyIGNhc2VzIG9uIHNv
bWUNCj4+Pj4+Pj4gYXJjaGl0ZWN0dXJlcyB3aXRoIHdlaXJkIG1lbW9yeSBsYXlvdXQvdG9wb2xv
Z3kNCj4+Pj4+Pg0KPj4+Pj4+IFdoaWNoIHg4Nl8zMi1wYWUgc2VlbXMgdG8gYmUuIE1hbnkgYmFk
IHBhZ2Ugc3RhdGUgZXJyb3JzIGFyZSBlbWl0dGVkDQo+Pj4+Pj4gZHVyaW5nIGJvb3Qgd2hlbiB0
aGlzIHBhdGNoIGlzIGFwcGxpZWQ6DQo+Pj4+Pg0KPj4+Pj4gSGkgSmlyaSwNCj4+Pj4+DQo+Pj4+
PiBUaGFuayB5b3UgZm9yIHJlcG9ydGluZyB0aGlzIGJ1Zy4NCj4+Pj4+DQo+Pj4+PiBCZWNhdXNl
IDMyLWJpdCBzeXN0ZW1zIGFyZSBsaW1pdGVkIGluIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBwaHlz
aWNhbA0KPj4+Pj4gbWVtb3J5LCB0aGV5IGRvbid0IG5lZWQgZGVmZXJyZWQgc3RydWN0IHBhZ2Vz
LiBTbywgd2UgY2FuIGFkZCBkZXBlbmRzDQo+Pj4+PiBvbiA2NEJJVCB0byBERUZFUlJFRF9TVFJV
Q1RfUEFHRV9JTklUIGluIG1tL0tjb25maWcuDQo+Pj4+Pg0KPj4+Pj4gSG93ZXZlciwgYmVmb3Jl
IHdlIGRvIHRoaXMsIEkgd2FudCB0byB0cnkgcmVwcm9kdWNpbmcgdGhpcyBwcm9ibGVtIGFuZA0K
Pj4+Pj4gcm9vdCBjYXVzZSBpdCwgYXMgaXQgbWlnaHQgZXhwb3NlIGEgZ2VuZXJhbCBwcm9ibGVt
IHRoYXQgaXMgbm90IDMyLWJpdA0KPj4+Pj4gc3BlY2lmaWMuDQo+Pj4+DQo+Pj4+IEhpIEppcmks
DQo+Pj4+DQo+Pj4+IENvdWxkIHlvdSBwbGVhc2UgYXR0YWNoIHlvdXIgY29uZmlnIGFuZCBmdWxs
IHFlbXUgYXJndW1lbnRzIHRoYXQgeW91DQo+Pj4+IHVzZWQgdG8gcmVwcm9kdWNlIHRoaXMgYnVn
Lg0KPj4+DQo+Pj4gSGksDQo+Pj4NCj4+PiBJIHNlZW0gSSBuZXZlciByZXBsaWVkLiBBdHRhY2hp
bmcgLmNvbmZpZyBhbmQgdGhlIHFlbXUgY21kbGluZToNCj4+PiAkIHFlbXUta3ZtIC1tIDIwMDAg
LWhkYSAvZGV2L251bGwgLWtlcm5lbCBiekltYWdlDQo+Pj4NCj4+PiAiLW0gMjAwMCIgaXMgaW1w
b3J0YW50IHRvIHJlcHJvZHVjZS4NCj4+Pg0KPj4+IElmIEkgZGlzYWJsZSBDT05GSUdfREVGRVJS
RURfU1RSVUNUX1BBR0VfSU5JVCAod2hpY2ggdGhlIHBhdGNoIGFsbG93ZWQNCj4+PiB0byBlbmFi
bGUpLCB0aGUgZXJyb3IgZ29lcyBhd2F5LCBvZiBjb3Vyc2UuDQo+Pj4NCj4+PiB0aGFua3MsDQo+
Pj4NCj4+DQo+Pg==
