Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0080ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C7B21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eRDoI9xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeIOGvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:47 -0400
Received: from mail-cys01nam02on0117.outbound.protection.outlook.com ([104.47.37.117]:43118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbeIOGvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGv3RSyrMaRDDf+J4R0LUKikccUjn3zn3wfXspUQYHE=;
 b=eRDoI9xiAbMdM0n1Og9eaf1xsX46Wm0UMLuufblPZOYXAUQbSXAWn5Iii/SmmUq14NSwrLJZsoH5oQNLt8oXG50GCA9ZBz4M5p2xL7DvTcbq9lUJyG8vpcBIpZX0Mbn6zOWr5HmMY3glqLXY9Hk1zyf88cS9IuXTl57MV8Si4L0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Lu <wei.lu2@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 25/34] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Topic: [PATCH AUTOSEL 4.9 25/34] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Index: AQHUTJRFSIUhsNysKUyl02o0ubunCA==
Date:   Sat, 15 Sep 2018 01:34:41 +0000
Message-ID: <20180915013422.180023-25-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:/0fyho51HpHfZywvOU+oIP+S7EOngzV6gPozJQHefq5bQoOYTOd2WwkGAX0IhU4gz/SwY6piGZ0iRih873Y2wLdibJfexCufm+BDwDSI8jMQvRrK+IB59MF0awZzw8yMOFRfeyZrLuzXynPOC/E0qXZtiEY/Ht61wd16TXXq3uE6invjBCJf74tIqX3N2s+lz9aVIYgdSMeaAaPFPAHmFr+94R7QDT9fN4zjm9hopjAufXYtb2CEw/cXQx2wglg7O1UY+jAlS6OF6rlVyncKAp65ZGEzXKdDCan7lYLgVASHe1ZNVlYLS7oMiiSJlYwfL6SUTr8TNkkG7vRlqWfRq9PnedCd9YUMPF0ciJn9gsO/ia5U0pVUv+cQHnsbzVwwB9RKVV5AQCxbGd2fBRsw7nLBDi90J0uojIRWGNYAciNjGzd1aizPUQQLe0OVIDA4mfA5o8B+k10hAANFovPWDg==;5:sBzBNEkbCh6TUZzNZ4JaZ6j9N0SB4ZA1+XNunEuPJFoyAn/OSTkFOn5nvEIhqiGp/haZtREYeR2MPz6ufbKYg0qfdlaVK0bsw7azF3A5eanVb9rC4ZBcTZi7uWdI27We1Yfd4+HcOPbrDWUgg0P9ASbvBt6ySg/ylpTUpAvPWLU=;7:oDMnxIgj+3Qm43Jf+VSa+ZMCCxQGxPHVPag87atEa5uZYVAXYXdZ26PrOv8JQ1uomGbUEZq8iXgEbp9LkXopFHTdXR3tXQya2l3HQjhJ+64Yi++dXjHm9iJvklOgwJeAYdiHljRoJj6RAGU0kY1JDf+DTDksMWIEjI4+0GvZF+WNwmQrpTBjqbI6sP7N4ejcIeKAyQjqQCVKqc9HkFfrWPrRUdvvAhCMlJGBhCKD+iUlq/zc7l0kzGThA/XeYa67
x-ms-office365-filtering-correlation-id: 409eb2bc-b2c2-4f63-5498-08d61aab6865
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB0823CEB0A7C4BB54B62DC6D9FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(39060400002)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: DlYSgQ3BLYlq1jdD5dXsFd+LY8G6VRZHRK7TAkyPjBeuhWnhlFHfMT+e+2fOlLZG7Di+F4sBIvq6a0BCAaHcdcoBt8ze+OMAisUsl80+lQNy/fl4xjW28DZsya0B7XYW7I1vXV7S10oc5efMjnq02PU001LgXqBoqJbPF2Ghy76V8C5OdBqHF2c23hZt2x0Ube4Nn96j8Sjb10taXsFZOXeSQVR6CClpk5+BQRnZ+/jwsNUteNrf5MCe5stSa/YJNhHHb6FA5aHpe+7yFry8A1f3HFtNQ+03pZg3ZEA8fLENFNzecq8lamjVF4Yz5XhfTOJYuB8OGBVDdx+UbtgIZXoCKFeFhUFcNTv+w/f5V70=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <456EFC0BA9B8FD4CAD0F37ED7244324B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409eb2bc-b2c2-4f63-5498-08d61aab6865
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:41.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2VpIEx1IDx3ZWkubHUyQGFtZC5jb20+DQoNClsgVXBzdHJlYW0gY29tbWl0IGU0N2Ni
ODI4ZWIzZmNhM2U4OTk5YTBiOWFhMDUzZGRhMTg1NTIwNzEgXQ0KDQpSZXR1cm4gRVJSX1BUUigt
RUlOVkFMKSBpZiBrZmRfZ2V0X3Byb2Nlc3MgZmFpbHMgdG8gZmluZCB0aGUgcHJvY2Vzcy4NClRo
aXMgZml4ZXMga2VybmVsIG9vcHNlcyB3aGVuIGEgY2hpbGQgcHJvY2VzcyBjYWxscyBLRkQgaW9j
dGxzIHdpdGgNCmEgZmlsZSBkZXNjcmlwdG9yIGluaGVyaXRlZCBmcm9tIHRoZSBwYXJlbnQgcHJv
Y2Vzcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VpIEx1IDx3ZWkubHUyQGFtZC5jb20+DQpSZXZpZXdl
ZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCkFja2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfcHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3Mu
Yw0KaW5kZXggMTcxNDgwYmI5NWQwLi42ZTdlYjc2MTg5ZjkgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQpAQCAtMTI0LDYgKzEyNCw4IEBAIHN0cnVjdCBrZmRf
cHJvY2VzcyAqa2ZkX2dldF9wcm9jZXNzKGNvbnN0IHN0cnVjdCB0YXNrX3N0cnVjdCAqdGhyZWFk
KQ0KIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQogDQogCXByb2Nlc3MgPSBmaW5kX3Byb2Nl
c3ModGhyZWFkKTsNCisJaWYgKCFwcm9jZXNzKQ0KKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
DQogDQogCXJldHVybiBwcm9jZXNzOw0KIH0NCi0tIA0KMi4xNy4xDQo=
