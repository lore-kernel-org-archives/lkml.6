Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAEFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E04D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wwiKy+0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfBZLSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:18:54 -0500
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:58343
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfBZLSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQQCxVEvcrBLDm38wVAHrYT5y4oaVzvDp6l/WjvZG9k=;
 b=wwiKy+0Ns4jKHzK9tap+5vk20K1uWn/dQ7YZfU2b6gokuMCCo5sk7zPFZTeA8kInLxzqcQx99ugcBMmV4VYFcbgsP/qBMS8lodkPKmv1dnfvw1EhmtuE0jwk4pEfx9XtCmu478tuXbdklPQFtogHG5eFxEgE7a5g3uLhTvffntA=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4879.eurprd04.prod.outlook.com (20.177.49.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Tue, 26 Feb 2019 11:18:08 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:18:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
CC:     Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4CAA5A8AIABK8BQ
Date:   Tue, 26 Feb 2019 11:18:08 +0000
Message-ID: <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
 <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
In-Reply-To: <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfedda09-20b5-426f-5aa7-08d69bdc1603
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4879;
x-ms-traffictypediagnostic: VI1PR04MB4879:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0ODc5OzIzOlg4WkJTZEkvRFJES0NWTWgvc1JCaVVQL1NW?=
 =?utf-8?B?aXV5VzJVK3dRYlR0YUFQMmlMRGc2c0xKSURVc1d3Zzc1Mzg2OGg1KzdHcmo2?=
 =?utf-8?B?TktLRmhpM1FFUU13RUhaRzIvK01jcHJpSzk0UWhxVGZrUGJhZGh3akkwSU9s?=
 =?utf-8?B?VFpGbC9WbklLQ0E5OE5MbnhSb01oaFIySlhpcnhMSWJLVy9OeVRrKzhaWlN3?=
 =?utf-8?B?d1JZeXk0MjNEYUpFa09ZTkRaeWd0TWlGYUUwZFl5dUFtVjRKSjB3TVlNc1V6?=
 =?utf-8?B?QU92L251ZWE5eC9Lc05PMkNWQ1N4STN2QWFTYUhmb3hOa0pKQlJKbmtBV3JP?=
 =?utf-8?B?VnRtRkZSR0dEM3hISUlnVEFxUEZSczNkOTcrTkZMQTlKZGUyNW9zaElhUFNw?=
 =?utf-8?B?VkVZSi9QMnVYTGdENXdDVm4vb1BKUGo0Mm55cmxkdDM3S3F1QkUxTGhCR04z?=
 =?utf-8?B?d3NWc3ZmaFRPM20zK2NoQ3FHNDVCdFlSVmx1cHlzVm9MMEl6VFJ5NnRDaDRw?=
 =?utf-8?B?OEh1S0VzV1FWZDY5QUNOczJ0amltUGxia0dsUmdVUTNqWFd2Z1lCQTdIWVpN?=
 =?utf-8?B?R1VIVm5KUmd2NWNaWGdoSWcxSXlKM2dmNjFUbC82SDNGeGRzREx2cnZqdzJF?=
 =?utf-8?B?ZXJLZVV5dGhUYm9XTnRaZ3BlVFY1NnIxZzRLaGNNM2tqUTN3Zy9OcW5rdWpI?=
 =?utf-8?B?UU9NbkhUVFF0Tk1vd1lnenJYMmtGalB4WGs3N1NNRW00emI5eVFSSjZBd0Nm?=
 =?utf-8?B?WDNGZG4vQmVPUnVuWkl0eGgrekIwS0tIWGozaXBzeXRFd0paT2NSTnVnUnRZ?=
 =?utf-8?B?TC9kSGJNd0dSR0VTdWxnckRQR2R5T3U0MmxFWW9tQUxhTGxkc0FhM0JKRHl5?=
 =?utf-8?B?cFA5ZFZSYXFrSW4xQ1l3TDhWSFFJeEJJRC82UUdGSThLL2RtRGF5NVF2bmVI?=
 =?utf-8?B?dHVtU3FuZHVEdnh6LzRpVmdQOC92T2VPbHQwUW1ubTVpalp3OUorSWVObnRj?=
 =?utf-8?B?NXdzZ2RUa3JYYlBaMmFVTDE5c3E0Rk5LNk5RaTRzUDVadjR6ME5wOG1tZGdx?=
 =?utf-8?B?NDl1TXlMZFRSSFRXQWFsKzN1d285d1J4OEhPZTNlMlFEKzRPVVRNWnJraWp5?=
 =?utf-8?B?RHhwZUw2ZWx1UHhtTXR6Njk5Zm5kSlo2Q0U5WTBCL3BHbk5lV05BUzF0RE54?=
 =?utf-8?B?WUo1a3d6THhPVUc3TTE1Yk5wNGlsQ0NQODROSU1RK1licWloOFU0K0R4REJm?=
 =?utf-8?B?eHlLUmZXVDFCVWhuUlNUYk1xSmoxRHd5NTZzQXB6djRjUzZ2d3NORnZubUZS?=
 =?utf-8?B?OGhmU2cyZXZLZzRNQjJudERNUFdQellxbVJxN2lyMHpGMHE5M3FrWXRMKzdX?=
 =?utf-8?B?L29sc05qcEFKOGNQNXRiejM3S3FkZlFVT3ZjcVdoWmVMRXdzOEYrUVlzTFBl?=
 =?utf-8?B?STJaR0EzREgvbC8yRW5LWlpDZ0RuM3V5ZzhKY2NPR3Mwb0J5QUNZc3A0SzI4?=
 =?utf-8?B?MXdVR0JCcjhpKzR5YjJOUFRZNTRIOXJNU2pSNVlRUm16U2JCSmdqZGZUSGJu?=
 =?utf-8?B?TzJFc2ZRTnUvdFpWS1g2ci9qRko4QTM1NkhOUVVQVitpNTJCbEZoekMyWkht?=
 =?utf-8?B?NFZVbitYeHp0M1FnUTVLSTJwT2hvOEhRaURuNXByaTg1NmhEa3JDVmVHOVc2?=
 =?utf-8?B?QVF5TFZiaWFiQm5mb3BPQ2gvVFhiSG5uWG5UeW8rMjNVZ2hSdUVtNVgwZ2E3?=
 =?utf-8?Q?ZUzV5iZoaMhSS2IRuwndSOkej1eUY0rBa5oTI=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB48793A62C7C960620306F15B807B0@VI1PR04MB4879.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(51914003)(305945005)(99286004)(6436002)(76176011)(74316002)(5660300002)(6506007)(66066001)(53546011)(4326008)(9686003)(7696005)(55016002)(52536013)(53936002)(102836004)(14454004)(25786009)(7736002)(26005)(478600001)(86362001)(3846002)(6116002)(71190400001)(71200400001)(97736004)(2906002)(54906003)(44832011)(110136005)(106356001)(93886005)(68736007)(186003)(105586002)(486006)(33656002)(8676002)(6636002)(8936002)(316002)(446003)(256004)(229853002)(11346002)(6246003)(476003)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4879;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qEyuKWPyj3Fm+cBA3K0uZW1H0k8yvW2+/Zxl03GLH6zdBaxpseeOexbnx7oi8c6/hJU+8SzefnYePwMECXmTOaqg4k7zXJE3UR70CiDMZafyWEeLLXflwGSM/JyhppISmhbWj8gh6bYDFK1MI/ZfxPUMEi+UailkAoASo1HlgK11I1lZf3F5md+vFyo9LbAcdU5XdmfVgizLfp0604nvhpHqGjaI6TMNk+WYtsyqwQsJQVmN9TDi0MFvjzvJTPPv2NKTJ7LkluIXSWtO60IUEzwpowd+yAtuk6CcGs2ObjIdbU0WiUPo/YXyM77ztVABzjdw1y4ur+ROQl79fJ/O9ZJ8xZNRs6B/+K4Nv5O1mHsxHXCJoohUxVsIpb+8zoZKRk/LHfFGaebsU/GSSTmBbjgO3+PPmtDl9Rc9aTutTlU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfedda09-20b5-426f-5aa7-08d69bdc1603
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:18:08.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBU
dWVzZGF5LCBGZWJydWFyeSAyNiwgMjAxOSAxOjIzIEFNPiANCj4gUXVvdGluZyBBYmVsIFZlc2Eg
KDIwMTktMDItMjMgMDI6NTg6MTQpDQo+ID4gT24gMTktMDItMjIgMDk6NDY6MjMsIFN0ZXBoZW4g
Qm95ZCB3cm90ZToNCj4gPiA+IFF1b3RpbmcgQWJlbCBWZXNhICgyMDE5LTAyLTIyIDA5OjA3OjMy
KQ0KPiA+ID4gPiBNYWtlIHRoZSBlbnRpcmUgY29tYmluYXRpb24gb2YgcGxscyB0byBiZSBvbmUg
c2luZ2xlIGNsb2NrLiBUaGUNCj4gPiA+ID4gcGFyZW50cyB1c2VkIGZvciBieXBhc3NlcyBhcmUg
c3BlY2lmaWVkIGVhY2ggYXMgYW4gaW5kZXggaW4gdGhlIHBhcmVudHMNCj4gbGlzdC4NCj4gPiA+
ID4gVGhlIGRldGVybWluZV9yYXRlIGRvZXMgYSBsb29rdXAgdGhyb3VnaG91dCBhbGwgdGhlIHBv
c3NpYmxlDQo+ID4gPiA+IGNvbWJpbmF0aW9ucyBmb3IgYWxsIHRoZSBkaXZzIGFuZCByZXR1cm5z
IHRoZSBiZXN0IHBvc3NpYmxlDQo+ID4gPiA+ICdzZXR1cCcgd2hpY2ggaW4gdHVybiBpcyB1c2Vk
IGJ5IHNldF9yYXRlIGxhdGVyIHRvIHNldCB1cCBhbGwgdGhlIGRpdnMgYW5kDQo+IGJ5cGFzc2Vz
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBYmVsIFZlc2EgPGFiZWwudmVzYUBu
eHAuY29tPg0KDQpUaGlzIHNpZ25pZmljYW50bHkgc2ltcGx5IHRoZSBjbG9jayB0cmVlIG91dHB1
dC4NClRoYW5rcyBmb3IgdGhlIHdvcmsuDQoNCj4gPiA+ID4gVGVzdGVkLWJ5OiBMdWNhcyBTdGFj
aCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+ID4gQWNrZWQtYnk6IEx1Y2FzIFN0YWNo
IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4NCj4gPiA+IEkgc3VzcGVjdCB0aGVzZSB0
ZXN0ZWQgYnkgYW5kIGFja2VkIHRhZ3Mgc2hvdWxkIGhhdmUgYmVlbiBkcm9wcGVkLA0KPiA+ID4g
dW5sZXNzIHlvdSBkaXNjdXNzZWQgYW5kIHRlc3RlZCBvZmYtbGlzdD8NCj4gPiA+DQo+ID4NCj4g
PiBPdXBzLCBJIGZvcmdvdCB0byBkcm9wIHRoZW0uDQo+IA0KPiBPay4gQ2FuIEx1Y2FzIHJlLXRl
c3Q/DQoNClRlc3RlZCBvbiBjbGstbmV4dCBieSBjaGVycnktcGljayBhIGZldyBkZWZjb25maWcg
cGF0Y2hlcyBmcm9tIGlteCB0cmVlLg0KU286DQpUZXN0ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
