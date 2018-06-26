Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC84426CD1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="h8doyT3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84426CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754779AbeFZRyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:54:53 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:26658
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeFZRyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgimKYNKNggxN5odswvhUMfrXZjqXs1Jz9u38yb+WaY=;
 b=h8doyT3XNOnZLaAUr9tCRgEhbVwCBY4x7wChudRfDe5oJKGXEuNRWgGC45oJHp5foDhiJFQyYxLhM0gypyuz/5ije0Y8OIvzLur3qGMYGHbIRS4MdXwt7gNHq3HCDC/vX01sYy4Vd7+lEjC5MynefucgnEhLlhs++2ox/FIQ1S8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4461.eurprd05.prod.outlook.com (2603:10a6:803:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Tue, 26 Jun 2018 17:54:46 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fXsAl-0001rC-QD; Tue, 26 Jun 2018 11:54:35 -0600
Date:   Tue, 26 Jun 2018 11:54:35 -0600
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
Message-ID: <20180626175435.GQ5356@mellanox.com>
References: <20180624082353.16138-1-leon@kernel.org>
 <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com>
 <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::28) To VI1PR05MB4461.eurprd05.prod.outlook.com
 (2603:10a6:803:43::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc744f5-91a2-461c-e382-08d5db8de76a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;3:squdWNWcKzc0Ha9I8n5gYnI6cw32f9QKItoXaPOmrupahPRNmDjnRzORzy9olWmFyNBufuLjt5e0nqkQ0Jq7P13vQu4tM/Ul2ooc5UV3kn7BdlLUKsE9UPEFNVOXXJoYQfQQ3DOULT2VwT8jjc3gMHz1h+zQC8Ob+DwAyppGV6jnXyDU8CCnbwXKshaFgZquSBnd6wtlDqmykixpCGI302qLNWUt8NMh7zN/KmnYJb+43NppDcNCsjaRwFjFKVQa;25:SRnl0EhXGeoJtQbh2rTd4sIngDlnPu7i4MWV/4Wk0zdlQqK//k3A0cMKc6bmtKpnOVPQsdCoMmFsE0iNtgGBPI43HEEgaKZHo1hr8xYusPet5yZOkv9oEcX8RdpMR2QsAsjpHwGDib/vbRPRW/Wy9g9dP4BP2hVxJAodfW9MXWM+SBEMRY8ePKAo4r+XdB/LKmw+PR3iEW5hZy27exp/Lwp0I1uhIyNlbShu/JsY/vakho1tg62/XteSbVGKztJhCbCD2Wed9hCxPA596ZaAjUcpLCXh/V2slODlh10DtoP5Sjx6y5qfKJbxi3mDCJ47lLs25V5/b1c0pdf1LGLwyA==;31:oIC0X1jNgSQZFICF0ZK6t6TMlbb/Zs1MRlm2y9l1PW2jZ0shBC1nplowRZlXwQOX6qUFgxZKiYsqZ22ga7QrKSiG9cO7RL+NkEQsC9AQUO3O6s6+/iU5PZD+rcFgyvf9Gq/9EVvG63jKz8EtKsfmrSqxpUI8QjOcZGE7S0013hD6TGqBkSo7wDBTA6ixpmVRjnH+kEydoO8H6C7tB7HJVdrjUU0LFOOvVt7rj+AmjDc=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;20:ikjr3i6Hfb60ERi1quFqMZVGW2Z4xSR9ozbqRXJdExHj+/uF1gDeWD+2/HhgBwOQCuZwwA3dVkAwhZ92thMn9hgOhAOSqCAjDHjtqCi06aHJkMDiuXjZZ6DY4AdDiBDhv95AF7YipDJeYAJsYEoMIaj/z7ccP0VzBaLc0ZjSjEk/cC7VM/vWM47B4zLAvmkZFt1czunTJBn3sOmFrAHWxF0friyyqqLwbjKgfqMtdIhJRwjEiCkv1J6qzNIxAM8NTxe38W3rr2jadm0Q8P7ipWsrpO55rlXX1hdGl4OjaycOhnVNzqyAqPaogWPEqNbGFnUqa6X91kOMRyCmJWyqiJNAMCI2EiDMuHHxk7/6lKg/L8qGVAFT2UnIIwLtC3AcpwlMsZBCL16J9Jt8wcbf4s2ll3dwz6URYZYBQiiQjf/LDZt3IhW9NGOlFR7vdHULG+vjvw8QEkPNSqw3ISHwHNVgwNvpakzwr5GMMpMrrgjugQa1QKiGcV5fkHnjy4U4;4:b3bCqw8M5jgeSt0GdKAVPM2SaMr2+ovBWN/7QpqbwUrD6BaIAg0JZa3CnGjUYTDNoWHC2ZZX/e/HXhK9ijEA9kQH9jGT5WFAGLhu9UgRhvAQCNr8fnIi6LM+eOVXDyVkfuDhTQ4S/soARWX/pf0TQBSCZh8Lgxd3VQlJ9QrVrKYa9Xyx5wtpKYWhs6UUpGTBBz+p3EFagFYR7tWElSDZr1sUZUKWavBUp6Ab0iaLxzhnY2g9L/rABSh1S2EwQSXoe3jsVKKwizgYIGNw/Pdabg==
X-Microsoft-Antispam-PRVS: <VI1PR05MB44610FE96E5C894761CDDD15CF490@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4461;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6916009)(86362001)(54906003)(46656002)(476003)(53936002)(122856001)(2616005)(6246003)(316002)(47776003)(305945005)(11346002)(97736004)(446003)(478600001)(5660300001)(69596002)(2906002)(36756003)(66066001)(7736002)(229853002)(16586007)(58126008)(26005)(57986006)(93886005)(83796002)(3846002)(33656002)(105586002)(52116002)(6116002)(81156014)(81166006)(8676002)(4326008)(486006)(1076002)(23726003)(68736007)(50466002)(9746002)(53546011)(8936002)(76176011)(106356001)(186003)(386003)(9786002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4461;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4461;23:wIiiXx+marKfASeE0UzzloT3OU5+p1z4gxRAcw5WD?=
 =?us-ascii?Q?Nx5wuZRtRFY2+aStar1mqRlntoXLibXSfbdVgXeFKC+WWE8ki0LLfIciELAH?=
 =?us-ascii?Q?XxdekEalZJuHeJa8+3sSwptRtrIQT+rrMLPgfClBeWdiYmQnxY0wa7Sytc+J?=
 =?us-ascii?Q?m3LVlgYP9rf6y2L/2e1q6lekwirTjQozn6njdmit63aucvzEK9T/wMtVrZaI?=
 =?us-ascii?Q?/HOjEau0ELvpE+VQdW8j09YvXtFFQy3glYvPx6b5Ve8RVYVBk0dtasFIQSh7?=
 =?us-ascii?Q?WHgoor7J/4yNmhTuxslxPv2xk32rZ7gw3+dyJs1U/zQrHlJxWgCpD5785pgP?=
 =?us-ascii?Q?cYjP9JglDa5c3++T8jJvBxznVBeM1Qv1KGW9HS9hsKchHKbUQ6O61QjYl9Aw?=
 =?us-ascii?Q?EHfHNtTKCmPCdlI7fHq5lbbCL7D+Zh3lNaLxs+JeX54lcuGnCZ9bdHsFn/Nu?=
 =?us-ascii?Q?/KwacT+uCG2Afueq/SOQgD1IGQvOVXL4oy4mj9jZ+VWAabrZLF/GrOnIoulO?=
 =?us-ascii?Q?65RtoQMf1KMyWeBR/8HcQqxRhmqbqMFyO0xSNoEsrlS0fwdmcH1BvmspdAyl?=
 =?us-ascii?Q?NXovsUOIwlbYoEwIB/DnRJ0Np/Z4/LkMEqv0oR1JreC7XW6INUslbUvqFFGv?=
 =?us-ascii?Q?dJcF7Gv9WuvbnL4X4xlAPaN/iCUgvvEUZ5L60NZURJsAYFFHJ4kqIJBgp4WG?=
 =?us-ascii?Q?4pFBFBveCE4Z555FFV8KCFOBwdRKtObiz3Rlv8SRr4cxbQqtKhbUkRhq+ShN?=
 =?us-ascii?Q?Co79a+UWDe6S7f8IsCFXFyaN7VsBiNcX8X11mwTatKzc4XE2QLYehmJ70bTP?=
 =?us-ascii?Q?SlqHp/rhzdoUiU5fxUXO2jd4jwDx4i6Fj0CcKTrovmjgcQ1/VEyo7OVML7gR?=
 =?us-ascii?Q?ZKxAq9MFlo7An3m98DtySH5W1LGFuKLl3c2uIzXayg4udOLAeoQxYUkGQ9yN?=
 =?us-ascii?Q?ytRV9TXaSsyYuSe++cBP1S8feUAsVByTzFu9bq9fAEPuZ33vt35MR74vAcQ6?=
 =?us-ascii?Q?HaokN3uhNVCmnEiuctHrHFF2SryAEBRoqkte6TrTJTh/KRZGm2n/h/914iyV?=
 =?us-ascii?Q?UEZSpJ57hDKjx9fHQzZxfPEp7MM1NBxDWP1+gUkS0+beDcaBUglndEaBK2iK?=
 =?us-ascii?Q?fdhQ2PEEChlz/bHDocsFg+WQTrC5c91MMUz7LWBuAR2b2J5Yhhizvu1Xd7Yf?=
 =?us-ascii?Q?XFVxZ5nHo+R1Zuup8KMvm5szhAv/oiWps1U2NirPBZvLkEZ7Y33IRIdegQV9?=
 =?us-ascii?Q?p0jPK1j1u+YhsSSElXDtxHWGWLpbNi1KfueIeNVxs94ZlSpFyDpcnWD29kmL?=
 =?us-ascii?Q?no7w6dOPCfBZjlCEvIwmHg6Yj2v4QD/ozk15452VBaMVAWE3r47Xee4hnocP?=
 =?us-ascii?Q?lzDtAiNkWF2mmXRY1F2GlEAhe8=3D?=
X-Microsoft-Antispam-Message-Info: wQLVruT1l77D5VXp9Ytz6Jk7P0S1tKZJExilqGiQKbCpVQvs0UdYPABNI/Ep9CBnOMluLBgC1z3HadgoqFISAQMSYtnVHwZGEmzq59QkN4G67y1bwarQXRwsQFGldMSPXKon53NcSbxbjlKmwUy/Ts53mXan6LN3uCIi6HAEp8OnYPf1w3hHhGyQKj6lA//u5mQHa5QSc1b+eoutNIOV7YF5bxYOd6S1XP5qCAfCPUI0S2H9mW6xyyNyhvu+wrQs9l/VmdvaaL9RinVaBcNP09XnZqY2M3eWJHpwypxJD0Xzu6zV/UpW6B8OeOvyaiOwpOzaqz1ty0/QC2+rsZWfrIYVkY1AwyXWfVMsNW+Oen4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;6:r+vpouoRIobMw6fgrfMj51BQjXbdasgqXlu3n5G71ZUrkc2wnt/ulPBQU6/111IlZpQW2YneMsVPy1zTETdOT58ikRK9Ycv5zv/JBiZY98qZYhMCiG3tc1Oa4EyjaY8XXwWHUkQxAP4MJpOjmax3FLbKwGV7eGGIdsdybk7RmE9TN5QR5NVOaCV/eP7wvA1QiLby4xnF5rHFdrm6eoDQsgseMdbKslOEgooyiQBdFKvQKFSmVuMr6dlOMxyNHfCwfOWdl6AieaYR/MNShL0nyHxHZmho+dHsBpR0q1k22FpfTm5IMpfQFHn25eb1YGczpzQim+6D55BiN2LEvZvAgyfhHPJBJGIIfTkOpA6ccAUuXR2mrQTGFFxIXtmAQnH2nCm/qY5jN01CjowCbu5UKcXZeOxXMjDYq0p1pj6KS6++5asj2/SU/mcCofI8xRPdgcPypg5A1cxVwKTjDTWoqA==;5:Hf5m8L/8eNuvHu1C09X1ik435BbMShiN9Q4QnzIE8zHKOlw5zggckSeCFUUJ00dpR7FDve9kcFkbJ3NOnV00ZOg+6sjwBXjjRhU+vq7TwzMYp/ctk8nq6L4sovGNUgBM/j1k1ekU2IsY/8DrUaaKnJ3Y+MUomnAbufxBMTyTtRY=;24:wjd5s3hpYMQPTtxKiwrF3TgDd/U9A2S2A9WwvS1GyEl/bzIEiLZxSAWQCAKbYFHPvjrfsS5CLUi58CuOf0mf3WP3eFOqT/eoDcmWrn7R5+I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;7:Iq7woxaId1gUrqP2vDWS7ukFGw6lQy+6tALD3yH9PAIM4mLFEC1N9oov9IUNCBte8COlTx4TXaaCO4z7+Jj9ykE5BykedK592eRHBme8eb9W09bamTQi1g1gdYTGN2Fo4HnxgzYbMe0e2dRkfjZ7jNKGEQvqCN/2KpJqiGk2YKgLVcEL4NZnhfSSc85ZPjGMfuDdma5JlR30bFxEoRLOoRUn8lmGbt5uNkE+7XsHvC/65vUHE/eZfPWYSgj1oBBy
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 17:54:46.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc744f5-91a2-461c-e382-08d5db8de76a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:07:07AM +0200, Rasmus Villemoes wrote:
>    On 25 June 2018 at 19:11, Jason Gunthorpe <[1]jgg@mellanox.com> wrote:
> 
>      On Mon, Jun 25, 2018 at 11:26:05AM +0200, Rasmus Villemoes wrote:
>      >    check_shift_overflow(a, s, d) {
>      >        unsigned _nbits = 8*sizeof(a);
>      >        typeof(a) _a = (a);
>      >        typeof(s) _s = (s);
>      >        typeof(d) _d = (d);
>      >
>      >        *_d = ((u64)(_a) << (_s & (_nbits-1)));
>      >        _s >= _nbits || (_s > 0 && (_a >> (_nbits - _s -
>      >    is_signed_type(a))) != 0);
>      >    }
>      Those types are not quite right.. What about this?
>          check_shift_overflow(a, s, d) ({
>              unsigned int _nbits = 8*sizeof(d) - is_signed_type(d);
>              typeof(d) _a = a;  // Shift is always performed on type 'd'
>              typeof(s) _s = s;
>              typeof(d) _d = d;
>              *_d = (_a << (_s & (_nbits-1)));
>              (((*_d) >> (_s & (_nbits-1)) != _a);
>          })
> 
>    No, because, the check_*_overflow (and the __builtin_*_overflow
>    cousins) functions must do their job without causing undefined
>    behaviour, regardless of what crazy input values and types they are
>    given.

Okay, I see you are concerned about a UB during shifting signed
values. I didn't consider that..

>    Also, the output must be completely defined for all inputs [1].
>    I omitted it for brevity, but I also wanted a and *d to have the same
>    type, so there should also be one of those (void)(&_a == _d);

Humm. No, that doesn't match the use case. Typically this would take
an ABI constant like a u32 and shift it into a size_t for use with an
allocator. So demanding a and d have equal types is not good, and
requiring user casting is not good as the casting could be truncating.

>    statements. See the other check_*_overflow and the commit adding them.
>    Without the (u64) cast, any signed (and negative) a would cause UB in
>    your suggestion.

When thinking about signed cases.. The explicit u64 cast, and
implict promotion to typeof(d), produce something counter intuitive,
eg:

  (u64)(s32)-1 == 0xffffffffffffffff

Which would result in a shift oucome that is not what anyone would
expect, IMHO... So the first version isn't what I'd expect either..

>    Also, having _nbits be 31 when a (and/or *d) has type
>    int, and then and'ing the shift by 30 doesn't make any sense; I have no
>    idea what you're trying to do.

Yes, it is not helpful to avoid UB when a is signed..

>    [1] For this one, it would probably be most consistent to say that the
>    result is a*2^s computed in infinite-precision, then truncated to fit
>    in d.

I think this does not match the usual use cases, this should strictly
be an unsigned shift. The output is guarenteed to always be positive
or overflow is signaled.

Signed types are alllowed, but negative values are not.

What about more like this?

          check_shift_overflow(a, s, d) ({
	      // Shift is always performed on the machine's largest unsigned
              u64 _a = a;
	      typeof(s) _s = s;
              typeof(d) _d = d;

	      // Make s safe against UB
	      unsigned int _to_shift = _s >= 0 && _s < 8*sizeof(*d) : _s ? 0;

              *_d = (_a << _to_shift);

	       // s is malformed
              (_to_shift != _s ||
	       // d is a signed type and became negative
	       *_d < 0 ||
	       // a is a signed type and was negative
	       _a < 0 ||
	       // Not invertable means a was truncated during shifting
	       (*_d >> _to_shift) != a))
          })

I'm not seeing a UB with this?

Jason
