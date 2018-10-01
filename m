Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FEEC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC522083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HlFegPuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC522083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeJAH0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:26:55 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbeJAHOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpO0Ja2T7GQ+Mic0A4upMp7c5+zP1EtSZkjBOMX5r/4=;
 b=HlFegPuYBh0I/lSY2upWfXOgY7V1SdvrLLC5z9sNDrkuitc4fobgKU4vmEH+t1GR+qfvRR4PQ8q9sgXelM+NMhxh3bat6D6bXhoW0k0+GFaqYa9gNty9CNl4oD3QoBtrGsMATNYueYbdqGAF35F0Gg7UR85AJSGATjESCFWRJO8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 39/65] fs/cifs: suppress a string overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 39/65] fs/cifs: suppress a string overflow
 warning
Thread-Index: AQHUWR8RZGXjAPgZrUO71mo1Ckr61A==
Date:   Mon, 1 Oct 2018 00:38:27 +0000
Message-ID: <20181001003754.146961-39-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:erFITgtmMjJJOrxAQkph7hLHudMQTE4Vl7JJwpJwpVqwSB+1JiDDkE6Q5MOF59PTNrzmasc2eOzVOzzHLCV2hospwzgXsXpmSudXhCR5QKlxmv/fBzLDOvEhQml5enCgNFsx13JM2sGh94z5GPLWPvlinY42STQ36uvCFmQv/d5vFRrjCTvnS/0sv3p1FuQNuLvk1niFU9QFEISWNk/FF1kOTmk1LTonW7COvjdIORrN0DomKyowPEWoZVkLQLRqIN/IccWIsSMixEp5wTOzA0wUYvt+ukqAJh5tlbydoUCw5oKi+TZLApjf+KmXLzrSN1efagePrfwCbAoUWNkUmWb+oVszxIJHhwAVUbti3rajdtN6vvY+vwqOuQmcDcXZY3PWWv6/Hoggw1DbSPfWiS7RnUN4JdhgK6qOlxnGvw43kysW/Ff4DIsqSQqBVrF9zRpcgtGpI0hD8lZECsl9hQ==;5:kpvpfTKp6eRCTYfP7wqdBIt4EThXk2v/VfqPywqX3644s0szCvC+fa3+zrmas3zVLHe143fayS4atYSCpy3k6KNaD3EaEzWszWhatdHKc2OcpYOh00EfX4E8F2PaoqoNwZNQ3/8jQL9WULLltJWlAaNvnLmj+xG767nlySeRiaY=;7:XT8j5LNCrK11zGHHDGrD8Dx/zkjezr3szimt7DKl469c5oJG/4ygRDtndevyL3e6QQQExzBwDwWwQzN6w4QAD8wJRZYRvonjv/EpQht3XNzKV84uqQI/ibrEmK+mqI4oDlZ/EmfWC6JL87usNfCgt9y+QMmwH9jYHz7pifpjMuUYVKSMSo8QLnEDV2wtRdMYJI/+d57Bw87O9Sg/VHrU8HIEg3MT856/9JonEM8knlmYsI8awBCTEz/9Tzy1cyxp
x-ms-office365-filtering-correlation-id: 4bcd2d84-33d5-4528-7648-08d627364517
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01814FEA108D6846064044F4FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vsF7c7s/4Cd81iaspf5hO4lt76j7qpVEnMlZsFg6CZLS/+T2zYtjYZifxlGSQhJq1/ZTMHtL8vU5kiQFFivK4/iwm8mR4wcQN/y4fDjHxEJAwjfclKkBfz7OSBGObAOIAExKfdg/ijTSH3Yv3GJqBeiaG4wLCV0d1gYE8/Or6zAjQeQGf9h3hiyWuk4RT9bb34ey7fKrS4Yvsyn0NYs1Dv8lwtr7BceOVjri68Uy7679emobCfnVoSouLB+OORLdPTQ9go+NKR+c1IE+K9ImY4i8caaI4BIpAA6+rUSlSYqGX/GQ68uket5k9PgbQPPIcycp8ZKiez7glSnukWcf3FiSrhS0tN70OLpcQhvUKtI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA49954E83D024780BBFDEFB849236B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcd2d84-33d5-4528-7648-08d627364517
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:27.0506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
eCA5MzQwOGVhYjkyZTcuLmY1YmFmNzc3NTY0YyAxMDA2NDQNCi0tLSBhL2ZzL2NpZnMvY2lmc3Nt
Yi5jDQorKysgYi9mcy9jaWZzL2NpZnNzbWIuYw0KQEAgLTYwMSwxMCArNjAxLDE1IEBAIENJRlNT
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
