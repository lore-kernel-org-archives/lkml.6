Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7788D20821
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ocgYrlZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBGPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:18:11 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17640 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfBGPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:18:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c4c200001>; Thu, 07 Feb 2019 07:17:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 07:18:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Feb 2019 07:18:08 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 15:18:07 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 15:18:07 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3112.namprd12.prod.outlook.com (20.178.54.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 15:17:51 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:17:51 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUbM4AgAADlOCAAALKgA==
Date:   Thu, 7 Feb 2019 15:17:51 +0000
Message-ID: <BYAPR12MB3398D7C0AF550D12F3D133C9C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <a6b1acbd-9be0-62b7-29bb-081d93ee92fb@gmail.com>
 <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3112;6:AtuKMudg552XiGZ8KpWZIwM/ihz4A9H91VX07tFK6LaL4ZSH717kPgy/LMoYf6pl2DXL9cQjPr6pXpt+FzdD1W8AV6NF3DaVFMurSMWdQvP11Q1K6Mh3axKf+h4ovaAJUb+DycK3qpzjdbcmorix7Oj3dNyeO/jr0NR8zYYkM+0bUhCAR/kJPvNxq4sPqwu9EOSyVLy7qgF+SqCuub4bdI4+Lbl9hqtw2nNBMp/32lvI5OM4vo3ohanGyNFDgH8lM67OAPIDS4fYBARTVx5hGp3XVGvJ3F46RxLrsujZ3q5iFYqEowja9FYZRj/N5nxvyP4rRUvQa+vI9Ldj7aFcwalLcKiPO40isOMxTVpzlw4f9pOp+X1O1j096a6OqCxUdJsEZcxlG9AjNhbsy+KpAOOyn5hWyL8sTj3tzyGM1xCMB/dMS9EUFIziHRUN8YAFWT9+0oIxtmVDcmaPciJkWA==;5:Tp2uND9XLoJIAzVf85xAnaAD51Yi91+TfGALq2P0PXg27RaVlyeGVx3v7JqFTToetI0bGsTDBQIxEoSGt1LmE7C/naxdDRUAp+53j/XVzkTKtW1X6227cY79k5GpxfuQ8brbsTI0R2KP3VtSmnK42VHWZ8QXex2cEPyFEuBbJBObgTh6Gvk2gNOGGfhC4gT41NRXHjL7ZuhpML2Eqkh1xg==;7:UYa94C8a8XPL5KWdEsnMukyfcutLpvdDLghUlvQ5Dkj6JOBW+UjWYFx0fFvY0idlJdY7hT5RH5ceQaITNq1XDl50mm98UcFED3SR2KW8VuoBLQWLHWV/ZKSYmsCrsRkgl3rTg7kldqd1I211cLsLMA==
x-ms-office365-filtering-correlation-id: 09031baf-f41a-44c5-0107-08d68d0f6d45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3112;
x-ms-traffictypediagnostic: BYAPR12MB3112:
x-microsoft-antispam-prvs: <BYAPR12MB311244D2CDA7570DE30E3294C2680@BYAPR12MB3112.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(346002)(366004)(376002)(199004)(189003)(229853002)(316002)(97736004)(54906003)(110136005)(478600001)(81166006)(8676002)(7696005)(305945005)(93156006)(81156014)(256004)(6636002)(4744005)(66066001)(6116002)(25786009)(33656002)(9686003)(3846002)(55016002)(14444005)(8936002)(105586002)(86362001)(4326008)(486006)(106356001)(476003)(2940100002)(2501003)(186003)(2906002)(68736007)(99286004)(446003)(26005)(74316002)(7736002)(76176011)(14454004)(102836004)(53936002)(93886005)(71190400001)(6246003)(71200400001)(6436002)(11346002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3112;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sz338HQBGhYJZ1/gabLGs5016QgCN9vIA3TT0am2sFufGe5K14l8EKG4tZz1aRaxwUiuBexMRfMLNlqqyNNHLne1NK3+IwbK05G6l60UCBwtXPTWCx8Gzo8BZZwsFszYjhhxfnz3BPl3ajDhL1/T/A8SZKKixofbkSc/BmNaursZal4hjkdYCRlKOsWkLSqU8A8cWLixxxJq0X4ziaNQtiqk/vmupsc2h6GjP1ctaDj3t6SMFVsOp5c5uGwdm6gFS03p/hS6JfYz8B/npfFNTNtS38ymA5qnux7mWvMNKO2lvmQgoKSgnCkdPARSRNkDJ6csw+cAL/PcBkxYi3+SwVmSsGgD5Uhe2OTw8cpKXulexY6MvANWQVR9yK8QX5LZvQJYlypQnOjmm2lE+qvw1MdqCaB8CqWZA+tgKmpoAV4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09031baf-f41a-44c5-0107-08d68d0f6d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:17:51.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3112
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549552672; bh=bNNQ5ZAeT14mDZaBoouRzCAXfx/JW8rh6/C1QoV5ino=;
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
        b=ocgYrlZWNWCGytUzI6Yzk5ktrR6Ub6wfe/D0g09Uy6xaexjWUp9sHEMjJbRw2RnCz
         Vhzd83WnNrnxJ+sDSPY47UP+hEY0iVjEOUhukUK6g0bDmotfVTR3SiJ6sX3YW/T/OC
         hJrit0crL3AJSBq9jIIcy0IijGGTeRTIhHimqcwcDftQPG1XZp1tayt0ditWWNWjeg
         m5uPVH9cI8U1W9bilAgN28tILjGKr4tR0/Cb6BjiZJogdurR4Qq5LumVd0MGpGW6+f
         j0Ue2DEF65pqG4JRo91MzR2AqprAuDHIDWp1wAU8kkdLtCZ6yRcKB+xqL1Nx3WaQAG
         uq1FDs2jl2P4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IA0KPiA+ID4gQEAgLTExMjQsNiArMTQ1MywxMCBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gIAkJfQ0KPiA+ID4gIAl9
DQo+ID4gPiAgDQo+ID4gPiArCXJldCA9IHRlZ3JhX2kyY19pbml0X2RtYShpMmNfZGV2KTsNCj4g
PiA+ICsJaWYgKHJldCA8IDApDQo+ID4gPiArCQlnb3RvIGRpc2FibGVfZGl2X2NsazsNCj4gPiA+
ICsNCj4gPiA+ICAJcmV0ID0gdGVncmFfaTJjX2luaXQoaTJjX2Rldik7DQo+ID4gPiAgCWlmIChy
ZXQpIHsNCj4gPiA+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBpbml0aWFsaXpl
IGkyYyBjb250cm9sbGVyXG4iKTsNCj4gPg0KPiA+DQo+ID4gTWlzc2luZyBETUEgcmVzb3VyY2lu
ZyByZWxlYXNlIG9uIHByb2JlIGZhaWx1cmUuDQo+DQpJZiBwcm9iZSBmYWlscyBkdWUgdG8gb3Ro
ZXIgcmVhc29ucywgdGhlbiBJMkMgaW50ZXJmYWNlIHdpbGwgbm90IGJlIGF2YWlsYWJsZSBhbmQg
Ym9vdCB3aWxsIG5vdCBldmVuIGhhcHBlbi4NCkRvIHdlIG5lZWQgRE1BIHJlc291cmNpbmcgcmVs
ZWFzZT8NClByb2JlIGNhbiBmYWlsIGR1ZSB0byB0aW1lb3V0IG9yIGZyb20gcG1fcnVudGltZS4u
IGFuZCBpZiBpMmMgZmFpbHMgbG90cyBvZiB0aGluZ3MgZG9u4oCZdCBoYXBwZW4gcHJvcGVybHkg
YW5kIGRvZXNu4oCZdCBib290Lg0KDQpXaWxsIGFkZCBidXQgd2FudCB0byBjaGVjay4uDQoNCg==
