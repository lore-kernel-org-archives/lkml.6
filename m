Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B0ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BEF214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DUF43f0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BEF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeIQIZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:32 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbeIQIZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZRJTkCDiNuUbEtiI5F77RopqKvbdMM7xU1uctsvBAI=;
 b=DUF43f0QyDAwBNN3nSHrW+rC/4WavyVi5+1KeOFog99s1ekfFSlhYfsnhrtGupYykFBPta3h43to4k5LQEzLvjC7/hhck1IMAz4WtOCC/SZ/5ICmP0d5JPVVPASCUMCR8OqXIIZqOtXjeFinEPkOuUc/Y6RchUiDh68QWywxKRo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 006/136] siox: don't create a thread without
 starting it
Thread-Topic: [PATCH AUTOSEL 4.18 006/136] siox: don't create a thread without
 starting it
Thread-Index: AQHUTjKOuV+Of3fN2024e3nj/9cIhw==
Date:   Mon, 17 Sep 2018 03:00:14 +0000
Message-ID: <20180917030006.245495-6-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:ohUYY7y3gUsejzW71ZV9vIrzsVdI7fsmIDUjUXQLM5PQGK05BMPk7c14PdLS7n1/5MVJnCDS+r9abFriSV/bPKanIt6LkngE2nZYB1hyylKDWwxTZx4pnTw0/dzqxcbingX+UZDczYtS0UEbtCE+DpAXlmV6+CPkp6L+lV7Wifcxa1gMaG4RcfaULKtqrg6AarZ8+NF089TTqogQkiLRR+rbZNhxOoIw+ck8bx5GdJldbteRqyGt/P4vVJHVcIBubuEEnEyeSVcRUFKkjHChPCd72dn5h9fv/PfglhQYNETAmG7RRrmCIowMTfbCKsFZG1In9sjuds1+ziiRq4xMnYj5VNAuGWvtV9uTPVgWVjSPMeiuI93vrVeUigwfHKHhatScLnIiXoEu+EzVsl0pYxl0c6NAY0+U1TrDlrUaatvWlaIKwqsxlzaLlbZSH9vQa5F4OyEsDHoraVPrMzVLMQ==;5:dFutmzUq5JzPzvULcBPC8387TonmVlWgy6NjDDdy7deNDu1X2X56N6Eqkh7ypGYaiW7GmnQ9XbhekPTRhsN4ChrpSi5G1Ms57ibRMM0TgVIwKbVWJO7KOPf6OtaV6XHa5afRDgirQiR8XYaPBlvUJwMvWjuZHVw9/rdRPyEhEF8=;7:/V6eln02RXqBWv9GQM6gqCb5+xPnY5K3XpxQzHLssn7yUseurZa4R/TVpUI7ctsVRWEADk1OA4yjDnwV6UKNgkqm9mYxKeIdYfs2t5bqTJMypLhI3X9pJgXovwgHC7QOr/McfoFn9T3I77EiVQhKk1Qs8ufbk/5lk89zr6O5qjNMVDYaGraOFD+iboJ2B2PM1HvmvgjjR9j/HfEPG7v3J1G7LUkItRY/g44zhoInLgQdtEDGJG89jjFS+fYFYwXY
x-ms-office365-filtering-correlation-id: 2585a41c-e8c9-412b-3184-08d61c49b0fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134771A1F44D518A7E8CDBCFB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(575784001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h1w/zt2kGb9Z8Q6fCFxvhrUbd5I8m0l9nD0yKAWsmTrCeiff+XY/UthugPS4wrE27u/FyvnFCPP7zDXHxOqDhmXqF59aCBZxWIOCD61/3Z96Y1jngeInmFalX3APdNglXgRRdFNEi4BzfkpHvLbe2nGJx6Aw6D2ptdCIhpO0ZTPbBdSZIWBk40jkrBkVucDhcAz73NzRvz+HAH9yvx3VG1oNGJ4R8Dfjw35Fv/01R4btudCaYQiJfyASCNUx8cqvtpJOH2biciW1MoUANyp5gxGf858q/fU348wX26IsfCzENMaSYgXT87jirYZPEjK873aFsRwVx0Ji51OHSpyh9FrRrDwQwmiCGv4ggSf5Pyo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <268DE8CC23277547A8A8327F733A43D2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2585a41c-e8c9-412b-3184-08d61c49b0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:14.6361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4N
Cg0KWyBVcHN0cmVhbSBjb21taXQgZTg5MDU5MTQxMzgxOWVlYjYwNDIwN2FkMzI2MWJhNjE3YjJl
YzBiYiBdDQoNCldoZW4gYSBzaW94IG1hc3RlciBkZXZpY2UgaXMgcmVnaXN0ZXJlZCBhIGt0aHJl
YWQgaXMgY3JlYXRlZCB0aGF0IGlzDQpvbmx5IHN0YXJ0ZWQgd2hlbiB0cmlnZ2VyZWQgYnkgdXNl
cnNwYWNlLiBTbyB0aGlzIHRocmVhZCBtaWdodCBiZSBpbg0KVEFTS19VTklOVEVSUlVQVElCTEUg
c3RhdGUgZm9yIGxvbmcgYW5kIHRyaWdnZXIgYSB3YXJuaW5nDQoNCglbICAyNDEuMTMwNDY1XSBJ
TkZPOiB0YXNrIHNpb3gtMDo2MjYgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRzLg0K
DQp3aXRoIHRoZSByZXNwZWN0aXZlIGRlYnVnIHNldHRpbmdzIGVuYWJsZWQuIEl0IG1pZ2h0IGJl
IHJpZ2h0IHRvIHB1dCBhbg0KdW5zdGFydGVkIHRocmVhZCB0byBUQVNLX0lETEUgKGluIGtlcm5l
bC9rdGhyZWFkLmM6a3RocmVhZCgpKSBpbnN0ZWFkLA0KYnV0IGluZGVwZW5kYW50IG9mIHRoaXMg
ZGlzY3Vzc2lvbiBpdCBpcyBjbGVhbmVyIGZvcg0Kc2lveF9tYXN0ZXJfcmVnaXN0ZXIoKSB0byBz
dGFydCB0aGUgdGhyZWFkIGltbWVkaWF0ZWx5LiBUaGUgZWZmZWN0IGlzDQp0aGF0IGl0IGVudGVy
cyBpdHMgb3duIHdhaXRpbmcgc3RhdGUgYW5kIHRoZW4gc3RheXMgaW4gc3RhdGUgVEFTS19JRExF
DQp3aGljaCBkb2Vzbid0IHRyaWdnZXIgdGhlIGFib3ZlIHdhcm5pbmcuDQoNCkFzIHNpb3hfcG9s
bF90aHJlYWQoKSB1c2VzIHNvbWUgdmFyaWFibGVzIG9mIHRoZSBkZXZpY2UgdGhlDQppbml0aWFs
aXNhdGlvbiBvZiB0aGVzZSBpcyBtb3ZlZCBiZWZvcmUgdGhyZWFkIGNyZWF0aW9uLg0KDQpBY2tl
ZC1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQpTaWdu
ZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4
LmRlPg0KQWNrZWQtYnk6IEdhdmluIFNjaGVuayA8Zy5zY2hlbmtAZWNrZWxtYW5uLmRlPg0KU2ln
bmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvc2lveC9zaW94LWNvcmUuYyB8IDEwICsrKysrLS0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zaW94L3Npb3gtY29yZS5jIGIvZHJpdmVycy9zaW94L3Npb3gtY29yZS5j
DQppbmRleCAxNjU5MGRmYWFmYTQuLmNlZjMwN2MwMzk5YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
c2lveC9zaW94LWNvcmUuYw0KKysrIGIvZHJpdmVycy9zaW94L3Npb3gtY29yZS5jDQpAQCAtNzE1
LDE3ICs3MTUsMTcgQEAgaW50IHNpb3hfbWFzdGVyX3JlZ2lzdGVyKHN0cnVjdCBzaW94X21hc3Rl
ciAqc21hc3RlcikNCiANCiAJZGV2X3NldF9uYW1lKCZzbWFzdGVyLT5kZXYsICJzaW94LSVkIiwg
c21hc3Rlci0+YnVzbm8pOw0KIA0KKwltdXRleF9pbml0KCZzbWFzdGVyLT5sb2NrKTsNCisJSU5J
VF9MSVNUX0hFQUQoJnNtYXN0ZXItPmRldmljZXMpOw0KKw0KIAlzbWFzdGVyLT5sYXN0X3BvbGwg
PSBqaWZmaWVzOw0KLQlzbWFzdGVyLT5wb2xsX3RocmVhZCA9IGt0aHJlYWRfY3JlYXRlKHNpb3hf
cG9sbF90aHJlYWQsIHNtYXN0ZXIsDQotCQkJCQkgICAgICAic2lveC0lZCIsIHNtYXN0ZXItPmJ1
c25vKTsNCisJc21hc3Rlci0+cG9sbF90aHJlYWQgPSBrdGhyZWFkX3J1bihzaW94X3BvbGxfdGhy
ZWFkLCBzbWFzdGVyLA0KKwkJCQkJICAgInNpb3gtJWQiLCBzbWFzdGVyLT5idXNubyk7DQogCWlm
IChJU19FUlIoc21hc3Rlci0+cG9sbF90aHJlYWQpKSB7DQogCQlzbWFzdGVyLT5hY3RpdmUgPSAw
Ow0KIAkJcmV0dXJuIFBUUl9FUlIoc21hc3Rlci0+cG9sbF90aHJlYWQpOw0KIAl9DQogDQotCW11
dGV4X2luaXQoJnNtYXN0ZXItPmxvY2spOw0KLQlJTklUX0xJU1RfSEVBRCgmc21hc3Rlci0+ZGV2
aWNlcyk7DQotDQogCXJldCA9IGRldmljZV9hZGQoJnNtYXN0ZXItPmRldik7DQogCWlmIChyZXQp
DQogCQlrdGhyZWFkX3N0b3Aoc21hc3Rlci0+cG9sbF90aHJlYWQpOw0KLS0gDQoyLjE3LjENCg==
