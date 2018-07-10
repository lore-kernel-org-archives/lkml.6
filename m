Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B47C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE92208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="q57inJC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE92208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbeGJVOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:14:21 -0400
Received: from mail-sn1nam01on0116.outbound.protection.outlook.com ([104.47.32.116]:52231
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732265AbeGJVOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ/UGJnA790ufD24PhH/an5gJ7gGWrF/cer0D3Gjcxo=;
 b=q57inJC34WCbdNl+fgyv1SzPHYeFcjdBaqvx/dR16gEG/sQD2UGQM4w+H+vcIPv52BC0dwnJhsFxFdyf09jogwkUcnG28nFPJDyJckbypwO9W8DkhqLXRi86YTOMWiWdGBLIqWudDSH/hqmdCK5RtOJlTgcOkI+LTZO2JuhCIU8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 21:04:18 +0000
Date:   Tue, 10 Jul 2018 14:04:15 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180710210415.4uqstovovdfvxfup@pburton-laptop>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
 <20180710074815.GA30235@mobilestation>
 <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
 <20180710191354.GA32182@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710191354.GA32182@mobilestation>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR19CA0080.namprd19.prod.outlook.com
 (2603:10b6:320:1f::18) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be8a44ec-860f-4bf2-d776-08d5e6a8b3b0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:2j7LJ0jkc7g9dYn9fUoMHqf4r6j1XrVsVm4JDUZtZiDIFH+BQs7TVH2K6g5yK34IWnx1oFN8sB1tV6Axih7aqnYpDYE6mPtfeBSAT4zMNnW11Ig1CC60+hOwjgKhhDkZmSWhjM5zH2mc45WsWRG4VjJRVexb6rlrZqVf1dDhJ+Huw8Y5iXTOHZDVTgfdeSxPwd7zZ2pajKKYNuIFmHikDxiNMfqhbDfBxFQqgh4E+TV+q4j5uzTGXYwL7rxU1yNC;25:Fu+GrhKLZuoUHfTLRxmDCJ9sh9YE+4dMy86lblSlSI5Y73FRHgar4D3dlNBcd/8yjVek2ZLTMzkcdJUjwbVHwbHqOUIIChHRoQ8h7OHwC5x/CAwMZxANaQ/66fHX0Rz8xuDfbZBfN/PaIM4yk+3sOSOhKuyacDHtiBd1Y92d9yLPc+ooVYcA7gEPjn235zdUdWETvLfrzsX+NOlAhqc3tDwFMle+SZbqmrq3ESVggE4dGgFWfcYVLzoJqGXP3OGQlj6bMXFz5n9rLc7EF7k4nWm2XF2I64+XwG7lJFfpKK9N5x8oABDthG9QjjX2hKopbsqD2bbGLyICyEg6x5aHQg==;31:HF4x8vB7DAAWu6xFlWhsyiDLBr+fjp5pF3TKZ/esBouvLcrd4JgVd4mGOkPwOQZwX+oZA6Qv21xlPd1Czi+eA2KicMG6xVd4BXK/kMa0yu55c3DgWlfIpElOL3ZEm+b4G136NzFwL4OuA93k6PSL6PjrDqfe90YLr6ZjPRCFh/QRi19uCsJEJh/L1435NM5Z3xGxc6GrMqyS8XUpnGDWn4Z9tBv3lsobNaQVktQCYTU=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:hX6WAF0e5wEEV0Wa9ABvgBQJDM0j/w7WKm/fYSNwbG5TMjbRsTT8Qpdtjwn2kZupezK6WKDozsld3Ss1tk50HmOTMUq+VFRtT67QJSUDH4vSqJiKhaIFQbcpy+gIRT1y0XELQJJmnF6DoF1CgQzaST5Ik8LNmYS4JY5/3Q0MCV1z1jzOyD9uzykQb7C+9KshCOW10jdqvINjM0TzAxoniZcgqXk75DwU9ENnkrrc6aP4Z7PImlCN65TJdE3dk4Mz;4:zcd6p+NEKz1laOJDYMEt5oj9bQPrenGp1868iKuRErqq/8KAI1hJGHr12t05xRzY1AiRYydfR/2esWklaYb8TCH5SrEvd/+NlJss0ufV2P2oL5cb5bdquC7qsXu7rV1SeGNSbbOgNGBMS9/7HIaB9oP11yMyO6NSeoV21SvH5FEZmOs6ln9irMCtBixysIDo66hSPiNNHAQymz+FlVeSOO1oMP5c6lgrV1o4TwHTM6voL5ZFcHvOHJNkZG3ezNUtl/1na2ctikkPizJeXul6Rw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932BFFF11937C659CFFFDAFC15B0@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(346002)(39840400004)(136003)(366004)(376002)(189003)(199004)(69234005)(58126008)(53936002)(6246003)(4326008)(39060400002)(25786009)(9686003)(97736004)(6666003)(229853002)(66066001)(446003)(11346002)(50466002)(54906003)(486006)(2906002)(47776003)(68736007)(956004)(16586007)(44832011)(6486002)(8936002)(7416002)(42882007)(26005)(7736002)(16526019)(186003)(305945005)(5660300001)(81166006)(76506005)(33896004)(105586002)(106356001)(81156014)(6916009)(8676002)(93886005)(316002)(6496006)(76176011)(386003)(3846002)(33716001)(52116002)(23726003)(476003)(1076002)(6116002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:VgZqLy1WVyp3r/qhK7eXQAyF1/+jFg51qdksToINT?=
 =?us-ascii?Q?MHLyLh/o593AlUZqHIhAVTDAGQSjF1+jBbFGnLLo26dEkbxTLFllu+OUefZx?=
 =?us-ascii?Q?eivuthWJ3vfILQ9g9mN4jbz0clVfmiXd1BoNH7QgShhAIBu4p1hOKEKeKo1y?=
 =?us-ascii?Q?49MIVmmzZrZ7v00rniAEWk2wn9OCK+1KaTfxxc3a91idz48ZoySe6QE9fN3x?=
 =?us-ascii?Q?kmw78bHieOvT40t91OyfGHVKw+akYhEnlGTnXpqKupPZbaxbkltHqh52R1oV?=
 =?us-ascii?Q?CdpKc6lbvdJYO4x5srBY8v8GfahORZ225ksfRBylAoE+mDAT7fL2x3dX+aj4?=
 =?us-ascii?Q?ci7vFfpgVULPH7NZxB0v34AxbwiDoJ0i7TNRPINuR0FK2cpqZZ5XkoGvXUuV?=
 =?us-ascii?Q?bIMg984DVj4Qwbgl1FBrv9fwaIYqjVD83DnAuvumhgejfjx1tNJ5QsY8Icsu?=
 =?us-ascii?Q?vraLbaz4z9TEDpqF2t7ZtNONdIlzAhEDAp0Io2gkNGLVHC1QIbbE4n2l03ak?=
 =?us-ascii?Q?/nxSyQ6IxfahTBWXr48viX35abkbS3t+LNlmr+Y9NtPwCP//YvsAeKABk8zL?=
 =?us-ascii?Q?BocHqNFdDVOQjEnD13XSiXoMJynT7vqqunro9h1V6viZ5sazjd+CAXuA3ck/?=
 =?us-ascii?Q?DEkfN1+zypXfPEVbM93BknOfP6YnZDiWfuwNsq0RIthGQvIPAp/jp33Wa9rV?=
 =?us-ascii?Q?LoRu/G6CBvXinkdAUHqwljmmniN3ReJYyp1s37ANxyV9vcQ+cbVJuRYOoQXS?=
 =?us-ascii?Q?ICemecDInrBIfBlR/xYyguHigLivt61gv61D4S/AMyCZQRA2EPKNWlJNwWy0?=
 =?us-ascii?Q?Yu0UnKO+0ziVknrliSuEukVjZ0H9M8OC7wV8tyMcHu0ZtihUrD4AA/74fZHr?=
 =?us-ascii?Q?/ra+/Zd+Ce4bH9cpqeRD2paaLndors4vcKHcH2ljq6vjMj1MWrpNX0DVEpUn?=
 =?us-ascii?Q?wTuO3sTX29XwOIUBHSPqwmb8kYrl4+JYiyNQd7l0hvk7Fh1rssJys5YbLDvy?=
 =?us-ascii?Q?vQlt6p4lF+gA13UeLHjQ8v+TZMneD1tFYpMbjuz9JgXqWxPLdwO4eWJRfAns?=
 =?us-ascii?Q?ABqygTJV90DVdN0GupdXgWNEe7XeeEHk/gftBEm19YyvxAFH4lLvQF/Dh3Qk?=
 =?us-ascii?Q?Hoft1hkcfyzKnn54EVZoghKM8TiNZpvmROSwsxXBchBAVphEfVZq2BLpiNJE?=
 =?us-ascii?Q?TJYcN4ynVh6f8YsGLaJI7kltl6I6gxjzS2xKiKSQ+d/r7HiapBTIcSzGgR2M?=
 =?us-ascii?Q?F2aoFVGCVseQsIhOF33iIsZCprcI3fOkvbGRYJBLPgSjo4AalO5fbL0M9IQg?=
 =?us-ascii?Q?vm4sIZreHiYQN6LlhKKjdGhr2ZCpw5Sa3xL/EEYnEFLaQHXjZ/WI4BqDoru5?=
 =?us-ascii?Q?K8ix9yVDKFVJ9qa7hmzZJUrcmUdzwKkWZ6kDh1WC/S2b3Fk?=
X-Microsoft-Antispam-Message-Info: l3FT0Fr0bf/0FeuwY9Z07A9wJIwqcDvYJd1So+7YKfZqwyWjlMy2mDnD4ozB6HnsMklo3d0KjwMAKdNqI93qCAtBHYrnFF1UVOuJHFdHYXpBAO3QzEW7L0AggKQpee2QlLBTZ6eNjRdocUIy5TIlrZRh+k2/bE2otVuZtbID2EKOcLdtzq28NmNT2Dloocp/9Hjel2SlBqxvyBDjbclsxjDW+CNuM3XMtpACDVAT0zwrBTT2B/aXSjiA9Q/8iMOMl5CMynUnJYHBy0woPXbaOXYPEu7tl39o0n+YeKrNlWJF4czx4WwVfNNosp6fj5Rn0xS4KQmqfZzmxDV/sHsCpNCA3PchmoZTi2L631d12n0=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:6J6sznN8LB/5ymMCIlDd8zynbMWQUNCTF0Q8kFDJJosBvingAAIhBry9sv7mqkKJVlIVZqy06qKcBICqZe3P30mYgRS+X5ieEE4ojT1MxGAnB5bPIy4bu8esR0SguAdCuVXKxVwMq015xcqa05qi5jjCsx1+rGIl4ofzeSroDxlcdGOobNqIC31XUA0LGJRhGyVaitwY1fExSldOkI216CN9d9DFAH70h/rl1V2d4eYeDW2Kb6qI6D1ItaFXo6kXLYwQ6hqN+HOVzsF0IFtoYFIvHLinlHwQ5JR1K7D5XN0dbPJxpskZO5inRnHritJhzBq5Ory1cEdSP6dYgmefBgH6dR99AzcvesitAR0nZ/ipW28cXLBqJD/4k55lY0St5J2dHIFKSnbhedRWIqgNQ0m4wdQUmarG2r7KIGe6UBMv4zFy3xdsoxuo7BjGfy/txJLLinGwTFoZjG5AN98Y2A==;5:kTTe+YbKDgVhVK5sc1rHj3F318sg4/sS/IFUJWbatdZHX+D3bmaE63GEctBvjMLtkaji4yXJjwxb7XchuZtKMgJK+Jjql9v80LxCDGxJv/XQQuOFuAQKNsDurs4ZSLfM+0FsWp17uvkYALwMRY/o1vMghxkawc79ITElUOpRAZI=;24:SU42hbFfj2T+7lepu9syNP/aoNis88rzAORj8YPG218I9AR6UhnS8DevBBZf3hCLIZkNQRHxebQXNTKwUW+2f6FdYdRnhZh3QvkcxpF1eNU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;7:eOfgABUY0CN1HigFRjv+je5hbwOzYkKXUwjyF8ETTB+BDwyG06pmsDRNljN+CHiV67+jPMIxRZmUVPvyL+ZDzb74tCJmuXYmnMcZ2NosXtM5mUVPE79btIOManDYzJjEOULOinTmAFQwIkT8T7Fb3fWG28+t/XVNvkrpQZLej4H6eKifQgA5AfnlGGOI69qqgi7z56QoBEz5jzkP2f8W+BXSIMeHSa33th0gG53HJy/7bVXAI8eFrt2aWp88Lwv7
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 21:04:18.3898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8a44ec-860f-4bf2-d776-08d5e6a8b3b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Tue, Jul 10, 2018 at 10:13:54PM +0300, Serge Semin wrote:
> On Tue, Jul 10, 2018 at 10:59:40AM -0700, Paul Burton <paul.burton@mips.com> wrote:
> > However FYI for next time - you shouldn't really add someone else's
> > Signed-off-by tag anyway. The tag effectively states that a person can
> > agree to the Developer's Certificate of Origin for this patch (see
> > Documentation/process/submitting-patches.rst), and you can't agree that
> > on behalf of someone else. Generally a maintainer should add this tag
> > for themselves when they apply a patch.
> 
> I'm sorry if it seemed like I added Signed-off on your behalf.

That's OK, I didn't think you did it maliciously :)

> I thought the Signed-off also concerns the ones, who participated in
> the patch preparation. Since you suggested the design of the change,
> I've decided to put your name in the Signed-off tag. What shall I use
> in this way then?

In this case Suggested-by might have been a good choice. Reported-by is
also commonly used if someone reported a problem which you created a fix
for.

Section 13 of Documentation/process/submitting-patches.rst describes
these tags along with a couple others.

Thanks,
    Paul
