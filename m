Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4394DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D062085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RROO+V6f";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZzoZ7Pzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D062085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJJNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:10:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbeJJNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:10:57 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9A5nvqg031282;
        Tue, 9 Oct 2018 22:50:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=coUSrwm8hbufsnd2j2jYrPbfJKFZSlzl9R+YSPOt5Zs=;
 b=RROO+V6f9NFiG5KzRFc8ic7iNREXkistaUpflEWAmpgc7cx2rfPpd2TAodVCQ/3G7BHd
 L/8BPxlspsJKP8ydio8yroilSc2Gl0SdHw3a2gs39pJsRowzNz+lEG13tLQ1bRm3gySd
 pD+jxoWZV4gfRWlAvFJC/6O6pGbv+MgNdGg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n1be000vh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 22:50:06 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 10 Oct 2018 01:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coUSrwm8hbufsnd2j2jYrPbfJKFZSlzl9R+YSPOt5Zs=;
 b=ZzoZ7PzihswfGf5/heeLFeSHGkGgbzVclF4lqQ8OFgFckVIkqsNigB269U0TcfkcDIbKhZ8IrzvO0F/E1Ihv/Vxsr22cIV3Voemv1YXr+41IWLLZZ85hq6I5n2uEnpmKiAxbpji2ZRu3J0oyyQFZvbE29+8d8fdSEOrS4DrcvbI=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1421.namprd15.prod.outlook.com (10.173.234.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Wed, 10 Oct 2018 05:50:03 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::ccb:6fd9:cf17:bfcd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::ccb:6fd9:cf17:bfcd%11]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 05:50:02 +0000
From:   Tao Ren <taoren@fb.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUW2On9LNQ+pmvkkW+1bSF6wxqO6UUS5aAgANCdYA=
Date:   Wed, 10 Oct 2018 05:50:02 +0000
Message-ID: <39978E69-8C5E-45A5-960A-5982CBA329EE@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
In-Reply-To: <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [67.139.178.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1421;20:LXlNNr0rsANqzBjAjrWDn5lHnrhmQfN7woSMQpVzXn2mtzMBEiwsCaqMO+hA+evxj8wVN0tgy+4kvHPK/SJEgXA8eQb8HnM9DLN4UWZT+VQcNkZpubxMHDgBKH4JM2mdVVHVj6CyHaFIPIYSQ4QQAblY7NYwkYTc8LJalWp6SqE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e9270343-21a0-4851-beab-08d62e74391c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1421;
x-ms-traffictypediagnostic: MWHPR15MB1421:
x-microsoft-antispam-prvs: <MWHPR15MB1421BD93A13F55BE2BC3E6A8B2E00@MWHPR15MB1421.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:MWHPR15MB1421;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1421;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(51914003)(6512007)(6436002)(82746002)(86362001)(486006)(26005)(476003)(25786009)(36756003)(186003)(2900100001)(2906002)(14454004)(478600001)(106356001)(105586002)(11346002)(102836004)(2616005)(446003)(229853002)(68736007)(256004)(14444005)(6246003)(33656002)(5250100002)(71200400001)(6506007)(7736002)(53546011)(316002)(305945005)(81156014)(81166006)(8676002)(66066001)(4326008)(6916009)(76176011)(71190400001)(83716004)(99286004)(5660300001)(97736004)(8936002)(53936002)(54906003)(3846002)(6116002)(58126008)(39060400002)(6486002)(3714002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1421;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EwhpOZy4n5cJ0j4Le1wcdBWym7X/YV+YOTAxNItdey6xqIR4TM1oltAH+uBa6kOAeNJFt6q2O4A2LhP6w+Pyw9nX7daaWHqqPZhmN3Ea4EHiwsPWy7S4AP4aP8GmD+q0dG+N1AdXqPZFkP1xcNFej5H0hhEj2jXbIJ2qm7FCdThlrntO1iHjPzO8v3Z4nDPKNbXbMKwUEcFg6m3vnbZo58m9YH1tzk7pesl+nIBjMO1nGNjZIt9e0pmPUAs5d96f/PxSvlkbxUl++RIlntvLjDBNntSOGtEFUdlftWD+X7WCEIJogl50FegAxJr9dmLWlUKOWkaTsthOO0P/kbQj8hcuPT9z4V9GyTSfcX38qk4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ECD91FDCD5D4E4B8540D9B82002F0E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9270343-21a0-4851-beab-08d62e74391c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 05:50:02.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNy8xOCwgMjowMyBQTSwgIkxpbnVzIFdhbGxlaWoiIDxsaW51cy53YWxsZWlqQGxpbmFy
by5vcmc+IHdyb3RlOg0KDQo+PiBUSU1FUl9JTlRSX01BU0sgcmVnaXN0ZXIgKEJhc2UgQWRkcmVz
cyBvZiBUaW1lciArIDB4MzgpIGlzIG5vdCBkZXNpZ25lZA0KPj4gZm9yIG1hc2tpbmcgaW50ZXJy
dXB0cyBvbiBhc3QyNTAwIGNoaXBzLCBhbmQgaXQncyBub3QgZXZlbiBsaXN0ZWQgaW4NCj4+IGFz
dDI0MDAgZGF0YXNoZWV0LCBzbyBpdCdzIG5vdCBzYWZlIHRvIGFjY2VzcyBUSU1FUl9JTlRSX01B
U0sgb24gYXNwZWVkDQo+PiBjaGlwcy4NCj4+DQo+PiBTaW1pbGFybHksIFRJTUVSX0lOVFJfU1RB
VEUgcmVnaXN0ZXIgKEJhc2UgQWRkcmVzcyBvZiBUaW1lciArIDB4MzQpIGlzDQo+PiBub3QgaW50
ZXJydXB0IHN0YXR1cyByZWdpc3RlciBvbiBhc3QyNDAwIGFuZCBhc3QyNTAwIGNoaXBzLiBBbHRo
b3VnaA0KPj4gdGhlcmUgaXMgbm8gc2lkZSBlZmZlY3QgdG8gcmVzZXQgdGhlIHJlZ2lzdGVyIGlu
IGZ0dG1yMDEwX2NvbW1vbl9pbml0KCksDQo+PiBpdCdzIGp1c3QgbWlzbGVhZGluZyB0byBkbyBz
by4NCj4+DQo+PiBCZXNpZGVzLCAiY291bnRfZG93biIgaXMgcmVuYW1lZCB0byAiaXNfYXNwZWVk
IiBpbiAiZnR0bXIwMTAiIHN0cnVjdHVyZSwNCj4+IGFuZCBtb3JlIGNvbW1lbnRzIGFyZSBhZGRl
ZCBzbyB0aGUgY29kZSBpcyBtb3JlIHJlYWRibGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGFv
IFJlbiA8dGFvcmVuQGZiLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+ICAgLSAi
Y291bnRfZG93biIgaXMgcmVuYW1lZCB0byAiaXNfYXNwZWVkIiBpbiAiZnR0bXIwMTAiIHN0cnVj
dHVyZS4NCj4+ICAgLSBtb3JlIGNvbW1lbnRzIGFyZSBhZGRlZCB0byBtYWtlIHRoZSBjb2RlIG1v
cmUgcmVhZGFibGUuDQo+PiAgICANCj4gICAgUmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxp
bnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBMaW51cy4N
Cg0KDQotIFRhbyBSZW4NCg0K
