Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4752DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E572B204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LRmhoQm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E572B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeIBRVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:03 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:31968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbeIBRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx338KiNY27s31NUBbh+3KDk69U3xZ1fhlVQKRhavto=;
 b=LRmhoQm4WL9NAzNgkbuTVaj3ICawF/X1pR/I9Qzpaud1KKvouZnEdW1xwGbJXm6CO3Jxb75yA7I2P2qarg4QPOR2UhQSrKLsAogGXOj/YLMy6pl4MlZBHlHD/uWOpnVosGoh+SiiYlfZEW6PTyPfyVcGQ0fl4UVWfENXOxiSCkY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 071/131] Bluetooth: hidp: Fix handling of strncpy
 for hid->name information
Thread-Topic: [PATCH AUTOSEL 4.18 071/131] Bluetooth: hidp: Fix handling of
 strncpy for hid->name information
Thread-Index: AQHUQr184DdP3zldzUizCtSCnncS8A==
Date:   Sun, 2 Sep 2018 13:04:30 +0000
Message-ID: <20180902064601.183036-71-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:2OzRYjBTN826lbQSm9wa03J+nJc1kohbYg/p/+h4lX2UHml9BPKyxE2RFQ8FvJyAT8TrTlS1WkZYjjRWD8oNxbtVmCLqQc/Y9xwYEslDyNiGCZhEkM5Os3XMY0PkOB5f1zOmYeGhsrLwDla0x/z7umSaZ29GRIh77FL4kTiNsOwe6fDNQRsTz9T5uF1bIc4j3rdVjg9n9ENaZ7fTzuyluYBdoLoooZ7DQluM9vJdIvmSuaiTrSwTH0AxiM3GEqtA1E6Fup5BG+f+jwhGqqvzpdXW/7b2/AHqCD3+k1pNYzUQxnXO25TS2E4vllKpmlkN2DXewJeho5AGO3hOBVax5gmhnXNtkQqiNObqLaSOyYn2HbDjJDufFatE2HvaAxBVXiqLCgAp3jN6YZ6QNTmH+2ZMXK38JJGni91/4S5Dh6pE/E7fjXUpOzog5i7dT54JUXHFj+4uB56gGfOPFkFnPQ==;5:+2F2D9jxUbo49STKyvGuysV2hM6VdHIFUnQl/hp7+06+0iLp0cp0hLMeVmRW6TKXCZA3ICEz8QDgyfK/8ReFCwg1sHxDkQ6ENbzNGbjNr3OeVzeHegF8FHnaE7mxEIjNIasPWCID9pXOwWHgZ5h6wZKE6zCSGEIZNOrBMVqhepQ=;7:9q35iJI8ehSZ/cYbBU3Z5fOcy/b0Py7J2/AsCapGxSCyebsQE7K3KSvOqqfzw0k3qt14o0WfsbrADIq8qKT70RlDJ+OL8WbudkUjp7ivggcDmZ8zKdW4y7K/dCpSMB9QdJQ9KFRd4n0jW7bl+ZGVK9ceDV5fqF0xD/dkBTYtMfpFQ+Z55AnK6mRDP+gqpbNXZ21QvrAT/FYO+hbyH+lILrMFgNx4DFAK1lWIbIgHhTEsiOLXNVcVt97YdziF/9dz
x-ms-office365-filtering-correlation-id: 00ddb6d2-29f8-4116-5cdd-08d610d4ac4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012028AF96186238C65D7CAAFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IlDSoZ37Dq/4WiqAjyC/WMYrVeXwu7qlLYeHdkSkVjRVemja5NroNjUh3/nyC33bsGaOsjUz0RcLl845koupnNwPtnazIjAmImWuHSj+lZVLYDfYB4WrOY9qY8tDmqzy/khV7koCYwVSpKUe5z4BDT7wxKZL4cDHexQWw5BaTAMT77vizG70OzahCIT4P6+QlCRnLJ4k91FOhRppb6aMUyfqNn2Cj8N1AFxJ7RkyGZKoQlY+OkGDV18dbswlDwNW0BnoGaJSZtoqLpaTU7UmDRwALuecQ36RByruiL4pQ8HKMBK0lm5yyijUypEPoy5KlrU/Uw4mreLyhyp1WZGWWDTKyBt7wgvfZibzk6cfUFg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FEF997666C72B44B245C19BC100E1FD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ddb6d2-29f8-4116-5cdd-08d610d4ac4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:30.3098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCBiM2NhZGFhNDg1ZjBjMjBhZGQxNjQ0YTVjODc3YjA3NjViMjg1YzBjIF0NCg0KVGhp
cyBmaXhlcyB0d28gaXNzdWVzIHdpdGggc2V0dGluZyBoaWQtPm5hbWUgaW5mb3JtYXRpb24uDQoN
CiAgQ0MgICAgICBuZXQvYmx1ZXRvb3RoL2hpZHAvY29yZS5vDQpJbiBmdW5jdGlvbiDigJhoaWRw
X3NldHVwX2hpZOKAmSwNCiAgICBpbmxpbmVkIGZyb20g4oCYaGlkcF9zZXNzaW9uX2Rldl9pbml0
4oCZIGF0IG5ldC9ibHVldG9vdGgvaGlkcC9jb3JlLmM6ODE1OjksDQogICAgaW5saW5lZCBmcm9t
IOKAmGhpZHBfc2Vzc2lvbl9uZXfigJkgYXQgbmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYzo5NTM6
OCwNCiAgICBpbmxpbmVkIGZyb20g4oCYaGlkcF9jb25uZWN0aW9uX2FkZOKAmSBhdCBuZXQvYmx1
ZXRvb3RoL2hpZHAvY29yZS5jOjEzNjY6ODoNCm5ldC9ibHVldG9vdGgvaGlkcC9jb3JlLmM6Nzc4
OjI6IHdhcm5pbmc6IOKAmHN0cm5jcHnigJkgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQgY29weWlu
ZyAxMjcgYnl0ZXMgZnJvbSBhIHN0cmluZyBvZiBsZW5ndGggMTI3IFstV3N0cmluZ29wLXRydW5j
YXRpb25dDQogIHN0cm5jcHkoaGlkLT5uYW1lLCByZXEtPm5hbWUsIHNpemVvZihyZXEtPm5hbWUp
IC0gMSk7DQogIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NCg0KICBDQyAgICAgIG5ldC9ibHVldG9vdGgvaGlkcC9jb3JlLm8NCm5ldC9ibHVldG9v
dGgvaGlkcC9jb3JlLmM6IEluIGZ1bmN0aW9uIOKAmGhpZHBfc2V0dXBfaGlk4oCZOg0KbmV0L2Js
dWV0b290aC9oaWRwL2NvcmUuYzo3Nzg6Mzg6IHdhcm5pbmc6IGFyZ3VtZW50IHRvIOKAmHNpemVv
ZuKAmSBpbiDigJhzdHJuY3B54oCZIGNhbGwgaXMgdGhlIHNhbWUgZXhwcmVzc2lvbiBhcyB0aGUg
c291cmNlOyBkaWQgeW91IG1lYW4gdG8gdXNlIHRoZSBzaXplIG9mIHRoZSBkZXN0aW5hdGlvbj8g
Wy1Xc2l6ZW9mLXBvaW50ZXItbWVtYWNjZXNzXQ0KICBzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5u
YW1lLCBzaXplb2YocmVxLT5uYW1lKSk7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCg0KU2lnbmVkLW9mZi1ieTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1h
bm4ub3JnPg0KU2lnbmVkLW9mZi1ieTogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BpbnRl
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jv
c29mdC5jb20+DQotLS0NCiBuZXQvYmx1ZXRvb3RoL2hpZHAvY29yZS5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
bmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYyBiL25ldC9ibHVldG9vdGgvaGlkcC9jb3JlLmMNCmlu
ZGV4IDNiYmE4ZjRiMDhhOS4uMjUzOTc1Y2NlOTQzIDEwMDY0NA0KLS0tIGEvbmV0L2JsdWV0b290
aC9oaWRwL2NvcmUuYw0KKysrIGIvbmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYw0KQEAgLTc3NSw3
ICs3NzUsNyBAQCBzdGF0aWMgaW50IGhpZHBfc2V0dXBfaGlkKHN0cnVjdCBoaWRwX3Nlc3Npb24g
KnNlc3Npb24sDQogCWhpZC0+dmVyc2lvbiA9IHJlcS0+dmVyc2lvbjsNCiAJaGlkLT5jb3VudHJ5
ID0gcmVxLT5jb3VudHJ5Ow0KIA0KLQlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YocmVxLT5uYW1lKSAtIDEpOw0KKwlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YoaGlkLT5uYW1lKSk7DQogDQogCXNucHJpbnRmKGhpZC0+cGh5cywgc2l6ZW9mKGhpZC0+cGh5
cyksICIlcE1SIiwNCiAJCSAmbDJjYXBfcGkoc2Vzc2lvbi0+Y3RybF9zb2NrLT5zayktPmNoYW4t
PnNyYyk7DQotLSANCjIuMTcuMQ0K
