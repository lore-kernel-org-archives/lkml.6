Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC3ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913F621477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k7ckV/VM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Th5+D1nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913F621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbeIVABk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:01:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43252 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389545AbeIVABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:01:39 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LI8iqC024381;
        Fri, 21 Sep 2018 11:11:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5nbTtdcnVY5kGretonaj3CYR+eYge/HJvWL9jv5r/IY=;
 b=k7ckV/VMyVSey/5iP70XjSpHVZJFMb8xbXYcKrhHc7H0UiyHtEoSX2KXexaIIMjSi//1
 84fw2pEtGNGjGft1AKUbZ9no4zOSvEGZNXtGuvcv3bJxno6zrNEMjRfjZwqp99TjeWAq
 eLKQ+vcen/Vwgo/yv07deHbHTOBgYVAdRMA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn5e5g215-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:11:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 11:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nbTtdcnVY5kGretonaj3CYR+eYge/HJvWL9jv5r/IY=;
 b=Th5+D1nFzGTDOs7N0XO9lLo5Cl2hB+TAAwZC9MizKTB7qOn21liST7bhHU9iFUA3xjDVR1+99Yt7Al/jFiwThtVMo3GfOFo5FiLTAvzO89yVCdNbUjJxNKEtCNIGIsSlFMbUJgFByu+dj4jmjO139a6qYi7AvPKsI2aMKvcNLYw=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1725.namprd15.prod.outlook.com (10.174.254.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Fri, 21 Sep 2018 18:11:19 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::65d8:2dfe:e7cf:8a9c%12]) with mapi id 15.20.1143.017; Fri, 21 Sep
 2018 18:11:19 +0000
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
Thread-Index: AQHUUGYZopGOJgtP6kqMuhqvXVxY+KT5UT6A///lFQCAAOBzAIAAfbSA
Date:   Fri, 21 Sep 2018 18:11:17 +0000
Message-ID: <E3FA56EF-0B3C-4DBE-9A63-428EB342887D@fb.com>
References: <20180919221331.2511558-1-taoren@fb.com>
 <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com>
 <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
In-Reply-To: <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.e.1.180613
x-originating-ip: [2620:10d:c090:200::6:ffc5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1725;20:MXvXwWDxuolPdKzNO0QTp1ez3mZuYR8kLeaUwET8XNW8AxrF3toZ2nvSltBs7ogKubIldkG9DgIlSc7RRR3cpLWGvDgQmM5AznudMCcM80fv3e/2Bw24M/n11A5ye5bjYqKVMuIeNSJ53eGOTBL7+1n19V6pPv60chSr4OjqE1Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(68736007)(81156014)(256004)(33656002)(305945005)(106356001)(46003)(99286004)(86362001)(105586002)(25786009)(6436002)(8936002)(81166006)(6486002)(36756003)(102836004)(6506007)(186003)(478600001)(53546011)(14454004)(8676002)(229853002)(4326008)(5660300001)(11346002)(7736002)(54906003)(316002)(446003)(5250100002)(93886005)(58126008)(82746002)(2900100001)(6512007)(6246003)(486006)(6916009)(97736004)(53936002)(6116002)(2616005)(2906002)(76176011)(476003)(71200400001)(71190400001)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1725;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: df27b0a8-bcfb-4200-3506-08d61feda147
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1725;
x-ms-traffictypediagnostic: MWHPR15MB1725:
x-microsoft-antispam-prvs: <MWHPR15MB172568AEFAD83763516DD804B2120@MWHPR15MB1725.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:MWHPR15MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1725;
x-forefront-prvs: 0802ADD973
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WS056j/edO5kylcT5FRsrY/Bzja3FDs0lJASfCL+s49pQGp4r9bBS7eAPqAKjsKS0rsKTOMY//8mm2UrMdfLwVBnxaUoTx/92AOG4LIWG3VFyeS9z9JFA0YRPA+kiscw0WzHo8gDNuXTPN+vb5eNW/QB/7a8289Ra1LCsp6EC1PmQnPhFzkJSczqgUe937xIHXRp9cymXiJmF2OStyL54qurZdjIreMmc4hThxhROoPBoeWQjSZUoFZ6gloSmFy5VV9vBd7bIaZyxau5+/JMiwcKcbuX5JSh1jb1+RIRiKEkqTxMKbAVrA6oAlhoJ4heBhCr9ORxABlXLLogLHbmc9cshqqCZFGEYZ2ReVq1Ez4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0BD3D83D72A704DBCE7F02D33BCBA01@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: df27b0a8-bcfb-4200-3506-08d61feda147
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 18:11:17.5328
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

T24gOS8yMC8xOCwgODozMyBQTSwgIkpvZWwgU3RhbmxleSIgPGpvZWxAam1zLmlkLmF1PiB3cm90
ZToNCg0KPiBJIGdhdmUgdGhpcyBhIHNwaW4gb24gdGhlIGFzdDI0MDAuIEl0IGxvb2tlZCBva2F5
LCBidXQgSSB3YXMgd29uZGVyaW5nDQo+IGlmIHlvdSBjb3VsZCBzaGFyZSB5b3UgdGVzdCBjYXNl
IHNvIEkgY2FuIHJ1biB0aGUgc2FtZSB0ZXN0Pw0KDQpUaGFuayB5b3UgSm9lbCBmb3IgdGhlIHRl
c3RpbmcuDQpTdXJlIEkgY2FuIHNoYXJlIHRoZSB0ZXN0IChhIHNtYWxsIGMgcHJvZ3JhbSB3aGlj
aCBtZWFzdXJlcyBkZWxheSBpbnRyb2R1Y2VkIGJ5IG5hbm9zbGVlcCgpKSwgYnV0IHdoYXQgd291
bGQgYmUgdGhlIHByZWZlcnJlZCB3YXkgdG8gc2hhcmUgaXQ/IExpa2UgYSBmb3JtYXQtcGF0Y2g/
IE9yIG1heWJlIEkgc2hvdWxkIHJlZmluZSB0aGUgdGVzdCBhbmQgc2VuZCB0byBvcGVuYm1jIGZv
ciByZXZpZXc/DQoNCg0KVGhhbmtzLA0KVGFvIFJlbg0KDQo=
