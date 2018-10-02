Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B98C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39AD2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Av786DBp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T9v9QT+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39AD2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJCEx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:53:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725744AbeJCEx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:53:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92M5LlH022263;
        Tue, 2 Oct 2018 15:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=N0F77YSB3tWqNIzjaIMYHrVw4AHcseYIoOg0dwmVMOg=;
 b=Av786DBprpTB+A2o35cBkPmmXb4ObVl1CtaS9Q5fvSiOVxorFvOmVatWkwjvx77qctnd
 PtIHn/+UjtNjLJTert6/m07OA6CNWfoJ5gTn2tkLcIIR1M6lJVkERbBniancEYGRJvT3
 XB9n+XxF2f1y54BBfnWa+324cxj178rKQaE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mvdrnrny6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 15:08:10 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 2 Oct 2018 18:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0F77YSB3tWqNIzjaIMYHrVw4AHcseYIoOg0dwmVMOg=;
 b=T9v9QT+vUIzn/gzG/vpmR93lE2IoU1JTBkzb6J4fsH6KKIwX5xQ9CW2Zmflk+3DrWfLZa8g6NHb1D2apYUJ8t+UMglIBvyL8r0I6F3Y1Ta5oU896bGSE3mc8WmIojVtsuAE0SNJeP6CUa0uoNn2c407RhEhzY+dXC+4Fzgt7Pdo=
Received: from DM5PR15MB1211.namprd15.prod.outlook.com (10.173.209.17) by
 DM5PR15MB1884.namprd15.prod.outlook.com (10.174.247.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Tue, 2 Oct 2018 22:08:07 +0000
Received: from DM5PR15MB1211.namprd15.prod.outlook.com
 ([fe80::d9e2:e43d:91e:ed74]) by DM5PR15MB1211.namprd15.prod.outlook.com
 ([fe80::d9e2:e43d:91e:ed74%8]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 22:08:07 +0000
From:   Tao Ren <taoren@fb.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "mine260309@gmail.com" <mine260309@gmail.com>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUWgaCT67ZXjOUCkyaVb8BmGGbFqULkM4AgADz4QA=
Date:   Tue, 2 Oct 2018 22:08:07 +0000
Message-ID: <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
In-Reply-To: <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:3:151::17) To DM5PR15MB1211.namprd15.prod.outlook.com
 (2603:10b6:3:b2::17)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:f49f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1884;20:2SH9x3dQHcbvWgk0zhEoE15PgLjK5gDN56mH4hC9bAkMsJxAUs2fbbY8WBilvv72GDptjzAxdS69Lb5d036C8lW2dUV8MbxWHk4SeyER9Mtgh7i4T2b48wecSfW9dpEpy5y6z3eMsavuHd+0Eqg2SCZqR6b/qtQp+XwmJM5ER9Y=
x-ms-office365-filtering-correlation-id: 0fc6e6c7-9302-4985-a48d-08d628b38840
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1884;
x-ms-traffictypediagnostic: DM5PR15MB1884:
x-microsoft-antispam-prvs: <DM5PR15MB1884039A8C86E64837024DFBB2E80@DM5PR15MB1884.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR15MB1884;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1884;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(6512007)(71190400001)(54906003)(105586002)(8676002)(6246003)(8936002)(316002)(46003)(53936002)(36756003)(65956001)(256004)(65806001)(99286004)(6916009)(14444005)(81166006)(229853002)(81156014)(53546011)(68736007)(4326008)(76176011)(39060400002)(2900100001)(6116002)(65826007)(58126008)(97736004)(386003)(5250100002)(6506007)(31686004)(476003)(5660300001)(186003)(486006)(25786009)(478600001)(102836004)(31696002)(446003)(305945005)(86362001)(7736002)(14454004)(6486002)(2906002)(64126003)(6436002)(106356001)(71200400001)(11346002)(52116002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1884;H:DM5PR15MB1211.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zPMerpQtW9pNyUZAPA+lfQjt35p9dF4yxijDG22cu2XSNj4ca0xcHLYAYBhOy6wHB3KPo4RLyyEMuo/P6avJjF7/5vY/AiJ1tOYNi4JScM1ie4sA8XJ2zoK+ge6YMgONKBm/lZxIALmraCbLVbgIUQUzK+aSGJ5ncw5MQJYlNMy6ZJjra9iCXE7tvNLmCeUy7yVUuelPMOEKOQ0N9P3F7PpRsAk3lRENUPmlTx0WnAvNARztHviT1eidKMf0xDNH2byybQds6IfGDBuC4ye1zxRloqTGyRVhqpZL8blBwtzfKNqGJnpWOaK5YDU869Jrc72TgH9YXjod8xXMs54yTtGlyGWrut850H4iXuOesJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8512ACC435E8974EA812EF4475FB5F3A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc6e6c7-9302-4985-a48d-08d628b38840
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 22:08:07.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1884
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDIvMjAxOCAxMjozNSBBTSwgTGludXMgV2FsbGVpaiB3cm90ZToNCg0KPiBUaGlzIHN0
cnVjdCBtZW1iZXIgImNvdW50X2Rvd24iIGlzIGEgYml0IGJhZGx5IG5hbWVkIG5vdyBkb24ndCB5
b3UgdGhpbms/DQo+IFRoZSBwYXRjaCBpcyBmaW5lIHNlbWFudGljYWxseSwgYnV0IHBsZWFzZSBy
ZW5hbWUgdGhpcyBtZW1iZXIgImlzX2FzcGVlZCIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdCBhbmQg
dXBkYXRlIHRoZSBjb2RlIGV2ZXJ5d2hlcmUsDQoNClRoYW5rIHlvdSBMaW51cyBmb3IgdGhlIHF1
aWNrIHJldmlldy4NCkkgd2FzIGFjdHVhbGx5IHBsYW5uaW5nIGEgY2xlYW51cCBwYXRjaCB3aGlj
aCBoYW5kbGVzIGlzX2FzcGVlZC9jb3VudF9kb3duIHN0dWZmLiBCYXNpY2FsbHkgd2UgaGF2ZSAy
IG9wdGlvbnM6DQrCoMKgwqAgMSkgYWRkaW5nICJpc19hc3BlZWQiIGZsYWcuICJjb3VudF9kb3du
IiBpcyBrZXB0IGJlY2F1c2UgcG90ZW50aWFsbHkgZmFyYWRheS1mdHRtciBjb3VsZCBhbHNvIGJl
IGNvbmZpZ3VyZWQgYXMgY291bnRfZG93biB0aW1lciAoYWx0aG91Z2ggSSBkb24ndCBzZWUgYW55
IHJlYXNvbiB0byBkbyBzbykuDQrCoMKgwqAgMikgcmVuYW1pbmcgImNvdW50X2Rvd24iIHRvICJp
c19hc3BlZWQiLiBCeSBkb2luZyB0aGlzLCB3ZSBzZXQgcmVzdHJpY3Rpb24gdGhhdCBmYXJhZGF5
LWZ0dG1yIHdpbGwgYWx3YXlzIGJlIHVwd2FyZC4NCldoYXQncyB5b3VyIHRob3VnaHQ/IERvIHlv
dSB3YW50IG1lIHRvIGluY2x1ZGUgYWxsIHRoZSBjaGFuZ2VzIGluIHRoaXMgZGlmZj8NCg0KPiB0
aGVuIGluc2VydCBhIGNvbW1lbnRzIGxpa2UNCj4gLyogVGhlIEFzcGVlZCB2YXJpYW50IGNvdW50
cyBkb3dud2FyZCAqLw0KPiAvKiBUaGUgQXNwZWVkIHZhcmlhbnQgZG9lcyBub3QgaGF2ZSBhIG1h
dGNoIGludGVycnVwdCAqLw0KPiBpbiB0aGUgY29kZSBzbmlwcGV0cyBzbyB3ZSBzZWUgd2hhdCBp
cyBnb2luZyBvbi4NCg0KTWFrZSBzZW5zZS4gTGV0IG1lIGFkZCBtb3JlIGNvbW1lbnRzLg0KDQoN
ClRoYW5rcywNClRhbyBSZW4NCg==
