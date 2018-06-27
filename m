Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A50C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BD224276
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LhDlwVu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BD224276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965537AbeF0SK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:10:28 -0400
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:45760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935039AbeF0SKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtP3PfATZpnNUQXxIKucQmgmrSKVxBJ2i2J4wZQMjYg=;
 b=LhDlwVu4gzG6UKzxuQdro4CNqwapPyN3OcLAoCEM63gbC5PqvD60AvUOc8neIk6aSmrl7zQBC6kOeBaPEdn0qj5M8ghJ9cDkZASG0mjZ6NQ2h6HpRiTY11AZS/aoqmfH03pjlvApa+SesbVarX7zcMoZKww3Ds5jLStv/zf6TUM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (2603:10a6:803:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Wed, 27 Jun 2018 18:10:20 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fYEtQ-0007SI-CC; Wed, 27 Jun 2018 12:10:12 -0600
Date:   Wed, 27 Jun 2018 12:10:12 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
Message-ID: <20180627181012.GM20754@mellanox.com>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com>
 <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: VI1PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:803:14::29) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384120e7-062c-43ed-fc12-08d5dc593ecc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:KoYgFOfxeickF7MQXI3z9eNPR+A1py8j5aLu9d0NwNwqz0zQTgD6DMiLZOwYGT/tEu6lRcHiOXCItUY2KRlX6dBca9GqYi4m+Nlkf1ZXs/UKtwWAiFH28MjXil/c6QY74zEdScOKJbyb7WwZEW8RSMhKWrpr0f1yn9OLa/w8iNNB0C2qSOvuNF1VAQzKroYQCcuNGpQMQw8kcgjdaQN9fPZeNufn1PJS70SEgCEdqUQqZ9fo+4la8gLqxMISsdn1;25:ON00wAbtn9iG9r/UHiewmXrhTc9SQCkwBCyfjqJYJS9bQahjN6logY8PMlsAiKKqfKPDi90NoRAQr7+U5mxr+XPm0cqxb3PjwWURO0whS0zN9LFcECDPOBDcpP/krtTxqzwrrH1rAWpqtDZWBybjs7tyGDEhqwM13sR9nVwlctIAQEB0DRGyHGzlJZhB9UB8QkReI0gCAefTWwirsqJqEXLfNIonZCzz4UrFss6H0/utpzOxWRUyjP/OxU83Ng0lMA79ShtBeEJ+S5Ldn4bUCZ4LRrsEBMZ2WXAEEKfWGozQuqSZq1Oo60gMni/PswwuX60dr2egE26YBropleDYwA==;31:nccVtI43gbups51m7BVlFYhCqSNpSVdKwoBsCRNxZk6FvMvSuh4bgwkPZsxMkxpn3fFHYCSeQ6u7lrHt1kSiKIe8u2MUNIVK25yX0k9J3VQrXfjDRK6gpM7VbShQodXCb+QhTl1/xD9EUiPx9U7NiMHzvgH0c9WvM5myLGGcOW34mi4aZRD35slK3ED5QsFFZRu1eTQTBGwsBWrgk1f8fnPZDBwLGGHG9kD6U41ed78=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:mbdxwrWU1AJrlYGI+suR3Gu9WV3+WPmaCJ6DNmsm4oAGmkgMxKqE3XF8H0cXTW0FzL/ELnF9MhOCInCu+7vUU/RGPC96aU7Z6JhwMfkI57E9R5OicZ1yhooGKz8JsI9XOQhcxuL0C6A27I2/KgvrwV2ZIngR2b89DwwyQXsj+ldnNEBue9Y8XevaJkL/fSHdiFSGi+I1iOfle6scJ1lGE7D0g+UerLA9Z1/seYZkVDemHMRAqPQ63JxiuGXZvq+1nlRMjRvdGBftfr0gd0nSA91hs0iKXyfKw2pnIlcYU2BCRTOVVc9ap1tA99BGyQGPR7gAFiccDrqzATyezuWDy4SPUXqTx3ZqEOleBtE1oHt6P2WLvtPGuRPMTU0pvOe4vp8YFgqAJherbHo71LWFXNRLfD3KQp9/THgUdFRpAjJ8Y7zOjTAZgq2Amfqp2oL01Uquqf9fg+hzY/UXTDWU7xl+pQkpEvg++8hmNtM4gP8kmvvWrv0zPMROXJeRBokn;4:L4i4ZLJjv0tIm0cCIoX0uIopLE3KRqCerrqcZ8LNoBqSCSSAlO+NjeXC/G6Ev2zGOVceuqOzmB61o+ItFn3r7n1byHK8jsvcVcec7iooLi68kg28fpFNbVCfBSocOYqzC83YTkMOYb0AtcVnPFnFRJs04Q1DyLtlT6suqNEMDImWZmGPQFwlRaBk8XanrBFMtyf+gYgzKdYXk93TzFBt+ftFKA2ZPMI2/DDaLqn8Qlw9c3awMCZGsPElOTVVM3UZeRY0Fxv7F33yywlm/8RlXA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462D4027234CB964C7623CFCF480@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(4326008)(1076002)(6246003)(316002)(122856001)(16586007)(478600001)(11346002)(52116002)(36756003)(54906003)(9746002)(446003)(58126008)(105586002)(106356001)(23726003)(6116002)(3846002)(9786002)(69596002)(93886005)(7736002)(33656002)(53936002)(68736007)(83796002)(5660300001)(305945005)(46656002)(66066001)(97736004)(76176011)(50466002)(86362001)(186003)(47776003)(486006)(2616005)(26005)(6916009)(476003)(229853002)(57986006)(2906002)(386003)(8936002)(81166006)(8676002)(81156014)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:xKD9YvRKBlzTBLjqTkN5jcA0z1tm1kiaioo52rIl0?=
 =?us-ascii?Q?93FfyBD+Y5YFInbn+bK5BLb4siuPNpk0cuNZ1SqF8rH7MXmCTEd+KyOAHJ9U?=
 =?us-ascii?Q?y6OwC1GhhrakM32IBgKBzv/ujDR+NswbVGMeN0OPkY2QtTi2C3Z0djYuRzvv?=
 =?us-ascii?Q?bCat8V/AFj4sshxMJncXMkXH1l0DAZUg1TdWZplIXZVWKWPT0qlP1y4lwHbD?=
 =?us-ascii?Q?Ki5tnfVS4TN3sS9ZvWfLAs3Mcnt2lTwQL+CRE658HRIvoiuOmeXKQff9whLk?=
 =?us-ascii?Q?xIHGT26FYoz5pv93+NwmXNiqKoflN4PmAsHRjTJKP+1UQH9O6DRAKSiGraaU?=
 =?us-ascii?Q?+QmiPQGQBhnod8oKvLbiiGi0ZCAcB7w+A7r3iIa6zVMmksVZFCvbAQ4N+Rn/?=
 =?us-ascii?Q?Wtw3ZYNRk7Sz7Zx1KhRoDzyyumUv91bkUs2ckFB+pou+B0UW8DoemFQ9ve15?=
 =?us-ascii?Q?o0q/5kG3XyFikCKjq7XS1/QLFa6NnFVHgz9R1zylcZawMpd8fweoTKN7wf8a?=
 =?us-ascii?Q?3DUA1bYu8ZKoicWjSTS5I7g3eV6JJs7RR1qK82H8JkSSNZHoFhFIN8BLbXIk?=
 =?us-ascii?Q?ntA2CvbGtFo2zOoJXnJk/sIaJtfTFVSDjF5WrSSi0TRpN6ldzrjy+urof1jF?=
 =?us-ascii?Q?gJ9gulmlzTu6x3c8hw+6dOrmszGHQiEhKjqjuKI42Q4YOLmTK4kPgv8QyLKP?=
 =?us-ascii?Q?aQMMTzsgW2kF56izGAv9iNY23GlWvm45/uFCJGGHm/sbVcSundZUrlB31DDT?=
 =?us-ascii?Q?YuwESTITTfzou0HDJqiFPySRU/p0DgP+v173ht02HZOGzX4hhOS6H0lh/9HD?=
 =?us-ascii?Q?NvcQT2hNgk7HPvCJjf0+xL7ag2eY2NLELTBonfUIqQMPHNxI3sm1lhEJBCPK?=
 =?us-ascii?Q?W7lrNsdR+9r5kv2EbEeRUZNsW9wzIolNUkGGm3UdSDg/NtZ+nF00w+xO9gUZ?=
 =?us-ascii?Q?8+A27gXEBuauVyQZazn5lnY0EsNgR468adDM+6pFwZoc2scMVF8qDwSJ6bAM?=
 =?us-ascii?Q?UENJW533MiCoKICVDBbP92V0iciuyJKwUL9+MbMNIa10PjhAy2dm2MS1e0LD?=
 =?us-ascii?Q?Nv3PZuVX2v4s6eqNvHttTA1L3eq0qY9WVEGHjhtu9JHh5CwSd/VD01VF6MSv?=
 =?us-ascii?Q?XwRHamNKnZ0fU1OzNdQvhW5GXdg3f5G///VnBzkGlmwD/ZTcWxWL52dx2A57?=
 =?us-ascii?Q?UqY9BX1jO+GIFxBSCCO9kJNaNP5Yk6fDtdE8FWZFbLXvmgUWj33u53r9Mykk?=
 =?us-ascii?Q?6jSi1/XH7nd+CxSFHw7lD0TAsEmHxIHKXCxXfHkmCwSRit5jwWaNCG5w6LRz?=
 =?us-ascii?Q?srbCWGQiQmZD8ZIvAkfYVsYgqvdfA8LVEEh2ZDifCdjg38qGyfHYqoDtiEQh?=
 =?us-ascii?Q?e9Tpg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0+c1nxFd2I2QM9BQXq2bzDTPrCulmZMceEe34baaPrpUDiwBYZo8lfc49vKnch2qD64vDgNrOWO76y2EBY2wxYOdHSbfg3jn4uN84p0yZotB/9VOXoMik/6ikyF4V37aPtuk/ye6JxUVM4EQ/HL/ZnBUCuQpORirEiXDlyIKGBn6ZzKyfB4B5BQvfzZaytaCs9AIuQawocrgqeSK+lPgoz9kriIafh4j3LpuBoM7wg+8tWigRposTWMa3ehsnkYDpt1yf2hyJcB8YgJbX9Hgwjz6IMl9x1yb1+HvaN6ijtwHQLfsHMpBSwBN6AeZymrqbFenmx3MhKzAM4Ly6GN2/QT9u/a2Yz2R0pBOyj6c9x0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:Zc/5ET/U3HL4dudn8udAKXaS/blo2dfxm/XaxGRMcARhN8IR8WejbxzzES5yFO9+OVYpBgD7d6i0imJQWBmUhWmogePr1Q1zqX2mU85uQB/W2zndCIQJoiYowiMVs2wbiNzX9b5lXee7AniMjxJlGzviyWFHV7MOoSEIF/ON5P2r+5wJRAyqQap45cLkiN6lPEkTP+KOleynADwjX2dBQ+RI31mBi6PbEN66fMyogDNly2yCRLQAnnoMZs5w+yV1PFj7/XCcKG1+J0mwNig7JSqxeuPNFnYixjm/j6MxyG13CCUPH7OwxM2M4vWz0eWe8wYMye7WrSOz6W/V7JpO6iXstS/77hXngfcfT58xTFjz0emcm+u/TQezzP6PceZJ5bDqsViuSyzHt3AmN/5r68XzP0nzAkGxIH+V8JuIpJ+Ml4BiL6iVPth9FNdNAqpCZgXZgKo/ZZr70jkmFK8/Gw==;5:KpXv8pYCX7+IMy3E3DslbfQB6vsc+29kjHM7RIQkra8AvnGtpdb/N/SrMpFcD4Nr7DbD4FqYkfOzHQJkVmlhdjPWHEdLF3cj3ssPfDp+Oz+Kx+HRMwVPxBiMsivMQRwvIb9z/DGHKXGZUdcXpVdVo0bI/+w3oEcaYTGr+v0s//o=;24:Mmt6chpOqP6DbgnIcEdtJ9gW70p247AkRY+kIfx1X4JHahTgc6UJDZz540HNPx/O8mLXdhVTmCO2xgItep7IR4D70m8NznC9FIA9KJxm4qQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;7:sGvkl4QrM9RWlLfICLUOa9fkRcT4rHYv4FE1eCrrZNeCuTQc086hDaETmiJqls2eH2lAR2dghYAm8AFhjduLzbfO1e3zYciMGi5dia+060JVi5M4wXX7uHJlp8mGkggPmoAJ8OVFirGy3CHidvMn4a9MikhzClMbhbnA/ooGlHiB2oTt8y2TxETtGIKZ6yGw9VfbGTf28EmJ/p+q/BLhosO2PNc/V1EYn+r0yDAE6w23BviLknse+d3aho4V1EmE
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 18:10:20.4823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384120e7-062c-43ed-fc12-08d5dc593ecc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:36:03AM +0200, Rasmus Villemoes wrote:
>    OK. The requirement of everything having the same type for the
>    check_*_overflow when gccs builtins are not available was mostly a
>    consequence of my inability to implement completely type-generic
>    versions (but also to enforce some sanity, so people don't do
>    check_add_overflow( s8, size_t, int*)). There's no gcc builtin for
>    shift, but if it's relatively simple to one allowing a and *d to have
>    different types, then why not. It's of course particularly convenient
>    to allow a bare "1" (i.e. int) as a while having *d have some random
>    type.

Yes

>    Wouldn't check_shift_overflow(-1, 4, &someint) just put -16 in someint
>    and report no overflow? That's what I'd expect, if negative values are
>    to be supported at all.

I would say that is not a desired outcome, bitshift is defined on
bits, if the caller wanted something defined as signed multiply they
should use multiply.

IMHO, nobody writes 'a << b' expecting sign preservation..

>    Well, the types you can check at compile-time, the values not, so you
>    still have to define the result, i.e. contents of *d, for negative
>    values (even if we decide that "overflow" should always be signalled in
>    that case).

Why do a need to define a 'result' beyond whatever the not-undefined
behavior shift expression produces?

>      What about more like this?
>                check_shift_overflow(a, s, d) ({
>                    // Shift is always performed on the machine's largest
>      unsigned
>                    u64 _a = a;
>                    typeof(s) _s = s;
>                    typeof(d) _d = d;
>                    // Make s safe against UB
>                    unsigned int _to_shift = _s >= 0 && _s < 8*sizeof(*d) : _s ? 0;
>                    *_d = (_a << _to_shift);
>                     // s is malformed
>                    (_to_shift != _s ||
>                     // d is a signed type and became negative
>                     *_d < 0 ||
>                     // a is a signed type and was negative
>                     _a < 0 ||
>                     // Not invertable means a was truncated during
>      shifting
>                     (*_d >> _to_shift) != a))
>                })
>      I'm not seeing a UB with this?
> 
>    Something like that might work, but you're not there yet. In
>    particular, your test for whether a is negative is thwarted by using
>    u64 for _a and testing _a < 0...

Oops, yes that was intended to be 'a', and of course we need to
capture it..

Leon? Seems like agreement, Can you work with this version?

#include <stdint.h>
#include <stdbool.h>
#include <assert.h>

#define u64 uint64_t

/*
 * Compute *d = (a << s)
 *
 * Returns true if '*d' cannot hold the result or 'a << s' doesn't make sense.
 * - 'a << s' causes bits to be lost when stored in d
 * - 's' is garbage (eg negative) or so large that a << s is guarenteed to be 0
 * - 'a' is negative
 * - 'a << s' sets the sign bit, if any, in '*d'
 * *d is not defined if false is returned.
 */
#define check_shift_overflow(a, s, d)                                          \
	({                                                                     \
		typeof(a) _a = a;                                              \
		typeof(s) _s = s;                                              \
		typeof(d) _d = d;                                              \
		u64 _a_full = _a;                                              \
		unsigned int _to_shift =                                       \
			_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;               \
                                                                               \
		*_d = (_a_full << _to_shift);                                  \
                                                                               \
		(_to_shift != _s || *_d < 0 || _a < 0 ||                       \
		 (*_d >> _to_shift) != a);                                     \
	})

int main(int argc, const char *argv[])
{
	int32_t s32;
	uint32_t u32;

	assert(check_shift_overflow(1, 0, &s32) == false && s32 == (1 << 0));
	assert(check_shift_overflow(1, 1, &s32) == false && s32 == (1 << 1));
	assert(check_shift_overflow(1, 30, &s32) == false && s32 == (1 << 30));
	assert(check_shift_overflow(1, 31, &s32) == true);
	assert(check_shift_overflow(1, 32, &s32) == true);
	assert(check_shift_overflow(-1, 1, &s32) == true);
	assert(check_shift_overflow(-1, 0, &s32) == true);

	assert(check_shift_overflow(1, 0, &u32) == false && u32 == (1 << 0));
	assert(check_shift_overflow(1, 1, &u32) == false && u32 == (1 << 1));
	assert(check_shift_overflow(1, 30, &u32) == false && u32 == (1 << 30));
	assert(check_shift_overflow(1, 31, &u32) == false && u32 == (1UL << 31));
	assert(check_shift_overflow(1, 32, &u32) == true);
	assert(check_shift_overflow(-1, 1, &u32) == true);
	assert(check_shift_overflow(-1, 0, &u32) == true);

	assert(check_shift_overflow(0xFFFFFFFF, 0, &u32) == false && u32 == (0xFFFFFFFFUL << 0));
	assert(check_shift_overflow(0xFFFFFFFF, 1, &u32) == true);
	assert(check_shift_overflow(0xFFFFFFFF, 0, &s32) == true);
	assert(check_shift_overflow(0xFFFFFFFF, 1, &s32) == true);
}

Thanks,
Jason
