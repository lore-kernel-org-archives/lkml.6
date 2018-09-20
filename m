Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBEFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A1B21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NRU5WC86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A1B21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbeITIiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:38:09 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731731AbeITI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8AWD1R5l49OXbz98WQOj/cd8ui6L4/WILNE+/uhp70=;
 b=NRU5WC86z7n2mepcC/me4jPMsq2+Dw+LTBhSP0q4umSPRcrTsWmaqUjlm08Yg3sbWlNzo59KcbVN9faSLU+bXG5FzLqgA3fP5KnVOiCtPAgJ2FXNUkRrnrytr+XPYPXzcskbf2Ct7LpJWiwxqiZehr8Gc0PPrS6LqS0Dn4V3cCw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 18/56] drm/amdgpu: fix VM clearing for the root
 PD
Thread-Topic: [PATCH AUTOSEL 4.18 18/56] drm/amdgpu: fix VM clearing for the
 root PD
Thread-Index: AQHUUIxLbB95GbGPd0mRlbM1OqwgJQ==
Date:   Thu, 20 Sep 2018 02:47:40 +0000
Message-ID: <20180920024716.58490-18-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:VeCyf2izNBvSBVn+TFz9lvKDntUVzCjvRuL1CYEwbBFJvFXzVjL8jBL2+gScoNciFEq4vhRTuattrPHF4MNHbQTc3JmO4F1Wl8jtfbgzXyAhzjyjBPw3MecWZyyolEpE10jWXOxf9Bta8hjk3H1K4iMD1dULug3zzBgUyMRpuwlMbSUl1zTh4mH02PeAFzPw/Lu2MA4CBGNHFlodqvRHMcnKxQhTwKnNNTcQF2rEJo5CzF7akVRIYcVEedNTHbFKsTRQKfKgAFnyjfAxRIZHYzYUYcrxAYpWggyWQWhvdM+6ktbfWMfrcOF7TjbaI9ZNkEHlNdoAkRcfSPuXKsG1HUMxsrDU2ne/+i0rhuvgmzbATWuUoReUFGBpvAkT2refwVdDvPNxshFLNtu9XszBOT7vjmI6vqvPMrm3vWnclnNsFMNw2XbeezQlSq+iHRP54v0alRk9DZIPb/0yBQqpRQ==;5:8CtP9ohF0rcAKxUGMhB707vlGdT0P6yZvjhhBq0bN4Jrx9Z1vYfhMAMlNL6kdzFMHWop4WQji+EtESWTKwBRKTlxkgI02/xssrejJDQ587R73VwZH/Kz0cz8LGMOMjUNqE/KYsB+8ZgZQ3r07ar95FaveXmCGBK90pZgye0kGGE=;7:Ket+spucr+eQllkrP+NTo1gommaItCbE7Gl/d/YxA3SHYTSfOy41eVJktWFxV0f8kQ/IBRx+wk8knE7sTv3jZrLulNA4Aat9bSuqWxCmxUWj9gC63dVp9E503pLaQRUoLs5VaFrDQ8ocZQPvArMopkqAQkAvN0j4gX2fftsDuRtjaFSOjuaa7ef6YVT2S1D7uaJCwiEw5lTv53SMMFLAFU4FhTYR+VMDqe/mKVeFXGDHbcR97LPuyz6pzkb8BxE2
x-ms-office365-filtering-correlation-id: feb1920e-23a1-4a83-a721-08d61ea36ff9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08228B5474784AE207EBC633FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5q8IeJZ26krv4UFsoOJfi6KQck7NZOLEHhWc8lDEr7+BqsE/dv9Jq240eqCZ7zYn/Cyxp1wwt56ll9PtBEEHETblRHyI3PzYuE2JEqUr3rgITJYaVFJ/9b6ReRFV1xE7pr+FAnzyqJRwsl/Ahyr18Z0eNamHRxxjEf/seepDMTu5DvyyBu2EvIbKjT70NO2Luo/A5x6l26cImOdt7W7stLlaHw45q9iwWwfxb29hrhczfxJCsR1MfKEvdMazSoXmUbXGlQbKGS5GzEGYoiUzRlYiHKdBgkU39hCRqL/MQqOCrmwD0SgTrdqpPrk7bhOhAYLUaqQ48wEg/cvDkweDZJ9ZHo2H5OLsJpPLeTYHkBE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEF57B488A0A2241BB97F5C52FAB6202@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb1920e-23a1-4a83-a721-08d61ea36ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:40.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQpbIFVw
c3RyZWFtIGNvbW1pdCA4NjA0ZmZjYmYwNGY4ZjRmM2Y1NWE5ZTQ2ZTVmZjk0OGIyZWQ0MjkwIF0N
Cg0KV2UgbmVlZCB0byBmaWd1cmUgb3V0IHRoZSBhZGRyZXNzIGFmdGVyIHZhbGlkYXRpbmcgdGhl
IEJPLCBub3QgYmVmb3JlLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFu
Z0BhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCmluZGV4IGZkY2I0OThmNmQxOS4uYmJkNGRhYTRk
ODcwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQpAQCAtMzAzLDcg
KzMwMyw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2NsZWFyX2JvKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LA0KIAl1aW50NjRfdCBhZGRyOw0KIAlpbnQgcjsNCiANCi0JYWRkciA9IGFtZGdw
dV9ib19ncHVfb2Zmc2V0KGJvKTsNCiAJZW50cmllcyA9IGFtZGdwdV9ib19zaXplKGJvKSAvIDg7
DQogDQogCWlmIChwdGVfc3VwcG9ydF9hdHMpIHsNCkBAIC0zMzUsNiArMzM0LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fY2xlYXJfYm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogCWlm
IChyKQ0KIAkJZ290byBlcnJvcjsNCiANCisJYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KGJv
KTsNCiAJaWYgKGF0c19lbnRyaWVzKSB7DQogCQl1aW50NjRfdCBhdHNfdmFsdWU7DQogDQotLSAN
CjIuMTcuMQ0K
