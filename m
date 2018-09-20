Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B095ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1486A21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eAQtguJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1486A21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbeITIbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:01 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:37182
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388513AbeITIbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpcGBBHyaEhQt9ylpaWKf00ydlwJQQYnSfz6/XSyoPM=;
 b=eAQtguJgJ9cH6PW7DpzkbZWpUy6J5QlNEyT8rEcqzHdGBG4HJ4lJviInmk7X37shMQjTCiQnBy9LoMyPOG3kMA9XK2bzqJM8A19Uk714zEQPBoqefze4H/2rs8XG8f3oat7mkV9ubie+3WzSxjUcs5XpTo6sPm1cozwMah/SJCs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/14] drm/amdgpu: Update power state at the end
 of smu hw_init.
Thread-Topic: [PATCH AUTOSEL 4.9 11/14] drm/amdgpu: Update power state at the
 end of smu hw_init.
Thread-Index: AQHUUIx1IISJh4zSfUiMWJq6keYPYQ==
Date:   Thu, 20 Sep 2018 02:48:49 +0000
Message-ID: <20180920024838.58666-11-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:ZJ8mm6eh4HxsIIBBqC/YZD7W0vUxZj8408t9kmvgn9vr4585bUHcmWfz+/uBWUqog73m40NlKbIEYu7jWNu5y83YCf1kXo/HBd0trRs4sYOw/zpNEbLGIohLhDF7K2c1WA2FjPnxJvuc9XeO9lBqBxDc9r21X/fC+Ukl1iOeqPbwCut8OkwSJPWZtDZBpKLlzWUS1nzrUFSiUr5BilgDbhy5MG+wFrzjzhEfQ3wxNwiDnK+Ra5cBDZDs9l/Pw9zGz/1bsCZT9RT4mpOAcvR7OkE2vPSRbJlhhJ1D1cAwghbZCU/eVOshgjjR1spEoZkCbKGp4ssCzoslXT/5iGlt8l7jX3lovUvSpt0RDOcBM6C3tE/FV2pxv0rQLyrtVP9c7lFSKTDxTa9uDEVG6qNrkZBQeVMRIBGEVG4era+p/DOosDj3WaqU4APP8frSjaiGrTCQPzUmH6ltkwLpaC4Nqw==;5:qDV3ZF7PUqPEk/ntyedQyGMFuq70ioW08VNi7XnWvzUMwAQaNtagOf/v1g480ZC6eInkQE8pb7A/qR3NkWylzBZgFDfWzZnrmhEIk/XNQgrKcJjOS2jK/Fxcf56anAtS5OMbFLS5hfUl4No5qCwbxM6UBBMleZXaTCaLPA9JxCo=;7:JU7ziz1Cdsgddm79oL0ZceVTTd6uWFhOMoZnRJxuAEiE8P2gCit063m+smIU/lHQYWElUehpUzYWH0vDOEALUO6pTo+aq6laG2GmeuWr+F92a5rillfiGOXm6vGTggnX25T42rvRIuZ0Fh+X826BYdegrTQTyHcEWoIxYkCq9tk1xruP0HomC2EmDo4UsHV9zgOuYxlUwVfw6vlKGZZb5C4kIRY5oChDr86OdPAqb+myYglTllXJ3AqY0l4YkEcR
x-ms-office365-filtering-correlation-id: 42b9fd75-efb4-4d18-5fb4-08d61ea3bf25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB04696427BE9BF32CC0CC391AFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(575784001)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(14444005)(1076002)(15650500001)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4Q2nUMyGIcN7MtlFdmwLlK7KmRhcIm8Sc2UfozaJYkVk6b+vPrXPh7SId5yG3/3FQzxS1ZlwwvgoKM3XqNDYo+wN7uBKd1ivg5mejN4iYEvp7hFyw4Rsbw6NG5bKOb3uxua8rqLy5/nISlgPN2tXIUYMUdETJ3k/Ybu1FU1q0cdMffwUID2MYdZMB3Zpq0vrEJKnpDvbCPC+U/7mPH5hvkTc7if/7hc+TqLvRfZn77WQLJI3aff1N+2u9RTaKyvC0dsA1op6zL9sY4QNqwYaONRVeGS1iA5UrYfGT4oGw30ZpJvXdM8LbpP3BXU407qukzFBTSXRokvk4RGlIJYqqZYbIJ+UH/lHgC1yRLCIy8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4788525CE893459CD34FF7AC22D414@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b9fd75-efb4-4d18-5fb4-08d61ea3bf25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:49.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPg0KDQpbIFVwc3RyZWFtIGNvbW1pdCAyYWI0
ZDBlNzQyNTZmYzQ5YjdiMjcwZjYzYzFkMWU0N2MyNDU1YWJjIF0NCg0KRm9yIFNJL0t2LCB0aGUg
cG93ZXIgc3RhdGUgaXMgbWFuYWdlZCBieSBmdW5jdGlvbg0KYW1kZ3B1X3BtX2NvbXB1dGVfY2xv
Y2tzLg0KDQp3aGVuIGRwbSBlbmFibGVkLCB3ZSBzaG91bGQgY2FsbCBhbWRncHVfcG1fY29tcHV0
ZV9jbG9ja3MNCnRvIHVwZGF0ZSBjdXJyZW50IHBvd2VyIHN0YXRlIGluc3RhbmQgb2Ygc2V0IGJv
b3Qgc3RhdGUuDQoNCnRoaXMgY2hhbmdlIGNhbiBmaXggdGhlIG9vcHMgd2hlbiBrZmQgZHJpdmVy
IHdhcyBlbmFibGVkIG9uIEt2Lg0KDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KVGVzdGVkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRh
ZW56ZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2t2X2RwbS5jIHwgNCArLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgfCAzICstLQ0KIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9rdl9kcG0uYw0KaW5kZXggNzFkMjg1NjIyMmZhLi5mNjFjNDg5ZTVmNmQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9rdl9kcG0uYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMNCkBAIC0xMzUwLDggKzEzNTAsNiBAQCBzdGF0aWMg
aW50IGt2X2RwbV9lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCQlyZXR1cm4g
cmV0Ow0KIAl9DQogDQotCWt2X3VwZGF0ZV9jdXJyZW50X3BzKGFkZXYsIGFkZXYtPnBtLmRwbS5i
b290X3BzKTsNCi0NCiAJaWYgKGFkZXYtPmlycS5pbnN0YWxsZWQgJiYNCiAJICAgIGFtZGdwdV9p
c19pbnRlcm5hbF90aGVybWFsX3NlbnNvcihhZGV2LT5wbS5pbnRfdGhlcm1hbF90eXBlKSkgew0K
IAkJcmV0ID0ga3Zfc2V0X3RoZXJtYWxfdGVtcGVyYXR1cmVfcmFuZ2UoYWRldiwgS1ZfVEVNUF9S
QU5HRV9NSU4sIEtWX1RFTVBfUkFOR0VfTUFYKTsNCkBAIC0zMDg2LDcgKzMwODQsNyBAQCBzdGF0
aWMgaW50IGt2X2RwbV9od19pbml0KHZvaWQgKmhhbmRsZSkNCiAJZWxzZQ0KIAkJYWRldi0+cG0u
ZHBtX2VuYWJsZWQgPSB0cnVlOw0KIAltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsNCi0N
CisJYW1kZ3B1X3BtX2NvbXB1dGVfY2xvY2tzKGFkZXYpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCiAN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jDQppbmRleCAzZmE4MzIwZTQ5YzEuLjQ4MjZi
ZWZjMWJjMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYw0KQEAgLTY5NTksNyAr
Njk1OSw2IEBAIHN0YXRpYyBpbnQgc2lfZHBtX2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiANCiAJc2lfZW5hYmxlX2F1dG9fdGhyb3R0bGVfc291cmNlKGFkZXYsIEFNREdQVV9E
UE1fQVVUT19USFJPVFRMRV9TUkNfVEhFUk1BTCwgdHJ1ZSk7DQogCXNpX3RoZXJtYWxfc3RhcnRf
dGhlcm1hbF9jb250cm9sbGVyKGFkZXYpOw0KLQluaV91cGRhdGVfY3VycmVudF9wcyhhZGV2LCBi
b290X3BzKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTc4MzYsNyArNzgzNSw3IEBAIHN0YXRp
YyBpbnQgc2lfZHBtX2h3X2luaXQodm9pZCAqaGFuZGxlKQ0KIAllbHNlDQogCQlhZGV2LT5wbS5k
cG1fZW5hYmxlZCA9IHRydWU7DQogCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOw0KLQ0K
KwlhbWRncHVfcG1fY29tcHV0ZV9jbG9ja3MoYWRldik7DQogCXJldHVybiByZXQ7DQogfQ0KIA0K
LS0gDQoyLjE3LjENCg==
