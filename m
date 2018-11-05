Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26391C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C040C2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XFxgBwGb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KuecZYmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C040C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbeKFEGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:06:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387747AbeKFEGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:06:06 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5IgAGO029346;
        Mon, 5 Nov 2018 10:44:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=L4YrrrFegHnCORVfnROmDMNFWeaEQ4/HGEUebOSoCYo=;
 b=XFxgBwGbxvaNU0j/1Bs5xD9EViOfCMf5BIv4FOoQ80CFx15ION09UL7CzEowqFZXRAjf
 Q9OZ1psxQc/Dn+aCxzBCK2edlSpzp/SVjMi1srLd2LeHiGEDI988QIByY3nQneNKnDLf
 MdDYAfMweaw1fhO9mE9bYEd8huMXxCEFDik= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2njstb8h24-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 10:44:41 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 5 Nov 2018 10:43:46 -0800
Received: from PRN-CHUB07.TheFacebook.com (2620:10d:c081:35::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 5 Nov 2018 10:43:46 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 5 Nov 2018 10:43:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4YrrrFegHnCORVfnROmDMNFWeaEQ4/HGEUebOSoCYo=;
 b=KuecZYmj0BHzbdTlU90bjcr4TBjrqN+zCbZe4w1EzT+7cklfPIj5ge73hBlweBTQEYY5PbX0Sh9yuqQY64ixlsm8TPUZf4bmvSLqJHiqTU0suU3m0bMIdiFzjaM43aNQ1tIajMxauLgngaHXcMo5huubiFN4CHRx6PqHJEOwvXs=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1950.namprd15.prod.outlook.com (10.175.8.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 18:43:43 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:43:43 +0000
From:   Tao Ren <taoren@fb.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUW2On9LNQ+pmvkkW+1bSF6wxqO6UUS5aAgCzmeQA=
Date:   Mon, 5 Nov 2018 18:43:43 +0000
Message-ID: <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
In-Reply-To: <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:200::6:40e9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1950;20:Ev2hoLxemri3k+BoeqIXhSPOYb71vSkLujpd2YmGYHn4DvVQv3X7hkK3Tp57pbeoLFZybdGyWkFvjt3CTUsl/OzxQSfq+OZ2kyK4eOoQoD4Cw8bJ7rJsMNW0kDJqMSyUBKx5LiUmfAxDRrWwS9SatpGODqVcyXwJNdYJwgKVw34=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c7f8f89b-0df8-4842-8367-08d6434e9cf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1950;
x-ms-traffictypediagnostic: MWHPR15MB1950:
x-microsoft-antispam-prvs: <MWHPR15MB1950F744801DBC7EA97326F4B2CA0@MWHPR15MB1950.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1950;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1950;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(186003)(110136005)(54906003)(102836004)(316002)(58126008)(76176011)(71200400001)(71190400001)(36756003)(97736004)(2900100001)(5660300001)(2906002)(33656002)(68736007)(82746002)(83716004)(53546011)(6506007)(39060400002)(53936002)(6246003)(8676002)(81156014)(81166006)(7736002)(6512007)(106356001)(256004)(105586002)(14444005)(99286004)(8936002)(6436002)(305945005)(86362001)(4326008)(446003)(11346002)(476003)(2616005)(6116002)(25786009)(478600001)(46003)(6486002)(486006)(14454004)(229853002)(3714002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1950;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RQjWtWwFwyTlLP3TXKHp1+pa1eVLGjJTxFqqmS9ILzbbo1KD7ZrtJJ8Ra2oviRUXKethehWRrROeVEGJHaNqPIXMmDL841Y2C3We6Zyq5InKWuGHc9CSGKXeCD6kPWBgwQMhjiezE8NoUuN8Vq8bcz61rnaLs4H5YGMWpbeRIhIH93KMAFDoguTSTRv8D1I0w+HRNoGaqOs4EGBrUXs8fJ7ViPCMQQH2ULWKwx8y+H4zDNmnEzKa3J5DO/oOVrT9mGIVyfRY4stTC+1MaxEV0NSeYKL8ycUBCt6EAHG5BqLDa4cCgLdrXrgHHg9qtsXdXf+L8MOVUtruIYFp8NuNxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8805CB55D5B00741954B71CFD37EBCCC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f8f89b-0df8-4842-8367-08d6434e9cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:43:43.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNy8xOCwgMjowMyBQTSwgIkxpbnVzIFdhbGxlaWoiIDxsaW51cy53YWxsZWlqQGxpbmFy
by5vcmc+IHdyb3RlOg0KPg0KPiBPbiBXZWQsIE9jdCAzLCAyMDE4IGF0IDExOjU0IFBNIFRhbyBS
ZW4gPHRhb3JlbkBmYi5jb20+IHdyb3RlOg0KPg0KPj4gVElNRVJfSU5UUl9NQVNLIHJlZ2lzdGVy
IChCYXNlIEFkZHJlc3Mgb2YgVGltZXIgKyAweDM4KSBpcyBub3QgZGVzaWduZWQNCj4+IGZvciBt
YXNraW5nIGludGVycnVwdHMgb24gYXN0MjUwMCBjaGlwcywgYW5kIGl0J3Mgbm90IGV2ZW4gbGlz
dGVkIGluDQo+PiBhc3QyNDAwIGRhdGFzaGVldCwgc28gaXQncyBub3Qgc2FmZSB0byBhY2Nlc3Mg
VElNRVJfSU5UUl9NQVNLIG9uIGFzcGVlZA0KPj4gY2hpcHMuDQo+Pg0KPj4gU2ltaWxhcmx5LCBU
SU1FUl9JTlRSX1NUQVRFIHJlZ2lzdGVyIChCYXNlIEFkZHJlc3Mgb2YgVGltZXIgKyAweDM0KSBp
cw0KPj4gbm90IGludGVycnVwdCBzdGF0dXMgcmVnaXN0ZXIgb24gYXN0MjQwMCBhbmQgYXN0MjUw
MCBjaGlwcy4gQWx0aG91Z2gNCj4+IHRoZXJlIGlzIG5vIHNpZGUgZWZmZWN0IHRvIHJlc2V0IHRo
ZSByZWdpc3RlciBpbiBmdHRtcjAxMF9jb21tb25faW5pdCgpLA0KPj4gaXQncyBqdXN0IG1pc2xl
YWRpbmcgdG8gZG8gc28uDQo+Pg0KPj4gQmVzaWRlcywgImNvdW50X2Rvd24iIGlzIHJlbmFtZWQg
dG8gImlzX2FzcGVlZCIgaW4gImZ0dG1yMDEwIiBzdHJ1Y3R1cmUsDQo+PiBhbmQgbW9yZSBjb21t
ZW50cyBhcmUgYWRkZWQgc28gdGhlIGNvZGUgaXMgbW9yZSByZWFkYmxlLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFRhbyBSZW4gPHRhb3JlbkBmYi5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4g
djI6DQo+PiAgIC0gImNvdW50X2Rvd24iIGlzIHJlbmFtZWQgdG8gImlzX2FzcGVlZCIgaW4gImZ0
dG1yMDEwIiBzdHJ1Y3R1cmUuDQo+PiAgIC0gbW9yZSBjb21tZW50cyBhcmUgYWRkZWQgdG8gbWFr
ZSB0aGUgY29kZSBtb3JlIHJlYWRhYmxlLg0KPiAgDQo+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxs
ZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQoNCkhpIERhbmllbCAvIFRob21hcywNCg0K
QW55IGZ1cnRoZXIgY29tbWVudHMgb24gdGhlIHBhdGNoPyBPciBpcyB0aGVyZSBhbnl0aGluZyBu
ZWVkZWQgZnJvbSBteSBzaWRlPw0KDQpUaGFua3MsDQpUYW8gUmVuDQogDQoNCg==
