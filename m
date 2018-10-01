Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B0FC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86D62083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bvnvdHqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86D62083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeJAH2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:28:47 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbeJAHNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tddSRu6W9vi9olzMZXzR64Yl1Wa6uI+xIjrmwDnbo74=;
 b=bvnvdHqujuXrQIDTP6QCYsteguUOJx2TO2BfZd8r0BxAESQzwJh9g/t2NtGaplxgaXiw+wr8ffD8TP8WbPelONMJeWSGEorMvNRpx8Jv3HROWsR6/02WRbIVGLbXHUoTkQ2nt7VserYqSH2rZ2gyQaAffw3ZKJrmgnp8N/5l1E4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anton Blanchard <anton@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 15/65] perf annotate: Fix parsing aarch64 branch
 instructions after objdump update
Thread-Topic: [PATCH AUTOSEL 4.18 15/65] perf annotate: Fix parsing aarch64
 branch instructions after objdump update
Thread-Index: AQHUWR8Ia9ls3+GfI0O5urZ9Z6/p+g==
Date:   Mon, 1 Oct 2018 00:38:12 +0000
Message-ID: <20181001003754.146961-15-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:t7NdXW7w8Sm/Bc35hl6DAd5dqAv0it64T/7IoTrml9ALMfmRZFy8y5jJtR/BY0+8NyjgvrTkUv/UJ3klCYQmjQnjrluxV5OOFIATpv48R6CqBfUHsdYoEpMFZgfUIjx2sSqoR/80tEbX6Up4d2I4/04fyxWh2fVZK9RhCwxmjNPO2AbLNUYlY663OLlu+G40oZiQfqRsKle1yARtTtUXckFYJwbWxINKofIo3/2DBjM7nZ7uW7ayJO1GD4qNAO94PthZK3E77Hc434F/8mVprzQnG2eJnBPv04EHPZCEgdpcqIna76s8HUKC5A+RoWL7p5/KzbKtG3mpamUEKk9gbWhVjnOKLkXZfMZxHt0RyKtlv7/QSKg04/E4aaVk4yDvWD/xYAmi1ygBB+FJigT8LmBpuItMtDIUPzJYlo9KREqy4e9d7CVJ9x6t/0k2gpBdnQ/45TKjI7Ri8X2YZvS0PQ==;5:o+riqGIEJ0+dzw7eN4q5mmYnd6TsjzPcyIUa3v6VFAGYgrPFFjQau+WoFinljmqz0uOZgIvxjaHT/jjm19erc+X4k7IguGvucQvmZkrnwzlySChEi1QVC/YlEFzcotijUnWQpTewOB1Szcwm3OcR67968sYO6NWTrv1qU0Cm0MY=;7:JU931JRjlVerfCKGxiDdU17UIifQhdGuKxuBEzq8NA9GhQk3sp1mGZN15uKYVP3VphEWzIU5hjlnzHafWVYxhG9l+VZWYmOXtoNOPMr14oJd7lrXTfp/qegCFmob8wCvcc5UiPz6Zd6NuJ91TXXZtwxHYHKm9tqihjBXBNYdNRmf50n7+dq9xivw9qoGYrgpwPYriowu6/jFHctlIJMOgZLY76FbWXsbu+mdiSpaap1fM4OFfKB79Jcz74SL5qJ8
x-ms-office365-filtering-correlation-id: 4eaa3ffa-20ea-4ffe-a33b-08d627362b21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB04721597508E0ACBF5EE2D80FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(42068640409301)(180628864354917)(228905959029699)(190383065149520)(104084551191319)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(966005)(6486002)(6306002)(8936002)(68736007)(486006)(6436002)(10710500007)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(39060400002)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(7416002)(15650500001)(2420400007)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(7110500001)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5/KqA88tPZXJhFhmvmeZI7MdkQSAV3uQHrAtYdmV6W4bVGkZH/8R3nytyd03MlrqCE03sqz0RLDYzcO6KT9E+yHemdBxANAGoD8806Z4jsr1ynJbumRUYG8v2Aalp9nrNkbKz8o5oIeId4/LNV3fgct+rrK2wkQHGGQBd+6O01Anx5OOSvOQ3wO7XAzd4oI2XFPD8Csb+IRJJwKttJj31PDDdMxmutArt0rMnBkLhUou3uL/wk92skHIWGrPe6CDVh166rp+sRZlsbbAIwJA2vP6LYa0gRxy98zTi94bi6lpf3Md8xm+21GsmnCQI3ZbaxbC/gecH3v95xUDMe81unwO48ssVSetXiGg/3eKgS0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2865C2D9722F4245989B077EE646A6BD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaa3ffa-20ea-4ffe-a33b-08d627362b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:12.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2ltIFBoaWxsaXBzIDxraW0ucGhpbGxpcHNAYXJtLmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgNGU2N2IyYTVkZjVkM2YzNDE3NzZkMTJlZTU3NWUwMGNhM2VmOTJkZSBdDQoNClN0YXJ0
aW5nIHdpdGggYmludXRpbHMgMi4yOCwgYWFyY2g2NCBvYmpkdW1wIGFkZHMgY29tbWVudHMgdG8g
dGhlDQpkaXNhc3NlbWJseSBvdXRwdXQgdG8gc2hvdyB0aGUgYWx0ZXJuYXRpdmUgbmFtZXMgb2Yg
YSBjb25kaXRpb24gY29kZQ0KWzFdLg0KDQpJdCBpcyBhc3N1bWVkIHRoYXQgY29tbWFzIGluIG9i
amR1bXAgY29tbWVudHMgY291bGQgb2NjdXIgaW4gb3RoZXINCmFyY2hlcyBub3cgb3IgaW4gdGhl
IGZ1dHVyZSwgc28gdGhpcyBmaXggaXMgYXJjaC1pbmRlcGVuZGVudC4NCg0KVGhlIGZpeCBjb3Vs
ZCBoYXZlIGJlZW4gZG9uZSB3aXRoIGFybTY0IHNwZWNpZmljIGp1bXBfX3BhcnNlIGFuZA0KanVt
cF9fc2NucHJpbnRmIGZ1bmN0aW9ucywgYnV0IHRoZSBqdW1wX19zY25wcmludGYgaW5zdHJ1Y3Rp
b24gd291bGQNCmhhdmUgdG8gaGF2ZSBpdHMgY29tbWVudCBjaGFyYWN0ZXIgYmUgYSBsaXRlcmFs
LCBzaW5jZSB0aGUgc2NucHJpbnRmDQpmdW5jdGlvbnMgY2Fubm90IHJlY2VpdmUgYSBzdHJ1Y3Qg
YXJjaCBlYXNpbHkuDQoNClRoaXMgaW5jb252ZW5pZW5jZSBhbHNvIGFwcGxpZXMgdG8gdGhlIGdl
bmVyaWMganVtcF9fc2NucHJpbnRmLCB3aGljaCBpcw0Kd2h5IHdlIGFkZCBhIHJhd19jb21tZW50
IHBvaW50ZXIgdG8gc3RydWN0IGluc19vcGVyYW5kcywgc28gdGhlIF9fcGFyc2UNCmZ1bmN0aW9u
IGFzc2lnbnMgaXQgdG8gYmUgcmUtdXNlZCBieSBpdHMgY29ycmVzcG9uZGluZyBfX3NjbnByaW50
Zg0KZnVuY3Rpb24uDQoNCkV4YW1wbGUgZGlmZmVyZW5jZXMgaW4gJ3BlcmYgYW5ub3RhdGUgLS1z
dGRpbzInIG91dHB1dCBvbiBhbiBhYXJjaDY0DQpwZXJmLmRhdGEgZmlsZToNCg0KQkVGT1JFOiDi
hpIgYi5jcyAgIGZmZmYyMDAwMDgxMzNkMWMgPHVud2luZF9mcmFtZSsweDE4Yz4gIC8vIGIuaHMs
IGRmZmZmN2VjYzQ3Yg0KQUZURVIgOiDihpMgYi5jcyAgIDE4Yw0KDQpCRUZPUkU6IOKGkiBiLmNj
ICAgZmZmZjIwMDAwOGQ4ZDljYyA8Z2V0X2FsbG9jX3Byb2ZpbGUrMHgzMWM+ICAvLyBiLmxvLCBi
LnVsLCBkZmZmZjcyNzI5NWINCkFGVEVSIDog4oaTIGIuY2MgICAzMWMNCg0KVGhlIGJyYW5jaCB0
YXJnZXQgbGFiZWxzIDE4YyBhbmQgMzFjIGFsc28gbm93IGFwcGVhciBpbiB0aGUgb3V0cHV0Og0K
DQpCRUZPUkU6ICAgICAgICBhZGQgICAgeDI2LCB4MjksICMweDgwDQpBRlRFUiA6IDE4YzogICBh
ZGQgICAgeDI2LCB4MjksICMweDgwDQoNCkJFRk9SRTogICAgICAgIGFkZCAgICB4MjEsIHgyMSwg
IzB4OA0KQUZURVIgOiAzMWM6ICAgYWRkICAgIHgyMSwgeDIxLCAjMHg4DQoNClRoZSBGaXhlczog
dGFnIGJlbG93IGlzIGFkZGVkIHNvIHN0YWJsZSBicmFuY2hlcyB3aWxsIGdldCB0aGUgdXBkYXRl
OyBpdA0KZG9lc24ndCBuZWNlc3NhcmlseSBtZWFuIHRoYXQgY29tbWl0IHdhcyBicm9rZW4gYXQg
dGhlIHRpbWUsIHJhdGhlciBpdA0KZGlkbid0IHdpdGhzdGFuZCB0aGUgYWFyY2g2NCBvYmpkdW1w
IHVwZGF0ZS4NCg0KVGVzdGVkIG5vIGRpZmZlcmVuY2UgaW4gb3V0cHV0IGZvciBzYW1wbGUgeDg2
XzY0LCBwb3dlciBhcmNoIHBlcmYuZGF0YSBmaWxlcy4NCg0KWzFdIGh0dHBzOi8vc291cmNld2Fy
ZS5vcmcvZ2l0L2dpdHdlYi5jZ2k/cD1iaW51dGlscy1nZGIuZ2l0O2E9Y29tbWl0O2g9YmI3ZWZm
NTIwNmU0Nzk1YWM3OWMxNzdhODBmZTlmNDYzMGFhZjczMA0KDQpTaWduZWQtb2ZmLWJ5OiBLaW0g
UGhpbGxpcHMgPGtpbS5waGlsbGlwc0Bhcm0uY29tPg0KVGVzdGVkLWJ5OiBBcm5hbGRvIENhcnZh
bGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0LmNvbT4NCkNjOiBBbGV4YW5kZXIgU2hpc2hraW4gPGFs
ZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+DQpDYzogQW50b24gQmxhbmNoYXJkIDxh
bnRvbkBzYW1iYS5vcmc+DQpDYzogQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBk
ZS5pYm0uY29tPg0KQ2M6IEppcmkgT2xzYSA8am9sc2FAcmVkaGF0LmNvbT4NCkNjOiBNYXJrIFJ1
dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KQ2M6IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdA
a2VybmVsLm9yZz4NCkNjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQpD
YzogUmF2aSBCYW5nb3JpYSA8cmF2aS5iYW5nb3JpYUBsaW51eC52bmV0LmlibS5jb20+DQpDYzog
Um9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCkNjOiBUYWV1bmcgU29uZyA8dHJl
ZXplLnRhZXVuZ0BnbWFpbC5jb20+DQpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQpGaXhlczogYjEzYmJlZWU1ZWU2ICgicGVyZiBhbm5vdGF0ZTogRml4IGJyYW5jaCBp
bnN0cnVjdGlvbiB3aXRoIG11bHRpcGxlIG9wZXJhbmRzIikNCkxpbms6IGh0dHA6Ly9sa21sLmtl
cm5lbC5vcmcvci8yMDE4MDgyNzEyNTM0MC5hMmY3ZTI5MTkwMWQxN2NlYTA1ZGFiYTRAYXJtLmNv
bQ0KU2lnbmVkLW9mZi1ieTogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQHJlZGhhdC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29m
dC5jb20+DQotLS0NCiB0b29scy9wZXJmL3V0aWwvYW5ub3RhdGUuYyB8IDIyICsrKysrKysrKysr
KysrKysrKysrKy0NCiB0b29scy9wZXJmL3V0aWwvYW5ub3RhdGUuaCB8ICAxICsNCiAyIGZpbGVz
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L3Rvb2xzL3BlcmYvdXRpbC9hbm5vdGF0ZS5jIGIvdG9vbHMvcGVyZi91dGlsL2Fubm90YXRlLmMN
CmluZGV4IDMxYTFlMThjN2JmMi4uM2IwNTIxOWMzZWQ3IDEwMDY0NA0KLS0tIGEvdG9vbHMvcGVy
Zi91dGlsL2Fubm90YXRlLmMNCisrKyBiL3Rvb2xzL3BlcmYvdXRpbC9hbm5vdGF0ZS5jDQpAQCAt
MjgxLDcgKzI4MSwxOSBAQCBib29sIGluc19faXNfY2FsbChjb25zdCBzdHJ1Y3QgaW5zICppbnMp
DQogCXJldHVybiBpbnMtPm9wcyA9PSAmY2FsbF9vcHMgfHwgaW5zLT5vcHMgPT0gJnMzOTBfY2Fs
bF9vcHM7DQogfQ0KIA0KLXN0YXRpYyBpbnQganVtcF9fcGFyc2Uoc3RydWN0IGFyY2ggKmFyY2gg
X19tYXliZV91bnVzZWQsIHN0cnVjdCBpbnNfb3BlcmFuZHMgKm9wcywgc3RydWN0IG1hcF9zeW1i
b2wgKm1zKQ0KKy8qDQorICogUHJldmVudHMgZnJvbSBtYXRjaGluZyBjb21tYXMgaW4gdGhlIGNv
bW1lbnQgc2VjdGlvbiwgZS5nLjoNCisgKiBmZmZmMjAwMDA4NDQ2ZTcwOiAgICAgICBiLmNzICAg
IGZmZmYyMDAwMDg0NDcwZjQgPGdlbmVyaWNfZXhlY19zaW5nbGUrMHgzMTQ+ICAvLyBiLmhzLCBi
Lm5sYXN0DQorICovDQorc3RhdGljIGlubGluZSBjb25zdCBjaGFyICp2YWxpZGF0ZV9jb21tYShj
b25zdCBjaGFyICpjLCBzdHJ1Y3QgaW5zX29wZXJhbmRzICpvcHMpDQorew0KKwlpZiAob3BzLT5y
YXdfY29tbWVudCAmJiBjID4gb3BzLT5yYXdfY29tbWVudCkNCisJCXJldHVybiBOVUxMOw0KKw0K
KwlyZXR1cm4gYzsNCit9DQorDQorc3RhdGljIGludCBqdW1wX19wYXJzZShzdHJ1Y3QgYXJjaCAq
YXJjaCwgc3RydWN0IGluc19vcGVyYW5kcyAqb3BzLCBzdHJ1Y3QgbWFwX3N5bWJvbCAqbXMpDQog
ew0KIAlzdHJ1Y3QgbWFwICptYXAgPSBtcy0+bWFwOw0KIAlzdHJ1Y3Qgc3ltYm9sICpzeW0gPSBt
cy0+c3ltOw0KQEAgLTI5MCw2ICszMDIsMTAgQEAgc3RhdGljIGludCBqdW1wX19wYXJzZShzdHJ1
Y3QgYXJjaCAqYXJjaCBfX21heWJlX3VudXNlZCwgc3RydWN0IGluc19vcGVyYW5kcyAqb3ANCiAJ
fTsNCiAJY29uc3QgY2hhciAqYyA9IHN0cmNocihvcHMtPnJhdywgJywnKTsNCiAJdTY0IHN0YXJ0
LCBlbmQ7DQorDQorCW9wcy0+cmF3X2NvbW1lbnQgPSBzdHJjaHIob3BzLT5yYXcsIGFyY2gtPm9i
amR1bXAuY29tbWVudF9jaGFyKTsNCisJYyA9IHZhbGlkYXRlX2NvbW1hKGMsIG9wcyk7DQorDQog
CS8qDQogCSAqIEV4YW1wbGVzIG9mIGxpbmVzIHRvIHBhcnNlIGZvciB0aGUgX2NwcF9sZXhfdG9r
ZW5AQEJhc2UNCiAJICogZnVuY3Rpb246DQpAQCAtMzA5LDYgKzMyNSw3IEBAIHN0YXRpYyBpbnQg
anVtcF9fcGFyc2Uoc3RydWN0IGFyY2ggKmFyY2ggX19tYXliZV91bnVzZWQsIHN0cnVjdCBpbnNf
b3BlcmFuZHMgKm9wDQogCQlvcHMtPnRhcmdldC5hZGRyID0gc3RydG91bGwoYywgTlVMTCwgMTYp
Ow0KIAkJaWYgKCFvcHMtPnRhcmdldC5hZGRyKSB7DQogCQkJYyA9IHN0cmNocihjLCAnLCcpOw0K
KwkJCWMgPSB2YWxpZGF0ZV9jb21tYShjLCBvcHMpOw0KIAkJCWlmIChjKysgIT0gTlVMTCkNCiAJ
CQkJb3BzLT50YXJnZXQuYWRkciA9IHN0cnRvdWxsKGMsIE5VTEwsIDE2KTsNCiAJCX0NCkBAIC0z
NjYsOSArMzgzLDEyIEBAIHN0YXRpYyBpbnQganVtcF9fc2NucHJpbnRmKHN0cnVjdCBpbnMgKmlu
cywgY2hhciAqYmYsIHNpemVfdCBzaXplLA0KIAkJcmV0dXJuIHNjbnByaW50ZihiZiwgc2l6ZSwg
IiUtNnMgJXMiLCBpbnMtPm5hbWUsIG9wcy0+dGFyZ2V0LnN5bS0+bmFtZSk7DQogDQogCWMgPSBz
dHJjaHIob3BzLT5yYXcsICcsJyk7DQorCWMgPSB2YWxpZGF0ZV9jb21tYShjLCBvcHMpOw0KKw0K
IAlpZiAoYyAhPSBOVUxMKSB7DQogCQljb25zdCBjaGFyICpjMiA9IHN0cmNocihjICsgMSwgJywn
KTsNCiANCisJCWMyID0gdmFsaWRhdGVfY29tbWEoYzIsIG9wcyk7DQogCQkvKiBjaGVjayBmb3Ig
My1vcCBpbnNuICovDQogCQlpZiAoYzIgIT0gTlVMTCkNCiAJCQljID0gYzI7DQpkaWZmIC0tZ2l0
IGEvdG9vbHMvcGVyZi91dGlsL2Fubm90YXRlLmggYi90b29scy9wZXJmL3V0aWwvYW5ub3RhdGUu
aA0KaW5kZXggYTRjMGQ5MTkwN2U2Li42MWUwYzdmZDVlZmQgMTAwNjQ0DQotLS0gYS90b29scy9w
ZXJmL3V0aWwvYW5ub3RhdGUuaA0KKysrIGIvdG9vbHMvcGVyZi91dGlsL2Fubm90YXRlLmgNCkBA
IC0yMSw2ICsyMSw3IEBAIHN0cnVjdCBpbnMgew0KIA0KIHN0cnVjdCBpbnNfb3BlcmFuZHMgew0K
IAljaGFyCSpyYXc7DQorCWNoYXIJKnJhd19jb21tZW50Ow0KIAlzdHJ1Y3Qgew0KIAkJY2hhcgkq
cmF3Ow0KIAkJY2hhcgkqbmFtZTsNCi0tIA0KMi4xNy4xDQo=
