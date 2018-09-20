Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644A214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bDsF/R8f";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c32U8h5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4644A214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeIUCz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:55:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbeIUCz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:55:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KL7mK1017293;
        Thu, 20 Sep 2018 14:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UGSCWeUOU1BwTe5BieU9bTqSpaXTXrmELmOKEYFnato=;
 b=bDsF/R8fPfNRHPO/4oC+LVwPePitefBfQbELWdtxn055LEj88hgL5XZ1+Cgo3o6+0K94
 Gd2f8yb352l30MCVrJIzL7cMLlJ7rWHRzxtE+r4Sai/sFRtIjgi9C6lrsxp01W/Tm0ii
 0CTfI3IrAGL9GfavVnmPSvowJ6svfKu7YEA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mmhfk8bba-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 20 Sep 2018 14:09:41 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 20 Sep 2018 14:09:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGSCWeUOU1BwTe5BieU9bTqSpaXTXrmELmOKEYFnato=;
 b=c32U8h5fpBjCUxJQWMSPdisCGjpHm0Zw5pEzwMb689SQ59KzgNgcjnjBugNsOfQKU8EZ4eQjNMQl/BO0yxjFbAws5umeZz6tMGfHBF0Wit0p1c9396dES6AaMHDN0N8MTAoGa5g9xqcafjHuKX326bPWfc9f2iNnwNCQSnNq/s4=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1869.namprd15.prod.outlook.com (10.174.100.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 21:09:38 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c%12]) with mapi id 15.20.1143.017; Thu, 20 Sep
 2018 21:09:37 +0000
From:   Tao Ren <taoren@fb.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Christopher Covington <cov@fb.com>, Tian Fang <tfang@fb.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Index: AQHUUGYZopGOJgtP6kqMuhqvXVxY+KT5UT6A///lFQA=
Date:   Thu, 20 Sep 2018 21:09:36 +0000
Message-ID: <84F9ED20-0964-462E-B389-39B107A232D3@fb.com>
References: <20180919221331.2511558-1-taoren@fb.com>
 <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
In-Reply-To: <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:50d5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1869;20:53vwIWr8AGHnkSsLHyiA+ItH85L4WudA1mj9riLuBmb0RqDpcvaFCAgZ9oMvpoHXPqHIIhvviVpUXPNGNyBNlDdKGSwCGv3sGyQC7GRLN286xOkQg0KKq8j1XbbGvWoizK22Pz3DtxWfvpR+FM5iXczL3CbNYR+nabKxVgaeg/I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(229853002)(82746002)(81166006)(8676002)(8936002)(81156014)(256004)(14444005)(33656002)(36756003)(97736004)(6116002)(5250100002)(68736007)(102836004)(53546011)(6506007)(99286004)(6436002)(76176011)(83716003)(25786009)(53936002)(105586002)(46003)(316002)(106356001)(6512007)(186003)(305945005)(110136005)(486006)(446003)(11346002)(54906003)(5660300001)(476003)(2616005)(6486002)(86362001)(2900100001)(71200400001)(71190400001)(7736002)(4326008)(6246003)(14454004)(2906002)(478600001)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1869;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: b8053574-d012-40b1-d3f9-08d61f3d5f31
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1869;
x-ms-traffictypediagnostic: MWHPR15MB1869:
x-microsoft-antispam-prvs: <MWHPR15MB1869926A8E2CAADDCC593C20B2130@MWHPR15MB1869.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(2280121)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR15MB1869;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1869;
x-forefront-prvs: 0801F2E62B
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TPyG283mTgGeZcczHgji++ZZSQuTKTzw9H8dBMIYCbkbys04TilPBRWIJHJOlvCAvSAUpbi0I7pJK/sw/Kfbnzyzx6i1kto+BPBzt7dSB6CfTMCVNr+7Q9lZ7pp5Bse/YkvVqzh9OCao+2mwWwLkBzmCZR4bjYt4AhCdirKsdzsffb3w/Mh3N0KfDznONutKyM4BLX/i8T2NGSAKmKqZHkQqixR6tp7oYuwUOthDzb4s6lhYB56YfcDLXfwmvR6P6AiYVFrpaFHGhuUn/Q8HQXEHc7X1Kr77h51WvR0/wMpJD6dJKLuAjebkjNfm7e1JB/5/U5/2nUXxBCwS5zZW437crYSOUfdXTIZhVoexUEs8WVea/BsrHaAGbCKsBn5RFXrsREWq6xQOUxJVR9iv9O914XaRvSrNjm8ajSdtoNChv6ENYqk43t6JqSbzPyKzGIKwvAvP7qXWuGcmTvJgpYendVkI9R776gpXgAakNLc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5D1B6668DFD547820F902FDF07F5DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8053574-d012-40b1-d3f9-08d61f3d5f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 21:09:36.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1869
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMC8xOCwgODo0NiBBTSwgIkxpbnVzIFdhbGxlaWoiIDxsaW51cy53YWxsZWlqQGxpbmFy
by5vcmc+IHdyb3RlOg0KIA0KPiBBY3R1YWxseSB0aGlzIGlzIG11Y2ggbW9yZSBpbnR1aXRpdmUg
dG9vLCBpdCBpcyB0aGUgdHlwaWNhbCB3YXkgdG8gaGFuZGxlDQo+IGEgZG93bi1jb3VudGluZyB0
aW1lci4gR29vZCBjYXRjaCENCj4gUmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz4NCg0KVGhhbmsgeW91IExpbnVzIGZvciB0aGUgcXVpY2sgcmV2aWV3
IQ0KICAgIA0KPiBTb3JyeSBmb3IgYW55IGNhcmdvLWN1bHQgcHJvZ3JhbW1pbmcgb24gbXkgcGFy
dCA6Lw0KPiBXb3VsZCBiZSBuaWNlIHRvIGdldCBhIG5vZCBmcm9tIHRoZSBBU1QyNDAwIHVzZXJz
IHRoYXQgdGhpcyB3b3Jrcw0KPiBmb3IgdGhlbSB0b28sIHNvIGluY2x1ZGVkIHRoZW0gaW4gdGhl
IFRvOiBmaWVsZC4NCg0KTWFrZSBzZW5zZS4gSSBhY3R1YWxseSBib290ZWQgdXAga2VybmVsIG9u
IHFlbXUtcGFsbWV0dG8gKGFzdDI0MDApIGJ1dCBJJ20gZG91YnRpbmcgaWYgdGVzdCBpcyB2YWxp
ZCBiZWNhdXNlIGl0IGRlcGVuZHMgb24gaG93IHFlbXUgZW11bGF0ZXMgdGhlIGhhcmR3YXJlLiBJ
dCB3b3VsZCBiZSBncmVhdCBpZiBzb21lb25lIGNhbiBoZWxwIHRvIHZlcmlmeSB0aGUgcGF0Y2gg
b24gcGh5c2ljYWwgYXN0MjQwMC4NCg0KPiBJdCBhY3R1YWxseSB3b3VsZCBtYWtlIGtpbmQgb2Yg
c2Vuc2UgdG8gcmVzdGFydCB0aGUgdXAtY291bnRpbmcNCj4gdGltZXIgZnJvbSB6ZXJvIGFuZCBz
ZXQgbWF0Y2ggdG8gd2hhdGV2ZXIgdmFsdWUgaXMgcGFzc2VkIGluDQo+IGFzIHdlbGwsIHNvIEkg
bWlnaHQgc2VuZCBhIHBhdGNoIGZvciB0aGlzLiBJdCdzIG5vIHJlZ3Jlc3Npb24gdGhvdWdoDQo+
IHNvIG5vIGh1cnJ5IHdpdGggdGhhdC4NCg0KSSBhZ3JlZS4gQmVzaWRlcyBiZWluZyBtb3JlIGlu
dHVpdGl2ZSwgdGltZXIgb3ZlcmZsb3cgaW50ZXJydXB0ICh3aGVuIDxjciArIGN5Y2xlcz4gb3Zl
cmZsb3dzKSBjb3VsZCBhbHNvIGJlIGF2b2lkZWQgYnkgcmVzZXR0aW5nIHRoZSBjb3VudGVyLg0K
DQpUaGFua3MsDQpUYW8gUmVuIA0KDQo=
