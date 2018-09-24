Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8CD2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R/Hav+Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8CD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbeIXVLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:11:00 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732914AbeIXUvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5VUru/kN2GmKfrcfyhuqVAxhiW3b6ayUTXKrlUdeDM=;
 b=R/Hav+Gv16/WDFDFDtson/eQrJUQahLgWQX5uWtLw/fIUGvYW+UYdsWgrmPtitQWPkw4kKIxuR6OZr+LAKHckb+XfjcOp0oV4a61UuuT2Z9NYcmcOJe5hS7UEEuvDnInVHTFi5YsTtHBgohDzxw7wpDWpK54+4lLT1Bd3s+r9qE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Raspl <stefan.raspl@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 41/76] tools/kvm_stat: fix updates for dead
 guests
Thread-Topic: [PATCH AUTOSEL 4.18 41/76] tools/kvm_stat: fix updates for dead
 guests
Thread-Index: AQHUVBWm2MTqkPEAwkKKrChOCbRcTg==
Date:   Mon, 24 Sep 2018 14:48:27 +0000
Message-ID: <20180924144751.164410-40-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:zRLekNEsgwFbokocwhCA1nNub+IP7aaxKnV73T1bmMTf3cwUN3Dxhn4enp/p/YcWgNbkdTqoOC9Bfq9PzbGZoLu3UoE81ammW1AKeS+Dnqnx993lLblyMG0pBGKNO3iUNRanqs9UaP/601uUES5f8GG4oeZDXM4ltdr6rQzI46s8785rM6k+MA7VGQUGAhkLjrU5SFxjixrXCjhtk9LYFqFhqsa7Bgn2sdXx5Iv8C0BmkyFzWO3tXuj3HLzWnEePlN1D7AJw5njFD77EzUVVLd+udQc7ZhvgJZrbtNsdbXFVTZpo8MymIa7WksrOrFaj2VKzJEbcudoJtjTTi+65fAcipnTSFtBGSk1zfXhfFSkvmjXfbBwBW1sYYu4Ezts8Y6X2YjQy51YBYsvUkJKu9tLufCIBHEXchNWlR12EMG0fsNz/+Gk8IlzQL4HfMsSYEvsHCmhV4YFN+TPrINWUUw==;5:sd5pKhaLLnmw3g/X7EFI6WY8FMOXaGBElRuFJ1hbZJVyn4Ub3GEBOaniqUTAoxZpuC/6YDLpcPZlklRuFiRZJ/KeMc2nC3MAhbTqTBIvjsOqc3UChN9BiR0NTdo/GGWsgjP3M2zGKM+De3/CDrKun1Y9y4ZOSkpWdxYjv6Ttbls=;7:cHAV12AAgBtBR6FlQQc3cP+comr4HWOVTcvnXco748yMzp6ex7EXZ5D2vJPK8UJ7RVg2K0JUMaoWM9Sk/tydtJcEzXaBat6BBbbBKag9WC/C8gMDo4XtYLbeQPSdn2ewP5oY8s9FcKByNE1K61VReGqAgaLVDHiaoT+nTAe6f/u80p/5RpdnmgZwB7ExUZUUL8HWEY0JmTfxwnOsIbzyrK1H8N4vl13hRk0shOFCssh8n2FDg5NJEGLUWxgPn9Do
x-ms-office365-filtering-correlation-id: 40cf1910-2e62-44ee-590b-08d6222cd9c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08559EAE79F111281FF8F482FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c1hFOcbHiQvfuO0ywRTiak2+mW8YJZ4nrcu+klNFB5UVu+pq0U123wg7Jwsgl8GTbdZNt4TaeSemJyIL9Ci8B+f8MOkVq/4STKcdD/JnndV8kr6zk2QgIwNp3sv/KkhXUS/VSmvugOim71hofddUctQJOFEyiC+KZf44FDYv7y4sxr8Ph0eb4egH93ajVTvjalKI1yFRDdxpoZxT3AU5WRcR+9R31Ubv1hHdjaInBIxa4YokTkf02Eliz4zijdozTXS+8liJZGjgoCO+UfQUM4/MdAaurU8FqrRpKHVmI1aW9Mfc//xdpAYIkywkeQJQZc3UNQ1zU9Wz9UWQH5jqID454F70pF9mxj0B3lmDpoA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F8F8BAFDA76C747A31A7E82AEF6DCAC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cf1910-2e62-44ee-590b-08d6222cd9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:27.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIFJhc3BsIDxzdGVmYW4ucmFzcGxAZGUuaWJtLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNzEwYWIxMWFkOTMyOWQyZDRiMDQ0NDA1ZTMyOGM5OTRiMTlhMmFhOSBdDQoNCldp
dGggcGlkIGZpbHRlcmluZyBhY3RpdmUsIHdoZW4gYSBndWVzdCBpcyByZW1vdmVkIGUuZy4gdmlh
IHZpcnNoIHNodXRkb3duLA0Kc3VjY2Vzc2l2ZSB1cGRhdGVzIHByb2R1Y2UgZ2FyYmFnZS4NClRo
ZXJlZm9yZSwgd2UgYWRkIGNvZGUgdG8gZGV0ZWN0IHRoaXMgY2FzZSBhbmQgcHJldmVudCBmdXJ0
aGVyIGJvZHkgdXBkYXRlcy4NCk5vdGUgdGhhdCB3aGVuIGRpc3BsYXlpbmcgdGhlIGhlbHAgZGlh
bG9nIHZpYSAnaCcgaW4gdGhpcyBjYXNlLCBvbmNlIHdlIGV4aXQNCndlJ3JlIHN0dWNrIHdpdGgg
dGhlICdDb2xsZWN0aW5nIGRhdGEuLi4nIG1lc3NhZ2UgdGlsbCB3ZSByZW1vdmUgdGhlIGZpbHRl
ci4NCg0KU2lnbmVkLW9mZi1ieTogU3RlZmFuIFJhc3BsIDxyYXNwbEBsaW51eC5pYm0uY29tPg0K
U2lnbmVkLW9mZi1ieTogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQot
LS0NCiB0b29scy9rdm0va3ZtX3N0YXQva3ZtX3N0YXQgfCAxMSArKysrKysrKysrLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS90b29scy9rdm0va3ZtX3N0YXQva3ZtX3N0YXQgYi90b29scy9rdm0va3ZtX3N0YXQva3ZtX3N0
YXQNCmluZGV4IGI5ZThkMGRlZjFhYi4uN2M5MjU0NTkzMWUzIDEwMDc1NQ0KLS0tIGEvdG9vbHMv
a3ZtL2t2bV9zdGF0L2t2bV9zdGF0DQorKysgYi90b29scy9rdm0va3ZtX3N0YXQva3ZtX3N0YXQN
CkBAIC0xMTcwLDYgKzExNzAsOSBAQCBjbGFzcyBUdWkob2JqZWN0KToNCiANCiAgICAgICAgICAg
ICByZXR1cm4gc29ydGVkX2l0ZW1zDQogDQorICAgICAgICBpZiBub3Qgc2VsZi5faXNfcnVubmlu
Z19ndWVzdChzZWxmLnN0YXRzLnBpZF9maWx0ZXIpOg0KKyAgICAgICAgICAgICMgbGVhdmUgZmlu
YWwgZGF0YSBvbiBzY3JlZW4NCisgICAgICAgICAgICByZXR1cm4NCiAgICAgICAgIHJvdyA9IDMN
CiAgICAgICAgIHNlbGYuc2NyZWVuLm1vdmUocm93LCAwKQ0KICAgICAgICAgc2VsZi5zY3JlZW4u
Y2xydG9ib3QoKQ0KQEAgLTEzMjcsNiArMTMzMCwxMiBAQCBjbGFzcyBUdWkob2JqZWN0KToNCiAg
ICAgICAgICAgICAgICAgbXNnID0gJyInICsgc3RyKHZhbCkgKyAnIjogSW52YWxpZCB2YWx1ZScN
CiAgICAgICAgIHNlbGYuX3JlZnJlc2hfaGVhZGVyKCkNCiANCisgICAgZGVmIF9pc19ydW5uaW5n
X2d1ZXN0KHNlbGYsIHBpZCk6DQorICAgICAgICAiIiJDaGVjayBpZiBwaWQgaXMgc3RpbGwgYSBy
dW5uaW5nIHByb2Nlc3MuIiIiDQorICAgICAgICBpZiBub3QgcGlkOg0KKyAgICAgICAgICAgIHJl
dHVybiBUcnVlDQorICAgICAgICByZXR1cm4gb3MucGF0aC5pc2Rpcihvcy5wYXRoLmpvaW4oJy9w
cm9jLycsIHN0cihwaWQpKSkNCisNCiAgICAgZGVmIF9zaG93X3ZtX3NlbGVjdGlvbl9ieV9ndWVz
dChzZWxmKToNCiAgICAgICAgICIiIkRyYXdzIGd1ZXN0IHNlbGVjdGlvbiBtYXNrLg0KIA0KQEAg
LTEzNTQsNyArMTM2Myw3IEBAIGNsYXNzIFR1aShvYmplY3QpOg0KICAgICAgICAgICAgIGlmIG5v
dCBndWVzdCBvciBndWVzdCA9PSAnMCc6DQogICAgICAgICAgICAgICAgIGJyZWFrDQogICAgICAg
ICAgICAgaWYgZ3Vlc3QuaXNkaWdpdCgpOg0KLSAgICAgICAgICAgICAgICBpZiBub3Qgb3MucGF0
aC5pc2Rpcihvcy5wYXRoLmpvaW4oJy9wcm9jLycsIGd1ZXN0KSk6DQorICAgICAgICAgICAgICAg
IGlmIG5vdCBzZWxmLl9pc19ydW5uaW5nX2d1ZXN0KGd1ZXN0KToNCiAgICAgICAgICAgICAgICAg
ICAgIG1zZyA9ICciJyArIGd1ZXN0ICsgJyI6IE5vdCBhIHJ1bm5pbmcgcHJvY2VzcycNCiAgICAg
ICAgICAgICAgICAgICAgIGNvbnRpbnVlDQogICAgICAgICAgICAgICAgIHBpZCA9IGludChndWVz
dCkNCi0tIA0KMi4xNy4xDQo=
