Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3EECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73202084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="FPbcvHwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73202084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeGSVpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:45:07 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:39360
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730301AbeGSVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRG/NLrqO9GCsA77xjAnZEU5S3Xd+0Vx94Cx4AsKVEQ=;
 b=FPbcvHwYo0fXw04uZ2mqYJIlFbQRjGw8NJmyoiadY32OZnqC1+FfbvPQRE6srWG6xP8vG/9mhemG9/YkDxE7D3VV9fOBOaztO+JguebOgc45ZT3007ASdBGS6xz8cp7XKVTu3ngB1KXxbYqhHsANvpZurIB9XR8wLQkCjcdPeSY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 21:00:10 +0000
Date:   Thu, 19 Jul 2018 14:00:07 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Maciej Rozycki <Maciej.Rozycki@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Add FP_MODE regset support
Message-ID: <20180719210007.u3ddehsxb573avli@pburton-laptop>
References: <alpine.DEB.2.00.1805111326000.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805111326000.10896@tp.orcam.me.uk>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:a03:60::32) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b322a4b-c0da-4443-24c1-08d5edba9dae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:g+MmnmFKMFsv2gsHLyxCgOcX/Cbvm2hRV9y7SSFFLhbzdpxLbcC7Km/0hFBoj7/rdeoGWUQyyIi+49EYZRlEioE9TKvYYveefV9zTIsw/x2QBcKNL30/OfOiE3XLQSr/iJScA43MlfULJ8a2jEvo4cwzba0TAkoUDC4/jAC2YcmZtQNs/ZnVoL4W4HzdfEo/HRs5yWEHWmUlLxkcshgCZR6au/33kW4x6qiu+hXL+RyEYTTbmM6LoSLz7i5EDL+X;25:kDB0ncImqHLDlU8JZvT8F72L60YD+I0pkvF/0RAHmUSdVxRm5PaIIH2oXjQ1o4G1h/7wGMON0yz7RQwvwP5GVdwogjM5NGxIqPu5ZKvnqL8H68bIss0X618SZ1B2gM+/pi/k8QacFaBnTjH3/zir9gAazrRio7QwDpPUCUzK07R8XE+UXrSJ9weLooPT4t7GUsFjJVcKzzmaDSt6W/IPL7niZTqManuetBOUP9tH73D+tNIq3UZ35S/r9EP7Hz6+CXJrxhuDvAGBbDuBlK69FbXWtNBsFKof33Qe99erj9Ujtjc+rPqgZAi/H4TtvL3FLSuB/tsrkvrDNyVXOb49mQ==;31:RZsTL+qSI0fGd9/cYfE3OEUG10VecDLuqOx1fW38txRNi9y3dJKtEqQcEEzzwwLqsFOxA8z2R1YrK3jYe0v6BBlYDFHYVf3KSN2VwVLuKM3TyXIB51OznMZ07Gw84BsZcp7egUuOa9H+rohaqGbm7Yy7OJCimar4wwj30dRzJOgNXQoIzt4xFqpX6nMxJfbt9kEt+BDFfFFBbZF/Fq9rVlORiO5Ym/LFS9tAWFVr1gY=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-LD-Processed: 463607d3-1db3-40a0-8a29-970c56230104,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:+JegTNtmqMXSb0lUUfO6fVec0N8NzBPS1oIbhV75wEYozWFSwhWLLRMmdtU7RvG8A711yKjXohh74hCFucW/7pyVBsxblUsvcv7hd3LIjB6w+6/ul7iqlxY9IWfYVeu9vPkCftA+AKPlKYSZpQWkwz/7LEgrhBYbimLKC7xTExLOKm1or0N32Ps7vQLbYhJe2oGLgUUnPSUJ40IljYCX8EGyfnQuJlKmY+luh/vuGuoq1FhF897PkonWHzstXEiz;4:3AKTvgR7SUIExZAvU8buPFpd8CUXUKyicDx5+A8axE2iedtSxo37TdEXdDdcs6bF0E1P93+o+S02GWNJbaz5ac6XUi1r/ssltvVAwzCOIJJniNC6xuAWw6HQrQlNNWdbM2GVf4R/wv6HAvgPykYWfu6rB/L/DptepjnehjppLqo7QgwBUvbQWte+/wm1b/tCApr5Ey72wzc2gFVmEACXaAgJNQFR4N7h3uzOz/EyRvaOXkEZ0I/uhzIXJs2pryjI0a+UNHAb3pbwE0Z6AjATxg==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4930F1DCD8416FD81E765E6AC1520@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(376002)(346002)(136003)(39840400004)(366004)(199004)(189003)(6666003)(5660300001)(68736007)(6636002)(2906002)(50466002)(33716001)(81166006)(53936002)(81156014)(76506005)(97736004)(6246003)(8676002)(47776003)(8936002)(66066001)(305945005)(7736002)(25786009)(6862004)(106356001)(105586002)(4326008)(6116002)(42882007)(229853002)(316002)(446003)(11346002)(6486002)(76176011)(16586007)(6306002)(16526019)(9686003)(58126008)(52116002)(54906003)(44832011)(26005)(386003)(33896004)(486006)(23726003)(3846002)(956004)(6496006)(476003)(1076002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:0aX/sm1hx9E8qisonmFwyW0wQObEJWkq59aBRhkS/?=
 =?us-ascii?Q?KBfRyCm4ljpyEhJ0FEd5ovV5FxAmSRdxD+mzh8n47TVaFKO/8BQuViF6ZHXj?=
 =?us-ascii?Q?5LEzZlE3C5dUojpfYcRnAHyhJL0WKl6RPqmdiKnExFtqiHOo5t5epquCbebh?=
 =?us-ascii?Q?cs0cazA/2AsXo1ZHfRGTmCo07lvbvouGqlW6gbzmSDGUkLWZX43qnn6nqycD?=
 =?us-ascii?Q?suLp+bWRPhaV7zKcW7h93ZpgGruPB6QfmHKWuIxEilRYWusuQuVauHta8l9g?=
 =?us-ascii?Q?bRsosf8n1wcmxMQ54PIPPSxobCikrcjOjLth6mQmUd4lk2ANPMG6otrwKpxG?=
 =?us-ascii?Q?JPvPato7kJfLTPshmRnRIWlB5rp6oFSn/eUMp99ytKTjsvwO+YgdzgDCiZiq?=
 =?us-ascii?Q?Ng4DX23b3QD4uhKBj0J2YlqGnN0btHxFfgq8roVud5/TOjhpePieff/vIOK+?=
 =?us-ascii?Q?Z9uz+WbDtXQ3me4E5FZZ8H6h7IG+wcUxp64mNhIuw+Xuo/1ZdfSJ+/Id846S?=
 =?us-ascii?Q?kZMU7A4aJTlgKRXlr/xpwiMrcxraeDxYj3m5VZJDOfT4j4ooS8xhtQg2QGVI?=
 =?us-ascii?Q?4udXOW7QzEoHBX8Vu5b6Oz8TIMD7zvbhJcTpU4lsWXhSVXps7TygGEEh1LEx?=
 =?us-ascii?Q?osu3CRQHPx6D+YQKccUQPzcMjoWZGc+qZeOnWjwp6KRNcw8kpugQvenmsPBe?=
 =?us-ascii?Q?3USlAcr7b3s/7tMXvCvB4y9eSsztv0Y5Bl7FRw009beC8K3YcHAujusDvFtF?=
 =?us-ascii?Q?qqfOC8jfRpNvuswwjJgLbroee6ITmWNXnjC164OgkXSvCFlpYp/3ba5ik8fU?=
 =?us-ascii?Q?dDam69yinUIqAsf9IlQN58QU+cV0ihRIVdLBEtnZoiFE9ZitkOH+c0X2icp/?=
 =?us-ascii?Q?ndrBz5O/GoGmWxqPWG+rC8nifW4X/CIIJPhvcF0i6qsPvMDBJSb/YRGcvqTS?=
 =?us-ascii?Q?R9nM6RdzTLif//+JYZ/47tr0CDZTLH7lND0BdxmMBNM+CgIsOl/Rb1vKzVfq?=
 =?us-ascii?Q?MJ4RHsMdgP6h36RUV175ta2tdqSKMmRwAaRXFE0pss2H484uAH6b1KtpuLYP?=
 =?us-ascii?Q?rsElLnBwlGmU9HN2l0jNP7jMMnLbceZlAnW2p7X+/gc0HtdTyb05OfZEtDij?=
 =?us-ascii?Q?qd+lzro7ZQNXIsjc0+XnFn1EuvfCEccte5o2kqzEncxKDQt3rcXvBo+9MlaG?=
 =?us-ascii?Q?fWtyWRAr9CfOo57FfkA0oj2OEH//9YB5kwQRRCL0a9sxhbeqmqfO5PlEgXrd?=
 =?us-ascii?Q?CRWOic8NYuM84FsKpNIH13K3Nh10+heWG2bwlArI5Ac+hjwoKbHiTsFPmKKe?=
 =?us-ascii?Q?UN5AkXdUdMcpl7ga5onfcLK8Z2mbLIshuM+yVGKNgUC?=
X-Microsoft-Antispam-Message-Info: LtzcbS3OO9+gO7E1Z2punCR629crlRaOR7W5JGdHMK0JQ9pbZe2uqQWORF2LaTF6tWZ1wbpGiTgl7l5qz/8s/z53/iyg9uyo3xIluHAaFAGUSuMHuE/2elBDs3GfsFvgC6GdTjt+uJsXUJkTuL+c2GqUJLPQL4Yg2fovJoTLlo/a4LUlECbHwPZZsW7Xso9EvmQvFcVwmApIzdwvcey/V9+KtLj3s3Bm+PmgatM5NoHdcUOKVNRi2R0spOs5aqnJxeMm0NKjUUXKoUAXpG/lLlTZ39kU+ykm824eDR6YUu/EcCXZBaTJwaPT8j8Q0e8dC7zmjmW5W85LbUvCwZVAnf59t9egwDn5b3B+YQpMNAo=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:dkYPHaRJBx2r4l1DHlrG+zRa9smU7WOtRvfkXOKvJKeO8hxkwaDAKMZn5iJlANsEl0saEM/wSyAD+ihbfq8J4FWGDCnpu9jnt9I3pMMkdfqnFrU2JesHZmwQK8wbZXlxnFnhXPUdHvlJkDfrigLQwuIVU0m5DvC1U/ukoEVatXWx3VJnZhFAPX9Ey7GNtTd3fvThEuk8enqanUsBZTn8veRx4KqkHBmqcHb8C+koZpbdmzVlCoMDBBc8CpJqXGUc2AYeMaY/e4iNMbhAqkjVScWLilnX6MkOxTMUmBfKceYrBDcm5XqThcDhe36IG4veGzRR5+aPt3dDEvWktRkThkSdZA7xN20vmT+PiV4FDQUqanNEvRyAlPhntof61ohBonVDsXM649kCF6sCnOq30qQC7CZqY0pq3TwCbLFJgUrY742RuT3Jn8pi4GJFgDdv6E3OWi9lnMKq1o7ksopSvA==;5:EhCU0A565kivcKWzQvmhZbKV344/PDMPvh4mDNWrgCHw4DuJUIPB30gLA+1h0R/U2XLYI8dxrCX1b4ai98F1ecH50SKgb7zJTDdEEDzojVPnPbyP9pbvbi38eUKs/aAjWqHx+2TqkZIaN1smdiWDPtichKVDXPCtCiZdo8rFxw0=;7:Qa9tpP6vc7c/PewhP0GzoEXdBX2Im4R1nctfMSnjzbpuA/4x2w97l2YYGLSdXfRm8QRZWMpoxpA7jFqzY6wJX9Nnf4k7jTkhr4IkNTqg6qZKnjidv3ztPW18OBnidVVvMeWewWR4EbAKQ10H/W1SHp94KJbK2n2IKWN+9tQNrJjXT2ehaI0Ay+/wxP6LnfC9FMOVdLrfX5J+WgHBFpYYk8ONH0PlxOfCo56U3fDeqmRTyPB0nMz+MW9b74aM1fTc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 21:00:10.6366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b322a4b-c0da-4443-24c1-08d5edba9dae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Tue, May 15, 2018 at 03:40:18PM -0700, Maciej Rozycki wrote:
> Define an NT_MIPS_FP_MODE core file note and implement a corresponding 
> regset holding the state handled by PR_SET_FP_MODE and PR_GET_FP_MODE 
> prctl(2) requests.  This lets debug software correctly interpret the 
> contents of floating-point general registers both in live debugging and 
> in core files, and also switch floating-point modes of a live process.
> 
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> NB due to patch conflicts this change relies on the DSP ASE regset series 
> <https://patchwork.kernel.org/patch/10402171/> to be applied first.
> ---
>  arch/mips/kernel/ptrace.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h  |    1 
>  2 files changed, 64 insertions(+)

Thanks - applied to mips-next for 4.19, though with NT_MIPS_FP_MODE
changed to 0x801.

Paul
