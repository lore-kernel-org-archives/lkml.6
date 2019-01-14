Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H3puoZq9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Iq46gVBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfANT3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:29:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbfANT3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:29:12 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EJLbCq026478;
        Mon, 14 Jan 2019 11:28:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nMWjnX8Li/rqjrKtr49iOm5cvEGMcBNILHXXJut3e+g=;
 b=H3puoZq91UdZe0a5wm+3JnxP+HuhxDyhLK+R2LCQNvnhcRDPKz2uHDGKLpBI4OV7vE6A
 GmLGot9VlCdUT2mZ2Kerko/rnbyUbXIWT0Un2n5v+4dHcHeQZITP8V2MUlb49Buj9uu5
 ieOfKf0csRQjbdNHawSMcEBEMbg76cR7iYs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q0x5rggs7-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Jan 2019 11:28:45 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 14 Jan 2019 11:28:43 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 14 Jan 2019 11:28:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMWjnX8Li/rqjrKtr49iOm5cvEGMcBNILHXXJut3e+g=;
 b=Iq46gVBqZJOps2lMDZmQFNz69T2qQ9cwkciDZ3eTnW0F41ZgsaUeMmkAnss3VO0QdlFbTnZ1m8S63RXnDhqeMlBD4Yzo8o2Qd8KQKvZNJYUSiZes82pmztZvOKiVvw54hg361FMJ1wzGxrNhQI6U0Dq/vMbMicWCcKn2x9adj/o=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1687.namprd15.prod.outlook.com (10.175.121.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.20; Mon, 14 Jan 2019 19:28:41 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::f9c6:952c:8b66:cc9d%10]) with mapi id 15.20.1516.019; Mon, 14 Jan
 2019 19:28:41 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
Thread-Topic: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH v2 4/4] ARM:
 dts: aspeed: Add lpc ctrl for Facebook
Thread-Index: AQHUqg5kq5zkppfjDEupYTurooq9yKWtzaAAgADW2wA=
Date:   Mon, 14 Jan 2019 19:28:41 +0000
Message-ID: <B36B9550-0E17-442C-974A-908736EB2980@fb.com>
References: <5972B57A-23D5-43F4-9476-229379B96C7C@fb.com>
 <1547419180.2315773.1633559160.3F7D29CF@webmail.messagingengine.com>
In-Reply-To: <1547419180.2315773.1633559160.3F7D29CF@webmail.messagingengine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:6dbd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1687;20:23YTfYa1mlMSCbFxlSnuYn8hbKfw20BNGuhW7TkobcLCVR5v3R+2j7kPK/jLP/tHvOz13eRhMH05xkYHJvCJQA7vB2uCh+BAkCnbeVNl3/0RbkS/LdcKb3r6Iu0CVK8GFW7zvojYw5gAsmB7rhDjfSMXDYUnyYkoTERSkux1rPg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2586ad57-fa12-4af3-6ef8-08d67a567db3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1687;
x-ms-traffictypediagnostic: CY4PR15MB1687:
x-microsoft-antispam-prvs: <CY4PR15MB1687A48D006037278CDBA000DD800@CY4PR15MB1687.namprd15.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(346002)(366004)(136003)(47680400002)(43544003)(189003)(199004)(6486002)(2201001)(2616005)(11346002)(446003)(110136005)(4326008)(6436002)(486006)(97736004)(86362001)(316002)(476003)(2906002)(8936002)(81156014)(36756003)(81166006)(8676002)(256004)(14444005)(478600001)(14454004)(6116002)(106356001)(186003)(105586002)(82746002)(99286004)(6506007)(53546011)(7736002)(305945005)(46003)(33656002)(5660300001)(102836004)(68736007)(25786009)(6512007)(6246003)(53936002)(76176011)(71200400001)(229853002)(83716004)(2501003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1687;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qs8fNVkdNbK+K5rOWK0WN3s5vjgDCWP/nncKc1z1/ME+rYa+0t6jKADNLTaRQwp0pBjWWswljOZD4+JymvMW8qs/CtUgVpx+LJcVLzA+hy5R/Xslfircdqzo8UaivisCii7e2HZm0Sa+Jsi5VFdfHZ2p63v4w5/kS932bqbZE5NDPjAZY8JJdUNkC7LSqEaC8LlMONtVlsxTMwAU+nTBiWpOO7mtGGD5Bse1YTSwsV+E1ZRVi6YWrHkOAh4uRle8hFAJ7d2bYU9dvo6fHa4uqF69xPxtcmWeNV6QMj+p8gbULUAfUAwLwGuNoJaiZd2CuPSB2oX3sxYGH88D0ylPgC5hvRvrO2jXiol9PakIPdNSyS99lfAks2fz7rEF7JK9g4pspbArx5NnIDGc4QvWxDthsFDf+LzIq1HsKka1njo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0D47D5C7865C44ADAACD1CBC68E370@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2586ad57-fa12-4af3-6ef8-08d67a567db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 19:28:41.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1687
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEvMTMvMTksIDI6MzkgUE0sICJBbmRyZXcgSmVmZmVyeSIgPGFuZHJld0Bhai5p
ZC5hdT4gd3JvdGU6DQoNCiAgICBIaSBWaWpheSwNCiAgICANCiAgICBTb3JyeSBmb3IgcHJvdmlk
aW5nIGFuIG9waW5pb24gc28gbGF0ZSwgaG93ZXZlcjoNCiAgICANCiAgICBPbiBTYXQsIDEyIEph
biAyMDE5LCBhdCAxMTowMywgVmlqYXkgS2hlbWthIHdyb3RlOg0KICAgID4gSm9lbCwNCiAgICA+
IFBsZWFzZSBtZXJnZSB0aGVzZSBwYXRjaGVzIGFzIGl0IGlzIHJlcXVpcmVkIGJ5IGZhY2Vib29r
IHBsYXRmb3JtLg0KICAgID4gDQogICAgPiBSZWdhcmRzDQogICAgPiAtVmlqYXkNCiAgICA+IA0K
ICAgID4gT24gMS83LzE5LCAxMToyNSBBTSwgIkxpbnV4LWFzcGVlZCBvbiBiZWhhbGYgb2YgVmlq
YXkgS2hlbWthIiA8bGludXgtDQogICAgPiBhc3BlZWQtYm91bmNlcyt2aWpheWtoZW1rYT1mYi5j
b21AbGlzdHMub3psYWJzLm9yZyBvbiBiZWhhbGYgb2YgDQogICAgPiB2aWpheWtoZW1rYUBmYi5j
b20+IHdyb3RlOg0KICAgID4gDQogICAgPiAgICAgUGxlYXNlIG1lcmdlIHRoZXNlIHBhdGNoZXMg
aW4gdXBzdHJlYW0ga2VybmVsLg0KICAgID4gICAgIA0KICAgID4gICAgIFJlZ2FyZHMNCiAgICA+
ICAgICAtVmlqYXkNCiAgICA+ICAgICANCiAgICA+ICAgICBPbiAxMi8yMC8xOCwgMTA6MDYgQU0s
ICJMaW51eC1hc3BlZWQgb24gYmVoYWxmIG9mIFZpamF5IEtoZW1rYSIgDQogICAgPiA8bGludXgt
YXNwZWVkLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxpc3RzLm96bGFicy5vcmcgb24gYmVo
YWxmIG9mIA0KICAgID4gdmlqYXlraGVta2FAZmIuY29tPiB3cm90ZToNCiAgICA+ICAgICANCiAg
ICA+ICAgICAgICAgSm9lbCwgQ2FuIHlvdSBwbGVhc2UgdGFrZSBjYXJlIG9mIHRoZXNlIHBhdGNo
ZXMgbWVyZ2UuDQogICAgPiAgICAgICAgIA0KICAgID4gICAgICAgICBPbiAxMi8xNy8xOCwgMTI6
MDQgUE0sICJWaWpheSBLaGVta2EiIDx2aWpheWtoZW1rYUBmYi5jb20+IHdyb3RlOg0KICAgID4g
ICAgICAgICANCiAgICA+ICAgICAgICAgICAgIEFkZGVkIGxwYyBjdHJsIGRldmljZSB0byBlbmFi
bGUgTFBDIGNsb2NrIGluIEZhY2Vib29rDQogICAgPiAgICAgICAgICAgICBUaW9nYXBhc3MgZGV2
aWNlIHRyZWUuDQogICAgPiAgICAgICAgICAgICANCiAgICA+ICAgICAgICAgICAgIFNpZ25lZC1v
ZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgID4gICAgICAgICAg
ICAgLS0tDQogICAgPiAgICAgICAgICAgICAgLi4uL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJv
b2stdGlvZ2FwYXNzLmR0cyAgfCAxNyArKysrKysNCiAgICA+ICsrKysrKysrKysrDQogICAgPiAg
ICAgICAgICAgICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCiAgICA+ICAgICAg
ICAgICAgIA0KICAgID4gICAgICAgICAgICAgZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2FzcGVlZC1ibWMtZmFjZWJvb2stDQogICAgPiB0aW9nYXBhc3MuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgPiAgICAgICAgICAg
ICBpbmRleCA3M2U1OGE4MjE2MTMuLmVmNzg3NWI1NDU2MiAxMDA2NDQNCiAgICA+ICAgICAgICAg
ICAgIC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNz
LmR0cw0KICAgID4gICAgICAgICAgICAgKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJt
Yy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgPiAgICAgICAgICAgICBAQCAtMjIsNiArMjIs
MTcgQEANCiAgICA+ICAgICAgICAgICAgICAJCXJlZyA9IDwweDgwMDAwMDAwIDB4MjAwMDAwMDA+
Ow0KICAgID4gICAgICAgICAgICAgIAl9Ow0KICAgID4gICAgICAgICAgICAgIA0KICAgID4gICAg
ICAgICAgICAgKwlyZXNlcnZlZC1tZW1vcnkgew0KICAgID4gICAgICAgICAgICAgKwkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQogICAgPiAgICAgICAgICAgICArCQkjc2l6ZS1jZWxscyA9IDwxPjsN
CiAgICA+ICAgICAgICAgICAgICsJCXJhbmdlczsNCiAgICA+ICAgICAgICAgICAgICsNCiAgICA+
ICAgICAgICAgICAgICsJCWZsYXNoX21lbW9yeTogcmVnaW9uQDk4MDAwMDAwIHsNCiAgICA+ICAg
ICAgICAgICAgICsJCQluby1tYXA7DQogICAgPiAgICAgICAgICAgICArCQkJcmVnID0gPDB4OTgw
MDAwMDAgMHgwMDAwMTAwMD47IC8qIDRLICovDQogICAgPiAgICAgICAgICAgICArCQl9Ow0KICAg
ID4gICAgICAgICAgICAgKwl9Ow0KICAgID4gICAgICAgICAgICAgKw0KICAgID4gICAgICAgICAg
ICAgIAlpaW8taHdtb24gew0KICAgID4gICAgICAgICAgICAgIAkJY29tcGF0aWJsZSA9ICJpaW8t
aHdtb24iOw0KICAgID4gICAgICAgICAgICAgIAkJaW8tY2hhbm5lbHMgPSA8JmFkYyAwPiwgPCZh
ZGMgMT4sIDwmYWRjIDI+LCA8JmFkYyAzPiwNCiAgICA+ICAgICAgICAgICAgIEBAIC01NCw2ICs2
NSwxMiBAQA0KICAgID4gICAgICAgICAgICAgIAl9Ow0KICAgID4gICAgICAgICAgICAgIH07DQog
ICAgPiAgICAgICAgICAgICAgDQogICAgPiAgICAgICAgICAgICArJmxwY19jdHJsIHsNCiAgICA+
ICAgICAgICAgICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAgID4gICAgICAgICAgICAgKwltZW1v
cnktcmVnaW9uID0gPCZmbGFzaF9tZW1vcnk+Ow0KICAgID4gICAgICAgICAgICAgKwlmbGFzaCA9
IDwmc3BpMT47DQogICAgPiAgICAgICAgICAgICArfTsNCiAgICA+ICAgICAgICAgICAgICsNCiAg
ICA+ICAgICAgICAgICAgICAmdWFydDEgew0KICAgID4gICAgICAgICAgICAgIAkvLyBIb3N0IENv
bnNvbGUNCiAgICA+ICAgICAgICAgICAgICAJc3RhdHVzID0gIm9rYXkiOw0KICAgID4gICAgICAg
ICAgICAgLS0gDQogICAgPiAgICAgICAgICAgICAyLjE3LjENCiAgICANCiAgICBJIHVuZGVyc3Rh
bmQgeW91IGp1c3Qgd2FudCB0byBtYWtlIHlvdXIgc3lzdGVtIHdvcmssIGJ1dCB0aGlzIGlzIGEN
CiAgICBicm9rZW4gd2F5IHRvIGRvIGl0LiBBbmQgdGhhdCdzIG5vdCB5b3VyIGZhdWx0IC0gd2Ug
c2hvdWxkIHJlYWxseSBmaXgNCiAgICB0aGUgZHJpdmVyLiBJIHRoaW5rIHRoZSBtZW1vcnktcmVn
aW9uIHBoYW5kbGUgc2hvdWxkIGJlIG9wdGlvbmFsDQogICAgYW5kIHRoZSBkcml2ZXIgc2hvdWxk
IHNpbXBseSBsaW1pdCB0aGUgb3B0aW9ucyBhdmFpbGFibGUgdG8gdGhlIGlvY3RsDQogICAgdG8g
anVzdCB0aGUgZmxhc2ggcmVnaW9uIGlmIHRoZSBtZW1vcnkgbm9kZSBpcyBub3QgcHJlc2VudCAo
aS5lLiByZXR1cm4NCiAgICBhbiBlcnJvciBpZiB0aGUgbWVtb3J5IHJlZ2lvbiBpcyByZXF1ZXN0
ZWQgYnV0IG5vdCBkZXNjcmliZWQgaW4gdGhlDQogICAgZGV2aWNldHJlZSkuDQpMZXQgbWUgZml4
IGRyaXZlciBpdHNlbGYgZmlyc3QuDQogICAgDQogICAgQW5kcmV3DQogICAgDQoNCg==
