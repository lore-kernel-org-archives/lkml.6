Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43975C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5D821855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hEfcXxDn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YmTTGnou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfAXT3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:29:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731237AbfAXT3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:29:41 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OJSfuu005760;
        Thu, 24 Jan 2019 11:29:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zVqqywUjfqqxYXKktcOEU53QvoIsBoxXnyADkQa5rzE=;
 b=hEfcXxDnmnTieHnKGtppzrK5qoi6CCztICXYHVw5NYkYoyhBFBVUcD1te3BYvoCKaKDe
 zzevCAgxKvirz3nCuHKPi21zKVkvkyMslornabuyzA11N5ODBA3ku+9HC9g1Keqnds78
 R4vJeg3gxx1rfDqxNbCwkyzmVNCx0fmzMc0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q7jvcr5ae-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Jan 2019 11:29:20 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 24 Jan 2019 11:29:17 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 24 Jan 2019 11:29:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVqqywUjfqqxYXKktcOEU53QvoIsBoxXnyADkQa5rzE=;
 b=YmTTGnouYcQwnZep95O3hjTWFPbL0oAeUpbczvs6aKHKB+9/Pw5tzM/Msuj4MZXXbK1ZnlddWhLivI13P0y3F+j2eoSYyhdbP3rLrukG9tt4SCcKv2dtbKvdKSuvdeo932d5l4u7FLvxF3lQ+pIURtnAqY+QvWOBYUUZ9TtZu0M=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1288.namprd15.prod.outlook.com (10.172.181.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 19:29:16 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b4e4:1e1f:8c5d:9a8c]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b4e4:1e1f:8c5d:9a8c%4]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 19:29:16 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>
CC:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Thread-Topic: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Thread-Index: AQHUs3BeMI31TwUu10WDx7+uo1I7z6W+EyAAgAA2EYA=
Date:   Thu, 24 Jan 2019 19:29:16 +0000
Message-ID: <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
 <20190124081544.GA1649@kroah.com>
In-Reply-To: <20190124081544.GA1649@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:af34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1288;20:3grAI8LHtLCKBuLgzrIuY3USvTLC+/CmFD2igFHAZgBebzT8pyF5cBWcNEvfTzqJ1DdddtiH76g+nC1tiEtba8YzHAovzBSQErtCbKvLuJo4fCPHRnuS3wBPBCbCm3rSpCPGKcvj7y06ouu7oQl+dHyEc/MvDx74GVZSdTfkAZA=
x-ms-office365-filtering-correlation-id: a8aec6f4-d331-433f-00aa-08d682323a92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1288;
x-ms-traffictypediagnostic: CY4PR15MB1288:
x-microsoft-antispam-prvs: <CY4PR15MB128832E0E7132BC3B7DC96E7DD9A0@CY4PR15MB1288.namprd15.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(316002)(6512007)(110136005)(53936002)(305945005)(83716004)(7736002)(6246003)(2906002)(68736007)(33656002)(6506007)(54906003)(97736004)(76176011)(86362001)(102836004)(99286004)(256004)(14454004)(46003)(105586002)(486006)(106356001)(446003)(2616005)(476003)(11346002)(478600001)(6116002)(8676002)(36756003)(6486002)(71200400001)(25786009)(8936002)(81156014)(81166006)(4326008)(229853002)(6436002)(82746002)(71190400001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1288;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mC6769IUo87Dw6Tno3bje/Tv5Ma0rlfe5chxk+Rq6mmWR7AuJDTfYUkjopxNAS7JeFrQVjET0UNSTiTuGnePtrG/tTo8MQm9J2DPxmaLnKdPHQau3aJU6nkwgDQdWxaFxq/+5AlcpPMqpOK4lSlGPA0aMwo6Q28BVDhPAW1FzzmQV2Gsm7QbkvP3rRkaf3SURvT6+cgWvDGD22KPzs6vu8Eeqp4Tq7wymPTl7UhpWWkUlIWJcBzXgDYpmK5q30e6kNtoPfwbej4uWz/NtrWD+cKclGeM994A3039/8qs6ZXgDIJvb0Xr6r2ZvUQxNwOEy91ftTrAr1ef//9ZG0LwOmG5g2VQvrSNG7emSheu7OCe+PMHRV9wsFkEQR9c4M4nowF/UZlQGuSrtAuWxjrnb0WAkoPAfyNQGAA47RHJ9zM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <810BF40483D70F48A818ADB8CC69353E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aec6f4-d331-433f-00aa-08d682323a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 19:29:16.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1288
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEvMjQvMTksIDEyOjE2IEFNLCAiR3JlZyBLcm9haC1IYXJ0bWFuIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KDQogICAgT24gV2VkLCBKYW4gMjMsIDIwMTkg
YXQgMDM6MDY6MzRQTSAtMDgwMCwgVmlqYXkgS2hlbWthIHdyb3RlOg0KICAgID4gQ29ycmVjdGVk
IHNvbWUgb2YgcmV0dXJuIHZhbHVlcyB3aXRoIGFwcHJvcHJpYXRlIG1lYW5pbmdzLg0KICAgID4g
DQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4N
CiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvbWlzYy9hc3BlZWQtbHBjLWN0cmwuYyB8IDE1ICsr
KysrKystLS0tLS0tLQ0KICAgID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQogICAgPiANCiAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvYXNw
ZWVkLWxwYy1jdHJsLmMgYi9kcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMNCiAgICA+IGlu
ZGV4IDMzMjIxMGUwNmU5OC4uOTdhZTM0MTEwOWQ1IDEwMDY0NA0KICAgID4gLS0tIGEvZHJpdmVy
cy9taXNjL2FzcGVlZC1scGMtY3RybC5jDQogICAgPiArKysgYi9kcml2ZXJzL21pc2MvYXNwZWVk
LWxwYy1jdHJsLmMNCiAgICA+IEBAIC02OCw3ICs2OCw2IEBAIHN0YXRpYyBsb25nIGFzcGVlZF9s
cGNfY3RybF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwNCiAgICA+
ICAJCXVuc2lnbmVkIGxvbmcgcGFyYW0pDQogICAgPiAgew0KICAgID4gIAlzdHJ1Y3QgYXNwZWVk
X2xwY19jdHJsICpscGNfY3RybCA9IGZpbGVfYXNwZWVkX2xwY19jdHJsKGZpbGUpOw0KICAgID4g
LQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBmaWxlLT5wcml2YXRlX2RhdGE7DQogICAgPiAgCXZvaWQg
X191c2VyICpwID0gKHZvaWQgX191c2VyICopcGFyYW07DQogICAgPiAgCXN0cnVjdCBhc3BlZWRf
bHBjX2N0cmxfbWFwcGluZyBtYXA7DQogICAgPiAgCXUzMiBhZGRyOw0KICAgID4gQEAgLTkzLDgg
KzkyLDggQEAgc3RhdGljIGxvbmcgYXNwZWVkX2xwY19jdHJsX2lvY3RsKHN0cnVjdCBmaWxlICpm
aWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KICAgID4gIA0KICAgID4gIAkJLyogSWYgbWVtb3J5LXJl
Z2lvbiBpcyBub3QgZGVzY3JpYmVkIGluIGRldmljZSB0cmVlICovDQogICAgPiAgCQlpZiAoIWxw
Y19jdHJsLT5tZW1fc2l6ZSkgew0KICAgID4gLQkJCWRldl9lcnIoZGV2LCAiRGlkbid0IGZpbmQg
cmVzZXJ2ZWQgbWVtb3J5XG4iKTsNCiAgICA+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCiAgICA+ICsJ
CQlwcl9lcnIoImFzcGVlZF9scGNfY3RybDogaW9jdGw6IERpZG4ndCBmaW5kIHJlc2VydmVkIG1l
bW9yeVxuIik7DQogICAgDQogICAgV2h5IGRpZCB5b3UgY2hhbmdlIGZyb20gZGV2X2VycigpIHRv
IHByX2VycigpPyAgWW91IGp1c3QgbG9zdCBhIGxvdCBvZg0KICAgIGluZm9ybWF0aW9uIHRoYXQg
dGhlIHVzZXIgcHJldmlvdXNseSB3YXMgZ2V0dGluZyBmcm9tIGRldl9lcnIoKSA6KA0KDQpJIGRp
ZCB0aGlzIGFzIHBlciByZXZpZXcgY29tbWVudCBmcm9tIEFuZHJldyBKZWZmZXJ5LCBhcyB3ZSBk
b24ndCB3YW50IHRvIHB1dCB0aGlzIGVycm9yIGZvciBkcml2ZXIuIEl0IGhhcyB0byBiZSBoYW5k
bGVkIGJ5IHVzZXJzcGFjZS4gQnV0IEkgYW0gc3RpbGwgcmVwb3J0aW5nIHNvbWUgZXJyb3IgaGVy
ZS4NCiAgICANCiAgICANCiAgICANCiAgICA+ICsJCQlyZXR1cm4gLUVOWElPOw0KICAgID4gIAkJ
fQ0KICAgID4gIA0KICAgID4gIAkJbWFwLnNpemUgPSBscGNfY3RybC0+bWVtX3NpemU7DQogICAg
PiBAQCAtMTM0LDE2ICsxMzMsMTYgQEAgc3RhdGljIGxvbmcgYXNwZWVkX2xwY19jdHJsX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KICAgID4gIA0KICAgID4gIAkJ
aWYgKG1hcC53aW5kb3dfdHlwZSA9PSBBU1BFRURfTFBDX0NUUkxfV0lORE9XX0ZMQVNIKSB7DQog
ICAgPiAgCQkJaWYgKCFscGNfY3RybC0+cG5vcl9zaXplKSB7DQogICAgPiAtCQkJCWRldl9lcnIo
ZGV2LCAiRGlkbid0IGZpbmQgaG9zdCBwbm9yIGZsYXNoXG4iKTsNCiAgICA+IC0JCQkJcmV0dXJu
IC1FSU5WQUw7DQogICAgPiArCQkJCXByX2VycigiYXNwZWVkX2xwY19jdHJsOiBpb2N0bDogRGlk
bid0IGZpbmQgaG9zdCBwbm9yIGZsYXNoXG4iKTsNCiAgICANCiAgICBBZ2FpbiwgZG9uJ3QgZG8g
dGhhdCA6KA0KICAgIA0KICAgIHRoYW5rcywNCiAgICANCiAgICBncmVnIGstaA0KICAgIA0KDQo=
