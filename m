Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ACA20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c1a43bnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ACA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeIBRcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:23 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730263AbeIBRcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78F8aUcBY+cJNUMh4Ub4oE05QzapffxQZUs547HWKbY=;
 b=c1a43bnVFSuAGtwGFQ1uWXMfK21bbJfR5O83Yd4+aGwbzGGetILi08ytrdDSdhr65WqcvK5I7p5k6u6igJ+8AhCnJc+W9IennHQzzWRcosd4i/xCtN5JNVpjZ+p7KfLSXgaTNpaD2a7zoMeXa3movfIKQLeAA2UyEVecI0cPOHA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 21/47] Bluetooth: hidp: Fix handling of strncpy
 for hid->name information
Thread-Topic: [PATCH AUTOSEL 4.4 21/47] Bluetooth: hidp: Fix handling of
 strncpy for hid->name information
Thread-Index: AQHUQr8Xpq41onEhv0m7hBgCEJDAxQ==
Date:   Sun, 2 Sep 2018 13:16:00 +0000
Message-ID: <20180902131533.184092-21-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:UKlpiRI52D9G0FhBjGGITrIEE+JJe/qj5EDBnYTbiXikd7QhaEKKnrOKzIgccjoRDSKHBe7jllsxjjp0fQrIs7LLAgTj1muPS0AVtPZPc96iZFNJi9Qm8MMzwY50wVbBkjkFRp1bLuUFu++Ha5SU45nmr4sMr+Jd3Q2EZjoIod0o2Ra8nDdQrhXbL9O3R2Ku/X/wQ7NN8VFKMLzTshKUUwvW5pAeNsclAvmJcv7peajwBLc8xzhHQwMwvxJaVEHYA/6kuZqwi764KQf0Rgb9gCsxJP0EQcbd1G/MP7zvJKf4L/5OLN9bjnLwdhzVql8hx2IEMtHj81n99GpEZvYQuJmmmquafHqk3Ps28vAUNNi8T+ceHzBiZoxjC1fAcK5T7wYFt0aducHM7PR1vzlhar2YjPfsn3NM5Sp3TQCpO4kMCgQ7ntH7lX35FOTOVV9AnwzJEW7f2Xbz4P85PBDR8A==;5:QoCvx2XC/9Bu2bg1li5NYHhI86tQymqASYceef5QnlTzhSmtnXv5Ps+ogNR13YkzPzw3f46Tp7BGW9ZWAJwlfEuXAplFYQlgMA2Li2Q1+Y7dCCRNuReBHrNQFjlC93t5pJFKDNf176V2Mt3z4yfrOQrB7RXr1TDFdEtdSleO+vM=;7:F03QHPhe6gfOyVAvEtQmeI68ancZusSby129TuR/slzstX228wvWRAL5G1JNhvv8hfA2lmAeALU0nAaOdIrNPbXDad6ZNduUxkiwMG41Qz1gd4NlsU4FoI+XX9C28LveSzD/ycsUonuln3v4YPeu8oiHwIlh59bF0iqSI8FXc3CYgxSwwIPz2TY3MpakD3aT3GeQp2mONI5KgOJ6FgbzqpNKmq1t4O+MgXRH93tzk9L3fCWNmDYG9K7or/czQZvF
x-ms-office365-filtering-correlation-id: f6242526-4479-4826-7794-08d610d647fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06290D7627E48F092BCB3D08FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LvYxmsPtyOP4qJFG4tAh9MZdJwY644c86xrgOCWy6Nn4cGR6HM0KdMELUBQtqoj9WCxBcnxvbvFZE1wYa8MhOybMytfHaUmi4ksQQ5Gnv1pfP9Pl8FeYGajZ+/bkPG3Iw32R0VtIVWyh4iQpGPiS6NueiwbetG2sNxc/g4rwCI3O+/UgnnAv/2Zfv8aGU45JTi1mTOafTA0+/2/dQrUXJ1pq1hwGfLOVgc0fOJHTy0CQMzykfNY6edBbUyjgvA37VD5vJ6qz3egAzNUy5OKiP0NA3FzUM/dxI/yDwAndObmPE5ylts1POez1ybObVK2h+UlyC0exWcMOqGxTAZUAuF7EeMxV16TTvmM71kAOdhY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <73800ED91CA1C04D84B7EED58B98F552@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6242526-4479-4826-7794-08d610d647fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:00.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
ZGV4IDE4MTFmOGU3ZGRmNC4uNTUyZTAwYjA3MTk2IDEwMDY0NA0KLS0tIGEvbmV0L2JsdWV0b290
aC9oaWRwL2NvcmUuYw0KKysrIGIvbmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYw0KQEAgLTc3NCw3
ICs3NzQsNyBAQCBzdGF0aWMgaW50IGhpZHBfc2V0dXBfaGlkKHN0cnVjdCBoaWRwX3Nlc3Npb24g
KnNlc3Npb24sDQogCWhpZC0+dmVyc2lvbiA9IHJlcS0+dmVyc2lvbjsNCiAJaGlkLT5jb3VudHJ5
ID0gcmVxLT5jb3VudHJ5Ow0KIA0KLQlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YocmVxLT5uYW1lKSAtIDEpOw0KKwlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YoaGlkLT5uYW1lKSk7DQogDQogCXNucHJpbnRmKGhpZC0+cGh5cywgc2l6ZW9mKGhpZC0+cGh5
cyksICIlcE1SIiwNCiAJCSAmbDJjYXBfcGkoc2Vzc2lvbi0+Y3RybF9zb2NrLT5zayktPmNoYW4t
PnNyYyk7DQotLSANCjIuMTcuMQ0K
