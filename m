Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A221AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAA920842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HVOU096Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeIYQRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:17:50 -0400
Received: from mail-db5eur03hn0213.outbound.protection.outlook.com ([104.47.10.213]:12217
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeIYQRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MCVtRLdWwgWbSNc77beLVK5jkFCQaeWcnzsRsh/ya4=;
 b=HVOU096ZYI3QSqMSKDrklwmNrnkMmw2yboqAJGLR8gL/FO1MLyZdZHU2Ggo5dpwseLZJSIJn9Tsbi/mRGAiCRoGOk7ib6dcFv0hMTJUyNQR3CwhLmhBgRNBJGgCAWZGwiDu470g5VRRPQiQQkdLn/42vzN89ueXTI/0soGVb2kc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 VI1PR08MB3599.eurprd08.prod.outlook.com (2603:10a6:803:85::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 10:10:45 +0000
Date:   Tue, 25 Sep 2018 13:10:41 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx()
 in kvm_hv_flush_tlb()
Message-ID: <20180925101040.GA2336@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180822101832.31763-1-vkuznets@redhat.com>
 <20180822101832.31763-4-vkuznets@redhat.com>
 <8da03d2a-5405-f363-f081-e4bc46b106e3@redhat.com>
 <87r2hs7cco.fsf@vitty.brq.redhat.com>
 <87zhw62797.fsf@vitty.brq.redhat.com>
 <74055c3b-be66-4ce6-e727-a155f18a0ba1@redhat.com>
 <20180925085752.GA5391@rkaganb.sw.ru>
 <f8cd3988-ea7e-0e4a-ee95-927534276f84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8cd3988-ea7e-0e4a-ee95-927534276f84@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:7:29::19) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2446d02f-9183-482f-3777-08d622cf2989
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3599;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;3:JJlVmzSRIOLw0g3LrUUcJ+BIQrlYbLrfPAgTWEtHcBjS0mAnyQNcnwSHcgpBu1uVSKVEUb/AdxON78YUvjK6RvtxeTY2dRu8rdTeot1v8IaXGrOM25RNBIbqMBKwbQq5Y5Ki9wunpVROJ2B/2vxGWP61q3g0zMKJnR94bvyCZpCqdDDz6i7g4YvRVwl/0pnYeahShd54h8zVQAkpbJ+E2V9G9WgpU+SqC4mlRCKozYpE62hszlWu5nQnuBsMXOLM;25:YPwv/5gdaLsmW4nv3eOFXJsD/1KE979cP740uDGn4x79QdmD/4KCpOWKpRQOyxcRmqudOnwHTBDHc5qcTYSowzFjgJMDLxJjYNWl+MassgYf4le8e+Qc3fJ49Q585CGI/7DfVzFpwXRXcJ+BREqlf5UBl7yjJKc0wQpVRlfmRBqvimBPRGwiljHYv4KmMW2YymXJC1uh1PjnGwmZ9G1fgJGsDO8vO0NozGaqxPj+koK8tX6Xued8vhSKPW+7rSVo3cN7FmyhH0+TXeoGXgkvsG7iUkE184OLv0T3fUo8JMIT8J8/JIueAbF+LSs+/+diZOktMY3aq30ozkZi17/Kyw==;31:HlBWVSvroK7kXzhTlOsgur3maF4c5Ng4iK8dnHtKn4MahvDl32TMLc89sP+ryjhW2OPR74q69/59/RmJ1bzwHmsGCQwXIBgyEmCCVAGqNphDi7H0hJnuLg74iBsJh3uYGPG42EKS4VF+3DgMO2UacE5FCE5+Uwf4jiB8E7coWtGmgQaUM3EbMF2vzxUgI/AXzPSLCeZZQz8hM34giMkfFhM6sL+gv/K99OlbIKzREuI=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3599:|VI1PR08MB3599:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;20:NXIWW6WuXeUALIklqNk9Mk63ZKUu8hhAH6Gh++/ZuOxqdjDf4N6f90NYJCvFIQSeEgAPfgRk2ClYb8VUw6O48Oe1vhKDrOTPlSHt+AhTKOHFWPDCHWZID4l9oupsYRckuJWFMekGqIb3srH+5B9MMnNREwVez6DPtLUPbw1Il6ghTc0xAyhHmY+iCm2TgIP2yLAP8B7qJIFEXVz0lLYxt30T4u0tAX/PBG0WN36qfwVXEq487BNqUDMp3sA9c/PWGGGsW4MN9enHpZanBO0kqbS6/tABWwBBLR0eZRxXKBSTw7iYHrkJyZLRFdX5mnhZfmEjL26iZjnOYKp31jIkbbEx68fI8Woht7YOtWbK0UlSJ9PTJYB8qrwC0/3Q8dayJ0aQxAXVa/r7HwHMALJKl4MutXIO5okYLOMjeNEsiOX1IJ6y4B7ROj8Nb1K+4EXYcPvvOfkHMHgSq1U0e0wRuSXtuXIfyHfQJ2jRkXsyRvSke8Mkoc5p9qrwOCit1e88;4:2jRgrau+l5KlChMnVDEoYD4kfiy74/FfmdMC3ceE2ZpzTtAL6kf+ANDKUvIXbGBYikjIODraiONWoRCfN+evj8YZC4H7DRtPT5m0keUQIMnySuf0CcR23WkzmfeYBbysp3BcVdIjpTUa2xN5xCXwOQMsN3iykZV5xwqf8/vhJ2UKdGLApZ0Wefu/wQzU6vga7ZZsK3zpLTkeW8XoeV7F2Z79Y0j+RJ+Dapr8qCGb2vfAawGmVCwaGwiINbaFHEIzEKGA4XIhFzr2txp9SDCwaQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB35991BEE734CB18D984F7FAAC9160@VI1PR08MB3599.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR08MB3599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3599;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(189003)(199004)(386003)(54906003)(16586007)(7416002)(305945005)(7736002)(26005)(6246003)(53936002)(4326008)(25786009)(39060400002)(106356001)(16526019)(105586002)(33656002)(186003)(68736007)(229853002)(50466002)(55016002)(66066001)(23726003)(9686003)(58126008)(36756003)(3846002)(6116002)(1076002)(53416004)(446003)(11346002)(81156014)(476003)(956004)(47776003)(478600001)(486006)(8936002)(7696005)(86362001)(52116002)(97736004)(69596002)(8676002)(6666003)(6916009)(81166006)(316002)(76176011)(2906002)(5660300001)(53546011)(93886005)(6506007)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3599;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3599;23:I1a16eASdsG5wF+pqUmtHHrIedAyHXVX7p7pFa/3O?=
 =?us-ascii?Q?4cJNkkOwiyewQ7UVUNeCowVmPO5bM4M6q4hpr4okOV3Yqcznrpb8CwmDytH2?=
 =?us-ascii?Q?2eA17mWRq9ye9uIhM95GfHTg33KshaUaIhyNREhVE40lHFctfqX2NMmbRIqY?=
 =?us-ascii?Q?Wu5zQ70FyWQfkFoS42A2jfXB3SSLYid9wOgRanqmpvUDfHa5w3j0XKSkvyp4?=
 =?us-ascii?Q?w2Zz9SdEvX81lnTPH25yRwlPRk5zfBk2KpLE2X0oasI/DRfdTodLeci+FoV2?=
 =?us-ascii?Q?KtFoQXgVDfD7SkDGQ/ccFiTgN6oMvw6fNRAuzcdzw6RB7AFDe5YEL19sMNbX?=
 =?us-ascii?Q?6ohqYwPc37AGdA307u9QEOu4rx8u8jXLSDyb++plZAu4D7/FQBABI9ydOszw?=
 =?us-ascii?Q?QIgY19yB+g5UKhWPKHTIes+Q5kK8np5S7xvZfUVYipDdGBIkwldG1KmzQ6HT?=
 =?us-ascii?Q?Klb44FkR1qfcth6Ez20TF8bUWZwGeJjgkeGsihNeqJ7FLKSf/Lr8vuF3xmCW?=
 =?us-ascii?Q?Yu6b0Bu6EZ4V5W5tYcByqNuOKlGqA9RdA+UhCqneEHR+Aoiz3tXaJMD8xgH/?=
 =?us-ascii?Q?lL+e8BD9lDFYH+zut+jWQpuulc/XJCGKmLvq07vp5vIQYa4EmxQN9d7W4NMg?=
 =?us-ascii?Q?4XHyQjgoZKMALwuW+v+thMUlr/wUsbWaNLSXbAZGzxNzTO+2N6apyEJyGblv?=
 =?us-ascii?Q?xXJBRfhbdnoo3yY5MU1N+kN5THkrbDWQaqzT4bT+MBw/bNeGyiFrV6sCuM4s?=
 =?us-ascii?Q?gEBR0SJ0TZlmWX64SzXhHQ+sL3vPPoHQ3u5PTxNcuN1dtgnJE6IGoQ4AR73a?=
 =?us-ascii?Q?DaSeGBLZhNbvOCUctZmLNu3Z9VNgo7g6w9fZKdBWtpUbm0EpzuOT5KKh4Ry6?=
 =?us-ascii?Q?vQb+VDmq9gSBvcLmgAwEtkFpNviW+eCrfiA9nV2EY/Is687Kg2BTQLhJSufE?=
 =?us-ascii?Q?eO1oofGLt46DCkTOCDv1HGnghb7wC1Xgmjm2eCHB6lxxWCRQDLAssLHZ7OZB?=
 =?us-ascii?Q?WabseP6eLn05FE7z/A14+DArP4OL2EN6COokzIUYDmBqTYxnp/69vF4cVwRe?=
 =?us-ascii?Q?pIt8ufPwBjaSEUf+1UOaScTWlzgRNJ8H2cWkcXXf0/32LqGgUb+wfc3Q/GcJ?=
 =?us-ascii?Q?cnfVl72MjNSKecQmW8F75NTv0fxhAAELMD2JCoUkYRRQ3D9pOxYoZONEWg4E?=
 =?us-ascii?Q?wiI+M8teN8NqHoHHlRHBuLw4bv3UqF5XD5RpZSO7LizZ1WwhMZ0Jy+xc+Jej?=
 =?us-ascii?Q?CU57SvOxLQvKDemPNG11C1ySXo1UXHlPxwhFxWSEMomYPpZus0BesNgwppEL?=
 =?us-ascii?Q?OI6qMB6PgEa/0MNoD8IZvtCBKls92tJsdThT305hAsYw2LtQQvfmvud8o8E2?=
 =?us-ascii?Q?pRfq4tqTmHzh7P6NI888cFAGA3jP3V8XPIDNfEq9yzlnMOdMlRRRnIR22idQ?=
 =?us-ascii?Q?xYbuXj4mYLiIYJUd50SwNThB1hu0V0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;23:2cl4dpTs88kfjNuvH7HvrP3tNq+iVTG+mDFtlJ0mzcr92efjbeMLArxbVLDuZqMeSPxvCwIlraY8bTrVCT6il8zX6G25A0wzfW/pFyKcpAO/5cExbyRL4f2RIA+Sye1Heto0huE15XKB0vcfo2Cbig==;6:w6BNvYxn3RaQaEk9yLXSLvimXYPYcEWSNk8Tqe4u4UI5bShpM8oYd4d98f/brYs7eDZwS/0B/KJrENTL0oqYaWp1mV6eaoAaxATiugp7zZ9EKO8yPLuaS3UnUW19NXM+TMgtpBgfX6AwdpYTJhI4oDOAXGs060cIfLu0Lz8Q5pEWhfTGntnEl/4Cg0LCk0XsbddMem6cBGTxOkwrq5t319sNYkOhVNAT3keFaJS19lPsyeh3d7u+h5L9CkLbZFIwaB63x9F6OYlwKQuF9TsdFmbnuxlossr73Xh31f0+dIg+7Rp5G+DD24zv07ME40PYPvJzJdbz6DxznedI7n+yH55/7RErdRd1eAvGhJFoUBrhlRZqcftRo0vCueTiwfdHlhjU6johDQRu2Sr6VkJNYwHuwd6LO5zHZ2R1IxPMjTG8raUjFz3y1Tb/uUDD+UDW4g6A54ro3h6emkxDJ4iL7Q==;5:SKWaWaQLJ64tGZf85CO3YC0Jc9ceUuPKdD6+HskS8nSixRJb84b+8c8ukDjeyLT1MAgpbhozOO/2dfo5eD0dFyd8yCBLLXz2/t1bYYiT6VpvgE5e/Wx7KTxJPHHGqxCG8QrYRMnJ6bKAPdP+25etNhGLk2z54W70sbhddgalcwc=
X-Microsoft-Antispam-Message-Info: Rt3Eg3k/3teaIWyM3TrYP8Fe+kTnoDJdiRMIJ4PtNrn98+8R4aEQi5dz1eSsnltIhnFT1+2r0bQ7Qsuk+DJUjZaNRGEzxGF1MyXvVfYHVUl6Jb7i+TDmAyFBt+mEfaDSPZr0lLgOC/sjPtCtVJqYqc1+nCclqnppMKGWzDzclVk9paqlM84WqzCXIF9jOoXrYEHmQzrRMy4ZblmL1yzy0jy5jxb4dB48G2F81OGi2HNQNoQmcoKachEvizcbvFxcYfeMnfwUwDrEn6mfrgDmaJ0RPkmFOaeNXyii4kGPrilCeLQSyaOPYiUjvvn94ebZnzWEGH9WbzXBs0VsHaicDL0LANrKQSqgczQGTuK6HmoKOCnyA7xWSKySlBMt7ub7DLKJ0p5xsUwbvk2wiSRKUB1gsQPhCX8y26tTvoA3s/YDktCFqjr2hbwNXituSmBoT7ToiJQxmzPYehrgjuSsJvfuD7rm4mTHYKkz+SHMspYrlXXzEUvFvugVJBtmB6YIgWN2EqH7N2O7N/noSSNl9cfqGmitW9ivAX1hrWRdcaCCA+O3Ugw/WFJXgAkgaOwkepB20GkAjC0PT6BP7qPZpQ==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3599;7:nA5ElZWbKqo3hN0UkfY3c/5mXALoNV6x0CHB/I1wEcFMldHNNhM7wQCYug5ERpBZAj0fbXcloKDxnKhcHV2rAXQmbeXpL7H7VpgYIzQ6qX6j2wfzC8GLlA78xoZnmn+d/gqQqstpUqaFo8z78XTyntog3X5v+6aMrFnoVN/h52o/Q79rbjIEERhG/AzInlFzuErTPc9wFw+m0nxemibgObMSvEZHLBgU6l0fhyOVVpPR5CLpG9pL+TQHzzGDinJn;20:sLiQayD0j0aBdpffTcd6YSzV4phqyQlA+F4f/P5tyCilrmAcChwhVdLyQato0Ea8fm3L2om0l6xRIvNeW9nzJuTdm0wrLLKUBjQdMnrMiw1bApyMP9w9p9jx0lyK12bEDChpNGDg/VhqW3iaJyiVWwx1VEU7EEBerrTUo02Jlis=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 10:10:45.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2446d02f-9183-482f-3777-08d622cf2989
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:29:57AM +0200, Paolo Bonzini wrote:
> On 25/09/2018 10:57, Roman Kagan wrote:
> > If we can assume that in all relevant cases vp_index coincides with the
> > cpu index (which I think we can) then Vitaly's approach is the most
> > efficient.
> > 
> > If, on the opposite, we want to optimize for random mapping between
> > vp_index and cpu index, then it's probably better instead to iterate
> > over vcpus and test if their vp_index belongs to the requested mask.
> 
> Yes, that would work too.  Perhaps we can do both?  You can have a
> kvm->num_mismatched_vp_indexes count to choose between the two.

Makes sense to me.

Roman.
