Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C1AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1531620858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kYomBC7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbeKQDuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:50:14 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16379 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeKQDuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:50:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="23385586"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 16 Nov 2018 10:36:55 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 16 Nov 2018 10:36:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgTFSpK+8CXyyPnZy0B7kS9q2yTCFFEEZa33+r5CFLs=;
 b=kYomBC7fgXoCYqIeGmxlX5kls6JhiIChBzYziesUx6MptadlxK2rz5f7HEt9+x7MFmp9PJ1mI6CIAyhOgSlSiMKf06v6KcrT+YtJyNuzLBMIvKgImCiAsDakdGAMTzSKdjXc1CJ0Q+49KJTtmUlkFrxDnzMWkzp52ToYyaY05Kw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1684.namprd11.prod.outlook.com (10.173.28.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 16 Nov 2018 17:36:53 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:36:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix selection of uniform erase type in
 flexible conf
Thread-Topic: [PATCH] mtd: spi-nor: fix selection of uniform erase type in
 flexible conf
Thread-Index: AQHUfZ3tA+dcLeFrOEOuQb9SrChWeKVSqqmA
Date:   Fri, 16 Nov 2018 17:36:53 +0000
Message-ID: <3c2c7a76-c7da-5c6e-0bb3-8963132f79d4@microchip.com>
References: <20181116111708.30259-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181116111708.30259-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:803:1::23) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1684;6:qV1GVIv5dUtb9baidui0CegWPKtc2Da/E2Waa/mpULlLcdN0phSw1N4fO9kKTUUxx6B+OczmjfpQV3OKhS2GY5XYDMrtWOGAeGHDFrvjUW08majkFQYKOSQyFij0YFSGIn7VVL3Ro03Y6mD/UeO0HwIgVuEmRVz9S81sq1OdIRPBCdhHeh1rCcEzq7MGh0XHTioMxIFbieW42zkXFwnTtE4R0Xo6rcRHonsSdauf2DxyBbLSSUJg5rL9GdaLIcxnlFCJ37xp9vgv2otcizfzLXPXmvBtVCpHxVuN1RXnp8db4gnkAL5mfsOZl5x7vGPY8W/C7SotWLUkh/+p0x54r4n2Qj4naSrVkEOJ7BIy+RG/HApEhkrQAMIJ3Hkxp54nFwD0VjN6YREo4Iih6mWqpHqYGXIi92PNkTfiIJsyhRbodImAHMsy/MyoLVxug9ckGem4LFxqey5IOR4cs0Sojg==;5:KZ/wZsR1xgdOIBevj8pcwrkAtjcnJ2wUsIQp68p/9F3sGS0Qz+6Ix1Kz2wl/w90G8p/SbSoZ9TOpxsCZbZLnXwd0e9kJxfDnm75NbVJCHr2vMyztxwGauErpaAG8XKRHtmZtrnKKrtj0xafeftD4lDhBn2U43LwDhVcT9npM8xQ=;7:o3BNdU99memDajPa6pc2ArGcboIcrhcHYQabXip6IYl5edPihDFdFnSrM/3cylXeUUiM1sCzZ/L0cfual7fyQ1WISlAN9D9MQMwq/MPGNz4NyU3iZm3vhUbyFpuOs72eFXUAnDK6Qk1mBdPZWtYEvA==
x-ms-office365-filtering-correlation-id: 69f7bb02-4b3a-4d81-7223-08d64bea18b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1684;
x-ms-traffictypediagnostic: BN6PR11MB1684:
x-microsoft-antispam-prvs: <BN6PR11MB16848B5422A67A6807501D5BF0DD0@BN6PR11MB1684.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1684;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1684;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(39060400002)(6116002)(3846002)(31686004)(2900100001)(110136005)(68736007)(486006)(316002)(81156014)(305945005)(71190400001)(71200400001)(81166006)(229853002)(6486002)(7736002)(8676002)(256004)(2616005)(8936002)(5660300001)(11346002)(446003)(99286004)(14454004)(6512007)(66066001)(52116002)(476003)(6246003)(106356001)(76176011)(2906002)(72206003)(53936002)(105586002)(26005)(97736004)(53546011)(102836004)(25786009)(478600001)(386003)(6436002)(6506007)(2201001)(31696002)(2501003)(86362001)(36756003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1684;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A5N8YGVlQQWj7skNlLcVAXt7qBC5INIuowh74iIchS57UMw5gg/S7u28ucVEIXRJhICS1yPAqfK9uekU0DMG7LMarCKruguCYGLCdzlfnzk/WGwGltNsMwnQUZWvWybbc1ODz6TjFY6Dlqf+GUl4/HHy1x4c8Uh1o1HF94wqU1cZoXJp+Oqu+KmFc9kdGW/2VZekPxzO7VsdmfAo2Il+j+Rzg5cMFPTjwCdqDNU9tN1RKaCoD2aTM3M7nSjO/ctSimdgONxmjEKwve9M+b/jdEn01LWIK8mlfFYrtpuvB52Dri9jIJsMAWbFzTg8yhCNwUr3115d98r3idSlDVPLFHUvugu96+1gBGUhWcGWAiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <919A3535DA42CE42B2CDBA943C69B46D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f7bb02-4b3a-4d81-7223-08d64bea18b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:36:53.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1684
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzE2LzIwMTggMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQoNCltjdXRdDQo+IEBAIC0yNzI5LDkgKzI3NTEsOCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFy
c2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgCSAqIHVuaWZvcm1fZXJhc2VfdHlwZSBi
aXRtYXNrLiBUaGUgYml0bWFzayB3aWxsIGJlIHVzZWQgbGF0ZXIgb24gd2hlbg0KPiAgCSAqIHNl
bGVjdGluZyB0aGUgdW5pZm9ybSBlcmFzZS4NCj4gIAkgKi8NCj4gLQlzcGlfbm9yX3JlZ2lvbnNf
c29ydF9lcmFzZV90eXBlcyhtYXApOw0KPiAtCW1hcC0+dW5pZm9ybV9lcmFzZV90eXBlID0gbWFw
LT51bmlmb3JtX3JlZ2lvbi5vZmZzZXQgJg0KPiAtCQkJCSAgU05PUl9FUkFTRV9UWVBFX01BU0s7
DQo+ICsJbWFwLT51bmlmb3JtX2VyYXNlX3R5cGUgPSBzcGlfbm9yX3NvcnRfZXJhc2VfbWFzayht
YXAsDQo+ICsJCQkJCQltYXAtPnVuaWZvcm1fZXJhc2VfdHlwZSk7DQoNCkV2ZW4gaWYgdGhpcyBw
YXJ0aWN1bGFyIGNoYW5nZSBkb2VzIG5vdCBhZmZlY3QgaG93IGVyYXNlIHdvcmtzIGluIHVuaWZv
cm0gY2FzZSwNCml0IGlzIG5vdCBxdWl0ZSBnb29kIGJlY2F1c2UgbWFwLT51bmlmb3JtX2VyYXNl
X3R5cGUgd2lsbCBub3QgcmVmbGVjdCB3aGF0IGlzIGluDQptYXAtPnVuaWZvcm1fcmVnaW9uLm9m
ZnNldCAmIFNOT1JfRVJBU0VfVFlQRV9NQVNLLg0KDQpUaGlzIGNoYW5nZSB3aWxsIGJlIHJlbW92
ZWQgaW4gdjIuDQoNCkNoZWVycywNCnRhDQo=
