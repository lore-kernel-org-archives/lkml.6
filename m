Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11716C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18A6208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MGv8/QuW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="i9bM3RPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18A6208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIYGpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:45:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeIYGpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:45:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8P0bZvm014457;
        Mon, 24 Sep 2018 17:40:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Eo2HCetRgZSzbPEY1wIYA3TCM4v9elZZZkJ+Wlt05DM=;
 b=MGv8/QuWhqg6poJuAGHRKbyXb+gFytfMven4XTN2tjfKP82XQREJRTD9pZhRVleZiIVL
 xZ1rCBl4wHckwOKlwDeGLZYtZzM2pX7KzWUGYV6xErokq4IcMVLiwLof0l0PHDBfKROB
 f9e7CAxXSD4uLJPvzfrpKklxvb4ID+rvtPE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqahdg0n8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Sep 2018 17:40:08 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 24 Sep 2018 20:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo2HCetRgZSzbPEY1wIYA3TCM4v9elZZZkJ+Wlt05DM=;
 b=i9bM3RPNwVPyUI/3d2wM7s3uFjDnVbZbT1ln0Z3eDDYstYTFJPLJTkVtNt5NQCcHnfzQrUXa1R8CaHD0qrgmWgq4Wjby9Te4jDV87pEKpHUIBvAojOcRSvC3i3jCwGQJkUL8ieXalHhXBPUFxZAcQygFyULc91zUn+AGklKSH3M=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1405.namprd15.prod.outlook.com (10.173.234.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 00:40:05 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c%12]) with mapi id 15.20.1143.019; Tue, 25 Sep
 2018 00:40:04 +0000
From:   Tao Ren <taoren@fb.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Christopher Covington <cov@fb.com>, Tian Fang <tfang@fb.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Index: AQHUUGYZopGOJgtP6kqMuhqvXVxY+KT5UT6A///lFQCAAOBzAIAAfbSAgAWFAYD//6D2AA==
Date:   Tue, 25 Sep 2018 00:40:04 +0000
Message-ID: <B4F1CA67-8404-416D-ABA9-FCA69B7FD771@fb.com>
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
user-agent: Microsoft-MacOutlook/10.e.1.180613
x-originating-ip: [2620:10d:c090:200::7:c831]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1405;20:cQTfp/iUvCwhxyk49G7Dx76qFWlXKbOrUSx6eWbmmHF99SGNy2kS/u9vjOVgE5Jnty6/RFP/wp+7FJ7F5NwIMfz3eacFW9ykXDPlYdGo0zDyqQnEvrPS4H2WKPN7JWEY3nP4EAUtkR9q7aGgvQIatG9G0Wy+G4+3vP/frND6j9g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(14454004)(478600001)(102836004)(81156014)(6512007)(81166006)(6246003)(5250100002)(97736004)(11346002)(6506007)(76176011)(256004)(2900100001)(486006)(476003)(86362001)(83716004)(446003)(36756003)(186003)(53546011)(46003)(8676002)(229853002)(316002)(106356001)(305945005)(6916009)(5660300001)(7736002)(6436002)(53936002)(93886005)(2906002)(2616005)(58126008)(4326008)(82746002)(33656002)(105586002)(6116002)(25786009)(68736007)(8936002)(558084003)(71200400001)(6486002)(54906003)(99286004)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1405;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 4c564be6-b573-44ef-c577-08d6227f6f6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1405;
x-ms-traffictypediagnostic: MWHPR15MB1405:
x-microsoft-antispam-prvs: <MWHPR15MB14054FE498EA1C252F3F952FB2160@MWHPR15MB1405.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:MWHPR15MB1405;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1405;
x-forefront-prvs: 08062C429B
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S/EiKs9wzLzMpEO4ZPxmQq88xIeC/3IvlRETkGchhjZ1dL1ddd1mePW0dpb0Gptw0Dp9X9CS3iTbbmJdi1GsAr7a5u3PF4Pd8Oo+M9rFx02MFbpluCE5bYquM/4usGFuAgK9gJ4gdbyMX1ku5k7rNF+TXWxw5g486rbfdWtIn1O2aQ8aQGMOStbHCijS89B1qvYNxkDfYTqqwF2riSDcir2MMdOlXMuTa/ugIW/NSL3U919JTuRPwbuQeBbFc+UqlLEAtCHOJbvISubaPJ0ZuDoP/QTiUZHoTm9zzOk5PgoUQc3FZTzNNoK3yldiuS8gk7dLxLJhaGseD9/xbaMhBEn1eRAYrSdiv/7Rt1JA420=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D817CCB87169AF46BDF22ACAE9D45C6E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c564be6-b573-44ef-c577-08d6227f6f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 00:40:04.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNC8xOCwgNDoyMCBQTSwgIkpvZWwgU3RhbmxleSIgPGpvZWxAam1zLmlkLmF1PiB3cm90
ZToNCg0KPiBXaGF0ZXZlciBtZXRob2QgaXMgZWFzaWVzdCBmb3IgeW91LiBBIHBhdGNoIGZpbGUg
b3IgYSB0YXJiYWxsIGlzIGZpbmUuDQo+IEkgd2lsbCB0aGVuIGFkZCBpdCB0byB0aGUgc2V0IG9m
IHRlc3RzIEkgcnVuIHdoZW4gdGVzdGluZyBhc3BlZWQNCj4ga2VybmVscy4NCg0KTm8gcHJvYmxl
bSwgSm9lbC4gSSB3aWxsIHNoYXJlIHRoZSB0ZXN0IGNvZGUgd2l0aCB5b3Ugb2ZmbGluZS4NCg0K
DQpUaGFua3MsDQpUYW8gUmVuDQoNCg0K
