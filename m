Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA74C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC4020684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JiuHIKmf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hf+TzPQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC4020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJDD4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:56:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbeJDD4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:56:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93Kxf8P006390;
        Wed, 3 Oct 2018 14:05:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TAmCjwOi/EAEwGceb0pQ/6w5ErFkxLFguzQlZTV0L0A=;
 b=JiuHIKmfE0oiunkN2RKPA2LfBD9iJPgyYoE/FJQoJsuOBdfdHhIahGQsRmz80lUDb0ZC
 DNGwcRl1A88N2OdlwjyUM2TKon5IuBPhHSNWM5L2UDGwFl2ujKEezxN1PqfJuOSGj8Fa
 iGpo9ctoJ2N08BthdEg7yJVSsTPdoc3dppM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mw4wcr3md-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Oct 2018 14:05:46 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 3 Oct 2018 17:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAmCjwOi/EAEwGceb0pQ/6w5ErFkxLFguzQlZTV0L0A=;
 b=hf+TzPQRUQ8857FaRxtw55tk4p1SdouBHwxWJTh2Hdlu5sDybmUiPplGdH22N9Hh/D6xiXWlYD9NYz5MfcFj+d7klroc8TJq5JKq79IjyM+pFl15zix1hG0tdl2irNGUwH/nYnSkXV0Y8RiPv98cPfUUFBXLHSZmGmiXKnpq9Wk=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1792.namprd15.prod.outlook.com (10.174.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Wed, 3 Oct 2018 21:05:09 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::ccb:6fd9:cf17:bfcd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::ccb:6fd9:cf17:bfcd%9]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 21:05:09 +0000
From:   Tao Ren <taoren@fb.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUWgaCT67ZXjOUCkyaVb8BmGGbFqULkM4AgADz4QCAAJPLgP//mGCAgADELoCAABsYgA==
Date:   Wed, 3 Oct 2018 21:05:08 +0000
Message-ID: <0FD6C848-4F06-43EF-9FAD-EA2AEE05C606@fb.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
 <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
 <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
 <6e7703e4-461b-77bf-5c9d-cc9e91c5ef3d@linaro.org>
In-Reply-To: <6e7703e4-461b-77bf-5c9d-cc9e91c5ef3d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:180::1:d978]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1792;20:TUpvVIdQBvD5JbT3gAt1n9f3RO/HrSBOB+X/nWb4RpnqBH+M1oYsxkr6gR+4r7ESylPO4XV7VskuZT99OAR0hfMwrDLSIAB24qsNK5u0IO/HJ4szUzmT5wAPY729QabKMwXY4vKTfchwFLPsl9xGKAAvCe9fPhvoWwYlUGFSkQs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f67bc6b8-4ce4-43ce-200a-08d62973e6d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1792;
x-ms-traffictypediagnostic: MWHPR15MB1792:
x-microsoft-antispam-prvs: <MWHPR15MB179262A85A5047849580D92AB2E90@MWHPR15MB1792.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:MWHPR15MB1792;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1792;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(99286004)(186003)(5250100002)(256004)(6246003)(97736004)(25786009)(4326008)(2906002)(39060400002)(83716004)(71200400001)(71190400001)(486006)(76176011)(2616005)(11346002)(86362001)(102836004)(53546011)(6506007)(46003)(2900100001)(82746002)(476003)(446003)(81166006)(8936002)(33656002)(81156014)(478600001)(110136005)(106356001)(8676002)(5660300001)(105586002)(54906003)(58126008)(14454004)(6486002)(6436002)(316002)(6512007)(53936002)(36756003)(229853002)(6116002)(93886005)(305945005)(68736007)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1792;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8K/kO240n7aG/d7825DpqpKRDXOwwv2kqw17r7CZvZvHIlIfA2S5Y5sqETevoc6AaiEHBnY5l4YvhvJPWsh9Ca7fdOl+bZNus5AvJSbFcZQPNntNMHeXHFJYemI5PF533a/wTJhEvjLf29rc60+81S5WzPRJZ8ckoqRyVnHkOfTG3VCs8e9Z0V5RxrwXSdJuNEFfJgUmCE1EJukWpIFpQ6GAPkg7txvEcRWWE+DTwzO/HI/RsUnlZejIinXot52JaF+FXztZTIvFpOb5AMDKQWCW+oSPkDKhttnEkmR025zjUO5Lh/UPqhAWo+bnhFJ8hHPlqot6pUm5ejlO4V669wQpachWdi3nV6A74LolgXY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5301DB68BE3B3C4FB5DB90476CDDC300@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f67bc6b8-4ce4-43ce-200a-08d62973e6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 21:05:08.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1792
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMy8xOCwgNToyOCBBTSwgIkRhbmllbCBMZXpjYW5vIiA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4gd3JvdGU6DQoNCj4gdGhlIGJyYW5jaCB0aXA6dGltZXJzL3VyZ2VudCB3aWxsIGJl
IG1lcmdlZCBpbiB0aXA6L3RpbWVycy9jb3JlLCBzbyB0aGUgZml4ZXMgd2lsbCBiZSBwcm9wYWdh
dGVkIHRvIHRoZSBtYXN0ZXIgYnJhbmNoLg0KPiBCYXNlIHlvdXIgY2hhbmdlIGluIHRvcCBvZiB0
aXA6dGltZXJzL3VyZ2VudCwgdGhlIG1lcmdlIHdpbGwgaGFwcGVuIHNvb24gYW5kIGJvdGggZml4
ZXMgd2lsbCBlbmQgdXAgaW4gdGlwOnRpbWVycy9jb3JlLg0KDQpHb3QgaXQuIFRoYW5rIHlvdSBE
YW5pZWwuDQoNCg0KLSBUYW8NCg0K
