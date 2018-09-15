Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C286ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2B4208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J9F4nSDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2B4208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeIOGsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:33 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728723AbeIOGsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kds8D89RsUlqY4DTXi9G0+oE8bL9ole4XiI2mD3CMug=;
 b=J9F4nSDvuhfZhtArMSeCSIp9yg9+LYfvQrpnc0tdSQKX5Axy9j1QbheSg0eWPHAln35eho+ML3AKZ6BumEveAOAJX/XS6onvcoMz1DGhCa9SWv7At+KnEK/GEte/A5b75rAGGd9s9ThI5yzsyOul5bF6tlf78UEkVfk0n0FtyYE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Lu <wei.lu2@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 66/92] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Topic: [PATCH AUTOSEL 4.18 66/92] drm/amdkfd: Fix error codes in
 kfd_get_process
Thread-Index: AQHUTJOzFZF0xVBrl06dIwcThOqpYQ==
Date:   Sat, 15 Sep 2018 01:30:35 +0000
Message-ID: <20180915012944.179481-65-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:zEbRjYBI8ixgrKCh+CW6/j3BHoxF98Onr0pWlj4RDV8mKfWR5gvViiKEb8z94pKF5kZmw41VjUNfPA4VjKzCZeuZOgoJrPnngbg4TQxZXZjwZk86K4Mn3XJgvsd+AFDMNse8mIzNx0EUnxhW264OMrslqfdZ1EV3sR9pwf8byaDVMcrQKvfJHUX0k6K/6WEqMxhYI7g7JEFBytFx4duE3tT1I4iJ8Bstcp3nabroi2noPkzkJmk4Mri7nifyUxFsJYbaLQd/+p1xz0DdMXJksa3/cufVuPT1XioBhAYCbegVkUZsAV/3jWrxTG9+50OGUQGEW2WK3occg1/SQnjAAHAFmtoQh4bQYsgDzT9zOYpP5FysA34MUEwZTCLJkh3SX1nzEVJ59Ga4eMieXiQbe7dWrJu33Kc2LqSMlzZXA4l6Dvhi4Vr6WH7DnXnN8954zmM0gC/6IXLO3KduJN03Og==;5:F7oN1t0zC9FpOL0sso/7Fr9ctLAlhqlg2JHXzzn+fUKuV/bwi4erZ7D8UELRn/9RVq2oFaZTb6O5r1T4DIPwUJbgurwCC55GQ0HxTGURCp/yAsDgF/5cx3DAaqY/4n20/GmA6BkKfmAI9raHCzBpmwvZxWWCmI4MFcTVDbx0nRk=;7:2kPOVd71flFIyDG3L92eCkX5lkUiB9LZ4m5Lh6dee7NpNzQGqsgN1C9r+8yU3rEBeNPTJDgE8YTyGSmPZhMtqK8dUPA4bLuvciSdf1+XekzlWIksN+n58eqLqdmdab3/2tilnAD6JRAleXxTwo1z/mCpkvtCXoIFPJhGcmtfjz3F2x/+FEfzB1zYEbO5UOU71IBylnIkY69yqHPWkKuVzSKfeTJ66de+EM044Yvk+000CJ2XxqiZzjnSjJJeOu+d
x-ms-office365-filtering-correlation-id: 4f97d3ea-6156-4923-d39e-08d61aaaf7db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470659A663939197745D552FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(575784001)(2900100001)(39060400002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6yrtlrwSZ6lHn4b7XDKN5WQfs0AvWEc9AEm4ascbpPyYeHk4hzV+jwgf0wXq50UF37xKFeJLqApHhYKJSnRL4/5Wr101u0pn7vQp8XLKYtim3Y1anDXYX1rub/HlODADLMYEXz/cIJZc6EZPXQqB8TkBhXBHfqPq2MTiANv37X/n6gCbhXZKOjnswTYURy9uWj0bL35Vt5z23tZ/vshKyrp2pjxRizsGrLu+AoQ3WstbI0Ve6aq7Rn7Mimk2HMkoPlo0PtnzHDFo5enBmfQ/DOfWkgiYYvXH8f7MtLLWwg3t/WImfGULPtkJHtsj+AcDJQJepuSHc79qii2XARZ0QXS6DmeWcvISYT42EgSr7oM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C802C3493F02034DAC6BAA95EDB98683@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f97d3ea-6156-4923-d39e-08d61aaaf7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:35.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
Yw0KaW5kZXggMWQ4MGI0ZjdjNjgxLi40Njk0Mzg2Y2M2MjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQpAQCAtMjQ0LDYgKzI0NCw4IEBAIHN0cnVjdCBrZmRf
cHJvY2VzcyAqa2ZkX2dldF9wcm9jZXNzKGNvbnN0IHN0cnVjdCB0YXNrX3N0cnVjdCAqdGhyZWFk
KQ0KIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQogDQogCXByb2Nlc3MgPSBmaW5kX3Byb2Nl
c3ModGhyZWFkKTsNCisJaWYgKCFwcm9jZXNzKQ0KKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
DQogDQogCXJldHVybiBwcm9jZXNzOw0KIH0NCi0tIA0KMi4xNy4xDQo=
