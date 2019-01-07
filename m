Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDDBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407612173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="e3cZjTX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfAGPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:36:02 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:2787
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfAGPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15LL+4epCl5LtN5XN7W0DBJMjzAdoUD5jtqYBGtORJI=;
 b=e3cZjTX8UcBukOblOVDUX8tUrPevc/5eTTtMWniWjOTcHlOXaf4/Me+/b36o3cw33LPD+mzzGZtKtcqCPehTs9eax+jTSzskWlDpSiE+fFn/wmQHT2FGENQxkrHHlxxGOdR/O5Quu1DnbDpfGvj3s7hJEN5sFIlRyND085FOKzk=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2336.eurprd08.prod.outlook.com (10.172.14.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 15:35:55 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::f40f:d74d:a1a:e95b]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::f40f:d74d:a1a:e95b%2]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 15:35:55 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Topic: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Index: AQHUiLiqITo/LLyl1EWjCUTAJp49+6Vx5IUAgAGUMoCAMLMwgA==
Date:   Mon, 7 Jan 2019 15:35:55 +0000
Message-ID: <a545e3a2-6d68-e0ba-7d98-168d3637858a@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <5C09448C.8010506@oberhumer.com>
 <fba24452-ae3a-0caa-11b4-aea69abf2fff@arm.com>
In-Reply-To: <fba24452-ae3a-0caa-11b4-aea69abf2fff@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::35) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2336;6:WLPRtoGGjj5sr8b8juluOGHR/EayAotug8hMnFgk4oYDG1BlPVDOAZbIWBUza29O0bzFKCYah7AB7OCtKPmL+IOAT1MBU4Qf1+7xBmzT3Z2a3DCk8sVzWdNO1iI5uk1zoR3jzx6ZxsY3CvReHpz2+PDLVA/8dGCKAIcfFIDJtCuz9Z0JNJtd3ugqEWi7ZPakGs8WNUvmUjshYzbVqzp1xeGMq4nSB0nYTCj9dekHG1MfBcHmrx439DVP0FoX5xM1xbnQYyH7TV1ok5G2kXjnjdcXbDzT9zBjdtlnsQbJ4yIJpiMhJRPCuChNGDFlKgbjW90+ZfR0VIkv5ntddXs56yx1VLwKrmeIYsLNhUU1VoE9K3BDn0ZEh1175af2s+vvZLK6Z9Wpko05CngEihs/9FVKs5Q24l4SnPoX46mIfMyPAI5dYpFfNto2UhTmFL6d7Isp2XG774j3U5bbbBhU9g==;5:QfZVtJ7b7jqVbHot3Xa2TSz8iCTfgeYvud8dnwzZqf6cUtwcKSid8bU9EO8RZ7r78vyD1ZfitR3iUaVOjdWid/EEae8yW8nuQzNKfvavhVcjdPfjMonPzkuwIl0GMQIJRz7MJ8KdB0WkVJyoYLdyxTzy2peYbmM/HboENOZJiR8aebZhPoAENUNiWQ4ycM/Vev5tgPj3YNO2xk7RRcTj6A==;7:zHAc1+ARlN91DUo0kZTA1kUDopUHh3X1Pm22UetFkKHqdgA9E9aPAQHmnCyzyyoTK6hlCSiOXlx6sUz2yqirXLcjfLL5CBqSD6dZwaX4A6eoSRoE3+6jyekO4HAMOvJrF5oR9hCZLZzMsOWDbtdtXA==
x-ms-office365-filtering-correlation-id: 17342beb-d356-4743-90f2-08d674b5d036
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2336;
x-ms-traffictypediagnostic: VI1PR0802MB2336:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB23367AF5E9D114F7B6D90C368F890@VI1PR0802MB2336.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2336;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2336;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(52054003)(110136005)(81156014)(81166006)(476003)(2906002)(52116002)(76176011)(478600001)(14454004)(2201001)(5660300001)(6436002)(36756003)(7416002)(31696002)(6486002)(229853002)(2501003)(6246003)(53936002)(105586002)(25786009)(68736007)(31686004)(106356001)(97736004)(86362001)(305945005)(6512007)(7736002)(71200400001)(486006)(4326008)(71190400001)(6116002)(99286004)(66066001)(3846002)(6506007)(186003)(102836004)(11346002)(44832011)(54906003)(386003)(2616005)(316002)(446003)(26005)(256004)(14444005)(8676002)(39060400002)(53546011)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2336;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A9n4243x0rrAXlyfzosj+a2gHvRPOF+A98hBmlxmzww4gwHbb43uQtfq+1yzHtDNNP0Rxrb5vgk6jHgEU5MfuBgCAOStMiSuGEyRL72hmZOPBLBJZ28pj0nrL9hytXFGHBkQc9PA5/NtCNOr5i3H9+jN7u0kFJgsRwCvn7yPzRBhCEYvPftV6mWwgTrD5GukP8xXthsYuorv7472z4XR02vtVGruX1jCdAqrtEE9isB3jztendJNzsQXRGFXp5BUtjrGd/S/l5bnDgOhZUjAqwaEXjfCGQ8UBCG5t4G2hTiqqJ5TBZvQA/b4OI+jDjv9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B0385DEF9C89944BA1DBEE48817B4134@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17342beb-d356-4743-90f2-08d674b5d036
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 15:35:54.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

What are your thoughts on how we should proceed with this patchset? You rai=
sed a few concerns in December - however, I'm=20
not sure what further changes might be needed, if any. IMO this could be me=
rged as it stands.

Regarding compatibility concerns: patchset v4 does not modify the behaviour=
 of existing lzo. It introduces an=20
independent algorithm (closely based on lzo); and also introduces some Arm =
performance benefits for existing lzo,=20
without modifying the behaviour. So I don't see a compatibility risk.

You mentioned a crash on MIPS - do you have any details on this please? I h=
ave not seen any crashes in my testing so I'm=20
not able to look into this without more data.

On 07/12/2018 3:54 pm, Dave Rodgman wrote:
> Hi Markus,
>=20
> On 06/12/2018 3:47 pm, Markus F.X.J. Oberhumer wrote:> Request 3 - add lz=
o-rle; *NOT* acked by me
>  >
>  >=A0=A0=A0=A0 [PATCH 6/8] lib/lzo: implement run-length encoding
>  >=A0=A0=A0=A0 [PATCH 7/8] lib/lzo: separate lzo-rle from lzo
>  >=A0=A0=A0=A0 [PATCH 8/8] zram: default to lzo-rle instead of lzo
>  >
>  > It (1) silently changes the compressed data format
>=20
> I'm not sure this is relevant: as a separate algorithm, there's no reason
> to retain the same format (although backwards compatibility can help with
> migration). If you know of a way to improve the compatibility aspect
> though, that would be great!
>=20
>  > (2) crashes on MIPS,
>=20
> Please could you provide more detail? I tested on x86-32, x86-64, arm,
> arm64 and big-endian MIPS64, but if there is an issue I missed I'd like t=
o
> address it.
>=20
>  > and (3) makes compression and decompression on typical data 10% slower=
 on
>  > X86_64 with our internal benchmarks,
>=20
> It is of course data-dependent. In my testing, as I mentioned previously,=
 RLE
> without the other patches does regress slightly on high-entropy data, but
> offers a win on low-entropy data. For the right applications (e.g., zram)=
,
> this makes it overall beneficial.
>=20
>  > and (4) has to be carefully checked for buffer overflows.
>=20
> This has been reviewed prior to sharing on LKML, and of course tested,
> but further review is of course welcome.
>=20
>  > As a final comment, I question the quality your benchmarks - combining
>  > arch-related ARM64 improvements and algorithmic changes into one
>  > benchmark comparision is just unprofessional marketing.
>=20
> I felt it was helpful to show overall performance with the complete patch=
set:
> this is what end-users experience. However, as you can see below, I also
> previously shared a summary of the two main components of the patchset to
> try and address this sort of concern:
>=20
>  >> As a quick summary of the impact of these patches on bigger chunks of
>  >> data, I've compared the performance of four different variants of lzo
>  >> on two large (~40 MB) files. The numbers show round-trip throughput
>  >> in MB/s:
>  >>
>  >> Variant=A0=A0=A0=A0=A0=A0=A0=A0 | Low-entropy | High-entropy
>  >> Current lzo=A0=A0=A0=A0 |=A0 242=A0=A0=A0=A0=A0=A0=A0 | 157
>  >> Arm opts=A0=A0=A0=A0=A0=A0=A0 |=A0 290=A0=A0=A0=A0=A0=A0=A0 | 159
>  >> RLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 876=A0=A0=A0=A0=A0=A0=A0=
 | 151
>  >> Arm opts + RLE=A0 | 1150=A0=A0=A0=A0=A0=A0=A0 | 181

Regards

Dave

