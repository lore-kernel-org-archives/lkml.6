Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D050920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Amc/QKSx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iFXQcE9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D050920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeGSTB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:01:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731636AbeGSTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:01:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6JIFMvn010636;
        Thu, 19 Jul 2018 11:16:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=j3jdheyJBtn5Xb2+Q2JoBSEv6QuRugxnLyi6ER1Bqy0=;
 b=Amc/QKSxSToGjJNQ9cyW9x2uGLj7T276RO6EEYSH+Pk5aIQQOPQo9QpfUZJmH/WcGnbK
 gTcVlh94M0KmT0pl9t2k0YJNQAAdTgwxeyybiudVXgoVusL5h/DpCZRvWxhfWL4izxC6
 WjEu8qDz67deSPzq00Zb+ZSy7sqkuAcNJEk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kaxbsg8xr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Jul 2018 11:16:31 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 19 Jul 2018 11:16:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3jdheyJBtn5Xb2+Q2JoBSEv6QuRugxnLyi6ER1Bqy0=;
 b=iFXQcE9OaYgT80jorBM4O7mxsxX0OLXwBLQOXYvAdrEx9tEtlgwylujucvkNiTurRCUvMiBMYEz21YealLdxgcS/6NyNKAzUaZqe/d1zcxUkK1Z08wfB4RFkRHLKdatN46sc0cG52w5Iq4if833plme9LvhoOcCfCQ6KCGw3uUA=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:b6f1) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Thu, 19 Jul
 2018 18:16:23 +0000
Date:   Thu, 19 Jul 2018 11:16:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/7] mm, slab/slub: introduce kmalloc-reclaimable
 caches
Message-ID: <20180719181613.GA26595@castle.DHCP.thefacebook.com>
References: <20180718133620.6205-1-vbabka@suse.cz>
 <20180718133620.6205-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180718133620.6205-3-vbabka@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:b6f1]
X-ClientProxiedBy: MWHPR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:301:73::42) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b133f41-b636-4fec-5dfa-08d5eda3bd4d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:WdgtaeFZft1nbjgeYPVqYLbYxjYZP/fAlKS7x7JO6aj0fQMkGoAcwASIYPDlQ5DeMj8RGqCAdeoP+9iyAehfAlgBW/RsD3xWqP03moNjLsPalGGz7rF4RI6Zl06OvJwM010jFUsL6wH6MXrjak1+WClbYoY+y8g25Qi7mhT8LGFZIMuXiu4NrkJx1yleUyqDy7s6y8ZwslDyZiW6439Kd634mQzmqHchw0AKnCNzP8DmpPENRpZOaTQMDLYoOj6k;25:oF4AnaI2wgledQCbEGSMFjrwH6MfC4O9FFBA4lH8Jbck28MLjjKnJ/Olo0HLJd789qFBkpNzBZFQsdKlB+KU/hj02kdOaFKR3+mLdbqkr52JI6fx+/fqGQHUSNMpyJRKi+2861N84/1cxZbIT+EkNrnyJOqsuJb4CIB6wVUpsD7efN4lszc0NVc6GUcxiIm7kRCc/AoScK2uMQ6Ma+Zds1E0QtfxyxecHVj10FU1CHqa5H8eC4eR49ytSootoRipudfpK/EPneSOXzKnE1qlj+2fRjO47C1V/ENHMDnBK7LAjAjpnwCtHL5Z5et6ZXpWjopcvrB76hDpo6q0GpGuEQ==;31:WaohmMY58PgACUfKTGaIuCjkpICa6bNg4Z43UkoJN9Ap5XbGNpAggk/m1oDiYKgjl74YxSkU88dgGrXMA+C4tJ5LN92JrAjkQp2/2qKKTUsEvUQHO72aHFDa8fJ6i0hIKmJqIzCYGo4WeqzgEZfv/17dFg9NdU3tdkFwt4dtyyf+NU3hyAOz8zyxLUXkp2+nrB5tczqQANjAdKcB4c/c6wvkt805ZWByA9brwnT6DFk=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:5XsodWoluu7qhVsqeka8Vy/o4J3/nkhCWWWvFu5110lxLnrPgmMzhcmTv5lV66c0Y4+TpzPuyCtkUG6cvKnUUoAtjCyN+k/93AXdRtP9E7GSaqj96HaGxCRkboMY3wZkEocDqjGKLzE+tdO4fY6l+zQw7HCj6lq3SCWhEg0V8KdKp3wU51A1SrR4yCuQulA7ykn8uDNpC01UFIX6taWvIdfLr1sLydTVBYcq5WzMbsEHBcXQV3GRVLnpuVnXEdKBiVeFEpeMfcEHnWqVmO9rTDcASanXAeYoNoQ5HzsFqr1+SeNphBJvOIMNvzFAl8N3/2p12jKfmQUtQal4+sQBZ/ITzBpD3lIdle31fL24Pgf2H/+0Kilb35r4yktWB9RSdZaihEYcVHB1tN/G9zDP0WdV3TVpVbrkBXet4ShooAOBLdbjh1NFNjvFVqEPxFXdLLAju209hAU0yzGcYp/n/hp4ee7rFyjluGoyOibeitCWXFfrxK9WhdYSivaxdFzk;4:3zebMrb1y3AzBx4pn7zoTmMLkwxxNz5sP44DfoG5NkYKuOYp9opIBroZTq7/3Ubx0rJfUCfDCNv8lzdi9yVAnH3JrzObDYqlt0YZi8uHTR6bG6E3OogLXySVjkY/zclWkxJVVK0HOHBLxZOW5L7C5aH7cAyTvZho5PG3wO8CTqFmelCBP1+0hnmtLNGJms32CQFT2SKEWmj40ZqISEdcYcHvUj9/NmZJ1OA2KDSqeq+a1U1qoynA61wOmipttL+xTvEqkcLnPJEQB43whCO74fcXGtxQ2qAVcuDCeKXSOneFRMLGdHWul6lh64vvs+dn
X-Microsoft-Antispam-PRVS: <BLUPR15MB0161AFAD954A7CE0FE300A1DBE520@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(316002)(81156014)(81166006)(4326008)(97736004)(1076002)(58126008)(25786009)(46003)(23726003)(6116002)(7416002)(8676002)(8936002)(486006)(106356001)(105586002)(54906003)(5660300001)(7696005)(55016002)(52396003)(52116002)(16586007)(2906002)(386003)(76176011)(186003)(11346002)(47776003)(476003)(16526019)(446003)(6666003)(14444005)(6916009)(6506007)(68736007)(305945005)(6246003)(229853002)(478600001)(7736002)(50466002)(33656002)(575784001)(9686003)(53936002)(86362001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:zuLhTDDnjGcQr+cmMgidxXtgRGLJflRnwTpr8ue4z?=
 =?us-ascii?Q?92Xjp9vxqhDk2e0WOa4L4uunW+FlrIOsIGh93zvpjkixoCrtDqCdThkVWtMx?=
 =?us-ascii?Q?7J7jZYsWA/StasmfbWtVh+JN5hLwz2i+yr/Swtp+4nKJ/+CutQFHOvlvulZ2?=
 =?us-ascii?Q?yFHSKhE0SdJfybAG9UxnjxLPDFh55AQT3KnDpUBMKeybWtn6qO73kGTbEiRX?=
 =?us-ascii?Q?YFMsVqRdxQvZLswsJ7PgV+gY6wwTaGlohiLLa+MU0Ng7j+Kltuf8R32/8Sg5?=
 =?us-ascii?Q?6d1YbmC5UNik8z0XOpzz/AgrQcA8MrYv4YjGAVn7ii+H4Pmtvoa4AGRAlHFx?=
 =?us-ascii?Q?waFUJWpWOoNEE6Ezm8puc631v0ZXNo9Yva8H1wrb5tXK17dhJSAPAMxqyLLO?=
 =?us-ascii?Q?gA56T0POKJ25Khk63xN/m8tPdij4BzX0PIHLe1HHWAU1jsZ1qshNykw6mAS/?=
 =?us-ascii?Q?c5cWSdOS6zaYw99ClTux0VTf/f0/BcxhJzVjnHYWHFWdbKmQygw3cLLUxjnT?=
 =?us-ascii?Q?rP0wpgT6MAPDW56jKLnBljCe0jx6k8NHf/KEAvTwan0na6MwL5MytP/vd+b9?=
 =?us-ascii?Q?CuHFHNnmfeL3CgOCDWPUY2/i5k2S1tG2O27O+mjPv7gpX+auYPFukhAchFeF?=
 =?us-ascii?Q?yZUsjCUkgSsCIEvg172/mhGZPhyJZIwzeIGZK2L8dmNCP6IWyWh3bSIdtPbx?=
 =?us-ascii?Q?BGeQjiM1ciJfcuz0zb/DxBGPBdPF76RUJiDWRQBZxgO4SIl8ZLlYqE9YmIGP?=
 =?us-ascii?Q?yjQXVFWqU30kv9tUIxVW4Y1NLVt+flxKnDuLxisefVGm9JMiAHDcPAjKPH2g?=
 =?us-ascii?Q?+XAvICR8IKNAY8cP8bgV4VDt2Qg8biEh6J8HJwVT5bb6obU1pIGy8K6+u5UV?=
 =?us-ascii?Q?lKYrmCc87HvLQHllIoAEEnES9Y75n0QlrzLGAY3Q1Qw7YhxJyJNnSvIvBXBR?=
 =?us-ascii?Q?t66EOtLzcCn7nZiwlOrJiPCwO/TlBSwuHj8wpdIVMcLtvdqKjl2qf3aGbe+R?=
 =?us-ascii?Q?K99oI2fsUBGBc/CH/MxfaFE6ia+tZjaY6Hsp8U1Ar2/MRvGLQg1blURrRs2n?=
 =?us-ascii?Q?eDj/2e2DGRRe/49JkcCFulhE/SM2PkfCUXhj63Ho6QXeeAzwGjHyt0KUIWsD?=
 =?us-ascii?Q?8jguoAIyKPVNkFrEFS8oGpzheos/0bVUsaMFLUYGawZ0DeSPppW0v2i5vlNP?=
 =?us-ascii?Q?cp+M+CiKN6NXgts3wickiJRGkpSbUe2cp5vRW3DG8zXyF/LeHJI+3J2Oub2w?=
 =?us-ascii?Q?G9EjYe3WCaOaY1ukKx2GhYLdzIDW0A+Nv+578tdTrHYgjzM19QwDtqZUQmid?=
 =?us-ascii?Q?viKkn1bbxySk0bKCfJ/CoM=3D?=
X-Microsoft-Antispam-Message-Info: /+fRqegSAGWJhvmlH26/4VdB1sKrgeYpcyL4LvFJCPOVqgPb9dvN60RKKnEvnnVw16LnQ+516zYyACXPYHJ5GQMOOxXqlO/vfPzmjCORrDBm1ee+DeDOCQwVR6S8spkLTzLAPc5pkoGtdUbHUyGt9E0mq94cQwZC2rTZIukmpo443PvOxG//NxzAy1PWHv98Dme7HDOQDSpRp8s5He7u2n+WdAj5Lh+IVw/jz01jnJTz2SVCDqvhrUEDuOwKeBwJHNLFZPPE++WLrdQxpBmUtmquqIEz1ChxDXy21X29wmuqw9Wha2rznsiVn09V+bketK3+/xu2XHvb+ErL+plGRz++jyh7hvC3XvmJribJwDU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:ceg6votnztIh0k3z5X3Y42CGpxE0HoxHtftg/hcIgT8YPVWgRqYRPCcacFMtzjHuEbC0uCUdrH4K/gJAAuBkI2J5unZRvD0IVoyJ7G93bPcFOHpbre9cdtE25qYkCVF3Ku+boppRRu3VaJzFVckqsrtnqnL9EwEj/aBmtUKNWJm/iinZjS6t7IZtcZeGp8pa2qBX+r0Fo6ZkUiRCT2WOtiRf8u7johLc8xZ2R7DkCu2PQ0YAzUNLr7/hAMQb6EtYDjkBsYfGyW+qdEUHT5uRDQ/DR8AqoQOTMzlA+PbCIwF+nr8DgsRyMzhOhBI69BfJzhId5a42jAjhsYTbJDjMdNbiK1useUr1/wiNPHwMYOyLDTJHEoGxWWaviexVGzOfkbha9vOdf6t2RceN5a9JL8dQIVc5TE8FMiYbPE+B6+pYB5+yJ58/Y4rqn1QQMESJiPTkBk2PnzrCqqHbbH3BKA==;5:rmbXwmbtqT/wwgX7SEZmHaMrMiqZdPl0JwKYnz71AVaN8EL5NwrYzZ+c6QAAVAE+rQbB2oiwROwutAoJKDhfJGKF+FROZk50Kn2GziJsPpRMkk7xJl7XF25wtoK/PAJsbpBE1Jl96ID1rbynYXiU22y2keLLNrknXy+0aFOWX8I=;24:ehP+RojVhr1Ej3ARHNPwPvyPEl9f3tL+x2ps0lmz1cGCmJw1pLnohXGr6qTcSm2EOwgxfuqY8dEB9uv7puVe1LJbiTaGEHqN/wBoE2mTPGk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;7:/J5b28WPGjnY08khMWWL62P4K5pG0gZu9Uo+XZrtWpt6wtZU6kDYQziuZgGGscMn/jDpCxQ3ts/QVMfRCvqq8iLrVoORXRhSY7SdZ9nnqNWzO2ACQcd/mH/w4t0X4JX/FAwDj/L5y3E+stPHoR7BVHygX9+7Q8MdQwj2/TEoWKwoIX4pV1drez9GLeXUmv/qyYtxwlEWOjNuaKbGDIG41wy8rdI9mEk4CRaFlErsmgcXkKlOW2DjWnm4bQ1UOZI0;20:IzGKN5PiwjLDanqH458vEft2//eZP8CXJQ919Ot1bwfUMfo4kC9/rkJTMsWxQW3DCdnyMJ01fQv0IPxF5EpRUhy+5yMcFX5xUg2qjbgrf03ICC+AY1QrzYO3k5lgYId1SSJaoX8Wxuzy4lB1LkSxweJlkEHIs0So/7DTKoKMqTw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 18:16:23.5458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b133f41-b636-4fec-5dfa-08d5eda3bd4d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:36:15PM +0200, Vlastimil Babka wrote:
> Kmem caches can be created with a SLAB_RECLAIM_ACCOUNT flag, which indicates
> they contain objects which can be reclaimed under memory pressure (typically
> through a shrinker). This makes the slab pages accounted as NR_SLAB_RECLAIMABLE
> in vmstat, which is reflected also the MemAvailable meminfo counter and in
> overcommit decisions. The slab pages are also allocated with __GFP_RECLAIMABLE,
> which is good for anti-fragmentation through grouping pages by mobility.
> 
> The generic kmalloc-X caches are created without this flag, but sometimes are
> used also for objects that can be reclaimed, which due to varying size cannot
> have a dedicated kmem cache with SLAB_RECLAIM_ACCOUNT flag. A prominent example
> are dcache external names, which prompted the creation of a new, manually
> managed vmstat counter NR_INDIRECTLY_RECLAIMABLE_BYTES in commit f1782c9bc547
> ("dcache: account external names as indirectly reclaimable memory").
> 
> To better handle this and any other similar cases, this patch introduces
> SLAB_RECLAIM_ACCOUNT variants of kmalloc caches, named kmalloc-rcl-X.
> They are used whenever the kmalloc() call passes __GFP_RECLAIMABLE among gfp
> flags. They are added to the kmalloc_caches array as a new type. Allocations
> with both __GFP_DMA and __GFP_RECLAIMABLE will use a dma type cache.
> 
> This change only applies to SLAB and SLUB, not SLOB. This is fine, since SLOB's
> target are tiny system and this patch does add some overhead of kmem management
> objects.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 16 +++++++++++----
>  mm/slab_common.c     | 48 ++++++++++++++++++++++++++++----------------
>  2 files changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4299c59353a1..d89e934e0d8b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -296,11 +296,12 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>                                 (KMALLOC_MIN_SIZE) : 16)
>  
>  #define KMALLOC_NORMAL	0
> +#define KMALLOC_RECLAIM	1
>  #ifdef CONFIG_ZONE_DMA
> -#define KMALLOC_DMA	1
> -#define KMALLOC_TYPES	2
> +#define KMALLOC_DMA	2
> +#define KMALLOC_TYPES	3
>  #else
> -#define KMALLOC_TYPES	1
> +#define KMALLOC_TYPES	2
>  #endif
>  
>  #ifndef CONFIG_SLOB
> @@ -309,12 +310,19 @@ extern struct kmem_cache *kmalloc_caches[KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  static __always_inline unsigned int kmalloc_type(gfp_t flags)
>  {
>  	int is_dma = 0;
> +	int is_reclaimable;
>  
>  #ifdef CONFIG_ZONE_DMA
>  	is_dma = !!(flags & __GFP_DMA);
>  #endif
>  
> -	return is_dma;
> +	is_reclaimable = !!(flags & __GFP_RECLAIMABLE);
> +
> +	/*
> +	 * If an allocation is botth __GFP_DMA and __GFP_RECLAIMABLE, return
                                 ^^
			       typo
> +	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
> +	 */
> +	return (is_dma * 2) + (is_reclaimable & !is_dma);

Maybe
is_dma * KMALLOC_DMA + (is_reclaimable && !is_dma) * KMALLOC_RECLAIM
looks better?

>  }
>  
>  /*
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4614248ca381..614fb7ab8312 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1107,10 +1107,21 @@ void __init setup_kmalloc_cache_index_table(void)
>  	}
>  }
>  
> -static void __init new_kmalloc_cache(int idx, slab_flags_t flags)
> +static void __init
> +new_kmalloc_cache(int idx, int type, slab_flags_t flags)
>  {
> -	kmalloc_caches[KMALLOC_NORMAL][idx] = create_kmalloc_cache(
> -					kmalloc_info[idx].name,
> +	const char *name;
> +
> +	if (type == KMALLOC_RECLAIM) {
> +		flags |= SLAB_RECLAIM_ACCOUNT;
> +		name = kasprintf(GFP_NOWAIT, "kmalloc-rcl-%u",
> +						kmalloc_info[idx].size);
> +		BUG_ON(!name);

I'd replace this with WARN_ON() and falling back to kmalloc_info[idx].name.

> +	} else {
> +		name = kmalloc_info[idx].name;
> +	}
> +
> +	kmalloc_caches[type][idx] = create_kmalloc_cache(name,
>  					kmalloc_info[idx].size, flags, 0,
>  					kmalloc_info[idx].size);
>  }
