Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF8FECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19BF20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F9bfRaMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19BF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeIOG6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:58:55 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:42981
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725753AbeIOGuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kWqh90M6kqz7WX+tVTfnzVUdgocUmXjqvc9si3Nocc=;
 b=F9bfRaMCSI3SAsLqFMV1tFASNnK396DhyN2iYJIuUeYsfenBikQhjTzcdCx2m9j56weSh3izCUuMPUXSO76bOHLZxmWbiZ2cvG57AK7/kXxzMiK+uKH8BJG3fWp5uFStUKxgttx7KsRGORqaGJImWWQTvRPFjVgUUnWrfGKp5Qw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Lu <wei.lu2@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 43/57] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Topic: [PATCH AUTOSEL 4.14 43/57] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Index: AQHUTJQHbbKzjg0IXEOocHPrBrRArg==
Date:   Sat, 15 Sep 2018 01:32:56 +0000
Message-ID: <20180915013223.179909-43-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:0kEiM9qWmzRzAQlBetTO4ErqDu7YB6b/6CHggAqmR7pSGkLzEiKsoa43pJywOPjkGKl8l/N1fgxXiHNKBd+T7U4BpkpV1p4cMBUlKKDgh6/29YGyyufhpv+pKyLRsApEBTu0OWBY73a2OSYBRKRWCikhlg+nr86CF9UUHfTgDVs/zYVRt6/HnfWCf/mIikkUQQ8kRHHPYDOK4araLjbj4zrRaxCe1QkF6c4fjBlehfcBcjglKcXDZ1skepjCmCUxJg0uvkKZqgS2vcGACSaLVJsDTwWxCGYbZMVF+1doIkA395bMC60o72mRnlSnchmw3LyMVO89avmOcANHxvhAqB8YHT5Ez5+XjlBxAmm14Y7M9+70oTFcRYfXwQ+v+dUbpT7B43Hjbhimk8BFESRitxKzcFLMAE5+dymEYPAOnzHvcoIxdwwQ5/mZvLHRBjmH7ddKSgrf/bGv2LNC8vFrkw==;5:+x96PCzfLXyJbEDQb6HdTeU0lvqqsKRB21Pz0H+DwQ3mXNeF4MeTEUnY5zs1Y/QSJQCF/Ox/SUl4SOavoYU7UUd0RsVwRIkzOOvrnAWuNMglfKJRQbdHnmFHuGcsszdptxwGWCDTH0CE0Bu+oe6kAz4C58tCkHSC7dh2QZe1/Fs=;7:UbBsHZJIAOsDYnouRWjUKHF+0B8abx+2kijM/abL9jXq5XyTYFtYIXJV9usLJu40WKZ4G6w0lsm4cAOPHRAtTN16jjDCcl36N8WQ+YZmqQU/r9vPYffmhlnJAdKDHa8jXMnLVqFnSFRQbKk9D+k/hSVu4tIgmsAC6DOs9m6z6rzYEp4WO3faEQzoTHGUnBOb83qBO2qF9l55haSPbI4fYMVMAupcJrfbDVXHqSLP8Rpg6aPZhRLNqzUjSoQ+Qlzp
x-ms-office365-filtering-correlation-id: b04b0498-8ebe-44d7-de70-08d61aab39e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471DE685A56E469967E989BFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(39060400002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 82+qgbMmnAqw4E6rSJw/cKen3t3Fcs4SCuWbLQDTmBoU48y9yxG0kojYBHqxFaqKMwHOq8MIcxLG/AhWZ4gzHe/mULa/RHCR34IX6PmpfEidE0dohAHIKPYoHBDLrbgtb5f6cnb+7OGMTrxOxIVtrbjGdFvKrX8y36eV9QVUQyJZxPdX/iAxWun0NyWQfAIYJUceyMdJrGpEPHCWzo3GKE9vhhLvXPCsN8KJk7M9bwBh5ult7CGLlc4qIvQX/NyPUJgrVDpiFH9rUdyFM7YV35vsPl4ui62KhiR28Xb5RI+jCQEuj6p0IdmTFdOY0BE5f0TZwpLas8w49JE8p6wP3GWuX6V9wSaeawOj66ZkgMk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B7504055717274EADA0814C7C93C9A7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04b0498-8ebe-44d7-de70-08d61aab39e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:56.6334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
Yw0KaW5kZXggYzc0Y2YyMmExZWQ5Li4zYWU4OGRjZmYwOGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQpAQCAtMTIzLDYgKzEyMyw4IEBAIHN0cnVjdCBrZmRf
cHJvY2VzcyAqa2ZkX2dldF9wcm9jZXNzKGNvbnN0IHN0cnVjdCB0YXNrX3N0cnVjdCAqdGhyZWFk
KQ0KIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQogDQogCXByb2Nlc3MgPSBmaW5kX3Byb2Nl
c3ModGhyZWFkKTsNCisJaWYgKCFwcm9jZXNzKQ0KKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
DQogDQogCXJldHVybiBwcm9jZXNzOw0KIH0NCi0tIA0KMi4xNy4xDQo=
