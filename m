Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FB42147A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RIFeyEqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfA3Buy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:50:54 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:21713 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbfA3Bux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:50:53 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5102fa0000>; Wed, 30 Jan 2019 09:50:51 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 17:50:49 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 29 Jan 2019 17:50:49 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 01:50:48 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 01:50:47 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.54) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 30 Jan 2019 01:50:47 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 01:50:44 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 01:50:44 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuCjcFQq4Ugnr9EajTUu9v/+Er6XHCbsAgAACEcA=
Date:   Wed, 30 Jan 2019 01:50:44 +0000
Message-ID: <BYAPR12MB339850895826781B4E6AF028C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
        <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
 <20190130044214.65991195@dimatab>
In-Reply-To: <20190130044214.65991195@dimatab>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3638;6:mrIUnK9JR+HicPVFPLWut1+8u+RsB8VX091psVEW0bBpwwZvmhYqIfyVvbeQELIV5G2QNlDsMGNklqCkPHuKMI8mv61Z36SkA14Sun40r0gZ00Z1hbzqd3z6CRTa/YwzijTTzIooytUgHUS5SU4x5IEbhwv3Igy93l+b3T50dPX/Q9mvHewSQXXs7LxJ0icjBrUug7253G/ULWDnBMJefA4FUWiXrOP4knCEWnIqOZl/xFpLnb3iqT+nJ/1ht60MdL0jHj96sOXzgmhtkbVh/z6dSYhazNm1EByl6tl8uwKGSwzoVe3qFHzzjhmJUcx4Css1i7GoGqf68Lqu73RaNmE3Vw81jPhKecnCQL6MeLDBdj5SPbwtEgWlzIVqlybinaoMQS1meVJwVAvF79hv44p3IPmvwT7S1R4KSSUZAOzh70LDbYWNIgH1Jy6kycYM90eVjR5+5LwdEMS0C58iCw==;5:9g2wZR9dFsDz4oT6hNgUo+Y5AvF7KArAjr05+RmW1w7CWp3SP3NIPNBPV5qLNEoVpCkhkDNu3kVDDwCtgWE27D55EGA12YoMYqsEb8mfp2o1qua6TcZB1brgW03wCIVAlu13604ZJYA2+mYLBdf8pAQDSfUQMmFKHDb/jB52OjSOtWuDvInbvvOOW2lp3lbgA9PRX4Hy2NgaG5rGHG6YSg==;7:Jgh3STBj7NQxUe6STYC41RtEQpLD3sTB0I38jNMXXNUQDxs1HdH/7+lJ32ZxKtk2MboZDZ8KovDpeCBcSHuEhgmNl9FzM1z1t02tHJRNZhCVYyEqZs/lIqcVbOn72feX99c7MxyzlANXvVviPDRc/A==
x-ms-office365-filtering-correlation-id: 9e072037-47dc-4bf6-2cd1-08d686555904
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-microsoft-antispam-prvs: <BYAPR12MB36387C644C441661E08BD2C9C2900@BYAPR12MB3638.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(376002)(136003)(189003)(25584004)(199004)(305945005)(3846002)(7736002)(966005)(229853002)(6116002)(186003)(14454004)(74316002)(6506007)(6436002)(55016002)(2906002)(4744005)(33656002)(6246003)(53936002)(97736004)(478600001)(54906003)(316002)(4326008)(11346002)(256004)(446003)(476003)(7696005)(99286004)(39060400002)(486006)(86362001)(105586002)(6306002)(76176011)(106356001)(6916009)(66066001)(1411001)(25786009)(26005)(8936002)(102836004)(81166006)(68736007)(71190400001)(9686003)(71200400001)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dCK8Nqrxkk8W6Rq+cW7H5mV8lLpnDNE/nL6BmrCbgTV1OPpCtL94UQFNB6fdWyiIcM5alDvutvUeK5POka0Y/NQ5Z2VzHB/S3S6DUQ0wy3uImUru7JgNqTvyZbVlgnS4PkgXMfZ+saI1ce1koIjC6Q7JXOKoxGPgUN81eHa8JsA+xhq0n0AE8SJfg44Q95BVl96DIC+2pyQZq7TF1jCODU2RnHK2VQoPHfmFAPe0xwnLJXz2lSsCZoG1MdnzGQsnkdL7PaBrm7hiJDHyIgCoe4hN7EaElgnLdyeWhGrHV8XOKjDsF5WpaFTJXKEmkXmNOroWL466DWxQN192oUNAQTlLffNExT0KLVlJLZ1RJrqaaGYLGDW+VgpSBYrXz1hS0+WPMUE5kosA/GDctIan89IdNM06mMmyg2gcrj6mn2E=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e072037-47dc-4bf6-2cd1-08d686555904
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 01:50:44.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548813051; bh=qo13gShy8ikaA/i6RLhxBH63CfrL1CsWyO0ogKysX+4=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=RIFeyEqOTi9sbc0vEN+CwibvIagmDknHboYed/zGPwzsiABv4Tyli0U1NZ5zJ/c9s
         oh0mEUysrpnrcyst1HLlp8usysXi4JeqdnYMQS5dHRo6LZnToPo2SA1mAr+4kbxV7l
         7E65+q5Q60ibd42VKwajFVu8mT1oDVuA8ATIvEsjsf4xlJudtKxAQCkk5CrjKtFoYJ
         kuEeYA8/hAI2E/4mf5gI/+t44j6Ccrms7qy2bZyh48/1YTlDpRU0Ka9nexbsB7hZJt
         sTZjxR1muierrBorYtolGhu/A+cBqzuFLssZJSLB+rM1VLkLBuPGtbba5/Lr4k1WEj
         v33ksKtxCcwdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gQ291bGQgeW91IHBsZWFzZSB0ZWxsIHdoZXRoZXIgeW91IG1pc3NlZCBteSBjb21tZW50
cyB0byBWMyBbMF0gb3IgY2hvc2UgdG8gaWdub3JlIHRoZW0/IElmIHRoZSBmb3JtZXIsIHRoZW4g
SSdkIHdhbnQgdG8gZ2V0IGFuc3dlcnMgdG8gdGhvc2UgcXVlc3Rpb25zIGFuZCBjb21tZW50cy4g
SSdsbCBzdG9wIGhlcmUgZm9yIG5vdy4NCj4gDQo+IFswXSBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3BhdGNoLzEwMzEzNzkvDQoNClNvbWVob3cgbWlzc2VkIHRob3NlIGZyb20gbXVsdGlw
bGUgY29tbWVudHMuIFdpbGwgZ28gdGhydSBhbmQgcmVzcG9uZCBiYWNrLg0KDQpUaGFua3MNCnNv
d2phbnlhDQo=
