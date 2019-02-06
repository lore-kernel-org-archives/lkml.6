Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD9CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42282217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rNwx3qF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfBFPPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:46 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15821 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfBFPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5afa220000>; Wed, 06 Feb 2019 07:15:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 07:15:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 07:15:42 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 15:15:42 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 15:15:42 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2919.namprd12.prod.outlook.com (20.179.91.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 15:15:26 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 15:15:26 +0000
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
Subject: RE: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvirrRqFd+/7ajEuXA8RvSaEC+KXS3a4AgAAAyeA=
Date:   Wed, 6 Feb 2019 15:15:26 +0000
Message-ID: <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
In-Reply-To: <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2919;6:6y0JiHqPQMHU8rjSiWa+uF0pnBbJmCvvc7TQYjt+7I2A6blI0TBUKkRfUIOmtT2ZL27ZYQjy7MgWJ14Fl94GFijeYXLrCeoHO/bctY8h0a5MQwgxFfgQL/EOErpG6KsKEYfKFr2aw9cT/v5cg/iged7TynTREmyMnBgkBbkrTNMv6pr4zG6A7saPx6Sh9xnAw0hQ9jKTjEAHMFE0xim8AfddzItcRWhYkAm4iUW1u9EuCHDT5g+9nsRCs0Z/pT7yVsQw4py4KwnkFT9qr6XfHLtE5qUQ7AqMmB5h3F1sIZ1+j9s0Vq2z2WQAFpLdcOX5F4Difs1OSJdDBJ+u0yU0ALkfvtAVbv28JH34xwzoRShJGUVOKDoqKDTpKzUTR7wuBySp26wJQpqKQrhl8xId4jzIVWa+VmFl1plXhJGZzL57OmCjMbPrXuxVF2Tj7PVfCSHBDnhNa9eUY8hytcerhA==;5:b89D4YSTW2r35Z/N+Il/Wfz1r8vYqkrg2IQJag0aUOjB4WrfhWqrRooF06mep0SxTZD0Vs/WluCDBg7vgv1E5vGAY+My1Z0x3lVLdk/4BH0TEVY/HNz9DeQJ8xvlWWhC8zs+J8mLK/zD0huh5CW9Dna7lSRt2gWMnr8y4RQR5TKov65JSWAEnPXHWDYU+wGqAddtdOr465YG/2bhgjcqjQ==;7:qXRWKH1rN2uRSYHm6VWTcDMN0xbdKnj9DwEv0ZyNIusmaw1hB4rlBkd3LR9JGcoWiz5A94y5xfDOZfmQWHxvBwyaK5ENhBNmvBkwPZWWC+ZaK4hpMTmbd6tRuNIFGZGrFSNaFD5YDwUWuW5a//Vdvg==
x-ms-office365-filtering-correlation-id: 1d3f9431-37a2-428b-60eb-08d68c45ec53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2919;
x-ms-traffictypediagnostic: BYAPR12MB2919:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR12MB2919FD93498F7E4E654E5590C26F0@BYAPR12MB2919.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(186003)(4744005)(106356001)(6116002)(3846002)(26005)(102836004)(2906002)(33656002)(105586002)(6506007)(7736002)(476003)(305945005)(74316002)(86362001)(81156014)(4326008)(8936002)(81166006)(11346002)(25786009)(486006)(446003)(97736004)(53376002)(6246003)(93376004)(8676002)(6436002)(66066001)(478600001)(55016002)(6306002)(9686003)(966005)(14454004)(68736007)(229853002)(7696005)(71190400001)(71200400001)(6636002)(54906003)(110136005)(2501003)(53936002)(316002)(256004)(99286004)(76176011)(15302535012);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2919;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i1jLL4UFIk8wkGr25F2nqH/0B6u2TOKUfsW9yBRhQyj+Bxh0nGIx0jWGGY0d7SpcTxosnGnzD/3MrrT3p3OWlJeOaTC+BS09SrO25GQORFswLTT+qvk2Upn9+LsFA2dLKCSWBi0KkNWua2XVX3HmkUBkshcuwxnK4i8UefHESZqs5VlT8kZxtSG5aYbNFCDBGJn0mUxPHUoco1OKrR+uH56kk5TwLTtAKSGCTiFB1vn6D5KoHkLkxLY1Lvo5Hxt+9jvmJgD5CmgeN9+4NIPxv3+KzjHXWQg/6oOHdyhTHdeGnrA32TxrMUfpX2NMSAw5YlA9GOv6OAuEvlNrqt4iAlLp8T9rUS2tJVkmRqMGEBnrrOQUN4iUWtbxf8OufX6YqMEEmulZEH/1k2YfCbmrxkpMYP87w0bTcG7rBxgUuIE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3f9431-37a2-428b-60eb-08d68c45ec53
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 15:15:26.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549466146; bh=/t1l+20xXlw4B24USeZ7dsO2NyNMZAz+3eJJkR6Zt+c=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-purlcount:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=rNwx3qF6v/rfPk8JG9Fv2g2RNclxOGhNFJP1wfit1Ez0G9juDGIV03S5Ee8wfAzE8
         mnu8oNgmyTdWANKRehVNmb58luh8eDpmCjMuamLdHnf+pEILw4Yym1eTL07Z2EuT+/
         8NOcXxDYuFFRa8WkH21VfAMX5qEsQNzgIlTwFL0x5KibPRIa2YwhrAT1JlFd3QhVZ1
         DUaP9tH7cy73aIEYFE8UEPt6DtcthOligBz3HOcO3sCY5grYKJbxo91NHu+QzfRU2E
         q75sbHjlHs24dflf3dsE80Mux01ujKZ1tCOw7jQ4LwncMWppEusUUWzq5/LXz/boEl
         Xr30NiGu9PUSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFR3byAiOzsiIGF0IHRoZSBlbmQuDQo+DQo+DQo+DQo+IEdvb2QgbmV3czogRFZDIEkyQyB3
b3JrcyBub3cgYW5kIHRwczY1ODZ4IHByb2JlcyBmaW5lISA6KSBCYWQgbmV3czogYXRtZWwtdG91
Y2ggc3RpbGwgaGFzIHNhbWUgcHJvYmxlbXMgYXMgaW4gVjEyIDooDQo+IA0KPiBETUEtb25seSBW
MTM6IGh0dHA6Ly9kcGFzdGUuY29tLzBYSjFaOEcudHh0DQoNClN0cmFuZ2VseSwgdGhlcmUgYXJl
IG1hbnkgdHJhbnNhY3Rpb25zIHRvIHRvdWNoIGFuZCBhbGwgb2YgdGhlbSBhcmUgZ29vZCBleGNl
cHQgRE1BIHRpbWVvdXQgb25seSB3aGVuIHJlYWRpbmcgVDQ0IGFuZCBUNQ0KYXRtZWxfbXh0X3Rz
IDAtMDA0YzogRmFpbGVkIHRvIHJlYWQgVDQ0IGFuZCBUNSAoLTExMCkNCg==
