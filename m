Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD591ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C2921477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CsjcEkpO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cjmq50Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C2921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbeIVABk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:01:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43254 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390180AbeIVABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:01:39 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LI8iqB024381;
        Fri, 21 Sep 2018 11:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Zj5CiHThsVkmX/0oR8TSf7mAicLUayJgRSkMFigYYRk=;
 b=CsjcEkpOibG7cS7H8aM+MFthjAHz4/m+MP788w37rKUriL7vpp9oDIP8Y0dZn8IZvimJ
 3EwL31Bly0pkNT1NLRUCBTvb9vs2zKTGlzdDDPHDMY1PAJwP1u9Np+NM/89SfrwkhJyk
 T7ooi1bwtGozIsy8MaFPvyozTqK25TOLqAQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn5e5g215-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:11:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 11:11:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj5CiHThsVkmX/0oR8TSf7mAicLUayJgRSkMFigYYRk=;
 b=cjmq50LbxauFyDQTuOrpu/GaZy+YouwTHXuBROj5c2NEF33q9jwiUjwHHTvRV5eVvTuBu6KanIgELUe6yP+2cZsKswJmhItaclc0fOpYQdQG2rA28nSjUbAx/b6aQ6Ndx+bN+fyroAVaE5PZrqdWDsvP88TjBZ2vqhd/RE5psTU=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1725.namprd15.prod.outlook.com (10.174.254.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Fri, 21 Sep 2018 18:11:18 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c%12]) with mapi id 15.20.1143.017; Fri, 21 Sep
 2018 18:11:16 +0000
From:   Tao Ren <taoren@fb.com>
To:     Lei YU <mine260309@gmail.com>, Joel Stanley <joel@jms.id.au>
CC:     Christopher Covington <cov@fb.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
Thread-Index: AQHUUGYZopGOJgtP6kqMuhqvXVxY+KT5UT6A///lFQCAAOBzAIAALz2AgABO5YA=
Date:   Fri, 21 Sep 2018 18:11:16 +0000
Message-ID: <11647FAC-EF61-43F5-BBED-567AADA1D2C2@fb.com>
References: <20180919221331.2511558-1-taoren@fb.com>
 <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com>
 <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
 <CAARXrtmpUn3DKguiQSubZvCM3sJ--QxtzoYVoEvC-81udH7BLA@mail.gmail.com>
In-Reply-To: <CAARXrtmpUn3DKguiQSubZvCM3sJ--QxtzoYVoEvC-81udH7BLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.e.1.180613
x-originating-ip: [2620:10d:c090:200::6:ffc5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1725;20:Xkj7bjJxbFN2cimJ+7HTbta1g/P0jjZhgV7dRvm5jAlFcZp9gj9WkkBufY9+tQDa3Z/wlR7ckhQIztakkmH0TA27vPEJE89r+YiCPjT5cFMy3dqIr6SCnIYdHBJLPDjWmD1e3+p+GhZ5bL7/B1J9K4+oprm0pulL9UJlUPFehSw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(68736007)(81156014)(256004)(33656002)(305945005)(106356001)(46003)(99286004)(86362001)(105586002)(25786009)(6436002)(8936002)(81166006)(6486002)(36756003)(102836004)(6506007)(186003)(478600001)(53546011)(14454004)(8676002)(229853002)(110136005)(4326008)(5660300001)(11346002)(7736002)(54906003)(316002)(446003)(5250100002)(93886005)(58126008)(82746002)(2900100001)(6512007)(6246003)(486006)(97736004)(53936002)(39060400002)(6116002)(2616005)(2906002)(76176011)(476003)(71200400001)(71190400001)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1725;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 77f5a86f-868c-4e4a-e63b-08d61fed9fdd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1725;
x-ms-traffictypediagnostic: MWHPR15MB1725:
x-microsoft-antispam-prvs: <MWHPR15MB1725ACBF8FC6A63FF73CC79EB2120@MWHPR15MB1725.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:MWHPR15MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1725;
x-forefront-prvs: 0802ADD973
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VS/NEwZLNdntHuwtPytNis8c9ksgBWR2uVsMLHA8SGUDlLG4vyHEyCaR2Yv516Ft4Z61JDmSaqUb9wVCcm1eFSBdrTS0Z2MmIrXUqp7SfxCnOWiC5x+YdcIAz0zFuoMHlFglPRhUIe7yv/OVGj/sFOcFBVXkz42iaavX8D6QC+ZK0vIWOh5nJETgOsfU+Yi0izzmyvjpImoG03pCCeKy5FWN9i87uXwpW65w4ng0upG/5qeYCmSMqR3hJeUpl23X0TrUyaKGuzZgRYsGRC+U4wIMSBZueFKoDkwSLlValwlXmnGYZx369Ef3t1xvgPs2tpt7Fx0yMd3zieFm5oXNaDUv0qNJTBTH2eqeHjdedLo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <076479100D4B994ABF1D1B704762DB9B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f5a86f-868c-4e4a-e63b-08d61fed9fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 18:11:16.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMC8xOCwgMTE6MjIgUE0sICJMZWkgWVUiIDxtaW5lMjYwMzA5QGdtYWlsLmNvbT4gd3Jv
dGU6DQoNCj4gVGVzdGVkIG9uIFBhbG1ldHRvIChPcGVuUE9XRVIgUDggd2l0aCBBU1QyNDAwKSwg
YW5kIGl0IGRvZXMgc2hvdyB0aGUgZml4IGlzDQo+IHdvcmtpbmcgb24gQVNUMjQwMCBhcyB3ZWxs
Lg0KPiBXaXRob3V0IHRoZSBwYXRjaCwgdXNsZWVwKDEwMCkgdGFrZXMgdGVucyBvZiBtaWxsaXNl
Y29uZHMgcmFuZG9tbHk7DQo+IFdpdGggdGhlIHBhdGNoLCB1c2xlZXAoMTAwKSB0YWtlcyBhYm91
dCA2MDB+NzAwIG1pY3Jvc2Vjb25kcyBzdGFibHkuIA0KPg0KPiBUZXN0ZWQtYnk6IExlaSBZVSA8
bWluZTI2MDMwOUBnbWFpbC5jb20+DQoNClRoYW5rIHlvdSBMZWkgZm9yIHRoZSB0ZXN0aW5nIQ0K
DQoNClRoYW5rcywNClRhbyBSZW4NCiAgICANCg0K
