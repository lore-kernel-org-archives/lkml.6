Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD91C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDD720850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p+SLkZfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfAHMCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:02:30 -0500
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:31320
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfAHMC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgiq/URs8mSPbmGcALjhAJ9nKqnxz2Jf0eOzx/r/As4=;
 b=p+SLkZflAA3erRLq6oIzofKHxQbD1fnH4EDi3zZkxlVqX5u2Vtms0x8IeEaJuwu86YaDCv5x53UjVMmYgsdkrMUshFVpO0t5ODyzIn5err7poCfbTZNGi4pr7VoOVpfgryj5kZadlfyKJ4jtqOYuqLfQ+vny4zRfWQGTImM5A00=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3295.eurprd04.prod.outlook.com (10.170.231.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 8 Jan 2019 12:02:24 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::6d0a:7236:6fac:6fd6]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::6d0a:7236:6fac:6fd6%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 12:02:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] dmaengine: imx-sdma: refine to load context only once
Thread-Topic: [PATCH v1] dmaengine: imx-sdma: refine to load context only once
Thread-Index: AQHUjS3z65ezEyQA4USXiDHUeJ9i7qWfZgcAgAYTFYA=
Date:   Tue, 8 Jan 2019 12:02:24 +0000
Message-ID: <VI1PR04MB45438679866C49256F1D79CF898A0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1544107081-7440-1-git-send-email-yibin.gong@nxp.com>
 <20190104151432.GJ13372@vkoul-mobl.Dlink>
In-Reply-To: <20190104151432.GJ13372@vkoul-mobl.Dlink>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [116.227.135.24]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3295;6:CbcVcq2gI7v7XaghtxkDjYJs0rj5DcsYh97H/OAKh1VGH85i7dPLMdQeODIOeL2u6JAjQzLmPufEAbNN9nGgXIiN1eGOVRNMucy0Mv0kIa8mG9T/Wc+dT9yz5oJMWwnJGr0IqpvFTq9U2S1PRQ85sj2V4qqnCqjtLUsLQ0dkGVpv/7twhLEZnlmQo5WMAlAOsIW1fkcCMtCik1MHWfO847Yh65e/SBmMlj8fk/Dmsmj3oSZHLjPLM034NCAse/MRpcII2WXPI1jorujRvpgDxRW7s89C+Bc/3ZkUkElRpP3qk5p9mxO7pSYLg6SolJYMfb2/VhGAGbR8cx9j7gufVvv+hz9B1Yil9c5Ckql3+Bvis+WQQ8I6ZqyOyRQAWqurIPcK0ZqBpIgge0eVWuGvnWlbbv03Eba4zcHWHaqdcPmeoKWVSMwil6ZJXsTzmAXgCepal3ENRZw41ALrPw/YuQ==;5:YgeminriisxnONLs3HYUwDjA4KCYBbylHDryWt2ILwF65GmDD+z7k4MgAvkGJfZ4kRf8g+3jBI+Q7OUKhe/v5Mi4+wRE1HJlXe6Zh+eQ7EhIgsz6ULyK3Hoz4lS/Q1Dm4Yx4fyk5l6utTNzTdmxpDH6wI+Ls2yy7NGuPwJ/0+T/eyNVcFOedzbsezLCCqV2smQL67lctSyaSHzz296o2bQ==;7:iTY98TVjWEha0+ssDgjqca7JVoPw7+6q05OQzqkrvG0xr3uCl0KFgepozomMNP/yau4tCgdnRScaK115JEpUMenXdJ4ug5DhW1ii3Ic406e9OJXA9BasnREtyW2oqpF0wCfZqwjTp26SpVK0mXClCw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 16e92e51-cb63-4a33-5ba3-08d6756126ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3295;
x-ms-traffictypediagnostic: VI1PR04MB3295:
x-microsoft-antispam-prvs: <VI1PR04MB32950130DA8A4CFCD5FEA067898A0@VI1PR04MB3295.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3295;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3295;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(13464003)(3846002)(6506007)(66066001)(68736007)(6116002)(76176011)(7696005)(99286004)(54906003)(14454004)(26005)(74316002)(229853002)(478600001)(2906002)(105586002)(486006)(8936002)(102836004)(53546011)(7736002)(33656002)(5660300001)(186003)(106356001)(256004)(476003)(86362001)(11346002)(53936002)(446003)(4326008)(81166006)(55016002)(316002)(81156014)(6916009)(6436002)(71200400001)(71190400001)(97736004)(6246003)(8676002)(25786009)(9686003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3295;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0/s+Tr+xHlIWrKc1NiYPq39d9zhB9rm+HoVfNlvWkMVDkp1g3qODnpb7g6iXlpwkaVePzDRyFeMse44eP5JK9ekcJ9kEgNuptjgC/T5HfDp7/Z4p8eMoWyhoStWTN+Vav7dJzXBB7CQGpT7DJrDCTAj/B+TJf7NwBifaQn2wRKJHP1IoUH+jvYThbBILmGHuvK4YBCebVBozK1c37MgusYdmCODGlf/QUGNfVuH7++J8gZlhLrSM6wiEgem/f1ql5TgnthIwZeITKPNSI9bQjA4eiX39lUJ+zQLX7s1nHeaJUTZ2z8sYxQudkjeTaPtx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e92e51-cb63-4a33-5ba3-08d6756126ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 12:02:24.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlub2QsDQoJSSBoYXZlIHNlbnQgdjIgYWZ0ZXIgcmViYXNlLiBQbGVhc2UgaGF2ZSBhIHRy
eS4gDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlub2QgS291bCA8
dmtvdWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqMdTCNMjVIDIzOjE1DQo+IFRvOiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+IENjOiBkYW4uai53aWxsaWFtc0BpbnRlbC5j
b207IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhA
bnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZG1hZW5naW5lOiBpbXgtc2RtYTog
cmVmaW5lIHRvIGxvYWQgY29udGV4dCBvbmx5IG9uY2UNCj4gDQo+IE9uIDA2LTEyLTE4LCAwNjoz
NiwgUm9iaW4gR29uZyB3cm90ZToNCj4gPiBUaGUgY29udGV4dCBsb2FkZWQgb25seSBvbmUgdGlt
ZSBiZWZvcmUgY2hhbm5lbCBydW5uaW5nLGJ1dA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eIHNwYWNlDQo+IGFmdGVyIGNvbW1hIHBs
ZWFzZQ0KPiANCj4gPiBjdXJyZW50bHkgc2RtYV9jb25maWdfY2hhbm5lbCgpIGFuZCBkbWFfcHJl
cF8qIGR1cGxpY2F0ZWQgd2l0aA0KPiA+IHNkbWFfbG9hZF9jb250ZXh0KCksIHNvIHJlZmluZSBp
dCB0byBsb2FkIGNvbnRleHQgb25seSBvbmUgdGltZSBiZWZvcmUNCj4gPiBjaGFubmVsIHJ1bm5p
bmcgYW5kIHJlbG9hZCBhZnRlciB0aGUgY2hhbm5lbCB0ZXJtaW5hdGVkLg0KPiANCj4gSSB3YXMg
Z29pbmcgdG8gYXBwbHkgaXQsIGJ1dCBpdCBmYWlscyB0byBhcHBseSBmb3IgbWUsIHBsZWFzZSBy
ZWJhc2UgYW5kIHNlbmQNCj4gDQo+IC0tDQo+IH5WaW5vZA0K
