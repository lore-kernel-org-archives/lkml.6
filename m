Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71433ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6E21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i5r0QWP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF6E21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbeITI3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:34 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388008AbeITI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PukHDYk8Oh7HqoLLY9pt/Q8PWJDK8PFxHAWNTvu9y9o=;
 b=i5r0QWP9Ks7LO+qcH2eUXPLiKndhTB/9QoXuZg9ovbbfKKdv+dG/6YNrkJuQmdaCXnXabRkNIk49Y1k7OjVTXRrfEt6GuK6SXHjLFRO05NGuOuGxT6mmJHFf5uVqibqs/JfVJ+vnH9yjbIao9rqUn3SmtllqSPhN7zcHJhyc0Tk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 47/56] drm/amdgpu: Update power state at the end
 of smu hw_init.
Thread-Topic: [PATCH AUTOSEL 4.18 47/56] drm/amdgpu: Update power state at the
 end of smu hw_init.
Thread-Index: AQHUUIxYDJx8G4k5lUeZjTQbEQiB8Q==
Date:   Thu, 20 Sep 2018 02:48:00 +0000
Message-ID: <20180920024716.58490-47-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:3rmnDHPhYaayTgyBFdfmqlilyRXvyjuEvX1ZDH4mS7Uj2vOEpGfw+Bd0V0zOZ+fh9+zjo+edg5kOzQwJw+22JnCKVXbpcfqoBicPdkEFwOpc3uNehM65tlpTSuJIfmqjnHw0vUMBdY7s03qGg45L0Ni/0jpC7K9q4jkfkbJTK0e1qlVw9/NR3MUbTlkVdNzmgBQTGBsHsqeFGSznRJ1ZHl9/g87SgS2u5oSq184XHMaDrEz4A+OflO0pyuOPP7pHv9wymdHe92guKMRnp5A9SycX0Xo3lWjTIzzzUvOQ1sUT+o3zs+qDk+OBVOM8Z87YFa7h/c1HPN5HiU0TrSaYL07s3QIiP82Q5jix9Js/MNbNQteX4Kl7iz1LioYTbnG4DT8P1RbCKCemhEYz0SfCeMePQuCTmQoOwtQi43K6PRN76pX7EpasKuq/FAIRTXXD5AA9Fp0zVVVYrgtHl0I+5w==;5:Wo0K3MVJ5QlY/sm0KlZY7EPp0d2gVA7Wv1jDfT6eGN9IvxSQs+k2LDt4RbP3nVfDpe7t7Vpe7iHO0UB/YFRLjuc2two1vSloBNYhGwoGCOlqwyhql3xC9WOOYb9Q3V1F8JfxRTUDSLOiUhWBBUJevGy/efSHJcm2QYIl5boDAL0=;7:QPi45vJD3Gl1wkjpw4iNNTr5nsd0NKyRmtUW1SXgPHvWPl+8IIv2KhrkTN7id1Ih3TXdFoNT6eDJ5JSzEbpNguP4N1iKdA2uS8FD/b9RdNxqdmcftUuu6hsykDCmVnUTZ3HKgpnuaep6LEd5JoQc87fb98oCQuouznpj08q1JqgpuP0FajuvAh1l9E65nuAqp+iIGVv2yCefXoZwK7y8a8nY0vQtfp8liqiQJjD2xY2raunYCjDYHw717kMFbJ9l
x-ms-office365-filtering-correlation-id: 874098fa-0b5c-4eeb-78a7-08d61ea38b1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119C1591A01A7BACB87F51EFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(15650500001)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MC78ZGSs1JX1KjrLXu3vdloGwTiwswyLGTaUd7M0zbiSnx3Un2bVeb94FFhIm0stuQ/+ra8UiPtrI8G/+q+I/5jtP+tq3GO0CwOIV9Bg2yOyWdJffDkhGXd3wOSBbgXiUZ97lGA5obLmEWgruMrs6I0F5PQ36gfH1MsC7BuKFcvhvENHN4sNgdSdampLTL35cZdbtof+q+KiWqTC+xQOCGd5c+6C+1vokAhFU/yBssVJSChAYfdFoaYtptN7a22y363cHx+fdQAdKkTAmWagrJCYxUO56hz+SMWLxShnDlwhYIJeTtu3XUJfPXV0YQJzpEX7Sx3rh/vV8YtVmy1lbwEz7afwTjBHg8EyeUbu3VE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F5B9774DA4E504E90E1015D4DF3749D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874098fa-0b5c-4eeb-78a7-08d61ea38b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:00.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
ZGdwdS9rdl9kcG0uYw0KaW5kZXggN2ExZTc3YzkzYmYxLi5kOGU0NjljNTk0YmIgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9rdl9kcG0uYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMNCkBAIC0xMzU0LDggKzEzNTQsNiBAQCBzdGF0aWMg
aW50IGt2X2RwbV9lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCQlyZXR1cm4g
cmV0Ow0KIAl9DQogDQotCWt2X3VwZGF0ZV9jdXJyZW50X3BzKGFkZXYsIGFkZXYtPnBtLmRwbS5i
b290X3BzKTsNCi0NCiAJaWYgKGFkZXYtPmlycS5pbnN0YWxsZWQgJiYNCiAJICAgIGFtZGdwdV9p
c19pbnRlcm5hbF90aGVybWFsX3NlbnNvcihhZGV2LT5wbS5pbnRfdGhlcm1hbF90eXBlKSkgew0K
IAkJcmV0ID0ga3Zfc2V0X3RoZXJtYWxfdGVtcGVyYXR1cmVfcmFuZ2UoYWRldiwgS1ZfVEVNUF9S
QU5HRV9NSU4sIEtWX1RFTVBfUkFOR0VfTUFYKTsNCkBAIC0zMDYxLDcgKzMwNTksNyBAQCBzdGF0
aWMgaW50IGt2X2RwbV9od19pbml0KHZvaWQgKmhhbmRsZSkNCiAJZWxzZQ0KIAkJYWRldi0+cG0u
ZHBtX2VuYWJsZWQgPSB0cnVlOw0KIAltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsNCi0N
CisJYW1kZ3B1X3BtX2NvbXB1dGVfY2xvY2tzKGFkZXYpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCiAN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jDQppbmRleCA1Yzk3YTM2NzE3MjYuLjYwNmY0
NjFkY2U0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYw0KQEAgLTY4ODcsNyAr
Njg4Nyw2IEBAIHN0YXRpYyBpbnQgc2lfZHBtX2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiANCiAJc2lfZW5hYmxlX2F1dG9fdGhyb3R0bGVfc291cmNlKGFkZXYsIEFNREdQVV9E
UE1fQVVUT19USFJPVFRMRV9TUkNfVEhFUk1BTCwgdHJ1ZSk7DQogCXNpX3RoZXJtYWxfc3RhcnRf
dGhlcm1hbF9jb250cm9sbGVyKGFkZXYpOw0KLQluaV91cGRhdGVfY3VycmVudF9wcyhhZGV2LCBi
b290X3BzKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTc3NjQsNyArNzc2Myw3IEBAIHN0YXRp
YyBpbnQgc2lfZHBtX2h3X2luaXQodm9pZCAqaGFuZGxlKQ0KIAllbHNlDQogCQlhZGV2LT5wbS5k
cG1fZW5hYmxlZCA9IHRydWU7DQogCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOw0KLQ0K
KwlhbWRncHVfcG1fY29tcHV0ZV9jbG9ja3MoYWRldik7DQogCXJldHVybiByZXQ7DQogfQ0KIA0K
LS0gDQoyLjE3LjENCg==
