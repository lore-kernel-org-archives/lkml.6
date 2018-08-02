Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B330DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6323F21528
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="C/SnkC2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6323F21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbeHBRx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:53:26 -0400
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:22681
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387829AbeHBRx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZW0osDYjU8wa+Rkp7da/BEp085k1aLuBGe1ww+LP5U=;
 b=C/SnkC2n59kQrPw9TxoaoR93N6xCPJPk24TU/StDmfMdDyq+uAyL50l/nm/RI/bj+jAe4p+LHeuSNnMEbxgLKUvMrSx3ssJGjeXnJDkQI84IEU1lX7QoCtExepRwPKqM9iSzZD2Fbn6b/NuvBfzRfc+fpFuSTOYwYQyD/cdlWJg=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB460.namprd06.prod.outlook.com (10.141.196.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Thu, 2 Aug 2018 16:01:33 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.0995.020; Thu, 2 Aug 2018
 16:01:33 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
Thread-Topic: [PATCH] lightnvm: pblk: take write semaphore on metadata
Thread-Index: AQHUKmd9X3C5mxaDEU6QvJbtkWc2haSsnkUAgAABFtE=
Date:   Thu, 2 Aug 2018 16:01:32 +0000
Message-ID: <E290F3A7-B98F-498C-9969-B7584F340B9A@cnexlabs.com>
References: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>,<2436f855-7a87-9ecd-be3a-358939c9c750@kernel.dk>
In-Reply-To: <2436f855-7a87-9ecd-be3a-358939c9c750@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [83.94.206.14]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB460;6:H/QLZ4+KknEXlqIQYgT3appAEz40qX90NaS2Ua7lMtvC3+NJUQfAt10oFmTyNDBO9Ir1ZpffHOaArrl8w9qRIZNG2xxvT1oLsLbiJ9fsk20O4XVBZ1CwW8vYTgSaiWcOGqEe/aeiDmzkP1/we5rRa4ZjNpp5ewXba6Vto8zgv66+Z2k+5y/wrMamkbdOwZO3QpKARJ6BDyjoe2RHtv8kb9+cWC/D9yjksLYmAYgA6PFMyCm9vYxKPB9FlZtfpT8Wxc+kASixUyj2M1C1zZkGcYqqnn5by4IpmsBx3KL1VTRBHvLJDzZ7JVNGeJZao/uS1HkxW1HATcoiGKZ4RnV7H7hfgM0Hfezt8o2IYlZ1vJc2DgvoLKk2as7ox1Up1bJ68tZ7zOwrXizphIqzd5R4cq+Ca6oOfxmfX2nLW/GVRV1ryEfs7ABZxcq2k1R5dT1Ky/n39KnOsS4ZNyCRUoUfsA==;5:y+NNoeY7hqyS7/6UWu8hPrp4vWvtkDD5otygMUFcG4QkwOppgZoe4TAKjnz2pp6It4Uu/HSnPjBDgvF3SIbFIPeO4nA1b7SkkMPyO1ySi5QFOpI+YMKIAA6F4szl/aWTiG9GvD1sqPaJXN2GFo5I+eTH5iP4gipdKcc8If+RcXA=;7:aBC9FuIWOIq38yfC74ihIvQ0mLAsuLiQCG/nYtN7yJvZVaFFrYG0Ejfq4Ur7UayFvYFJgJUU9BBM/szDEXcQCL3+NvR9kCL4X9cdheBNUTAz2BHlYQbCfT26ufVrh1wkNuowbdS3yxT8+WGLLegN76U+BlyNMSQrN9Tf8nlke7xukWwem92ox8PSbWnMdb6RXGuWNzMo+fGPWIC3FQUzvwmsnsenvhNXPRG9maxbq3t9zyDEsSvbriS5oPNT/65k
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 558ee8ed-6a1a-4f74-51fd-08d5f89137b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB460;
x-ms-traffictypediagnostic: CO2PR06MB460:
x-microsoft-antispam-prvs: <CO2PR06MB4603AC18BE869744DFB8676BA2C0@CO2PR06MB460.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB460;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB460;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39840400004)(376002)(346002)(136003)(199004)(189003)(54534003)(6512007)(83716003)(26005)(229853002)(14454004)(6436002)(53546011)(6506007)(102836004)(54906003)(2906002)(6246003)(53936002)(5250100002)(6916009)(316002)(36756003)(33656002)(6486002)(99286004)(106356001)(66066001)(256004)(446003)(105586002)(8676002)(305945005)(486006)(7736002)(478600001)(11346002)(476003)(25786009)(2616005)(81166006)(82746002)(5660300001)(76176011)(4326008)(81156014)(6116002)(8936002)(2900100001)(186003)(97736004)(3846002)(86362001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB460;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vbP6Df8qCtwDN00YV/Cnios5xjPmOunaug/ve7dj+Nh/E6ZzvKi7YjF9UsZHVlYvSqzSrbTDB7BOUZ7ZtJ2fwgH9xNv8DtTHncO6pKHrWUjEJcjEKb96lORLPLJ7UwL8rtaZ83WCfypI2F9Nq6y027ZiHSfMiXAOpV0T/jdinPu2qppyWgmoTGUCStfnc5eXTpNkY9ZtoJxoC0hxbYynK/54fG9M5DW3ZePxSVYr4792/0465nbmzYkjcAKlklgHhDhKZ+hsdFY071CQjxRAvvgq4xhJF11al7GU67Y8YOhYxwq8HdXIvnz4Xjp4M9uq/8JjlAbGhorFhkZdLtqRJVg4jc7pzfVQLSnmUdZEwYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558ee8ed-6a1a-4f74-51fd-08d5f89137b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 16:01:32.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMiBBdWcgMjAxOCwgYXQgMTcuNTcsIEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4gd3JvdGU6DQo+IA0KPj4gT24gOC8yLzE4IDc6NDcgQU0sIEphdmllciBHb256w6FsZXogd3Jv
dGU6DQo+PiBUYWtlIHRoZSB3cml0ZSBzZW1hcGhvcmUgb24gbWV0YWRhdGEgSS9PcyB0b28uDQo+
IA0KPiBJJ20gZ29pbmcgdG8gbml0IHBpY2sgYSBsaXR0bGUgYml0IGhlcmUsIGJ1dCB0aGlzIGlz
bid0IGEgZ29vZA0KPiBjaGFuZ2Vsb2cgYXQgYWxsLiBBIGdvb2QgY2hhbmdlbG9nIHRlbGxzIHlv
dSBfd2h5XyBhIGNoYW5nZSBpcw0KPiBtYWRlLCBub3QgaG93IGl0J3MgbWFkZS4gWW91ciBjb21t
aXQgbWVzc2FnZSBkb2Vzbid0IHJlYWxseSB0ZWxsDQo+IG1lIGFueXRoaW5nIHRoYXQgSSBjYW4n
dCBlYXNpbHkgZ2xlYW4gZnJvbSBsb29raW5nIGF0IHRoZSBwYXRjaC4NCj4gDQo+IEEgZ29vZCBj
b21taXQgbWVzc2FnZSB3b3VsZCB0ZWxsIG1lIF93aHlfIHdlIGFyZSBub3cgYWxzbw0KPiBncmFi
YmluZyB0aGUgd3JpdGUgc2VtIGZvciBtZXRhZGF0YS4NCj4gDQo+IC0tIA0KPiBKZW5zIEF4Ym9l
DQo+IA0KDQpZb3XigJlyZSByaWdodC4gSeKAmWxsIGZpeCB0aGUgY29tbWl0IG1lc3NhZ2UgYW5k
IHJlc2VuZCB0b21vcnJvdy4gDQoNCkphdmllcg==
