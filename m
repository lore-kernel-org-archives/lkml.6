Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1FF20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="AqHiZkSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1FF20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIFCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:02:13 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com ([40.107.5.107]:18123
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeJIFCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPaseEfYxx75CI0/ZVjQRy60qqeFbMsF8RE95dJOjiY=;
 b=AqHiZkSc0YcgWsPfCOS+LhKk1qcjUZ/ej5EWLBx6++MSGTrmK15I7aZltizKu3JAMu0R0klG9LlFZBzCOMrJHnB0iqLEsbPABgnnl2iCc/AqUTMI5xE+ncnEdoLlva2Ci1WwKanARflnILqKyYc3hyTy6x+/4I3w+bPca5AT+B4=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2046.eurprd02.prod.outlook.com (10.167.207.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Mon, 8 Oct 2018 21:48:21 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 21:48:21 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Luca Ceresoli <lucaceresoli77@gmail.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 1/3] i2c: mux: pca954x: simplify code to reach the
 adapter
Thread-Topic: [PATCH v2 1/3] i2c: mux: pca954x: simplify code to reach the
 adapter
Thread-Index: AQHUWzDdZcsx+mQps0S8cAqwSuNVz6UQiusAgAVf8gA=
Date:   Mon, 8 Oct 2018 21:48:20 +0000
Message-ID: <c3fdd93a-b0db-771e-85e4-480c3b01ac29@axentia.se>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
 <20181005114336.GB5433@kunai>
In-Reply-To: <20181005114336.GB5433@kunai>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::33) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2046;6:CIHPQYEF9BOMkod4v5xQedOWPzXeGO02X8d9v0VTtLTS/R/27YWpEpsG0HSswADS5MJFV3rXPOTYu4ALRJqEusUqSwq2spDjD/bMbaW1Qr0x4EG0/5OtWAMLdoXC6zA77bn+/UQVBqayFBhvPzXEODXXLx1TgeYy4+PVOPUsmMfnV9eY2MNA0nm3rEibU6oCHYAQAHhZctmELLp/KfkUueG5u5KlH5tZD/P2ffKaD6Hl3AO7+Msyo7FsE1fpV81X/TfGuBzxpfigWRQIqEbf865dLWMA+HSUrhLNMOngpJH6QSCoZAQ4h+RplwlbwqXA2dILX1G9TuC5AwVzIeG5Jy/omTw86SIz2HUFD434OofO79DwyUOz1e9/8IN1xOCc7EDG8Q6ATTAjEuoCMPBp7dMClGEnAyp4TVwvv/R5poEyWWGU7nHyWjqAHJiyuV8LRQy/3qPKCgpekv/4CRhv3A==;5:RQl3DN/ln+l1EU8rxN7235xSydl87zzoBWk1zM0rpZL/J2vVbge6NEk+mBsoRFQFWg3mJrjqjz7m32hPaoFklCJ/YhXlYDUd7t6Z1019mLjDSX5UrijpMDapnBiNcQtghYfbhLao60UKaSJRLk3RIhGRzGNNGoUZzGBcvP723Xo=;7:2DDdOav8CEIJnnQaJAFGDphFjRlTxI0u2rNbAxSW0lrJtk+/6aZnwGjfJWowzyn4GGVeLWYP1pvKP55Z7Mt0N1A+5uBlIYaa9avewMXkj6ZubYPzj0gDwE0GY/3SM85GAIbJVE/xF3HjXlgNlgx4WxJIAAsMafSpFkKICkUJBBD9D+s7EyRQ3knvGXCUMIIH9pBvMfoE3IfO7SKHa0k8yUs3MsBkwUiY6ZWTWU35djEeqbtL5oIvA+bwwoTD4rrT
x-ms-office365-filtering-correlation-id: 77548496-44b1-44ab-adc8-08d62d67c3aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2046;
x-ms-traffictypediagnostic: VI1PR0201MB2046:
x-microsoft-antispam-prvs: <VI1PR0201MB2046A3BD78D1A86845A32ADFBCE60@VI1PR0201MB2046.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB2046;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2046;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39830400003)(199004)(189003)(39060400002)(6512007)(53936002)(54906003)(6486002)(110136005)(3846002)(6116002)(256004)(31686004)(99286004)(76176011)(25786009)(4326008)(3260700006)(52116002)(305945005)(6436002)(7736002)(102836004)(105586002)(8676002)(106356001)(81156014)(81166006)(65806001)(65956001)(2906002)(66066001)(26005)(6246003)(64126003)(8936002)(68736007)(229853002)(14454004)(5250100002)(508600001)(97736004)(186003)(65826007)(86362001)(31696002)(2900100001)(5660300001)(6506007)(53546011)(476003)(2616005)(36756003)(386003)(58126008)(11346002)(446003)(71200400001)(71190400001)(316002)(74482002)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2046;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e0jj2h9ud1qLgGOCvA0z/oGMJAaT33apMzgeSgEVTdnBfduKLlpdMlkc++DehnhbWJ7MiF+zcdNLH7fj7UAiO8nkNijRjvazRdtmtm1pf5YCWFnn3bYhKyx7Nf6y75Nc+TzIeBg79nTBjdcZGNat4R4MfCIET3+Y1J4uhSheAul/SP+F/VdqNQPFYg4/efIGTVSE2MB/lWKbVuSE3fpjeXGCftof+XQiS9MnVeqE1aGE+ZJt/wQKxHXNVzSg25/3+qPWA90MCovYFNA8IjV5DC9DVteN/6GIxxChor3/mizV4dj6M6MjQg1VBEpyzYCkX2vjtOcR7vqOG8LUdwkpTPuLaLBBnxP9u/fHHNNJ1II=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <666B2A29BFB0AF48AEB3A4940BD7BEC7@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 77548496-44b1-44ab-adc8-08d62d67c3aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 21:48:21.0050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-05 13:43, Wolfram Sang wrote:
> On Wed, Oct 03, 2018 at 05:50:22PM +0200, Luca Ceresoli wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> struct i2c_client has a direct pointer to the adapter, no need to dig
>> it out of the struct device tree.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> I like such cleanups!

Me too!

All three patches applied to for-next. Thanks!

Cheers,
Peter
