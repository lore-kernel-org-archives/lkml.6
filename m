Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E4320898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PFXUw/lY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bZjGgKl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E4320898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeH1G0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:26:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39672 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbeH1G0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:26:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S2WIls018959;
        Mon, 27 Aug 2018 19:36:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=prpg0MVM3hzvDk8VAllO1dzQrfZcSlN7W8aP4ejDKbA=;
 b=PFXUw/lYC2U4Y5k1b7L3LQFNSiCDUg6N7dXKgsZP3/PQnUiomCmFGYBGXm8ZXKw/qRSA
 +a4SIivVE0SzKT0/jQJIBNKPgtL7Y05kcORp4YSG0oQiNfsJpwvW6HjkwCohcW4KJO2F
 r+XztFVd0mGlIxnH8hRDvegbrBKDreP63/o= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m4wnjg0c8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 Aug 2018 19:36:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 27 Aug 2018 19:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpg0MVM3hzvDk8VAllO1dzQrfZcSlN7W8aP4ejDKbA=;
 b=bZjGgKl7+3IcFBKY+98rYBAcryK35dztu/mS73qiTg5s0Hf/ICmOcVLZNXb/MjYQEt/hqJ71FM9y0fJ0ziWYDQR/sXDSa26iyUojVvwv+47XNH1xWUoOvZbEYEbvgkV2KAm/H0KLLqPDiHEnV3/RncvqttpVSmx+rL61Mj0CNqE=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB1964.namprd15.prod.outlook.com (52.132.149.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 02:36:30 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::b536:a6c1:58cf:dfa3]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::b536:a6c1:58cf:dfa3%3]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 02:36:30 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Adam Borowski <kilobyte@angband.pl>
CC:     Andi Kleen <ak@linux.intel.com>,
        =?utf-8?B?UmVuw6kgUmViZQ==?= <rene@exactcode.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, "Chris Mason" <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Topic: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Index: AQHTwX4w5Tc/5RmZHUq3duJllyvimaSH2sIAgABGewCAPObhgIAACrOAgAARzQCAABe+AIAADJaAgBAj6oA=
Date:   Tue, 28 Aug 2018 02:36:30 +0000
Message-ID: <8117EBED-C57E-40AA-8E29-F4DFAB97E059@fb.com>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
 <20180817175746.d2brxipp7xa4y2uw@angband.pl>
 <20180817192244.GF12066@tassilo.jf.intel.com>
 <20180817200747.bzmsl5nfwewyksvg@angband.pl>
In-Reply-To: <20180817200747.bzmsl5nfwewyksvg@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:c63]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR1501MB1964;20:mUCiYLrtMS/VhJ49FabFiahmxetgh22oSuzm3a2tj+H6wXpZ8DDh4SndtMw7sk/GwsZsQ1EoyHcumz3Ag4FZqyS7A27IeRPLi1QseBvfY4YSFV78+VcJSWi1qkpizaNdWEKgD1OrwLCmz/OEFmTHPUMuylYmpSMJ06K04vDS8vw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e75d8dcf-8f1d-4732-dc76-08d60c8f100d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MW2PR1501MB1964;
x-ms-traffictypediagnostic: MW2PR1501MB1964:
x-microsoft-antispam-prvs: <MW2PR1501MB19644740638BE92613FFA661AB0A0@MW2PR1501MB1964.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:MW2PR1501MB1964;BCL:0;PCL:0;RULEID:;SRVR:MW2PR1501MB1964;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(2616005)(6246003)(476003)(99286004)(6506007)(11346002)(25786009)(446003)(256004)(81156014)(81166006)(6436002)(14444005)(6916009)(229853002)(54906003)(14454004)(102836004)(6486002)(316002)(478600001)(5660300001)(46003)(53546011)(186003)(86362001)(76176011)(486006)(4326008)(82746002)(2906002)(5250100002)(6116002)(33656002)(305945005)(68736007)(2900100001)(93886005)(8676002)(83716003)(7736002)(217873002)(105586002)(36756003)(8936002)(106356001)(6512007)(97736004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB1964;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Dwf76iNIrSL47ukzqVlX8xe2xVKkcfVsglL5tr21UzkizTA18CnndUU1ANHOUv6KPmWCR5QLBJWm93QiyEKGpFwSARD2ylEzXx4Mp/D4/ZFJj6ydYHnQxY2RFVVkiGCEuveKTZYagsfKqwSgZdKLLAJ3pr4Cn5y5UtyXFd/4r8Z8VINdM+kPoH913TS+HPq0xlZTMLE4e0YB26MxB+X2jR1vNK/S2zIN+uVl43Xf/ApseELEgXQeUnNZ3qr9WB3MubbvENHdD/Vq+tUfSsi/sK5bkethTvzZtCJk7ePj/8tnh1HVXGLa+ZSVM4nTFlkTrMrLn+mTQqxMv2yZGG2VB4NESJ+Qs4BsEEImWk9NTZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6302651802CAB541B947048BBB8FC6E8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e75d8dcf-8f1d-4732-dc76-08d60c8f100d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 02:36:30.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB1964
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE3LCAyMDE4LCBhdCAxOjA3IFBNLCBBZGFtIEJvcm93c2tpIDxraWxvYnl0ZUBhbmdi
YW5kLnBsPiB3cm90ZToNCj4gT24gRnJpLCBBdWcgMTcsIDIwMTggYXQgMTI6MjI6NDRQTSAtMDcw
MCwgQW5kaSBLbGVlbiB3cm90ZToNCj4+IE9uIEZyaSwgQXVnIDE3LCAyMDE4IGF0IDA3OjU3OjQ2
UE0gKzAyMDAsIEFkYW0gQm9yb3dza2kgd3JvdGU6DQo+Pj4+IFRoZSAiZmF2b3VyaXRlIGNvbXBy
ZXNzb3IiIHNlZW1zIHRvIHJvdWdobHkgY2hhbmdlIGV2ZXJ5IHllYXIsIHNvIGlmDQo+Pj4+IHdl
IGtlZXAgYWRkaW5nIG5ldyBvbmVzIHRoaW5ncyB3aWxsIGdldCBtb3JlIGFuZCBtb3JlIGNvbnZv
bHV0ZWQuDQo+Pj4gDQo+Pj4gVGhlIGFib3ZlIHBhdGNoc2V0IGRyb3BzIGp1c3QgYnppcDIuICBJ
dCBpcyB0aGUgb25seSBvbmUgdGhhdCdzIHN0cmljdGx5DQo+Pj4gYmVhdGVuIGluIGV2ZXJ5IHdh
eSAocmF0aW8sIHRpbWUsIG1lbW9yeSB1c2FnZSksIHRoZXJlIGFyZSBhbHNvIG5vIG90aGVyDQo+
PiANCj4+IERvZXMgdGltZSBpbmNsdWRlIGJ1aWxkIHRpbWU/IEkndmUgYmVlbiByZXZlcnRpbmcg
YmFjayB0byBnemlwIHJlY2VudGx5DQo+PiBiZWNhdXNlIEkgY2FyZSB2ZXJ5IG11Y2ggYWJvdXQg
dGhhdC4NCj4gDQo+IFRvbyBsYXp5IHRvIGJlbmNobWFyayBhIGtlcm5lbCBpbWFnZSAoSUlSQyBO
aWNrIFRlcnJlbGwgcG9zdGVkIHRoYXQgYSB3aGlsZQ0KPiBhZ28pLCBoZXJlJ3MgY29weXBhc3Rh
IG9mIGEgcmFuZG9tIDE2ODI0NjcyIGJ5dGUgZXhlY3V0YWJsZSwgaW4gdXNlcnNwYWNlLA0KPiB3
aXRoIGRlZmF1bHQgbGV2ZWwgc2V0dGluZzoNCj4gDQo+IAljb21wCWRlY29tcAlzaXplDQo+IHh6
CTguMDM4cwkwLjM1NnMJNDMyMDI5Mg0KPiBiejIJMi4yNjVzCTAuNzMwcwk1MjM0NTE2DQo+IHpz
dAkwLjI3NHMJMC4xMDJzCTU2NTc2MjYNCj4gZ3oJMC44ODBzCTAuMTUycwk2NTE1NTA1DQo+IFoJ
MC40OTlzCTAuMTMzcwk4OTMyNDU5DQo+IGx6bwkwLjEwMHMJMC4wOTVzCTkxOTg4NzQNCj4gDQo+
IEFzIHlvdSBjYW4gc2VlLCB6c3RkJ3MgY29tcHJlc3Npb24gdGltZSBpcyBkcmFzdGljYWxseSBi
ZXR0ZXIgdGhhbiBnemlwLA0KPiB3aGlsZSByYXRpbyBpcyBiZXR0ZXIuICBUaGUgZGVmYXVsdCBs
ZXZlbCBpcyB2ZXJ5IGxvdyAoLTMgb24gLTEuLi0yMiBzY2FsZSkNCj4gYnV0IHlvdSBjYW4gY3Jh
bmsgaXQgdXAgZm9yIHN0cm9uZ2VyIGNvbXByZXNzaW9uLg0KPiANCj4gVGhlIGRlZmF1bHRzIGZp
dCB5b3VyIHVzZSBjYXNlLg0KPiANCj4+PiB1c2VzIG9mIGJ6aXAyIGFueXdoZXJlIGluIHRoZSBr
ZXJuZWwgc28gd2UnZCBnZXQgdG8gZHJvcCBpdHMgY29kZQ0KPj4+IGNvbXBsZXRlbHk6IDkwMCBs
aW5lcyBvZiBMaW51cycgaGFwcGluZXNzLg0KPj4gDQo+PiBHcmVhdCENCj4+IA0KPj4+IE90aGVy
IGNhbmRpZGF0ZXMgYXJlIGx6byBhbmQgYmFyZSBsem1hICh5b3Ugd2FudCBsejQsIHpzdGQgb3Ig
eHogaW5zdGVhZCksDQo+Pj4gYnV0IHRob3NlIGFyZSB1c2VkIGVsc2V3aGVyZSB0aHVzIHRoZXJl
J3MgaGFyZGx5IGFueSBnYWluLiAgSWYgeW91IHdhbnQgdGhlbQ0KPj4+IGdvbmUsIHBsZWFzZSBz
YXkgc28gLS0gSSdsbCBpbmNsdWRlIHRoZWlyIGRyb3BwYWdlLg0KPj4gDQo+PiBZZXMgd291bGQg
YmUgZ29vZCB0byByZW1vdmUgdGhlIGtlcm5lbCBpbWFnZSBzdXBwb3J0IGZvciB0aG9zZSB0b28N
Cj4+IGp1c3QgdG8gc2ltcGxpZnkgdGhlIGNvbmZpZyBwcm9jZXNzLCBldmVuIGlmIGl0IGRvZXNu
J3Qgc2F2ZSBtdWNoIGNvZGUuDQo+IA0KPiBUaGVyZSdzIG9uZSBjYXZlYXQ6IGZhc3QgY2hvaWNl
cyBhcmUgcXVpdGUgbmV3Og0KPiAqIGx6NCB1c2Vyc3BhY2UgdG9vbHMgYXJlIG5vdCBldmVuIGlu
IGN1cnJlbnQgRGViaWFuIHN0YWJsZSAoanVzdCB1bnN0YWJsZSkNCj4gKiB1bmNvbXByZXNzZWQg
a2VybmVsIGdvdCBpbiBvbmx5IHRoaXMgbWVyZ2Ugd2luZG93DQo+ICogenN0ZCBoYXMgdXNlcnNw
YWNlIHRvb2xzIGluIERlYmlhbiBzdGFibGUgYnV0IGlzIG5vdCBtZXJnZWQgaW50byB0aGUNCj4g
IGtlcm5lbCB5ZXQNCj4gKG90aGVyIGRpc3RzIGFyZSBwcm9iYWJseSBzaW1pbGFyKQ0KPiANCj4g
VGh1cywgaXQgbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8ga2VlcCBsem8gZm9yIGEgd2hpbGUgbG9u
Z2VyLg0KPiANCj4gQmFyZSBsem1hIGNhbiBwcm9iYWJseSBnbyAtLSB4eiBmaWx0ZXJzIGFyZSBu
aWNlIGZvciBiaW5hcmllcyBvZiBhcmNocyBpdA0KPiBrbm93cyAoZGlzYWJsZWQgb3RoZXJ3aXNl
KSwgYW5kIGxhY2sgb2YgaGVhZGVyIHJlcXVpcmVzIGhhY2tzIHRvIGZpbmQgb3V0DQo+IHRoZSBw
YXlsb2FkJ3Mgc2l6ZS4NCg0KUGVyc29uYWxseSwgSSdkIGJlIHZlcnkgaGFwcHkgdG8gc2VlIExa
TUEgZ28uIEl0IGlzIGEgY3VzdG9tIGltcGxlbWVudGF0aW9uDQp0aGF0IGRvZXNuJ3QgdXNlIHRo
ZSBsaWIveHovIGxpYnJhcnkuIFdoZW4gSSB3YXMgaW1wbGVtZW50aW5nIGRlY29tcHJlc3NfenN0
ZC5jDQpJIGZ1enplZCBhbGwgb2YgdGhlIGtlcm5lbCBkZWNvbXByZXNzb3JzLCBhbmQgdW5sem1h
KCkgd2lsbCBjcmFzaCBvbiBpbnZhbGlkIGlucHV0Lg0KVGhlcmUgaXMgbm8gcmVhc29uLCBvdGhl
ciB0aGFuIG5vdCBicmVha2luZyBjb21wYXRpYmlsaXR5LCB0byB1c2UgTFpNQSBvdmVyIFhaLg0K
DQo+IFNvIGl0J3MgdXAgdG8geW91IGd1eXM6IGRvIHlvdSB3YW50IG1lIHRvIGRyb3AgbHpvIGFu
ZC9vciBsem1hPw0KPiBXZSBjYW4gYWxzbyBkcm9wIHRoZW0ganVzdCBmb3Igdm1saW51eiBidXQg
bm90IGluaXRyZC4NCj4gDQo+IA0KPiBNZW93IQ0KPiAtLSANCj4g4qKA4qO04qC+4qC74qK24qOm
4qCAIFdoYXQgV291bGQgSmVzdXMgRG8sIE1VRC9NTU9SUEcgZWRpdGlvbjoNCj4g4qO+4qCB4qKw
4qCS4qCA4qO/4qGBIOKAoiBtdWx0aXBsYXkgd2l0aCBhbiBhZG1pbiBjaGFyIHRvIGJlbmVmaXQg
eW91ciBtb3J0YWwgW010MzoxNi0xN10NCj4g4qK/4qGE4qCY4qC34qCa4qCL4qCAIOKAoiBhYnVz
ZSBpdGVtIGNsb25pbmcgYnVncyBbTXQxNDoxNy0yMCwgTXQxNTozNC0zN10NCj4g4qCI4qCz4qOE
4qCA4qCA4qCA4qCAIOKAoiB1c2UgZ2xpdGNoZXMgdG8gd2FsayBvbiB3YXRlciBbTXQxNDoyNS0y
Nl0NCg0K
