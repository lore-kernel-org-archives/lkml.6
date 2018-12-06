Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6015EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B307208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="3a40GEsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B307208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeLFNlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:41:35 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:3406
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeLFNlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0FuCFSYOVWLj5HDGKlE1cLftiX8e4sOGCAfZEbSTh8=;
 b=3a40GEsyrqfVtxFv88VqtHwq9LHMRMoDdPEGsknDmNQoW+MlqNnVEz7ziJ4Vz7g19/K6BgwNXxlMWLgnQfTPs91WpCUa7DS49RgMiLfSevxdjtTVn/4tNd3USodUtAtDu1XtNUsy155m5+FiytpdyH0ag3jH+NZPaeMGiBZUXLQ=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4508.eurprd04.prod.outlook.com (52.135.138.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 13:41:29 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 13:41:29 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [RFC PATCH v3 0/2] pwm: imx: Configure output to GPIO in disabled
 state
Thread-Topic: [RFC PATCH v3 0/2] pwm: imx: Configure output to GPIO in
 disabled state
Thread-Index: AQHUjWlkAuCs7qbqzEWLcgLVujuruA==
Date:   Thu, 6 Dec 2018 13:41:29 +0000
Message-ID: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0088.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::29) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4508;6:BcqfyzbskJ0TNiPRAENCtuKEQJbVyE18MlMjCMyH4RB5DAQTqCHAtN1AHjgjBhDwqAEPErQBJZX9Fbn8vmcrvKq76DAvN1HzVC75H9Fzf4Qtp+QFTm0lrXJn77mhaKbFADm/wAZ8rKVr0X10xdKYiLmH0JZCmigLz8h88LVFsZY/891gVCHxQ7WVw1MwxqOcZmovE6zjY/LgL0xy+4QDFRrvH5SNRxtMYGvCg3TK9PJiljAINlxbAMQujJtf7y7lt+ljr86K+KywcltbZvAGpmErWQNZg6zretYxLZ+MeCwlqxmTPpyF6o364s8xeka5o4MdMHk/2MXedX4SgvPhdk3Kzp59Vj15Gm6Pmj7lodjHnlVLLvytwL926F4H0TQIdlcTs2xn4yKRCcQFUh8iNJXvMhqMWfPhAriavRwB7Vi1AmB4qG8R02Y4RSWNCEloYlZB/wuRV+itv2dyE59UPw==;5:Rz3WGXk58WlEPAC+GpDB82D4kklJet/JLG8B6CScauRneNdtlPMZ8sl3hIrI3tD0CbNE2eZiBK/ASIiC/P5oF0LAdD8jdHYqqFb1lHJrS2UbSp2YHClR6/NzKJ0Y44yvsaXntLVTCJZTeqOUnMk83YLaEb6RJJmV9VCPS4LW7Oo=;7:8Q1rVzxan0ux/acQVplGvZ9ZDSUINJEdHOmnOPpH10yhpCgCKJViN0A6xPG2HOfeqtxo3XwxO1Vq6y4pZjL76WTr46USWCsPgdiJP/xkSMVL0pTTFROOan0ZQFXkhnY1T700EbPVCcMH3SvX2cHcvw==
x-ms-office365-filtering-correlation-id: 6ae495d8-385e-4f23-f250-08d65b8086d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4508;
x-ms-traffictypediagnostic: DB7PR04MB4508:
x-microsoft-antispam-prvs: <DB7PR04MB45084927DD9DC188A87C30E79EA90@DB7PR04MB4508.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4508;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4508;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(6506007)(26005)(2906002)(106356001)(86362001)(72206003)(105586002)(486006)(110136005)(81156014)(54906003)(8676002)(99286004)(81166006)(102836004)(5660300001)(52116002)(71200400001)(316002)(7416002)(85182001)(71190400001)(6116002)(14454004)(53936002)(6436002)(3846002)(68736007)(66066001)(8936002)(36756003)(386003)(97736004)(2616005)(14444005)(6486002)(6512007)(476003)(256004)(305945005)(217873002)(478600001)(39060400002)(4326008)(107886003)(7736002)(25786009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4508;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gbERzfw8WT+TpKgf9QaR4LlWxODHdnV05jMkLDKWnMnweZqL0zd91EzCU7+Y37FBd0gnrOyFcWJT1kYmsq4v1VsxHEZ38x2gHPA+bmcQauiJNuqXgHOmhFaw+t2lOLh0aYCx7QWqidDn8tCuh95IF+RMnvlxDjiFM14Dq6Jb4xBRci5k/pI/BU5VOYOvZxJE5jjZJAQGxUrfS5yqfeHqMhUilFZRdIeYCPj7/6F9HkNr5vzvZDF1mxP1abRjh4dtR+nqUndWLkRbqi+hmgoH2PEfb+gLt4FKj0N6An7QRrIo/GqYGZ3K5ClaRcVVS3Pp/X1qiF78AGOb8FBJnzAWb2O4mhFGMnmDu/NbatyWriY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F49DC93FFA0E2B42B3AADCB9C587AE68@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae495d8-385e-4f23-f250-08d65b8086d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 13:41:29.8204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhbiBhdHRlbXB0IHRvIGRlYWwgd2l0aCBpLk1YIFNvQyBQV00gSFcgbGltaXRhdGlv
bi4NCldoZW4gYSBwYWQgaXMgY29uZmlndXJlZCBhcyBhIFBXTSBvdXRwdXQgdGhlIG91dHB1dCBs
ZXZlbCBpcyBhbHdheXMgMFYNCmlmIHRoZSBQV00gYmxvY2sgaXMgZGlzYWJsZWQuIFRoaXMgY2Fu
IGNhdXNlIHByb2JsZW1zIHdoZW4gaW52ZXJ0ZWQgUFdNDQpzaWduYWwgaXMgbmVlZGVkIHRvIGRy
aXZlIHRoZSBjb25uZWN0ZWQgY2lyY3VpdC4gV2l0aCBpbnZlcnRlZCBvdXRwdXQNCmR1dHkgY3lj
bGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIG91dHB1dCBsZXZlbCBhbmQgZHV0eSBjeWNsZSA9
IDEwMCUNCmNvcnJlc3BvbmRzIHRvIGxvdyBvdXRwdXQgbGV2ZWwuIFRoaXMgbWVhbnMgdGhhdCB3
aGVuZXZlciB0aGUgUFdNIGJsb2NrDQppcyBkaXNhYmxlZCB0aGUgY29ubmVjdGVkIGNpcmN1aXQg
aXMgZmVkIHdpdGggMTAwJSBkdXR5IGN5Y2xlLg0KDQpUaGlzIGJpbmRpbmcgaXMgdG90YWxseSBv
cHRpb25hbCBhbmQgY3VycmVudCB1c2VycyBhcmUgbm90IGFmZmVjdGVkLg0KVGhlIGlkZWEgaXMg
dG8gdXNlIHR3byBuZXcgcGluY3RybCBzdGF0ZXMsICJwd20iIGFuZCAiZ3BpbyIsIGluc3RlYWQg
b2YNCnRoZSAiZGVmYXVsdCIgcGluY3RybCBzdGF0ZS4gVGhlIGdwaW8gc3RhdGUgaXMgc2VsZWN0
ZWQgIHdoZW4gUFdNIGlzDQpkaXNhYmxlZCBhbmQgdGhlIHB3bSBwaW5jdHJsIHN0YXRlIGlzIHNl
bGVjdGVkIHdoZW4gUFdNIGlzIGVuYWJsZWQuIEluIHRoZQ0KZ3BpbyBzdGF0ZSBsZXZlbCBvbiB0
aGUgb3V0cHV0IGlzIGNvbnRyb2xsZWQgYnkgdGhlIGludGVybmFsIHB1bGwtdXAuDQoNCk1pY2hh
bCBWb2vDocSNICgyKToNCiAgZHQtYmluZGluZ3M6IHB3bTogaW14OiBBbGxvdyBzd2l0Y2hpbmcg
UFdNIG91dHB1dCBiZXR3ZWVuIFBXTSBhbmQgR1BJTw0KICBwd206IGlteDogQ29uZmlndXJlIG91
dHB1dCB0byBHUElPIGluIGRpc2FibGVkIHN0YXRlDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0IHwgNDkgKysrKysrKysrKysrKysrDQogZHJpdmVy
cy9wd20vcHdtLWlteC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDc3ICsrKysrKysr
KysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKQ0KDQot
LSANCjIuMS40DQoNCg==
