Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6460F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vc5fgk/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBDOl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:41:56 -0500
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:37952
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727274AbfBDOl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw4Pz+3/7xcYOciR8SIX2HCX2huNcxmJgvI2WPzRbNg=;
 b=Vc5fgk/z9NuMpX6MUhkuXLbmBPMjpzzhnk5fnmwcJhjgF0puRGjntb2cKgrui/l/A7KteN/QAIQbWtOjSkJkJTIxhKtA2XHXp3lC4SlAvGVmTURk5azBWdm/EqumeMfabYVATqChH21B1Lv1Mpml/8utIO1dXnhDYwZmi9Fgz34=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:41:53 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:41:53 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        "sironi@amazon.de" <sironi@amazon.de>,
        "wawei@amazon.de" <wawei@amazon.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH 0/8] KVM: x86: svm: Enabling AVIC with in kernel irqchip
Thread-Topic: [RFC PATCH 0/8] KVM: x86: svm: Enabling AVIC with in kernel
 irqchip
Thread-Index: AQHUvJfFhNUzP8QhsEyZAlNpVHmbmw==
Date:   Mon, 4 Feb 2019 14:41:53 +0000
Message-ID: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.90.26.242]
x-clientproxiedby: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:uvfBm1ZtG+jZT7c98VEBea+8bnixdJJskE95kLRS45pG9r2FKv2/sS9W/cyyXW/yblUYOk9cu4Nd0+xNZ5hUWSYD20h9J6AVMi8F/h6r+t5rxPkfaD9cju53VNKwqgyKOuJZ8hLWH+hTl6ZYlppemZXjKAqzkuf/gjW1LRTqStBn2HPjmZg8WnQYlum1YzLj/bc6RPuCcHc+PnssRA5AF5ZWikpdMnx/bG+oPJiDRt4DVLMbN55fqZzAAyLngOXx
x-ms-office365-filtering-correlation-id: 53ae4f30-6a13-4de2-db50-08d68aaee750
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB3274FC0BFD411AB2879138EEF36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(14444005)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(50226002)(71190400001)(486006)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(2906002)(7416002)(26005)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N+lzwxk31lmSAp7pZ9tIC+aU/ArAprcBlk6OU8H1Oo3NCPuDDe8TmsKs8nZo0+aKB2t3jVK+4iSpsbQK0fDhTuFupQxY+lLJSlEKBLFt6ibGUqYndmj8253sdQtLyDanNRg5gADO5I1OkuEfpaEvvQhrCPelQSxNdyyBDslK/YQsmo41zh44PNmRE0+4vmUGX6hUsYTg06WZR4Gs2l/dy/ET677AzpdLLSygAWLIDja9W7M1irtLzybqvqOjNo96QuWJLRUt+HfoBQodRSmWyLASn+axNoUznUcxcSa9bWvkFUQlhI8FXhubnBBzWxqXHIqNF2Q0H9l+9GXfL5BElAzwOlUf/uSxPhr48xLAMdMvNwaV59dq8nd4Kh9V+pJhJrwXCVIvOvjSXTWh0s9QdpExoqSVYOq/0g7BqvC9Nc0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <320233B1B09E254FB8D0838E4C63B8E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ae4f30-6a13-4de2-db50-08d68aaee750
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:41:48.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3VycmVudGx5LCBBTUQgQVZJQyBjYW4gb25seSBiZSBlbmFibGVkIHdoZW4gY3JlYXRpbmcgVk0g
aW4gaXJxY2hpcA0Kc3BsaXQgbW9kZSwgd2hpY2ggaXMgZHVlIHRvIHRoZSBmb2xsb3dpbmcgaXNz
dWVzOg0KDQogICAqIEFNRCBBVklDIGRvZXMgbm90IHN1cHBvcnQgRXh0SU5ULCB3aGljaCBpcyBy
ZXF1aXJlZCBkdXJpbmcgYm9vdGluZw0KICAgICBwaGFzZSBvZiBXaW5kb3dzIGFuZCBGcmVlQlNE
IFZNcy4gVGhpcyByZXN1bHRzIGluIGhhbmdpbmcgaW4gdGhlDQogICAgIGJvb3QgbG9hZGVycy4N
Cg0KICAgKiBVbnRyYXAgQVBJQyBFT0kgd3JpdGUgZm9yIGVkZ2UtdHJpZ2dlciBpbnRlcnJwdC4N
CiAgICAgUGxlYXNlIHNlZSA2NzAzNGJiOWRkNWUgKCdLVk06IFNWTTogQWRkIGlycWNoaXBfc3Bs
aXQoKSBjaGVja3MNCiAgICAgYmVmb3JlIGVuYWJsaW5nIEFWSUMnKSBmb3IgbW9yZSBpbmZvcm1h
dGlvbi4NCg0KVGhpcyByZXN0cmljdGlvbiBtYWtlcyBBVklDIGRpZmZpY3VsdCB0byBlbmFibGUg
c2luY2UgaXQgZGVwZW5kcyBvbg0KdGhlIG5vbi1kZWZhdWx0IFFFTVUncyBrZXJuZWxfaXJxY2hp
cD1zcGxpdCBvcHRpb24uIFRoZXJlZm9yZSwgdGhpcyBSRkMNCnNlcmllcyB0cmllcyB0byBwcm92
aWRlIHdvcmthcm91bmQgZm9yIHRoZSBpc3N1ZXMgYWJvdmUsIGFuZCBhbGxvdyBBVklDIHRvDQp3
b3JrIHdpdGggdGhlIG9wdGlvbiBrZXJuZWxfaXJxY2hpcD1vbiAoUUVNVSBkZWZhdWx0KS4NCg0K
UGF0Y2ggMSBmaXhlcyBBVklDIGRlYWN0aXZhdGlvbi4NClBhdGNoIDItNiBpbnRyb2R1Y2VzIHJ1
bi10aW1lIEFWSUMgYWN0aWNhdGUvZGVhY3RpdmF0ZSBzdXBwb3J0Lg0KUGF0Y2ggNyBwcm92aWRl
IHdvcmthcm91bmQgZm9yIHVudHJhcCBBUElDIEVPSS4NClBhdGNoIDggcmVtb3ZlcyB0aGUga2Vy
bmVsIGlycWNoaXAgc3BsaXQgcmVzdHJpY3Rpb24uDQoNClRoaXMgc2VyaWVzIGhhcyBiZWVuIHRl
c3RlZCBib290aW5nIExpbnV4LCBXaW5kb3dzLCBhbmQgRnJlZUJTRCBWTXMNCndpdGgga2VybmVs
X2lycWNoaXA9b2ZmL3NwbGl0L29uLg0KDQpUaGFua3MsDQpTdXJhdmVlDQoNCkp1bGlhbiBTdGVj
a2xpbmEgKDEpOg0KICBLVk06IGk4MjU0OiBSZW1vdmUgbmVlZCBmb3IgaXJxIGFjayBub3RpZmll
cg0KDQpTdXJhdmVlIFN1dGhpa3VscGFuaXQgKDcpOg0KICBzdm06IEZpeCBpbXByb3BlciBjaGVj
ayB3aGVuIGRlYWN0aXZhdGUgQVZJQw0KICBLVk06IHg4NjogQWRkIGludGVyZmFjZSBmb3IgcnVu
LXRpbWUgYWN0aXZhdGUvZGUtYWN0aXZhdGUgQVBJQw0KICAgIHZpcnR1YWxpemF0aW9uDQogIEtW
TTogeDg2OiBBZGQgY2FsbGJhY2sgZnVuY3Rpb25zIGZvciBoYW5kbGluZyBBUElDIElELCBERlIg
YW5kIExEUg0KICAgIHVwZGF0ZQ0KICBzdm06IEFkZCBBTUQgQVZJQyBoYW5kbGVycyBmb3IgQVBJ
QyBJRCwgREZSIGFuZCBMRFIgdXBkYXRlDQogIHN2bTogQWRkIHN1cHBvcnQgZm9yIEFQSUNfQUND
RVNTX1BBR0VfUFJJVkFURV9NRU1TTE9UIHNldHVwL2Rlc3Ryb3kNCiAgc3ZtOiBUZW1wb3Jhcnkg
ZGVhY3RpdmF0ZSBBVklDIGR1cmluZyBFeHRJTlQgaGFuZGxpbmcNCiAgc3ZtOiBBbGxvdyBBVklD
IHdpdGggaW4ta2VybmVsIGlycWNoaXAgbW9kZQ0KDQogYXJjaC94ODYvaW5jbHVkZS9hc20va3Zt
X2hvc3QuaCB8ICAxMSArKysNCiBhcmNoL3g4Ni9rdm0vaTgyNTQuYyAgICAgICAgICAgIHwgIDIy
ICstLS0tLQ0KIGFyY2gveDg2L2t2bS9pODI1NC5oICAgICAgICAgICAgfCAgIDIgLQ0KIGFyY2gv
eDg2L2t2bS9sYXBpYy5jICAgICAgICAgICAgfCAgMTEgKystDQogYXJjaC94ODYva3ZtL3N2bS5j
ICAgICAgICAgICAgICB8IDExOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KIGFy
Y2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgfCAgMzYgKysrKysrKysrKw0KIDYgZmlsZXMg
Y2hhbmdlZCwgMTY0IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTcu
MQ0KDQo=
