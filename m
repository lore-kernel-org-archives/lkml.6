Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7781C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861AF20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EaS1dRXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861AF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeIBRXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:13 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbeIBRXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuAL2uQwZXH1X7lYJFMLEZ3B6EHRLdVghIzo4rEkVOI=;
 b=EaS1dRXBxFpdFzp152g0vvnWcRn8XVJ1rXz6+GUwF/W6fdXu0fna3mIBeWrXFLJ5Ppw/A9HzXTKwfjAmUz9L/tCdJlG1p4HK9qvTqq7UtSA5BepQYnQ0shHeSGwD+XLAfGRQaN6O0iyxN+UBv14DAx4V9WtLrvS/8WT9WSIkEKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 46/89] Bluetooth: hidp: Fix handling of strncpy
 for hid->name information
Thread-Topic: [PATCH AUTOSEL 4.14 46/89] Bluetooth: hidp: Fix handling of
 strncpy for hid->name information
Thread-Index: AQHUQr3XzZltNyRSU0Gerb7WHSWRNg==
Date:   Sun, 2 Sep 2018 13:07:02 +0000
Message-ID: <20180902064918.183387-46-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:2BOtXct39UpCvyC+DWcE4nlcUZz5HicNa5rTYmsd5eVduk6RYeLT3yGm/rM4Wy128/a3nvibXPE0nK9pJm8+J5SQ0L3Fiym2XH23GA4ziZZBICJoXx3mbVzhupMYIAZTq/miZtwnOFwzytnHhI0Kea1BGzFTqyiWHnu02O449iM6lIPdcZ8Y/Vppy8y7mbEUtHxOUjy/HNTPnYgY8BQ1yTQIfoFlEVO89P3ITLg8l7oankuWiyspOyTAsT2wMVfYXdVwzE5ui6Lpfry+6l7BwfnXl86pJYKAGVGv3goh7IHb1FiMsgENjyt+SuJh7zaXe63MzccmT/2g0dNYTZppr0e5+LIlRyTQyIC/P22ZQ8sQljPpp4q3w8oxnsxKt6oXNQu7vrOKEK0SFSUfSKBNNkvdxdTHsVeb7BtbZiUtwE471pBRvE9sO5I8HeNcMqtrWPaB7Okm+/tT1d/auLyUCA==;5:esgB79st+pHJdYp7bSbM4/4wyDCKstB31XH9wr5vPtbg74DmwWKC/8ncfg7J4AnGe5ETjZCyRTnO9EepgR95gMpqn6NgE3QsgtBNyeE/Ni/0ZByJf/7o7P4cI0m8PScW+GgJ0Pu/9T1yOal04w3gZYNoELkXNhi/HgYThZO3rJs=;7:xJUsZmb5EdG/6MhumxVCOj3u6EJbXMDH6TvBgJrL4HMoB00bfOMe4NQ6O0ZQsuV+ugxCmX40/LEe+f05yZ8ifEXkrgqP/EUkyxfYDoWraaoDvDahcJz01lC/sKpAqliWedNfkdrkRE0I4Y2jL/QugCiyK6myXn98/0ysRLqJcVd+Cim2wX+CECPr7UHTIR0Rh0w+k4NQrIIaBpPqRs8SvhVyrhz+HtZsVxbD51SZGEoPw8+duVbPZzN0mTswn/YG
x-ms-office365-filtering-correlation-id: ee9e8506-353b-453d-17b6-08d610d4ffca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB050361FD977EF336EDADC636FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dHCEZmlwbAEfPUIPCMX+CqCbOz6e2ImuECJBlfp9KMFFt6/lb3iIorT03ImdF/3pkQlAUmvJIW1BIJfeGIwzAFGEsGKOH7Pb+cKZjGY9aSzjCRAhhK+qLP7xaYO8gAw0vLCxECim52tYnuEn/4nlQ+b1p7UGHl214ytc+t1NG2bpyK8G0my01PD9DqJSoxJ9T4rfAFOxDf9YMEgVFDZZf0RPX3t6VZK/Ba/F03xHQmE6g/72oOpmovw9UCUtYh4n1e584VItbo2ZSNIL5mizTxjKdcFK6bSbID5/FhciZj9nR87B9cV3FwdDjABx/RiSOx7ogcUaTMvY0tC0vFF6xxiAAscnK9AVgHJBimmaPqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <37C5F90BB8815B4081474581E7D07F71@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9e8506-353b-453d-17b6-08d610d4ffca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:02.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
ZGV4IGNlZjM3NTQ0MDhkNC4uYjIxZmNjODM4Nzg0IDEwMDY0NA0KLS0tIGEvbmV0L2JsdWV0b290
aC9oaWRwL2NvcmUuYw0KKysrIGIvbmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYw0KQEAgLTc3NSw3
ICs3NzUsNyBAQCBzdGF0aWMgaW50IGhpZHBfc2V0dXBfaGlkKHN0cnVjdCBoaWRwX3Nlc3Npb24g
KnNlc3Npb24sDQogCWhpZC0+dmVyc2lvbiA9IHJlcS0+dmVyc2lvbjsNCiAJaGlkLT5jb3VudHJ5
ID0gcmVxLT5jb3VudHJ5Ow0KIA0KLQlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YocmVxLT5uYW1lKSAtIDEpOw0KKwlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YoaGlkLT5uYW1lKSk7DQogDQogCXNucHJpbnRmKGhpZC0+cGh5cywgc2l6ZW9mKGhpZC0+cGh5
cyksICIlcE1SIiwNCiAJCSAmbDJjYXBfcGkoc2Vzc2lvbi0+Y3RybF9zb2NrLT5zayktPmNoYW4t
PnNyYyk7DQotLSANCjIuMTcuMQ0K
