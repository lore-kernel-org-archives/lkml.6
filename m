Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07892C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905C220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JNosOGrK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q+Qs+A5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905C220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIYXVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:21:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbeIYXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:21:54 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PH2dSJ024478;
        Tue, 25 Sep 2018 10:13:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XFi/JUnttEZJ0FpXo7SfFxWSRQftaVSxvBVgPIbt1i0=;
 b=JNosOGrKYfmpnpHDNjb19kNELvP9EtcTd0dOvZ/qgVqvlIbkZQBB3BjOAZWSrloxUpM/
 yifauftEFcIcM2L2Hrpd3jr9ApGXxdaI6OcGFH0pA9g2sslykg/1eF5XNa6vtYttJr3I
 oxoif0gWhyl8wT+uvnS7Zp4y5NCSlJqNO84= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mqptvgttb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 10:13:05 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFi/JUnttEZJ0FpXo7SfFxWSRQftaVSxvBVgPIbt1i0=;
 b=Q+Qs+A5sgCwH9AQ5Hj1iiAmbmvdRKjQP64PrpD32oputJ9hmt+9rw0L0DlguKmDsXAA07xtWgM1xrudZ9lwo2ZogAv3BEpGnTc8Sx10oBrh3ULNfJHLYuZvm7KS1ISQDyX1VvgWvbqgJlyC70q/+2D7ubE3WUStHpzzT7pmheA0=
Received: from MWHPR15MB1789.namprd15.prod.outlook.com (10.174.255.18) by
 MWHPR15MB1565.namprd15.prod.outlook.com (10.173.235.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Tue, 25 Sep 2018 17:13:02 +0000
Received: from MWHPR15MB1789.namprd15.prod.outlook.com
 ([fe80::853e:9e1f:97d1:71d6]) by MWHPR15MB1789.namprd15.prod.outlook.com
 ([fe80::853e:9e1f:97d1:71d6%7]) with mapi id 15.20.1143.019; Tue, 25 Sep 2018
 17:13:01 +0000
From:   Sai Dasari <sdasari@fb.com>
To:     Joel Stanley <joel@jms.id.au>, Tao Ren <taoren@fb.com>
CC:     Christopher Covington <cov@fb.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Index: AQHUUPk9lMrOh6dmWESJime7JMZLB6T5qoUAgABrGgCAAPVpgIAFDU2AgAC2ZQA=
Date:   Tue, 25 Sep 2018 17:13:01 +0000
Message-ID: <571BD9E6-5A5B-4B66-AFAB-EC4E97B0A0D7@fb.com>
References: <20180919221331.2511558-1-taoren@fb.com>
 <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com>
 <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
 <E3FA56EF-0B3C-4DBE-9A63-428EB342887D@fb.com>
 <CACPK8Xd03w51FM8iJsFNhWkpRFMhy97XZpxOhbRwbD3ytQcRbg@mail.gmail.com>
In-Reply-To: <CACPK8Xd03w51FM8iJsFNhWkpRFMhy97XZpxOhbRwbD3ytQcRbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:4c5b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1565;20:iiSyHbuuYfWY2P7+7PUvF/oU0PCm2L73l3+V6B04UKnh49a+wF6VGUX4o0BIfXcMWvkZaL5i7WJKO9cOWJHjyWK1kFTqaXxmHs/I5iNMM1VEMp2a8W12O5K+87EMeeD7GrFqIUNflQJmNCECuzCgNHAywS77ueBECoKN0IgPOss=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(6512007)(81166006)(256004)(6486002)(102836004)(316002)(2616005)(86362001)(229853002)(2906002)(53936002)(6116002)(186003)(54906003)(106356001)(81156014)(8936002)(76176011)(34290500001)(7736002)(82746002)(110136005)(71190400001)(446003)(5660300001)(2900100001)(6246003)(36756003)(478600001)(33656002)(14454004)(11346002)(476003)(8676002)(97736004)(46003)(4326008)(105586002)(486006)(25786009)(6636002)(5250100002)(68736007)(99286004)(305945005)(71200400001)(6436002)(6506007)(93886005)(558084003)(83716004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1565;H:MWHPR15MB1789.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c3f28f99-b71b-4c6f-8bcc-08d6230a2603
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1565;
x-ms-traffictypediagnostic: MWHPR15MB1565:
x-microsoft-antispam-prvs: <MWHPR15MB156592C17E073369F88BB107CE160@MWHPR15MB1565.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(65623756079841);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR15MB1565;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1565;
x-forefront-prvs: 08062C429B
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pg3ej51hjE0NeF1DrOrHJ7OnGS8h3/BeT3c0PmWPjDaCoZqc0VNvLHX6WRw6R7RCznlU5hH7RvTxq1urgKNmk4wwtXMx7EGIEmhFa1hM1Xo9RD7QuQ1ShhBu5Wm5OsBdQmx3SA2/LVmTQUgB5mEoN5fQHCX3wqlUJ6Pvd8hApK2x2FkS6x9Oh97rMhVaKrNEQSxxMzPjn7Oto7RCOUv4g+CWqYOrP2oWRgk2jM36ouJUuxMOVlxTSEAO1qJXUHMt8Sp5ySZts5seXVQI3HMDANMUcJPJ1zX7KNBOZX9vvAoJRVKc4pr+ysyxQmDTuzqD8wzrFn0ToTjPg0HYf9kGneoayLy2qTzuQqS+HVLvq4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD8FC3E1EA59764BA894BDCD6440B8DA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f28f99-b71b-4c6f-8bcc-08d6230a2603
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 17:13:01.2174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrvu79PbiA5LzI0LzE4LCA0OjIxIFBNLCAib3BlbmJtYyBvbiBiZWhhbGYgb2YgSm9lbCBTdGFu
bGV5IiA8b3BlbmJtYy1ib3VuY2VzK3NkYXNhcmk9ZmIuY29tQGxpc3RzLm96bGFicy5vcmcgb24g
YmVoYWxmIG9mIGpvZWxAam1zLmlkLmF1PiB3cm90ZToNCg0KICAgIEkgd2lsbCB0aGVuIGFkZCBp
dCB0byB0aGUgc2V0IG9mIHRlc3RzIEkgcnVuIHdoZW4gdGVzdGluZyBhc3BlZWQNCiAgICBrZXJu
ZWxzLg0KICAgIA0KVGhhbmtzIEpvZWwhIEN1cmlvdXMgdG8ga25vdyB3aGF0IHdvdWxkIGJlIHRo
ZSBiZXN0IHBsYWNlIHRvIGtlZXAgdGhlc2Uga2luZCBvZiBLZXJuZWwgdGVzdCBjYXNlcyBmb3Ig
c2FrZSBvZiByZXZpZXcgYW5kL29yIGFkZGluZyBuZXcgdGVzdCBjYXNlcyBhcyBuZWVkZWQuICAg
ICANCg0K
