Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8BAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26E321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ICz8KRqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfAXORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:17:37 -0500
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:41826
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727790AbfAXORg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70NT/Omb0GFUCY7JQcG1oLfsO0GBfFlnwiWP1cu9+fQ=;
 b=ICz8KRqCYAdQkpf53W7XK97aWOLmcJJCTiPMGnRk3qVjn/2Bf7VSD2SSfcDlATo9Y7EJF6JxfsMO+mfLb2oe8/zwvLH0AuMOyLIKP/yEQ51WRyRuohDD5//52OB4yGZBCzDnEBpAJIIOUR1DrEasF+IVNOBxxR+2tcm6kKsk+WM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3227.namprd12.prod.outlook.com (20.179.105.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 14:17:35 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 14:17:35 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device
 from a domain
Thread-Topic: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device
 from a domain
Thread-Index: AQHUs5ueti9jdxud0kGP04WcL8K6sKW+dkKAgAABlgA=
Date:   Thu, 24 Jan 2019 14:17:34 +0000
Message-ID: <c965ccfb-1a98-1fc2-5980-2d7f17688e54@amd.com>
References: <20190124041619.1974-1-Suravee.Suthikulpanit@amd.com>
 <20190124141145.GM32526@8bytes.org>
In-Reply-To: <20190124141145.GM32526@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [165.204.53.123]
x-clientproxiedby: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3227;20:6J9egMVChhlcmNzl7HXF39FYdiP4+2Gnpg/qv60FplAKardu86E4DoEfk+P04E+MNIIdFwx/wbofn4hKe2Jd4ZtAq9PdmMr0ZSNZf7sFER5er2E207G49MBmnYuuyq+EwUS2UbzY4GYiMDQ3ww9hUfAO1+JSfI4W3i1UVltscsjvfvdwh/Caxw+GPEkl8jEv5rNnw98RaajGmBZSA15bNHUKM6DFYJqDzCSnsxj84/vJOhAwNGuYzPYmMPHMGTM9
x-ms-office365-filtering-correlation-id: 291813b9-d956-476f-fbea-08d68206af8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3227;
x-ms-traffictypediagnostic: DM6PR12MB3227:
x-microsoft-antispam-prvs: <DM6PR12MB3227349C7DEA9BD0E2A5463CF39A0@DM6PR12MB3227.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(8676002)(68736007)(31686004)(64126003)(486006)(2616005)(86362001)(6246003)(31696002)(65956001)(66066001)(25786009)(53936002)(65806001)(4326008)(6512007)(476003)(8936002)(65826007)(7736002)(106356001)(105586002)(6916009)(2351001)(1730700003)(81156014)(2501003)(81166006)(6486002)(76176011)(4744005)(36756003)(99286004)(3846002)(71200400001)(446003)(72206003)(6116002)(54906003)(186003)(316002)(11346002)(52116002)(97736004)(58126008)(53546011)(386003)(6506007)(305945005)(229853002)(2906002)(5640700003)(14454004)(256004)(71190400001)(478600001)(6436002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3227;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CKx/xn4gSH/ZyEIwFBh2xnv5ujgIQxpYgxgs1dZC+hG103LslCRmS0OFIpqUoNvA/ETdtzDN3tTF0Plth3jJeRWYkZ3jH9CL/AK7Um3xxUVIUO7fFV5Ohjd0lczx5H9yyBL1I4CzdGWOlBsojMDd/6xwjxu/B4cKnk35KbFnmo9Kyw4VNxOHisFHzJwgPZ1+2Wpr80PA6UhvpoWkE20WQpHhVQfV1w2A5T+sPWLa5bogA1Q0XfPB+mcxfLGNRlzzUv/+TQyZI5O3mtcKX8IkNkxybXz84BqDLx7TJXCFtAZ56qnwpMihin/Rm2+N0/fYfWt2+swmafHBYgWuwGudSAGcG3WmnNk2Cc18AUNL5wDv/ZtG7l8ayHH2jgfvzD5TcVfVQzjq7VQ7udiE1+mhIFNfEQSrQDC6aeYVbr5rw3Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA1A9C074374641ACC3E802C57BA269@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291813b9-d956-476f-fbea-08d68206af8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 14:17:31.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMjQvMTkgOToxMSBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBP
biBUaHUsIEphbiAyNCwgMjAxOSBhdCAwNDoxNjo0NUFNICswMDAwLCBTdXRoaWt1bHBhbml0LCBT
dXJhdmVlIHdyb3RlOg0KPj4gICBkcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIHwgMTUgKysrKysr
KysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiANCj4gQXBwbGllZCwgdGhhbmtzIFN1cmF2ZWUuDQo+IA0KDQpUaGFua3MuIEFs
c28sIHNob3VsZCB0aGlzIGFsc28gYmFjay1wb3J0ZWQgdG8gc3RhYmxlIHRyZWUgYXMgd2VsbD8N
Cg0KU3VyYXZlZQ0K
