Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F023FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD220684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ebtvWzQB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NDR2AfuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AD220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCOdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:33:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36410 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbeJCOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:33:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w937dCqP028371;
        Wed, 3 Oct 2018 00:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GOwIHlNZF8/nk7wSWp2GRrjg4ylzlYs5vbypb13dNUo=;
 b=ebtvWzQB4PsVQ1VfMZazO79lnZHJxBQOjGQcg7ejhyRBXWB4IaKuG7/e/Bh72jtNM4tI
 nvXOvabqEKjOKAz7+sYJeKFtmCXqRAR7ogGnkghYCaw4vEuRw56MfeSL0frHXXZXsnpY
 Z1efz6Tj8kv69YHnPTORqIP/vqtjy9txWsk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mvpxhrbrp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Oct 2018 00:46:03 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 3 Oct 2018 03:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOwIHlNZF8/nk7wSWp2GRrjg4ylzlYs5vbypb13dNUo=;
 b=NDR2AfuJkCK+s6LmzHwR9dyMER2Ba9tXVy7FVhyZr7sCAiF5bh5QbG0IZiTn7QxMy5FEJAHKwNnEotRghQ/cu8TECQlixDH4aZW4qSBnsgqzWqI0ereN07HAt/PonLFlHSSmA2c4vxY5CmxmoZVj50rLYUnp4HlQjL0+czJyong=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1455.namprd15.prod.outlook.com (10.173.234.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Wed, 3 Oct 2018 07:46:00 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::ccb:6fd9:cf17:bfcd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::ccb:6fd9:cf17:bfcd%9]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 07:46:00 +0000
From:   Tao Ren <taoren@fb.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUWgaCT67ZXjOUCkyaVb8BmGGbFqULkM4AgADz4QCAAJPLgP//mGCA
Date:   Wed, 3 Oct 2018 07:46:00 +0000
Message-ID: <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
 <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
In-Reply-To: <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:180::1:4324]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1455;20:An3T3DKx3Eh2Ac9GCEItQujfiskmxik7t9W+nwPDzKrM/RTTN9OkrAlmgF0Yd5USzqFcXJjhoAbrq9frX6TsLWdoFL0NvBhdf/YAfEPBcnmG2PJEcAwqq4EXQc4sshkcqzblvYCU3/7QZPRv/Ri1pzgyApUobaP4UX9Fi91qzck=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b9afa8da-c0bb-47b2-1317-08d629044328
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1455;
x-ms-traffictypediagnostic: MWHPR15MB1455:
x-microsoft-antispam-prvs: <MWHPR15MB1455028F45B1BC6412917EC8B2E90@MWHPR15MB1455.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:MWHPR15MB1455;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1455;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(76176011)(6246003)(46003)(6512007)(97736004)(8676002)(25786009)(6486002)(476003)(6436002)(11346002)(99286004)(2616005)(81156014)(5660300001)(81166006)(486006)(53936002)(6116002)(54906003)(446003)(39060400002)(53546011)(106356001)(2900100001)(6506007)(105586002)(102836004)(83716004)(6916009)(71190400001)(58126008)(71200400001)(4326008)(478600001)(33656002)(5250100002)(256004)(68736007)(8936002)(7736002)(36756003)(93886005)(2906002)(316002)(86362001)(82746002)(14454004)(186003)(305945005)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1455;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GGh36BUOPYTB23As7GCrC7D13e34ocB6NJRzqlk/DV8hOJKqtxnJNnTlGnx5YvBqceQzL3coN3uu9w0pJ56n7T5fkW7IUAOvnMkatUFyLCFzkCDcIMsbiaS8TzhrxhW0KmrfXAGlq35uidxCuher0OS4A7Kx3/8nLfNJqrlJrkBkSLb9hRvZP62EZQpIiq1kFtlK5jJQsEDgWXzlFv0FCoSh2YBo9galjoEfk2tJl9p9VQlqCRQV6bRrr9qwPEXWlTIMLdGhcKcqc+T5GeHMDi4LczpDqRf4qDhTMx0k+RvsAU2W1pxVhAdNMiH2mpesnfwMvs/EzzFFJYNTG5ioNl7TW+sdHfihCwYSHnV0EM8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE2D6E8C3193E48A8F08DCE9EB449AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9afa8da-c0bb-47b2-1317-08d629044328
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 07:46:00.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMi8xOCwgMTE6NTcgUE0sICJMaW51cyBXYWxsZWlqIiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPiB3cm90ZToNCg0KPiBNeSB0aG91Z2h0IGlzIGdvIGZvciAoMikgYW5kIGRvIGFsbCBj
aGFuZ2VzIGluIG9uZSBwYXRjaCA6KQ0KDQpObyBwcm9ibGVtLCBMaW51cy4NCk9uZSBtb3JlIHF1
ZXN0aW9uOiBsb29rcyBsaWtlIG15IGZpcnN0IHBhdGNoIDQ0NTFkM2Y1OWYyYSAoZml4IHNldF9u
ZXh0X2V2ZW50IGhhbmRsZXIpIGlzIG5vdCBtZXJnZWQgYmFjayB0byAidGltZXJzL2NvcmUiLiBT
aG91bGQgSSBnZW5lcmF0ZSB0aGlzIHBhdGNoIG9uIHRvcCBvZiB0aGUgZmlyc3QgcGF0Y2ggb3Ig
b24gdG9wIG9mIHRoZSBjdXJyZW50ICJ0aW1lcnMvY29yZSI/IFdoaWNoIG9uZSB3b3VsZCBiZSBl
YXNpZXIgZm9yIHlvdSAob3IgRGFuaWVsL1Rob21hcyk/IFNvcnJ5IEknbSBwcmV0dHkgbmV3IHRv
IHRoZSBjb21tdW5pdHkuLg0KDQpUaGFua3MsDQpUYW8gUmVuDQoNCg0K
