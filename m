Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3197DC61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfASBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:25:34 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:36614 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbfASBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:25:33 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0J1G24a001735;
        Sat, 19 Jan 2019 01:25:08 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2q3ptb9245-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Jan 2019 01:25:08 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id EAA6960;
        Sat, 19 Jan 2019 01:25:06 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 2050B45;
        Sat, 19 Jan 2019 01:25:06 +0000 (UTC)
Date:   Fri, 18 Jan 2019 18:25:05 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        yinghai@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, vgoyal@redhat.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190119012505.GA21653@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1547539623-18201-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547539623-18201-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901190009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:07:03PM +0800, Pingfan Liu wrote:
> People reported a bug on a high end server with many pcie devices, where
> kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if without ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found. It raises confusion to the end user that sometimes
> crashkernel=X works while sometimes fails.
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M,high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammar looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> finally above 4G.

While allocating crashkernel from below 4G seems fine, won't we have
problems if the crash kernel gets allocated above 4G because of the SWIOTLB?

thanks


> Dave Young sent the original post, and I just re-post it with commit log
> improvement as his requirement.
> http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> There was an old discussion below (previously posted by Chao Wang):
> https://lkml.org/lkml/2013/10/15/601
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
> v6 -> v7: fix spelling mistake pointed out by Randy
>  arch/x86/kernel/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..fa62c81 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
>  						    high ? CRASH_ADDR_HIGH_MAX
>  							 : CRASH_ADDR_LOW_MAX,
>  						    crash_size, CRASH_ALIGN);
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * crashkernel=X reserve below 896M fails? Try below 4G
> +		 */
> +		if (!high && !crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						(1ULL << 32),
> +						crash_size, CRASH_ALIGN);
> +		/*
> +		 * crashkernel=X reserve below 4G fails? Try MAXMEM
> +		 */
> +		if (!high && !crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						CRASH_ADDR_HIGH_MAX,
> +						crash_size, CRASH_ALIGN);
> +#endif
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
