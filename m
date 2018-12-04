Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1160CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E8F2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YeGkaPT6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VmQz+ee/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E8F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeLDQ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:26:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22994 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543940794; x=1575476794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9NYJxIGllpsJoRyJgLakRqzLQfBFrN6xnovbiBGJOx0=;
  b=YeGkaPT6fv3g+REIlkjbU/RDPH6uap0zXwKrgoTAULRckkwczlKC9l74
   AeRvl0aYl+y9U4CECvPmHWpHsAJaszrGaBDUOmaRjNiSa813gJ8lbNBB3
   Vgu4RoVs+xZBwxs8aJDwff5XUlsnJmZGD9NcnpT5V+QZzQ0zHFoSAAnIM
   DR5x6ikCEiuY8WOJ/NKQvQwuVI3twEFKSZ//Rlda1UF0OBfAs6EvDSRLe
   mocyU009zBjh62ut+usGYXtKp6P4RUsjWm61JRCo5iH7vtTmhPnqhQS4m
   /DNKvFlriZJmFfmCkuvU0C8uk5+1HnCW4hUO+8P+DkhX8UVxEVYXzq+G6
   g==;
X-IronPort-AV: E=Sophos;i="5.56,314,1539619200"; 
   d="scan'208";a="100625010"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2018 00:26:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NYJxIGllpsJoRyJgLakRqzLQfBFrN6xnovbiBGJOx0=;
 b=VmQz+ee/4y0PMF8uXspTf0zRHvzfs9EXYnmfIQFE+KU3q3Llyj73DsCu2xHGobqBNtcj7j4kJ0PyHw7Xz7yWMdBLLfHN561nSvnqDUpK6oSjM5/mv3tib+awQOT+lxJqu6SdqsghmO+VqGy/MaRS4vrpvX5zUZEGlJn37fWAlgs=
Received: from MWHPR0401MB3514.namprd04.prod.outlook.com (10.167.162.141) by
 MWHPR0401MB3674.namprd04.prod.outlook.com (10.167.163.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 16:26:31 +0000
Received: from MWHPR0401MB3514.namprd04.prod.outlook.com
 ([fe80::94f8:957:b8c0:cfb2]) by MWHPR0401MB3514.namprd04.prod.outlook.com
 ([fe80::94f8:957:b8c0:cfb2%3]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 16:26:31 +0000
From:   Alex Lemberg <Alex.Lemberg@wdc.com>
To:     Liming Sun <lsun@mellanox.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        David Woods <dwoods@mellanox.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device
 tree
Thread-Topic: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device
 tree
Thread-Index: AQHUgQyZDPcojaKB7k2zMmMMoM4SWKVu+6cA
Date:   Tue, 4 Dec 2018 16:26:31 +0000
Message-ID: <99DF0CBE-2879-4869-861D-06097D9E12CB@wdc.com>
References: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
In-Reply-To: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.4.181110
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Lemberg@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0401MB3674;6:JcCda15xaWgkybwxSRBxHgnN+5ui54OdDBYEkNBTIEwkthg06CIiHV2rIvvDPcqhwPsFWrNkrytcIFqzTv8ITy1EuRoUL6ShSL0diPGJM68ckPoPuVahuzUc3RSKWNnr5zrsqWuwaR5xAnO9ExDKkTmf8qRKyoitHe9EyySv46nGtBcV4X3VVHzsHVF+Kd/hv1mRKeG4iQx5qbBX0c7KEN88Y7zKU1XRtrEtSO53DwD8D3LKcVPaiauCMsqU9tK18LbcGXS6u3lirHOBQ1x/cwbqfTXWonzdufcv/+5010pmUM1cJk1TnhPg2Bp8wht/+bPV6QBSeNgXP/MoTGir6e7yCP2UPuRFkpAPaEVN2EA8CH9MQIQF23/KQOEibRQzWUqGGYqDUx+WGMmpikr9Pz4g+1lKFFljQU1yN5StUOPCIr6j/4aB8y9vU1mKYhzy3uSV0ON4SCkKq6SohCJVuA==;5:fhHJCw9coFry/AlvqqgN5JG3dMTKNC6KHuLQpW9tF/R8j3rzHVChb7Fx2323g3J7RKoCL3wMyO5OTPId8U0+caU8cAwXd4TOzikbPXGgnko1tL4r7zfSIV0vw1EUwVF19OfiupkQ1WAZWzVhKGGRdzdp7davUgndEoVU6BEKY6Q=;7:6z97+lppy61RmewD2X6j/uqjIUrj9BQUWTJQWlL3bMblTWHVUg2ZBciFratIvgS7KqwaDlWK6/qogZIJx9/mRz5bQTi10e4wKeMNOBxDKSRqxP5aguFyM1pfKiNc7gFGfefrPW5MD795ZOWDT1deCg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 35a0af0e-9620-46e1-c31b-08d65a054019
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0401MB3674;
x-ms-traffictypediagnostic: MWHPR0401MB3674:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR0401MB3674F6682BC0D82E4B3B87128DAF0@MWHPR0401MB3674.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0401MB3674;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0401MB3674;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(186003)(26005)(14454004)(6246003)(66066001)(476003)(229853002)(2906002)(33656002)(8676002)(83716004)(54906003)(5660300001)(58126008)(82746002)(86362001)(72206003)(478600001)(110136005)(36756003)(4326008)(316002)(25786009)(71200400001)(71190400001)(486006)(305945005)(68736007)(53936002)(81156014)(81166006)(102836004)(6506007)(105586002)(7736002)(106356001)(8936002)(446003)(11346002)(76176011)(6512007)(97736004)(99286004)(6436002)(6486002)(6116002)(256004)(14444005)(3846002)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0401MB3674;H:MWHPR0401MB3514.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5KQ6N5bavZwenQ7YHGsFa/Z2P00OBgGlTpHg9rJ6OYpvCOkPRtWlPhywDiXAwVPqfmHMCn9UwpbZCHULMT48nAcSuSWz4s5/GTHj3hRHaLXvo+miydqmP/wpj3nzkfROd97W91raBLD5jcIv9y7bJwUyfh9iVaUhnRFlOxu53zV20v1rZ8B93fQkFvhnWypg2KtlmaxSIF3Smyx/fDzT/KVx6v+F9oONJ2CpysAjXDA+r930SZdpztzRiqxN0RG+R6g2h7OCdTqlm5mGQxGFB5KfsRELUOX8FkfxG5qivIW6gGtueeChcWkbV/k7xMNDz3z7MeBsfON3NHRj0gOVnmUX7yPryk39DXITrKHZMoU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <003F68CCAC33FD49B011C33ABD6DE006@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a0af0e-9620-46e1-c31b-08d65a054019
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 16:26:31.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSwNCg0KDQrvu79PbiAxMS8yMC8xOCwgMTA6MDcgUE0sICJsaW51eC1tbWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnIG9uIGJlaGFsZiBvZiBMaW1pbmcgU3VuIiA8bGludXgtbW1jLW93bmVyQHZn
ZXIua2VybmVsLm9yZyBvbiBiZWhhbGYgb2YgbHN1bkBtZWxsYW5veC5jb20+IHdyb3RlOg0KDQog
ICAgQ3VycmVudGx5IHRoZSBFWFRfQ1NEX0NBQ0hFX0NUUkwgcmVnaXN0ZXIgaXMgY29udHJvbGxl
ZCBieSBBUEkNCiAgICBtbWNfY2FyZF9icm9rZW5faHBpKCksIHdoaWNoIG9ubHkgd29ya3MgZm9y
IHRoZSBxdWlya3Mgc2V0dGluZ3MuDQogICAgVGhpcyBjb21taXQgZW5oYW5jZXMgaXQgdG8gdXNl
IGNhcmQtPmV4dF9jc2QuaHBpIGluc3RlYWQuIFRoaXMNCiAgICBmbGFnIHdvcmtzIGZvciBib3Ro
IHRoZSBxdWlya3MgYW5kIHRoZSBicm9rZW4taHBpIGNvbmZpZ3VyYXRpb24NCiAgICBpbiB0aGUg
ZGV2aWNlIHRyZWUuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogTGltaW5nIFN1biA8bHN1bkBt
ZWxsYW5veC5jb20+DQogICAgLS0tDQogICAgIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgfCAzICst
LQ0KICAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQog
ICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21t
Yy9jb3JlL21tYy5jDQogICAgaW5kZXggYmMxYmQyYy4uMmYyYjY1YyAxMDA2NDQNCiAgICAtLS0g
YS9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQogICAgKysrIGIvZHJpdmVycy9tbWMvY29yZS9tbWMu
Yw0KICAgIEBAIC0xNzkxLDggKzE3OTEsNyBAQCBzdGF0aWMgaW50IG1tY19pbml0X2NhcmQoc3Ry
dWN0IG1tY19ob3N0ICpob3N0LCB1MzIgb2NyLA0KICAgICAJICogSWYgY2FjaGUgc2l6ZSBpcyBo
aWdoZXIgdGhhbiAwLCB0aGlzIGluZGljYXRlcw0KICAgICAJICogdGhlIGV4aXN0ZW5jZSBvZiBj
YWNoZSBhbmQgaXQgY2FuIGJlIHR1cm5lZCBvbi4NCiAgICAgCSAqLw0KICAgIC0JaWYgKCFtbWNf
Y2FyZF9icm9rZW5faHBpKGNhcmQpICYmDQogICAgLQkgICAgY2FyZC0+ZXh0X2NzZC5jYWNoZV9z
aXplID4gMCkgew0KICAgICsJaWYgKGNhcmQtPmV4dF9jc2QuaHBpICYmIGNhcmQtPmV4dF9jc2Qu
Y2FjaGVfc2l6ZSA+IDApIHsNCg0KDQpBbnkgcmVhc29uIGZvciBtYWtpbmcgYSBjb25uZWN0aW9u
IGJldHdlZW4gSFBJIGFuZCBDYWNoZQ0KaW4gY3VycmVudCBkcml2ZXIgaW1wbGVtZW50YXRpb24/
DQpCVFcsIEkgbWlzc2VkIGl0IGJlZm9yZSwgYnV0IHRoZSBwcmV2aW91cyBjb21taXQgbWFraW5n
IHRoaXMgY29ubmVjdGlvbiAtDQppcyBhbHNvIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UuDQpBbHRo
b3VnaCBieSB0aGUgc3BlYyBGTFVTSF9DQUNIRSBpcyBpbnRlcnJ1cHRpYmxlIGNvbW1hbmQsIEkg
ZG9uJ3QgdGhpbmsNCndlIHNob3VsZCBwcmV2ZW50IGRldmljZXMgd2l0aCBubyBIUEkgc3VwcG9y
dCwgdXNpbmcgdGhlIENhY2hlLg0KUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSB3cm9uZywgYnV0IHRo
ZSBjdXJyZW50IGRyaXZlciBpbXBsZW1lbnRhdGlvbiBhbGxvd3MNCnRvIHNlbmQgSFBJIGZvciBC
S09QUyBhbmQgU2FuaXRpemUgKG9uIHRpbWVvdXQgZXJyb3IpIGNvbW1hbmRzIG9ubHkgLQ0Kc28g
d2h5IHdlIHNob3VsZCBsaW1pdCB0aGUgRkxVU0hfQ0FDSEUgY29tbWFuZD8NCg0KDQogICAgIAkJ
ZXJyID0gbW1jX3N3aXRjaChjYXJkLCBFWFRfQ1NEX0NNRF9TRVRfTk9STUFMLA0KICAgICAJCQkJ
RVhUX0NTRF9DQUNIRV9DVFJMLCAxLA0KICAgICAJCQkJY2FyZC0+ZXh0X2NzZC5nZW5lcmljX2Nt
ZDZfdGltZSk7DQogICAgLS0gDQogICAgMS44LjMuMQ0KICAgIA0KICAgIA0KDQo=
