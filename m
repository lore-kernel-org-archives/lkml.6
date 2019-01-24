Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4EDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EE72184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rCblUuSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXDZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:25:23 -0500
Received: from mail-eopbgr760071.outbound.protection.outlook.com ([40.107.76.71]:17920
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfAXDZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycj5/X1azLdQZhVAEGim7n4gE6+YbQdtLRx3aCScueE=;
 b=rCblUuSFQaOdalW/zOapYk0zczYWflniUWPIwxlGmcf1Z2TCcL3MmBdKN82JVHLNPxKYdbbLZ9/BXxRjjwnW+CKKMOa7FrTaqtH8PlxHjcNNX1THv3xv0qTrOc885XS56Uig7II4NajVjjcOR8eJv/yundrA/gRGTRm1GIyubF0=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3596.namprd12.prod.outlook.com (20.178.199.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 24 Jan 2019 03:25:19 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 03:25:19 +0000
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
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5KWx458AgAALuQCAADJSAIABBWMAgAf9UwCAAFYdgIABDUwAgAFGZAA=
Date:   Thu, 24 Jan 2019 03:25:19 +0000
Message-ID: <54a1da19-54dd-30cc-191b-7fe5dc4a58fa@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
 <20190122104454.nke2knuyqiswfh5w@8bytes.org>
 <e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
 <20190123075658.GE32526@8bytes.org>
In-Reply-To: <20190123075658.GE32526@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [171.96.74.181]
x-clientproxiedby: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3596;20:8oxQaCJTvyQzOasX1Q6eWpUtsIh+DXSIg8YxJpN6cGl4mQRRHeF+Btt2ZTigdTSD0DxvWs23+RD3JuKTXXTUSMkG1cO5eCRMBn2VadD8m+90hpjmj4qLIOWGM5M2wCvNZE1aBIkqIZO3sZKdouXSx5tXSU7RIEftt663m/kPKwjjnf0b4PyJo1d1UJYSvo2WZg4CPoJvJ8GSQkZzDhiqrISIlVRyXca3VJCJZZ2JZVMKwcuD2k8OQXSJPaL/NQYM
x-ms-office365-filtering-correlation-id: 8f4dda7e-b5cd-42a4-6d88-08d681ab911f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3596;
x-ms-traffictypediagnostic: DM6PR12MB3596:
x-microsoft-antispam-prvs: <DM6PR12MB359675FB50D06FD3BA37E8A2F39A0@DM6PR12MB3596.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(51914003)(189003)(6506007)(11346002)(68736007)(53546011)(446003)(6916009)(2351001)(31686004)(3846002)(6116002)(65826007)(316002)(58126008)(54906003)(86362001)(53936002)(102836004)(386003)(305945005)(66066001)(256004)(65806001)(7736002)(65956001)(71190400001)(31696002)(97736004)(8936002)(71200400001)(8676002)(6246003)(81166006)(81156014)(1730700003)(186003)(6436002)(4744005)(26005)(966005)(6486002)(6306002)(52116002)(478600001)(72206003)(99286004)(93886005)(76176011)(5640700003)(25786009)(105586002)(486006)(2501003)(2906002)(476003)(4326008)(14454004)(36756003)(64126003)(2616005)(106356001)(229853002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3596;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fCgW6g64L/055PLaup/Vm7vOr0doJVTuiKeZ7BMqoLsXacx9WN2yCkBXaxBcvje48Q0UKsYxA933QU9pUMpR6zvyNA4v6RqUA1B4q0JN9oAsyj3fD0QvRgdpIOhSyaAW0jwUIeePXfvgb4Jhb8PtNHjdVDnvP4GWCjL6oNpu2wueLlLHAAF6LlpiFH97B2UYS//KHaAihgZRRvtjszO4/zhhvka2BSGEPQ3TruMkVKyYAOc++9kqkaovrJ05MBROrzD1FJWmvscBPVl39eAxZT5S9A0ZXo/XNNp/WkC0ZMgvqC0anuE+eQ/KWgz62K09AtsmELC5gQHwr5lI8tyhsEKliCfm7ZLdLgziH1st6Mmr4GL67JwzSP3qLTxw0tGy4WlUB0nrSinw+IxvXO8KhZA6kkNeeANx+M1hJPOdjaI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <342ACEEFC1AC6347A1BFEC3E7373A5BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4dda7e-b5cd-42a4-6d88-08d681ab911f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 03:25:17.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMjMvMTkgMjo1NiBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBI
aSBTdXJhdmVlLA0KPiANCj4gT24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMDM6NTM6MThQTSArMDAw
MCwgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSB3cm90ZToNCj4+IFRoYW5rcyBmb3IgdGhlIGRldGFp
bC4gQWxyaWdodCB0aGVuLCBsZXQncyBqdXN0IGdvIHdpdGggdGhlIHZlcnNpb24geW91DQo+PiBz
ZW50IG9uIDEvMTYvMTkuIERvIHlvdSB3YW50IG1lIHRvIHJlc2VuZCBWMyB3aXRoIHRoYXQgY2hh
bmdlcywgb3INCj4+IHdvdWxkIHlvdSBiZSB0YWtpbmcgY2FyZSBvZiB0aGF0Pw0KPiANCj4gUGxl
YXNlIHNlbmQgbWUgYSB2MyBiYXNlZCBvbiB0aGUgZGlmZiBJIHNlbnQgbGFzdCB3ZWVrLiBBbHNv
IGFkZCBhDQo+IHNlcGFyYXRlIHBhdGNoIHdoaWNoIGFkZHMgdGhlIG1pc3NpbmcgZHRlIGZsdXNo
IGZvciB0aGUgYWxpYXMgZW50cnkuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJSm9lcmcNCj4gDQoN
CkFjdHVhbGx5LCBJIGp1c3Qgbm90aWNlZCB0aGF0IGRldmljZV9mbHVzaF9kdGUoKSBoYXMgYWxy
ZWFkeSBoYW5kbGVkIGZsdXNoaW5nIHRoZSBEVEUNCmZvciBhbGlhcyBkZXZpY2UgYXMgd2VsbC4g
UGxlYXNlIHNlZSB0aGUgbGluayBiZWxvdy4NCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jI0wxMjE5DQoNClNv
LCB3ZSBkb24ndCBuZWVkIHRvIGNhbGwgZGV2aWNlX2ZsdXNoX2R0ZSgpIGZvciBhbGlhcyBkZXZp
Y2UgaW4gZG9fZGV0YWNoKCkuDQoNClJlZ2FyZHMsDQpTdXJhdmVlDQo=
