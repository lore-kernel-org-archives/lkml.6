Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6054C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="MLxHNck7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF6620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeGXVgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:36:02 -0400
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:63200
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388640AbeGXVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rx3VYiHkWuntfnXP8I9i3IZpiHGSyhVuGkUdceULwE=;
 b=MLxHNck7kmkrXfjONbTTodvaJPUGTbEmldNpC+vVKpouPoPVHrK18sYX+g2FmFSe7ULEs8RgYpiSmC5tyyhtYfh4vUJmonJvbKNTcJ2UMkKqdoCMZa7pMwjTtMjX6EsSyNVgH0Oa7tfUKBgQGcT/70c2O7NCLNa2rahtZFdJf7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (90.154.199.249) by
 BN7PR07MB4372.namprd07.prod.outlook.com (2603:10b6:406:b5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 20:27:39 +0000
Date:   Tue, 24 Jul 2018 23:26:39 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 1/2] perf: drop unneeded bitmap_zero() in util/header.c
Message-ID: <20180724200356.GA22741@yury-thinkpad>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623073502.16321-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [90.154.199.249]
X-ClientProxiedBy: HE1PR0301CA0014.eurprd03.prod.outlook.com
 (2603:10a6:3:76::24) To BN7PR07MB4372.namprd07.prod.outlook.com
 (2603:10b6:406:b5::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5af36f3-3469-49c4-53ff-08d5f1a3e78c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4372;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;3:petWygebniSsHoWpDKyw+pCvbPYfD1DFoE7JKU7os2x6Tmu4NUIemdn8XL26Ye8BabXTMKqxUpap/cOKUykAIwq6miYXkggUmx32S1PWhTlqy7ww6JwBv/VcLrxmRD8VRAIxz7L4K3QsoCBj3xaMzzonkiPb2moxLocyYd/5qM2IvAivRIKHEDLjC3zSuPC0t9O4JA8tzwQpF0gn8LtDgROBB8E5bEQt6wDnGl2yi1KhQT1Pw6R4AZagEcu3/G2/;25:L50EnIsbw/7zrQm18deiggZVSp+nEkkLXM7QRUo61W/n2cK3YETCPN/d+Ktecz7soJZ0eQPR3N/a+INbC9uRjTIPoqrqNDprtBa2mQMlLWP9AWMA5MXzukjcv2hSGCgl2E6JQa5fd9fJzb5GkNSLoNKfp2CwEkQzOQvrpi1mlb9jbp2T8GiJuHrjMWHGu7aQLfGaqqEHeMCloj2hSRLk6TuG0228Ys85HZx804ULjArvN6B0ENbd2qV0cezvqVokCAKLkl2vEh5elMPrzfcgr3oHjLV9qnPA3Optif0ZCCp2AHYssnD49Z6FM3YUh4c2yiTvXwkSCFu9pwRhKlwuiQ==;31:o8UzFPOOml7g2t+PfP6sgmz8pfEq3sISs1qycf0i62qRPvFHArK2rYmSrXCY2vJ7f91dRwHmD36KdfYzoZjH6GbhwKu+EMc9lB9MYetp7cXg8kndqjXZ3zPQOT7O8I9YgCslbvlPwi2KJsYsKZGqsrRLcjvgdFrc1PkAWQA01N6NPx8m0bLvc9dsbsaOt3CEpvq2dQIMV0eXI9clCmYvPFsLq7w+IhyU13lSMsXuOqw=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4372:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;20:F51dn+iONLFWiU0gfu/t7dJa3gzhBeLiQRDSW0o4JbLzWhmqKS6LBGpN73ErhOeDz5qZ9DWgLV7wxOoMYKyPXUEume2ldc4drJYsl9N4CKMyAWw27FOae09TFrR9hx0n0xCfHLm9SDbQJ+OqW7gIcZEjnQYupVccg3rvbhPI4772vYOwGcZ13aLkhIbSkxgKAgit3tYZi7fOpJiQdWKUQuYNJCKXZii18glajey5YJpls2KD6/bet3ZigGs6bKMZYlUy8+1JA1wZsGYICE7NEwa3EuZtOzakpJUeRD7PXypEk1N1iaiNGP81npyC4dnPTlRCXc6v1MomhG5t6GgUxWF2pFu1C0FbI8HeV7T6sBfdaVZHzp6rY6S/8meQO7vkEkTRIYNq4Wr3ZSdhSXqlyHFtIthigApsAB3Y5ZZ5SR0Tz1oxze3YzetNKfQR3MIQf6xfbX9zWihcPOTUciQiBP6ZGHNLnKRZ1s/Fb/TonrY3ifMMRQgNVt2auwg3zdd0ceFzyKKVjQCbkmsmQp7HmsRe5nVkGUcEYwOhAtyyvFcA636P2TtNRv53PbWqE/ihi0cqq6HhBXsB6xhcTAWf0KMxLTR7nWT5ZdlpPONoL2I=;4:InGY3unescMm3uQY/6no4Xe1ZKYj8IAMYN+uUGYoURnrdeEGM2dEyJRCpbYDRFKtkb1GqqR+tx1+vQ9Z0V25D41Zi5yEhA9XJ+TbgeWgKb9Gz1HWYPXssUmVpezYq1VYkfmlA2zlOiyYU7/K8/phHm2pkSzO7QIF1kf61Q65mVS0gcjR6+bj2rkFfypECbM/ONt9a+Qeshkfg3jWHKzm3E/H1vsoSf9giLwN8IfSvO/Y99GZEsG1Av+FQznGejZdrxbwpwACsPGDbJD1zaeEfg==
X-Microsoft-Antispam-PRVS: <BN7PR07MB43726C46B293473EC4F61236E3550@BN7PR07MB4372.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4372;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4372;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(305945005)(6496006)(25786009)(11346002)(446003)(33656002)(39060400002)(33716001)(7416002)(4326008)(316002)(110136005)(16586007)(54906003)(58126008)(33896004)(5660300001)(7736002)(76506005)(105586002)(16526019)(106356001)(386003)(8676002)(76176011)(47776003)(26005)(68736007)(52116002)(2906002)(3846002)(6116002)(23726003)(486006)(42882007)(81166006)(81156014)(66066001)(966005)(186003)(6486002)(478600001)(72206003)(50466002)(1076002)(53936002)(6246003)(476003)(229853002)(9686003)(97736004)(8936002)(956004)(6306002)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4372;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4372;23:CQMqwv88RRIu/vCsOT/lFCBYZGt+EXrE7k52pdxqV?=
 =?us-ascii?Q?ssuN7HeTp+hua9T4K179qfzz3hYcZf96ZNLIkKP1U5/3ox+ZCtcasAmzUL30?=
 =?us-ascii?Q?vHRCAxmyF6VKUrtNhCUG2AZt3lo7/rAU+0U50Y02TH17CS2KxCdGY9tGvZlv?=
 =?us-ascii?Q?Rz934T4/5O9youuZis9zYJ4i4MXu+lLFfYvPhpHOg1m20P8wn5p7eh1CFngj?=
 =?us-ascii?Q?ZG7jRXrI2Z4AkXO8KnLe5gL7R1lRJj0jyClJvpL39AbShAl4Gw56yn4vH0fC?=
 =?us-ascii?Q?EyCiKv4S7OrCsUMgPJjAFTdq/5/Isu+ArhPw2KhwGgGT6L27BRDhr1RiDosH?=
 =?us-ascii?Q?u1v3f9FaaNQeaa/NL75b4zzzmi+LilCRj2UhNmYpEiEgy2/HhjFh4ki3vsO8?=
 =?us-ascii?Q?5MKlkvlIvPuIM+sQK/14GLuR/ZmrtdLY45c9ii+IkYziIvemathAKqgGA1Lm?=
 =?us-ascii?Q?RshJCTmsaUQUPFCC+3B3G4bIP/ghCUKTjt2QMDbZ6gq1i9SPR6DjlbJ9P6EF?=
 =?us-ascii?Q?t/TvmNIVmVifmSYpcQ735YR+GLvmvVK6psFZOi5rjjmXtM/9hoLrIPA3XDEj?=
 =?us-ascii?Q?UQF5ivZTGkm7njrbo0BtY1UwgB3R5c0ff4BLCE/3WbmkUFIf4AFQMGcL4Aw/?=
 =?us-ascii?Q?i4abMtEGshrubp/GK6gXsu5sTcQw08kAs5KWuKs6PgsaSArkfFNf6F72HjQo?=
 =?us-ascii?Q?xMeB2pWXQtXynhUGF/fAidF3pQq1kWvSNpqc54eAB/ghfkP10og6r+0eA1ba?=
 =?us-ascii?Q?62OmLTDPY40mmzQXNWnwNwe7/CfPjWeXxdqw9L0va7hO99m9U/g3mKchmQWx?=
 =?us-ascii?Q?PjBHKUhE+CIQZ0QP+7QuQovu7JJJI7S6vu+84MRx9bPHiuYj4uE5DwkzYIFm?=
 =?us-ascii?Q?LrEsBzpUL54CoGOlnWSch8BdG3MUYS3j1ZF6rXfJKt4MapSnzhNERSe5/r8N?=
 =?us-ascii?Q?ZShAo4HQz7VDd2HU0e2nQn2L3xZJHDDFtnBqOuZv74BL85T55yQb6qexBC9H?=
 =?us-ascii?Q?YhWgSqjFoT8HFkpezv20jsYSi1Gke4fEAyWFPwj7EWdR1RVD0d1sH7TPgE2v?=
 =?us-ascii?Q?Fkt11C91vD0CVKWApNuVO/ig6Y1Y6EOJoxw/NED6Tzmv21KvsqqujUaohs+9?=
 =?us-ascii?Q?qUe/DStLYAgSu4Cnwucu2mcXm4wdT3KoI5y8tlyGB4pHQNnqYtNiweeYW7oo?=
 =?us-ascii?Q?x99KeUuIjTlbE3wQDFctMt02AB9Rv8J78V5A2gjcoZUQPBJEjjbJtPRWm4/o?=
 =?us-ascii?Q?ocFPzDO7lUugnux+JT+5rRzU/G+oHsdKxI+wR/lG7EA+04ebXM+M7JKBsYsY?=
 =?us-ascii?Q?NsAPWKhhimwAxnWeNqA12/m12XEnRlJ/eSp9Bo6MOpfofZm8RGcoGsIJf1jp?=
 =?us-ascii?Q?5Xl/456OPT1rniTeHo/PDy+I4qKaJtsFZEsGyF4vz9am4L++dT92ItQ6P5NR?=
 =?us-ascii?Q?x5jcNK26c8so33RkfnXsEgz8l4tVD3nlu+rSUgM3T/4+Su6rDpU?=
X-Microsoft-Antispam-Message-Info: CG8r2gtAdI2G0vHsMkB89LA4XDKXDQXqPaoUgibXJaAmEpYioLnaRnbzxdxTeXh8X16yjP69qlq1mir1FZyeOIyEMrAec75tpGGVnR6QhFXg4m+pzHmQqInSD4lOUiZ/eL4sw6pl0vcLCJqjY9qBhMneWyIKQO5gZxqWOxHLMOgH/feWFczr7/202DEc7Ke/kRBMumpRbE2/aiTtPJwjxg2Jwgn4qqmFYw7Rmch3D15gJcPO39HPaRn92c80JCAgduJhh4CSCZf4YZdsDZcAX3xJYfDpP17qknheVtacWXWzoVTK9bK4UXJFet2FTeBgc/i01MWONB26fPekhbQgHOHsisDYbUr9vSYePN9gaiI=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;6:RBDItNUv5uFkzX18a3Jya0Nyy3aUYNXYaLeWN0kFnXzrmAep0waHCiu+hTvqRb2NDmofOwzwrp2/+yJMJe5tI3cR1wmzXgN2ryeyaCBisOlTHNoapL08hL+Eyj82jCH/kS0psWM4IwhV+mQwiSAhFp4Hbz97OUDvNeqvY9BZmMES0LS77E8+YDXEWdZwhMrhoHTNeGT7GyjASd9hkmj+wsURrsTrV5rjcLYjtIxnDRr+qJcqPJguKpTrd7gfRaFEStIpjJim7v7potHHKRzyfqqNVPHnZrNTgJLnOwPhKy7gG+rYFjoo8pN0akMv46jZl4Ketj6Ly3eivhQQ+Vd6Xchf0KDJiS97T19irMoTP/hN/e+H4SyuzwTf6gXhLn2xJwc0MoNe/oifNj5QrUfR4i5cQmj0g7zj9tBH+pkuYBxdJAV4zkNIWKCTetUl5mQwrPk4SuGcNuvvlP9tRu/ZZw==;5:cgvT/pmW3sueXhuUdu8vu57FFxF2BJ/vlXajLiWpUCmmrlZNe/hURdjhkxzxaYu2Nv1y5N+DVOp+E7xpEwvbI94DFnH7OpBYcwDrH2WULiWDxbKN7n+w1UTPYJXQLKxA3cibPHogUiuR1Np9BusMG0L9fJGaIaFD6KXAlQGs9tM=;7:y1VCBVofsgQj574E+t96O/qezYgLB6unS8t5OpcromKxqSGrkGkYYRSJpZSVgZictssUExLLkN43kJ8L4TFp7TDyCKFtv8YbkKUnCGe5qsfWGm9WnisU/cfEMTL5AwwPEimJZiP2VLntSspnTKF2UACPaqHqXQkO+PWhsxtPCfoL0qEO6Z+uKzm6myXjn4ocjUp8UaBFZkAtfQVuZSi73yGuCbmW5zQnxOv7oBB8qJZHv7Pz2wyKL2kdGatygM4B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 20:27:39.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af36f3-3469-49c4-53ff-08d5f1a3e78c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 10:35:01AM +0300, Yury Norov wrote:
> On top of next-20180622.
> 
> bitmap_zero() is called after bitmap_alloc() in perf code. But
> bitmap_alloc() internally uses calloc() which guarantees that allocated
> area is zeroed. So following bitmap_zero is unneeded. Drop it.
> 
> This happened because of confusing name for bitmap allocator. It
> should has name bitmap_zalloc instead of bitmap_alloc. This series:
> https://lkml.org/lkml/2018/6/18/841
> introduces new API for bitmap allocations in kernel, and functions
> there are named correctly. Following patch propogates the API to tools,
> and fixes naming issue.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Ping?

> ---
>  tools/perf/tests/bitmap.c   | 2 --
>  tools/perf/tests/mem2node.c | 5 +----
>  tools/perf/util/header.c    | 3 ---
>  3 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 47bedf25ba69..96e7fc1ad3f9 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -16,8 +16,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	bm = bitmap_alloc(nbits);
>  
>  	if (map && bm) {
> -		bitmap_zero(bm, nbits);
> -
>  		for (i = 0; i < map->nr; i++)
>  			set_bit(map->map[i], bm);
>  	}
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index 0c3c87f86e03..d8e3d49d3638 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -24,11 +24,8 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	bm = bitmap_alloc(nbits);
>  
>  	if (map && bm) {
> -		bitmap_zero(bm, nbits);
> -
> -		for (i = 0; i < map->nr; i++) {
> +		for (i = 0; i < map->nr; i++)
>  			set_bit(map->map[i], bm);
> -		}
>  	}
>  
>  	if (map)
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 540cd2dcd3e7..3a6bec22baa3 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -279,8 +279,6 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
>  	if (!set)
>  		return -ENOMEM;
>  
> -	bitmap_zero(set, size);
> -
>  	p = (u64 *) set;
>  
>  	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
> @@ -1285,7 +1283,6 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
>  		return -ENOMEM;
>  	}
>  
> -	bitmap_zero(n->set, size);
>  	n->node = idx;
>  	n->size = size;
>  
> -- 
> 2.17.1
