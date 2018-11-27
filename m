Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C1C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE23520660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cyQ4y2fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE23520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeK1DSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:18:02 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:11920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbeK1DSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgzec5jOavaw4xO/o5jAhnyVnBl7Z9wf9VXWTNV4O4I=;
 b=cyQ4y2fgn3eUcH3mGXbAU8D/8SI5u9ZsYcp66+qy0K5qNr1Q/hmRK9sJvMoWSZm8YG9KgTyOCYK3lphop5WnRdk1mEiiS8yxjzI2DHjvI++aWFLx5Yo8xTWWbD+Sw8Vaw49hbSelP1zJJIWjb2CnSGSsQu36AuvomULeYviQ0vg=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2256.eurprd08.prod.outlook.com (10.172.13.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:19:29 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1361.019; Tue, 27 Nov
 2018 16:19:29 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH v2 0/7] lib/lzo: performance improvements
Thread-Topic: [PATCH v2 0/7] lib/lzo: performance improvements
Thread-Index: AQHUhmz5V6GNgmJfP02ypoJE5HZwbQ==
Date:   Tue, 27 Nov 2018 16:19:29 +0000
Message-ID: <20181127161913.23863-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2256;6:H74Mm2xSkdNAAPJUhl55bKIgQfodldYxZnL+EFRNzJU1Z/BATateainPjpUwlbjcRy3GPMHgKRgZUQ/2dORwkVhqH6y4GnfjPHOdPVQ30Vjlap8kIVnSZZ3xqaYYVLnVDJIsTfkbm7VRHD5R5mHeAylBorkutcDIIAe/Rzy73pI07FvbBlXmGPEnNxSdS6c05vNRBjZn33GJotS52b24VoRW+l/GJ8UY7mA8r+IslgglT7ag/aN174LBvO26czkOrTrPUrDczZHh+rjSxoDzM+L7Mud+xBWNOMQh6qFvpc3v8dtcV0HZGs1gd6qi7EmgTFSB/ocLBjOfJnMeyX+IHgsilSjxXxvMj/2llTbDZL3oh3AlNd3h/5eduac6Wn1u2FvxNCe7+IMS31UdeyqTskly2VcA0P67LiiajCqmN4QlQuo8AU1Fzn1X4hGinmnip7iT1+wghySa3IAdR1hU4g==;5:fMvLydRQwIeLURXPgo3BVbvkQCyETql8a7XQCmcdMXrueXPiRfRdRn4/9nxpgYamGoszBfS9F1UdM2RrNyr28KMxUT1g3qH23eFnpjynvSodfHmamebmQr/oHpSO1hyAkud6hteOD2gee+bPPONtiqSUY557P47ENAiN2sfixD4=;7:AserlDjcsx4itlfm2qumEN3rEUCXsu6KfygnJnku6VbHjs0Aeahr0igRW5Jf6+mffBmjnjH3wg+fWw93nxZugXUWbAG2EEt+XiIPdBgMbKqQsqcwTSzrxARJPozPUpNG644guV7cjIAd6WKxmWX6bA==
x-ms-office365-filtering-correlation-id: 105a48ff-ad70-4aa3-e2f5-08d654841b85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2256;
x-ms-traffictypediagnostic: VI1PR0802MB2256:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2256F57D708B77102944EECF8FD00@VI1PR0802MB2256.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2256;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2256;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(2906002)(106356001)(105586002)(2351001)(256004)(6486002)(52116002)(53936002)(6306002)(99286004)(6512007)(5660300001)(54906003)(7416002)(7736002)(6116002)(305945005)(1076002)(5640700003)(6916009)(486006)(3846002)(39060400002)(6436002)(316002)(476003)(2616005)(44832011)(68736007)(4326008)(102836004)(386003)(966005)(66066001)(71200400001)(53546011)(36756003)(478600001)(25786009)(50226002)(26005)(6506007)(186003)(8936002)(8676002)(81156014)(81166006)(2501003)(97736004)(86362001)(71190400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2256;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6gDo0lRTSdFuRtAApv317R2rEBEkguut41wZiijM2noU7er5D5mydETYel2ZDHegbRS3WuArM94Ds7rnvi14FvE59/Pg/k5/3Wi/xp6snWWuphkO0Y9v7+xZ5eQtXNu86n+YjV/J2/Yvk2fIuhliIkePt6jgpTkGqQNeK8qy4V8uTpyHkRckjD2Ukpai5nMrLbV5qSZj+MX6wGXHr7RcPXEf5Yye6SI4hFEc/iXJi6kaREHGByo4M3bPcjrMZdRrXaEsJjMxrq5fZpZWH/X7OmOLiYox/sRyKCwbpibMkwtxBf0t7B4TXOPf4NGl8evBlbAqpkifSB3pbC8qC4rnjLEiZGb/Ct85Zq/Ew2p6Me0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105a48ff-ad70-4aa3-e2f5-08d654841b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:19:29.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces performance improvements for lzo.

The previous version of this patchset is here:
https://lkml.org/lkml/2018/11/21/625

This version tidies up the ifdefs as per Christoph's comment (although
certainly more could be done, this is at least a bit more consistent
with normal kernel coding style).

On 23/11/2018 2:12 am, Sergey Senozhatsky wrote:

>> The graph below shows the weighted round-trip throughput of lzo, lz4 and
>> lzo-rle, for randomly generated 4k chunks of data with varying levels of
>> entropy. (To calculate weighted round-trip throughput, compression perfo=
rmance
>> is emphasised to reflect the fact that zram does around 2.25x more compr=
ession
>> than decompression.
>=20
> Right. The number is data dependent. Not all swapped out pages can be
> compressed; compressed pages that end up being >=3D zs_huge_class_size() =
are
> considered incompressible and stored as it.
>=20
> I'd say that on my setups around 50-60% of pages are incompressible.

So, just to give a bit more detail: the test setup was a Samsung
Chromebook Pro, cycling through 80 tabs in Chrome. With lzo-rle, only
5% of pages increased in size, and 90% of pages compress to 75% of
original size (or better). Mean compression ratio was 41%. Importantly
for lzo-rle, there are a lot of low-entropy pages where it can do well:
in total about 20% of the data is zeros forming part of a run of 4 or
more bytes.

As a quick summary of the impact of these patches on bigger chunks of
data, I've compared the performance of four different variants of lzo
on two large (~40 MB) files. The numbers show round-trip throughput
in MB/s:

Variant         | Low-entropy | High-entropy
Current lzo     |  242        | 157
Arm opts        |  290        | 159
RLE             |  876        | 151
Arm opts + RLE  | 1150        | 181

So both the Arm optimisations (8,16-byte copy & CTZ patches), and the
RLE implementation make a significant contribution to the overall
performance uplift.

