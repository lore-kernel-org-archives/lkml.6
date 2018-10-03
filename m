Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A5AC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFB22082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFB22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJCHFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:05:46 -0400
Received: from mail-cys01nam02on0092.outbound.protection.outlook.com ([104.47.37.92]:42176
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeJCHFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:05:46 -0400
Received: from BY2PR0701MB2070.namprd07.prod.outlook.com (10.163.156.148) by
 BY2PR0701MB1973.namprd07.prod.outlook.com (10.163.155.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Wed, 3 Oct 2018 00:19:40 +0000
Received: from BY2PR0701MB2070.namprd07.prod.outlook.com
 ([fe80::d9db:102b:91b6:ea92]) by BY2PR0701MB2070.namprd07.prod.outlook.com
 ([fe80::d9db:102b:91b6:ea92%7]) with mapi id 15.20.1185.024; Wed, 3 Oct 2018
 00:19:39 +0000
From:   Mansour Alharthi <malharthi9@gatech.edu>
To:     "\"peterz@infradead.org; mingo@redhat.com; acme\"@kernel.org" 
        <"peterz@infradead.org; mingo@redhat.com; acme"@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: tracing child threads with address filtering using intel_pt pmu
Thread-Topic: tracing child threads with address filtering using intel_pt pmu
Thread-Index: AQHUWq7FS8q/vEC4K0OjZ3X51+wDTw==
Date:   Wed, 3 Oct 2018 00:19:39 +0000
Message-ID: <bcc45357-fe84-05be-58c1-248efd15e3d6@gatech.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0016.namprd14.prod.outlook.com
 (2603:10b6:301:4b::26) To BY2PR0701MB2070.namprd07.prod.outlook.com
 (2a01:111:e400:5335::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:c0:c380:8c9:b98f:24c5:198e:6987]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR0701MB1973;6:Z1mOBr+OgFqwRgUDDyAA67/rmoREyjwYb5tt6O58gEug7YlCN8EmKdWb4OZ0IgDjinf2pdxcouc/n8FSO6kf6VCQU/aLc4fa1ciPoaULon+FFCZtq2po7OPQVlOcXQ0mwzrNsGDqxKtVPCBXYmdPjNLJxTsWAJJOJt9koxUjkW3A0+bLEkpgk5evlR7o5HByWSst5EVyoFfNGX8yQgzOe6HvnSrNeR1Uo1gQ3FZxk3yUPTnyYxt7gDZMH0FZGzc7Z3DGZby+liWAHU4GLO7JI2wUwjye+PmgV5JEC9BiqrTqq8i+mjXkiqp1czNkVHIr4wic/c9nq4Mm/k5SWcO6Gkmm9Z3PhMWk7ywDriI84xSXbrOEOmfWSriTA5M9EJB7NfFYsFh0RucIBIR2SC0JWChcS5G42pp2nAuMoLNhZwamFnK+5S295bBwQOWyjH+vQ+IPXQTEjQ8yOC40dJ0FWg==;5:UxCxoRSyhKM2NUrOAJ5YE2lFKTNFGEt78b40QU64S8pyz9QoMnKmH53ZtItfvob1L0PLACvrFmUtyJr7s3PC5DQgWMagRXngP4L5RWMuv+8Tlb0owtKlHAT2T6JYwbqe3Xr2nwTs7gNkD0CsFkCM1YF+nQ0INdZY6TyzvpDK7D4=;7:8vKon6UkDN0hUkhQZHETladnABN94fTderOq5SIw9TB8s7cd8TS4k1W9RgSDF937EfHknvfQgIydlSoStSEvNnjdnQ22aFWn6FDHzigooPndsBnDVSZ8tcOPjThmMaP9u8HqQ6/c8wPyT3VhHsCK8xgNl21KJSiJJswsAtuWILZOvDUQnmb9XxYFBR3SNQ0XwZwj9K8HQVJYwVILMZzafcXtb/M8ckU0PwkZvma4FIJ9fg7ssVVHWtNDuKDQK0Fj
x-ms-office365-filtering-correlation-id: e6fa045b-5653-4542-9eae-08d628c5e7b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0701MB1973;
x-ms-traffictypediagnostic: BY2PR0701MB1973:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mansourah@gatech.edu; 
x-microsoft-antispam-prvs: <BY2PR0701MB19731ACEC88CB62F4416FCC0CCE90@BY2PR0701MB1973.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:BY2PR0701MB1973;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0701MB1973;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(53754006)(189003)(199004)(2616005)(14454004)(75432002)(25786009)(478600001)(71190400001)(4326008)(6116002)(2900100001)(2906002)(71200400001)(6486002)(7736002)(305945005)(6436002)(97736004)(186003)(53936002)(6512007)(476003)(486006)(5660300001)(31686004)(316002)(81166006)(105586002)(386003)(6506007)(88552002)(99286004)(46003)(81156014)(8676002)(8936002)(5250100002)(786003)(52116002)(31696002)(68736007)(102836004)(256004)(36756003)(106356001)(2621003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR0701MB1973;H:BY2PR0701MB2070.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: gatech.edu does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hpc+vqIt7TkwM/4iwKJ5Dt1t323wpkBXpCTGMB+wkcHwPuleV+Q19kWgQxwa0l5ts2mHjx2fCKq0BVkh7o9qL3+oIjO1WPtrRNIcVzN0aww2AyJRPwMv9aIj9sWxDOmJsbWoyVpbds/U5kmJle1ADtZEU3h7gYaAiAkVUFiR2EFY2rVMw6fR+upWnBbFx7TQ7/yHJ4U0pwgTaUzAOLM0gR3EcwD7+4y0wsdY5Si9woX/i+0Fwr8ts2sSOp3Kpx+BVgn5FZcSicdvK6X+Obxlgw0xg2FbdH7KAevFBAOLsjmEqh71ecHIaEp7Mr9gb0wcKADFnq/I2Bbbvq3rR1jWKLpg7dzXNR+U8EmG+k9Ef34=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A40A8151348C4E44A64BC4B857177485@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fa045b-5653-4542-9eae-08d628c5e7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 00:19:39.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0701MB1973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gYWxsLA0KDQpJIGFtIGhhdmluZyB0cm91YmxlIHRyYWNpbmcgY2hpbGQgdGhyZWFkcyB3
aGVuIHVzaW5nIGFkZHJlc3MgZmlsdGVyaW5nIA0Kd2l0aCBpbnRlbF9wdCAuLg0KDQpBc3N1bWUg
dGhpcyB0ZXN0IGNvZGU6DQoNCnRocmVhZF9zdGFydCgpew0KLi4uDQp0ZXN0KCk7DQouLi4NCn0N
Cg0KdGVzdCgpew0KcHJpbnRmKCJ0ZXN0Iik7DQp9DQoNCm1haW4oKXsNCi4uLg0KcHRocmVhZF9j
cmVhdGUoLi4uLi4uLCB0aHJlYWRfc3RhcnQsLi4uLik7DQp9DQoNCg0KVHJhY2luZyB0aGUgYWJv
dmUgcHJvZ3JhbSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCnBlcmYgcmVjb3JkIC12IC1t
IDUxMiwxMDAwMCAtZSBpbnRlbF9wdC8vdSAtVCAtLXN3aXRjaC1ldmVudHMgLS1maWx0ZXIgDQon
ZmlsdGVyICogQCAuL3Rlc3QnIC0tIC4vdGVzdA0KDQpSZXR1cm5zIHplcm8gdHJhY2UgZm9yIGNv
ZGUgZXhlY3V0ZWQgYnkgY2hpbGQgdGhyZWFkLCBpLmUuIA0KdGhyZWFkX3N0YXJ0KCkgYW5kIHRl
c3QoKSBmdW5jdGlvbnMuLg0KV2hpbGUgdHJhY2luZyB3aXRob3V0IHRoZSBmaWx0ZXIgZG9lcyBp
bmNsdWRlIHRoZSB0aHJlYWRzIHRyYWNlOg0KcGVyZiByZWNvcmQgLXYgLW0gNTEyLDEwMDAwIC1l
IGludGVsX3B0Ly91IC1UIC0tc3dpdGNoLWV2ZW50cyAtLSAuL3Rlc3QNCg0KSXMgdGhpcyBpbnRl
bmRlZD8gb3IgaXMgaXQgYSBidWc/DQoNClRoYW5rcyENCk1hbnNvdXIuDQoNCg==
