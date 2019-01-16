Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB07C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E539A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OfexXBF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393686AbfAPOlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:41:04 -0500
Received: from mail-eopbgr720064.outbound.protection.outlook.com ([40.107.72.64]:55456
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390714AbfAPOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EmBUx+2LD2vuvgGiS9kpgOc68E4tqcmC8Zp9hsvHuA=;
 b=OfexXBF00LlO5TKlHR2cxRYBATXieKT3yYHw2cZkNl5yMkTQIMlAHjL6+l34pJwDGKO5zK86SsZ2xZEuevr6JOFgbmU62a/9x6gwFLiVF0Uh2JCj7GAmenJ1owuTS9aD3J6RptSQV+n8BetRpKyI9M63BjQudyinhKbGdhAMI7k=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3627.namprd12.prod.outlook.com (20.178.199.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 14:40:59 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 14:40:59 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Topic: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5KWx458AgAAUrwA=
Date:   Wed, 16 Jan 2019 14:40:59 +0000
Message-ID: <df209299-8fd1-189c-9c44-b398cf790d1a@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
In-Reply-To: <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [110.169.70.41]
x-clientproxiedby: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3627;20:fAdNGFq7MPTNfDvCSRcLXySpQrABxpJ4Pkcnbix/t6/5FrT7RZGPMlmpiPCSZERP5Sls/zg0iWfGrG1gIRM1OS1AR1akYlIFK/+2P+p3RvbiJUkrag91g5eh0P8KmHJ+Ozzpltpf9SWIj+HtE3Up/w1A0YkFXFkPCd4DnItuV8wCGrYaIO/Crugaikrd3HCbjhp6NlH5EDVrB69T0u5yzjLVKOFeg4TSAcLJoru5aWh+ULICn+kGwkbAeflxh3YF
x-ms-office365-filtering-correlation-id: 13df7a0d-5b58-4401-74d0-08d67bc0a141
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3627;
x-ms-traffictypediagnostic: DM6PR12MB3627:
x-microsoft-antispam-prvs: <DM6PR12MB36278442865F4C6F03841466F3820@DM6PR12MB3627.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(102836004)(26005)(52116002)(65956001)(65806001)(66066001)(71190400001)(71200400001)(186003)(2906002)(97736004)(53546011)(6506007)(36756003)(14454004)(386003)(5660300001)(72206003)(76176011)(65826007)(99286004)(6116002)(8676002)(3846002)(25786009)(4326008)(6246003)(53936002)(6486002)(81166006)(31686004)(81156014)(68736007)(5640700003)(54906003)(446003)(105586002)(476003)(2616005)(11346002)(6512007)(2501003)(86362001)(106356001)(1730700003)(229853002)(64126003)(486006)(31696002)(478600001)(6436002)(5024004)(14444005)(7736002)(8936002)(316002)(58126008)(2351001)(6916009)(256004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3627;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DabPF/pp9EZ1y+HHzoRhPP8gqNrPBb+K+CGx2OhOi5E9n0FcLvSOIS0zbYpw/ukJoF40y2aenehndGx/kNtT64veC0dUVC1xPx5IhQ77FIepprXCS05GfiHau4YXol2yVyUA/T/zW6BUoN2YXlzFDbUVI68s3uDslNFdezCcgIXYrxRzPvyaWF7kZrLX0Rw3ZGWEf82tfeGqzfs4tAq/yekZ1KU80360EcuJ8e9uk2u0cgkjcWdQnest0tBVbX/tEWmWs+nHnsfFupCzTIQpDiI6Nm1GT06Yy7QM1Tby5NGI+Nb+dJQ+dOOumDLFvsHutybrFL1QHgyBUIL3kPJbG6vEGo5YBVYe7c0DwJbmqlxozhRQAEZyd2zYnKoVXP25d0QyEVFDmicvXUy3BfFaEoQxRnqx/BjtfVce831NyBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <55E42008F81E184F813F8AE32ECB453D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13df7a0d-5b58-4401-74d0-08d67bc0a141
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 14:40:57.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMTYvMTkgODoyNiBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBI
b3cgYWJvdXQgdGhlIGF0dGFjaGVkIGRpZmY/IElmDQo+IEkgdW5kZXJzdGFuZCB0aGUgcHJvYmxl
bSBjb3JyZWN0bHksIGl0IHNob3VsZCBmaXggdGhlIHByb2JsZW0gbW9yZQ0KPiByZWxpYWJseS4N
Cj4gDQo+IFRoYW5rcywNCj4gDQo+IAlKb2VyZw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYW1kX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jDQo+IGluZGV4IDg3
YmEyM2E3NWIzOC4uZGMxZTJhOGExOWQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2Ft
ZF9pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMNCj4gQEAgLTE5OTEs
MjUgKzE5OTEsMzYgQEAgc3RhdGljIHZvaWQgZG9fYXR0YWNoKHN0cnVjdCBpb21tdV9kZXZfZGF0
YSAqZGV2X2RhdGEsDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZG9fZGV0YWNoKHN0cnVjdCBpb21t
dV9kZXZfZGF0YSAqZGV2X2RhdGEpDQo+ICAgew0KPiArCXN0cnVjdCBwcm90ZWN0aW9uX2RvbWFp
biAqZG9tYWluID0gZGV2X2RhdGEtPmRvbWFpbjsNCj4gICAJc3RydWN0IGFtZF9pb21tdSAqaW9t
bXU7DQo+ICAgCXUxNiBhbGlhczsNCj4gICANCj4gICAJaW9tbXUgPSBhbWRfaW9tbXVfcmxvb2t1
cF90YWJsZVtkZXZfZGF0YS0+ZGV2aWRdOw0KPiAgIAlhbGlhcyA9IGRldl9kYXRhLT5hbGlhczsN
Cj4gICANCj4gLQkvKiBkZWNyZWFzZSByZWZlcmVuY2UgY291bnRlcnMgKi8NCj4gLQlkZXZfZGF0
YS0+ZG9tYWluLT5kZXZfaW9tbXVbaW9tbXUtPmluZGV4XSAtPSAxOw0KPiAtCWRldl9kYXRhLT5k
b21haW4tPmRldl9jbnQgICAgICAgICAgICAgICAgIC09IDE7DQo+IC0NCj4gICAJLyogVXBkYXRl
IGRhdGEgc3RydWN0dXJlcyAqLw0KPiAgIAlkZXZfZGF0YS0+ZG9tYWluID0gTlVMTDsNCj4gICAJ
bGlzdF9kZWwoJmRldl9kYXRhLT5saXN0KTsNCj4gLQljbGVhcl9kdGVfZW50cnkoZGV2X2RhdGEt
PmRldmlkKTsNCj4gLQlpZiAoYWxpYXMgIT0gZGV2X2RhdGEtPmRldmlkKQ0KPiAtCQljbGVhcl9k
dGVfZW50cnkoYWxpYXMpOw0KPiAgIA0KPiArCWNsZWFyX2R0ZV9lbnRyeShkZXZfZGF0YS0+ZGV2
aWQpOw0KPiAgIAkvKiBGbHVzaCB0aGUgRFRFIGVudHJ5ICovDQo+ICAgCWRldmljZV9mbHVzaF9k
dGUoZGV2X2RhdGEpOw0KPiArDQo+ICsJaWYgKGFsaWFzICE9IGRldl9kYXRhLT5kZXZpZCkgew0K
PiArCQljbGVhcl9kdGVfZW50cnkoYWxpYXMpOw0KPiArCQkvKiBGbHVzaCB0aGUgQWxpYXMgRFRF
IGVudHJ5ICovDQo+ICsJCWRldmljZV9mbHVzaF9kdGUoYWxpYXMpOw0KPiArCX0NCj4gKw0KDQpB
Y3R1YWxseSwgZGV2aWNlX2ZsdXNoX2R0ZShhbGlhcykgc2hvdWxkIGJlIG5lZWRlZCByZWdhcmRs
ZXNzIG9mIHRoaXMgcGF0Y2guDQpBcmUgeW91IHBsYW5uaW5nIHRvIGFkZCB0aGlzPw0KDQpSZWdh
cmRzLA0KU3VyYXZlZQ0K
