Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA8C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D052082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NmE1l/rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D052082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK3W4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:56:43 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:7088
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbeK3W4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzVYDsWOeUS3+zqFmf3xPWkKWbj5Ph4560WGQdLWi5g=;
 b=NmE1l/rQHTzmWClqmgCdThiF1AfgEygbEOfm0Wb5Qlr67H76Q+Tv07Yf18pcokbz8abvZCPm7aLoY4lXsNEtBtsFE/+ad5zPcbeTso1FnCK4+GRP/eHHby3AxifX+5vzbr45CMe6vyR3Y3I1oTDOBkP7r/sDvEh8Tibzz9POL5k=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2623.eurprd08.prod.outlook.com (10.175.20.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 11:47:36 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 11:47:36 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>
Subject: [PATCH v3 0/7] lib/lzo: performance improvements
Thread-Topic: [PATCH v3 0/7] lib/lzo: performance improvements
Thread-Index: AQHUiKJ8o9STQOuvYEC/c7Vy3VwWCw==
Date:   Fri, 30 Nov 2018 11:47:36 +0000
Message-ID: <20181130114715.27523-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWXP265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::22) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2623;6:qxNBkfSprdjBT+0KJw1gOzbWf6s9tsunTstWhPELBWexfgce8RMutgnSf8w1ISiVpgxbs8+ANKa9brEfwdA/5ST8KQU0t+2RsrIrZ1ApLpggPVe5PkvyIBwUuOedwXmCzW07GuxVsrDNkXJdT/v5GLGrjAm33IU5BYZ1m37QDgZkhD+HWS/wOiRYNPaIqHIdGy9dut74eT6e/hH+AdfS1MIQUCE9aWpj8Q8eF3hVbrKSVH+F0M4fLGiSrIo1rCelOdA5Pw7BM4OgMKdpffYYv3Go5jA8sLsv09SLOzMgt3J0qTfhlj36I4YWGLdBa1m2uHtFxb1TSibBK61rXPvFTWW3ALPvnThpjlRIl+0fzI73LHUU1vsFlsTW5mPwIoBj18GsAMprjBcp9PmYEH1FGtV7twsyV2jH/nnOkw1WYGimmNUd6acq4hbBC7D0h0NLDqOlsBkDnXz733zqCZES6A==;5:FrIF3w1J6SPAnaP8huF9Eav7D2gN6o/AeYBOePqz/aAYSyOfmXDIE5WyClKjwXQfZoqQYi2nr4V1NYv5mKFjOTFCV17+0T4TiAZ9qPMIW/LnWgrmY3Zp9j+rmaaYHH9gRdddsDTEVPk0gPbWi5krEW7Do/AiPhWMIsxFjB+dfzU=;7:lZ3ELANqcpIEUhjLRbNFwegZcZ8WkSq1qweQuS3oubSElt5eWJ2jnGDM7EJqVbXTpNnEPHOpgVMGuD9aOHrAgX6/lH/LDBnw77lQ0RG8EpPZtnzut/jidNjJIB0Ru/FtI9iGDzTdCyKo4Cbou476hQ==
x-ms-office365-filtering-correlation-id: c2199a68-d4ab-480d-ac4d-08d656b99f2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2623;
x-ms-traffictypediagnostic: VI1PR0802MB2623:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2623FB09C67FDD75A4A7A4A18FD30@VI1PR0802MB2623.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2623;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2623;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(52116002)(256004)(2501003)(106356001)(478600001)(99286004)(39060400002)(105586002)(68736007)(476003)(2616005)(5660300001)(966005)(36756003)(71200400001)(8936002)(25786009)(102836004)(186003)(53546011)(26005)(486006)(50226002)(44832011)(8676002)(81166006)(81156014)(6506007)(86362001)(386003)(14454004)(316002)(7416002)(53936002)(305945005)(66066001)(6436002)(7736002)(110136005)(6486002)(71190400001)(54906003)(2906002)(1076002)(3846002)(6116002)(6306002)(6512007)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2623;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PecjVsug9iTUksuXziLoqJOT+qi8TWIIh/lJxV2WuO2ywC1HfDumWwKHNg7h42bd2243U+t840Qvmb79SYt05jrSyPajT7DH6iK1AhpFy00yHMJtonGjNRwgG47wNPcKJL69SYGURdXkkGU0r7yLDnRYUbRKKsUQLZGwtWNFBTrcnMnBldPIQCt2zaXJ8GvDaRM5hcaGlG0UYE4R36CSunUeiL8bnH3wh+bKFtBtp1ZDp7ygg5tMaFjPR7zj4wljw6y9dS+77eLR+30zldPiZTQLUYKb7Mju0a5hZkdTaxEU+btJBXf36txa/3qJADPBIUFvsDGA+XoM83vnLJ2haHyC/2CBUB+aLAIyC0rDMmg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2199a68-d4ab-480d-ac4d-08d656b99f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 11:47:36.2526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces performance improvements for lzo.

The previous version of this patchset is here:
https://lkml.org/lkml/2018/11/27/1086

On 29/11/2018 8:32 pm, Andrew Morton wrote:
> On Thu, 29 Nov 2018 10:21:53 +0000 Dave Rodgman <dave.rodgman@arm.com> wr=
ote:
>>> OK, so it's not just "separate lzo-rle", it's also "switch zram to
>>> a new compression algorithm by default". I'd say that usually I'd
>>> expect this to be separate patches.
>>
>> Yes, fair point. akpm has picked this up now though, so probably a bit
>> late to break it out into a separate patch?
>=20
> That's fine.  akpm is flexible ;)  Whatever produces the best overall
> result in the permanent record, please.

Thanks - I've separated this as suggested. I've also fixed up the commit
message for patch 1 (tidy-up ifdefs) which looks like it was accidentally
changed (please ignore if the change was intentional).

Dave


