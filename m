Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A42C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9042089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vt1JjCer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9042089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeJAHQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:52 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:55885
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730142AbeJAHQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ789/P1cTy9qdjOWX6zy3OO0A2hOQ7yGYKzq/QxYVk=;
 b=Vt1JjCerw4lxaU5ICjNycDHGo6e5AJ3mGlqhLHVMzNDWJuLsQE3zQ3itqMk6odpxPXif/hAy1odybxcp6T1cmsdrsCM9XzLKoW78Z+GBpN3cp8IGT4cr+T9MmaTcvjg9UqVgfdVEFBm21nAEEDCLFtpjcu5gaj6qqpnY3hnIjaE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 07/17] fs/cifs: suppress a string overflow warning
Thread-Topic: [PATCH AUTOSEL 4.4 07/17] fs/cifs: suppress a string overflow
 warning
Thread-Index: AQHUWR99t4lDqorJtEadZkOwoIb5+g==
Date:   Mon, 1 Oct 2018 00:41:29 +0000
Message-ID: <20181001004122.147276-7-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:5c3CdVMpYNm11DDLm0wYUEV/zZEYcewsp0vJiG1AhGIUxRyqvHqVw9EMblosTRigyTHaLWDn1o5Y3aJaFp0vUdPyOHnLiNmiVbXoz2bwFZ3yiikczc2AasCRofHskZCp0p+5QwUB6fpLpXR2pg1KsON001UYVF6ksPhLR7nqfZ8RabWCVw/SM5fsTlqoI7IB18QpsABcR9S1ydisYy/UQ5iNFxu2BHbH2dGBDfCPkThjYtpMJChrh85NBzwCKiZXgZqzin+2UnAmjoKSnTzIbm5/BMieSGm7mM9RDE4P1WjQ5pF5e9XBSXUl9aSq1TJ52cLeRS7s2+8dfhr+xTQN88fR9VF5rksbbuuVkVVxDTXAcqzher2OPqzBrTkYyDgfyzbzacf+18iwmk4qLWiMPq1alutxiuJ8fvWXrSdOahQD149L70uF/xbd3V6oKBIfi5y+pBegvehbuEgfZnthcg==;5:9wFfAMIqpXIaEn4JVvkZUfiNzuD9cYAd5VqEeiCmK1NjeN9x5yDXaYNZGFN4VH748CnxDls9SW76vLSwrXm42fCAuF2iQQ5leD4WAEeiq5PfCevICcj4lMJqpTg/AGVNuJIa4U6YFNAkEXmQN9e+VUMwBIQyf09Vtp9aiJhixEs=;7:TFUWWsU0HOcVEOzyYe3e7cuCsmOBl1Iml1Eab5P+tpTX4hA+FKEPChRsUJzyMF9HZgdzIG6b6IphG9pmTjO///yY2YRn79E3gJDwHHX418bPsfDGXcg6J7inze53bh7CzLboa/SiCs43gbwq7M+Q/ENGGrvzdZX6LqxTHiF98mBSEPRxnEniABzCnkZU7MSONeEZP0PEEvAV9uWJ0avZgvNzgtMZ12XN/0azx8JPEnHGnGW3FClzRj77iopjcHFw
x-ms-office365-filtering-correlation-id: 2dbea262-8938-42a9-10c5-08d62736a059
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01652709F7CC2F95540125B6FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ekIEsPIIFem4SxptB/o1n7VtXQYp/2ZRLDzxOi1i5UMiwf8j1TMOF2PzCMGSs7m3qazdGXG4jd6rgGrvZTNjfeBiDZdR/WodYAMr+Bk1WSR+ItD21iKh/XR3NSiOzsZ1XNktwTrmveuYrXUL4rdo1tEs1VQdA8+oY2eWOI2mMOZvqQiw6iaytiKx6WJ6o2Treh2F3Sn2JK5s37lULNzpNqkbaq9az1uGafuT75WN07NwMvnFRO+4x9BTfHv/dX4QGFTEKEoyzJhCUu8nGAouagD1sFoT1uz3ZJa30mo1rJf4/VIKzZHXP2LeA4BJo8zCkHT3byF3UFDYrhwlQo7H8MNBykxlntlcy9t24qo0Yp4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2830C54819BE1498AB9902D7E5A8B5C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbea262-8938-42a9-10c5-08d62736a059
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:29.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQoNClsgVXBzdHJl
YW0gY29tbWl0IGJjZmI4NGE5OTZmNmZhOTBiNWU2ZTI5NTRiMmFjY2I3YTQ3MTEwOTcgXQ0KDQpB
IHBvd2VycGMgYnVpbGQgb2YgY2lmcyB3aXRoIGdjYyB2OC4yLjAgcHJvZHVjZXMgdGhpcyB3YXJu
aW5nOg0KDQpmcy9jaWZzL2NpZnNzbWIuYzogSW4gZnVuY3Rpb24g4oCYQ0lGU1NNQk5lZ290aWF0
ZeKAmToNCmZzL2NpZnMvY2lmc3NtYi5jOjYwNTozOiB3YXJuaW5nOiDigJhzdHJuY3B54oCZIHdy
aXRpbmcgMTYgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDEgb3ZlcmZsb3dzIHRoZSBkZXN0
aW5hdGlvbiBbLVdzdHJpbmdvcC1vdmVyZmxvdz1dDQogICBzdHJuY3B5KHBTTUItPkRpYWxlY3Rz
QXJyYXkrY291bnQsIHByb3RvY29sc1tpXS5uYW1lLCAxNik7DQogICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2luY2Ugd2UgYXJl
IGFscmVhZHkgZG9pbmcgYSBzdHJsZW4oKSBvbiB0aGUgc291cmNlLCBjaGFuZ2UgdGhlIHN0cm5j
cHkNCnRvIGEgbWVtY3B5KCkuDQoNClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gUm90aHdlbGwgPHNm
ckBjYW5iLmF1dWcub3JnLmF1Pg0KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5j
aEBtaWNyb3NvZnQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5s
ZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZnMvY2lmcy9jaWZzc21iLmMgfCAxMSArKysrKysr
Ky0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNzbWIuYyBiL2ZzL2NpZnMvY2lmc3NtYi5jDQppbmRl
eCA2M2FlYTIxZTYyOTguLmI5YjhmMTlkY2UwZSAxMDA2NDQNCi0tLSBhL2ZzL2NpZnMvY2lmc3Nt
Yi5jDQorKysgYi9mcy9jaWZzL2NpZnNzbWIuYw0KQEAgLTU3NywxMCArNTc3LDE1IEBAIENJRlNT
TUJOZWdvdGlhdGUoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfc2VzICpzZXMp
DQogCX0NCiANCiAJY291bnQgPSAwOw0KKwkvKg0KKwkgKiBXZSBrbm93IHRoYXQgYWxsIHRoZSBu
YW1lIGVudHJpZXMgaW4gdGhlIHByb3RvY29scyBhcnJheQ0KKwkgKiBhcmUgc2hvcnQgKDwgMTYg
Ynl0ZXMgYW55d2F5KSBhbmQgYXJlIE5VTCB0ZXJtaW5hdGVkLg0KKwkgKi8NCiAJZm9yIChpID0g
MDsgaSA8IENJRlNfTlVNX1BST1Q7IGkrKykgew0KLQkJc3RybmNweShwU01CLT5EaWFsZWN0c0Fy
cmF5K2NvdW50LCBwcm90b2NvbHNbaV0ubmFtZSwgMTYpOw0KLQkJY291bnQgKz0gc3RybGVuKHBy
b3RvY29sc1tpXS5uYW1lKSArIDE7DQotCQkvKiBudWxsIGF0IGVuZCBvZiBzb3VyY2UgYW5kIHRh
cmdldCBidWZmZXJzIGFueXdheSAqLw0KKwkJc2l6ZV90IGxlbiA9IHN0cmxlbihwcm90b2NvbHNb
aV0ubmFtZSkgKyAxOw0KKw0KKwkJbWVtY3B5KHBTTUItPkRpYWxlY3RzQXJyYXkrY291bnQsIHBy
b3RvY29sc1tpXS5uYW1lLCBsZW4pOw0KKwkJY291bnQgKz0gbGVuOw0KIAl9DQogCWluY19yZmMx
MDAxX2xlbihwU01CLCBjb3VudCk7DQogCXBTTUItPkJ5dGVDb3VudCA9IGNwdV90b19sZTE2KGNv
dW50KTsNCi0tIA0KMi4xNy4xDQo=
