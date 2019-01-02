Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57152C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D16D2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kVyhO82d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfABXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:02:16 -0500
Received: from mail-eopbgr60134.outbound.protection.outlook.com ([40.107.6.134]:25472
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfABXCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl/n80+f+LHHI7ZIDr3uNwrCQ7jQnduUtD0uuVkQAY=;
 b=kVyhO82dS4Gy2Xn0idElO6PGnGz4qBmSrbS0y7XiIymBIfSCgRMRz1B294YGaLVhUw+fIBYi7LVfTavQSGA64L9Sb5HTudZvla3DTVOn20h/F5ddoqzFgZCc9tH2SpAjsj7fyshyAh6/QTADEjp4CEj4OBO6ugahWRta3cOtAkg=
Received: from AM6PR0202MB3271.eurprd02.prod.outlook.com (52.133.28.141) by
 AM6PR0202MB3558.eurprd02.prod.outlook.com (52.133.11.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 23:02:10 +0000
Received: from AM6PR0202MB3271.eurprd02.prod.outlook.com
 ([fe80::3ccc:e2fa:d507:5ae5]) by AM6PR0202MB3271.eurprd02.prod.outlook.com
 ([fe80::3ccc:e2fa:d507:5ae5%6]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 23:02:10 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Thread-Topic: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Thread-Index: AQHUouT30N0PYO/CsUuP4U03RR2BsqWcmWkA///4+ACAAAYzgA==
Date:   Wed, 2 Jan 2019 23:02:10 +0000
Message-ID: <20cf9eb0-d8f6-7a85-3fb7-2c3aa5e41f31@axentia.se>
References: <1546465721-12108-1-git-send-email-skomatineni@nvidia.com>
 <e0f6cea5-cd18-1ed1-f8ee-aa9c58198df2@axentia.se>
 <BN7PR12MB283656FC1AA704474BC52728C28C0@BN7PR12MB2836.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB283656FC1AA704474BC52728C28C0@BN7PR12MB2836.namprd12.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR09CA0058.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::26) To AM6PR0202MB3271.eurprd02.prod.outlook.com
 (2603:10a6:209:19::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0202MB3558;6:2dI2DZ0NQiX8+UnZM1Wg2uIKa72FU/L4DFg+PeUM2xFbszZRgKeEm1pymaFmCxzVSZfxyRr8iTfeZN2TrwbiJa0RSAlQScoNUXqCu+MUw1oTyLoakP06pI6HtCVXJtRlW5afRh0VjPhTI0hIsLhUAmECs+Qt/NQPz0lYl92CvrHT7cWAlkN4wW7/7R2TCTjiTTDSzMRJDrbP6L6KuhnihXSGUAWqEOOjEj5/PSAtsjRtExtu3nV33A01ROqoMOgvbSfmhtmvt7VGQLCQrPFoxmH9PKVGyOcBxA7dYsE5v2QHWynWLe0imW1i0KVUloi8B19gHjRakHLBo5Pd2ZexwDCUQtXqs8a/NaKqNzNb3W6FRu6Lfb7viwRZGh1gzH0hvszraKPYRsn0hLvFLNrTjzCxX5Ybxn/lOSQh4UUsOoS5w2cv6Lbp9mx9uL4v4iqYS6eCYbvnqvC0cDcrmiq3/Q==;5:dSjJCjk1EpgTTdKu4rCrwCEzS/gXJH/t+5sWd2pAGnyqxrlHgb70LlLdxcSnxVHB93UDc2HN89/U6STnxcapBJJkGI2idWCN+RcwfNEiSzEYOK/a+ukDpkWqbuLgOMeMX+6WZBopKCLDf4cfI/uR3GIyn2UGe/irrwwnVy13F9tPfM2EZ5C6omxohZvPKTDWXKebC+qXl4m+SUXst8xvGw==;7:KReZ6CN0dZ5sbmynsmEXKuNfKpPe7nqimOiaWm0Qom01WIWT82P225k2dzJK4WQBlZ92Q23mCQcmXWeYbq68uIQ05XbDr0wS2wkucI7HY0Zkx9Q9Cl1eiisGne1d6rcpK3G7S2QnIq9NY3x4nEsV4w==
x-ms-office365-filtering-correlation-id: 6c130bba-081b-4470-59b2-08d671065379
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR0202MB3558;
x-ms-traffictypediagnostic: AM6PR0202MB3558:
x-microsoft-antispam-prvs: <AM6PR0202MB355818D5F23A9CDB55CB20C4BC8C0@AM6PR0202MB3558.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR0202MB3558;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0202MB3558;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39830400003)(136003)(189003)(199004)(54906003)(65806001)(11346002)(65956001)(446003)(305945005)(68736007)(97736004)(36756003)(58126008)(71200400001)(71190400001)(256004)(2616005)(6436002)(66066001)(110136005)(105586002)(106356001)(508600001)(316002)(14454004)(31686004)(476003)(486006)(5660300001)(6486002)(39060400002)(65826007)(64126003)(4326008)(74482002)(7736002)(81156014)(99286004)(81166006)(25786009)(76176011)(53936002)(31696002)(52116002)(86362001)(8676002)(6512007)(186003)(26005)(2501003)(6246003)(3846002)(6506007)(386003)(53546011)(6116002)(229853002)(8936002)(102836004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3558;H:AM6PR0202MB3271.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: STuKwlMO5/Gi2+s5bwsQCXYgPqTJ+XE8LzKFg928eaiCoGHmh9An/woV67y2LnLA2yIAyNSojgSFxGzZ3OThuKSHINgkZ/MM0SGZPMN/2iIiV0Ec75q7WKJwFK2VrmN8D8zFtwOoXYhpfC0AlTWxGB+IdTW6hm+oIAkLT2TWQkvmzmKcmPl1xOShtIDpfwHZsOlPKAbc9U+88R2Erxis6KM0g/PWHG20DVVPn2lTC42G72YdTFFKYfQJvPFzWx9JuM7Y3tiGVyPSF+9PqVpjpIGFAy64Dq4oRhJYs8WAu6j7UaUH2iJhT2MMjUBdkmSV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3807BD46D86DEC48A3A9C472AE224076@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c130bba-081b-4470-59b2-08d671065379
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 23:02:10.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wMiAyMzozOSwgU293amFueWEgS29tYXRpbmVuaSB3cm90ZToNCj4+PiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBpMmNfYWRhcHRlcl9xdWlya3MgdGVncmExOTRfaTJjX3F1aXJrcyA9
IHsNCj4+PiArCS5mbGFncyA9IEkyQ19BUV9OT19aRVJPX0xFTiwNCj4+DQo+PiBUaGlzIGlzIG5v
dCBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCB0aGUgZmxhZyBpcyBub3QgcHJl
c2VudCBpbiB0aGUgb2xkIHN0cnVjdCB0ZWdyYV9pMmNfcXVpcmtzIGFib3ZlLiBBcmUgeW91IHRy
eWluZyB0byBzbmVhayBjaGFuZ2VzIHBhc3QgdGhlIG1haW50YWluZXJzLCBvciB3YXMgdGhlIGNo
YW5nZSBzaW1wbHkgbm90IGludGVudGlvbmFsPw0KPiBGbGFnIG9mIE5PX1pFUk9fTEVOIGlzIHBy
ZXNlbnQgaW4gdGVncmFfaTJjX3F1aXJrcyBhcyB3ZWxsLiBJIGhhdmUgYWRkZWQgc2VwYXJhdGUg
cXVpcmsgd2l0aCBzYW1lIGZsYWcgYW5kIHBheWxvYWQgY2hhbmdlIGZvciBUZWdyYTE5NA0KDQoq
Ymx1c2gqDQoNCkkgd2FzIGNvbXBhcmluZyB3aXRoIG9sZCBzb3VyY2VzLiBTb3JyeSENCg0KQ2hl
ZXJzLA0KUGV0ZXINCg==
