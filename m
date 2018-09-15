Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838BCECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3261E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OVGU5Rcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3261E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeIOGwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:31 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729909AbeIOGwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TpF3CTY7w5LpYW0DeQUjWV+HF9cMz6OZ2Ujp13HyM4=;
 b=OVGU5Rcv/obemXgwv5xCx6/iwKwl1yH/huLSb/hHKOjrRoQr1IqPVQ9mJ1oMWKkjcHK4eJY9OsA5F91+CzbOaMsl53K4J1uuCsSqze+CrYAiEoSS3nCVvpyloxmluNDnCVmgXVzmK9UTRaf8xVjMr9WNvDepTWSMO90AGQzBC0Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Lu <wei.lu2@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 14/20] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Topic: [PATCH AUTOSEL 4.4 14/20] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Index: AQHUTJRZLm+CkI7hTEChLh8OKKjNFw==
Date:   Sat, 15 Sep 2018 01:35:13 +0000
Message-ID: <20180915013502.180110-14-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:feR611EwfVDV0k0Zn+29f2ORqSp19PkwCAHZ2fLQ0Sz36JjtrvcA7UqP3QyImzM7JBZTVAfNf9D1c0T87RpJxuha/eGZac6euaa/vhfdGhosJhnscBOsveOgKGd8+IXfrbb6afhmTFdpaw7b0IaeVCOM0MZifGeH0KXibXMQWyp4vdh3s/Pia4j8V0GfZdnGiIDuAa2m447eUxE9qDvwdJqDy6YB8B0ONDNIqAS7fWNMb/4hIsAxBQLx8Nf6nOxQV0u7cOH1djdoI5TCMIUc+ucbbW4J0OkmFK9Et27ZWBNMx4G4461OEUdkk2EcEX5zw+28Yb9/R1ISC2wGPSmk8JBhtKgoEbha7RSUZbHKWd3AglUVjN8NQ/+HQCaxEitEjKmcXk8lnotLxvSYRN3SIqmjqVjKc9/vO9jW82P8D9nsFhyCUxErF0oDWZmWVUzXJl1Ik7dQQkck4fKXkoZJEA==;5:cWrZFDCFToSd6dFZep/qLmwbyr2ASX4d76STCLM0s+MYNJQN1paEt4BFJ/sAc8lqX0fOcmSX8+r4bouTqeSS9tLGOl5K0ThpyOWL8YsOnNS7pdfR7EZ/3qZmA+hCESrTn0ZOr2zFnYrnvDSmPQFaJ++gjlKMYmiifLruKZcu74w=;7:A7BUsaZQmCj1dQWoMsEHE+GfTTQybAP2SUUoeiTFNZ9phsznNTGG3HAELymukwSAtQnqQCz/ujIlYTINcLe8BfjEAg9zj2FvD36K/rel88CYdQ8SSZbXZxNiTFgCE4vPDPT2TEfAvptbVIUshwDbSul71xw62aB6wVfqzpyRAEwRSsmrDbk7KWX25FTpGhqZIo16rgYTrE2EfHPRvN3JV1QZlM8rJmiitDwc708a7qkt1WgzTMV2lmvb7ApbKIS/
x-ms-office365-filtering-correlation-id: 8325fc64-94ae-4d83-4700-08d61aab80b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181D8B710733B852F4B5354FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(39060400002)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: drKQ597H17I6orYC9iWxx6obI8ZrdtICebZVrkFEYysHnL3ZQFUrnKrmsCn244DVWalelKcySZTU8j1r+Onu50rxt8QzFjfanFvNXmwpRk0MKRthdl/GdcWilCzoj2vsisxoKzd80WSh79rhtDoh8QQOewT4N1AxUFJIu8kkg3bxlSVC/ZcwUblNr0vWl3GUzOajv8oWM79Ydw4h58CadTh+yCNFWGSYk1K6t/7Grn8x+SOBe9bDSvXv9cwETNjcSfemmYuo693OAEvrsfrWh7bT7RN4FX7WqsNm5Uzi9ln2e10a9JSJSIpyDCl/6YFNHTcqfF9wtH8eULnSKHOhk9YlFGdBcMuO55mVgbp8SQo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <90A9779FD9B4964EB5CCCC23789848CD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8325fc64-94ae-4d83-4700-08d61aab80b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:13.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
Yw0KaW5kZXggZWIxZGE4M2M5OTAyLi44Y2RkNTA1Nzg0ZWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQpAQCAtMTI1LDYgKzEyNSw4IEBAIHN0cnVjdCBrZmRf
cHJvY2VzcyAqa2ZkX2dldF9wcm9jZXNzKGNvbnN0IHN0cnVjdCB0YXNrX3N0cnVjdCAqdGhyZWFk
KQ0KIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQogDQogCXByb2Nlc3MgPSBmaW5kX3Byb2Nl
c3ModGhyZWFkKTsNCisJaWYgKCFwcm9jZXNzKQ0KKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
DQogDQogCXJldHVybiBwcm9jZXNzOw0KIH0NCi0tIA0KMi4xNy4xDQo=
