Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306A2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBDWas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:30:48 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:60446 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbfBDWas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:30:48 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14MGLC1015374;
        Mon, 4 Feb 2019 22:30:19 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qev8prrg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Feb 2019 22:30:19 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id AEFC651;
        Mon,  4 Feb 2019 22:30:18 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0A23B4B;
        Mon,  4 Feb 2019 22:30:16 +0000 (UTC)
Date:   Mon, 4 Feb 2019 15:30:16 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190204223016.GB11986@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131234740.GO6749@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=622 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:47:40AM +0100, Borislav Petkov wrote:
> On Thu, Jan 31, 2019 at 03:27:32PM -0700, Jerry Hoemann wrote:
> > So even if a system administrator is diligent and tests
> > that a chosen kdump configuration works, that configuration
> > might not work on some random reboot 7 months in the future.
> 
> Jerry, did you read the rest of the thread where I'm *actually*
> suggesting to make the allocation code more robust against such
> failures?


Boris,

I may have misunderstood your earlier comment:

  So we don't really need this - we simply need to tell people to use high
  if it fails with KASLR, AFAICT

To imply an iterative approach to crashkernel size discovery.  Whereas you
may simply have ment:  Always use ,high as the old way is broken.


> Now let's look at the code:
> 
> The "high" allocation does:
> 
>                 crash_base = memblock_find_in_range(CRASH_ALIGN,
>                                                     high ? CRASH_ADDR_HIGH_MAX
>                                                          : CRASH_ADDR_LOW_MAX,
>                                                     crash_size, CRASH_ALIGN);
> 
> where high=true and CRASH_ADDR_HIGH_MAX on 64-bit is MAXMEM:
> 
> # define CRASH_ADDR_HIGH_MAX    MAXMEM
> 
> The second fallback in the suggested patch does the same:
> 
> +               /*
> +                * crashkernel=X reserve below 4G fails? Try MAXMEM
> +                */
> +               if (!high && !crash_base)
> +                       crash_base = memblock_find_in_range(CRASH_ALIGN,
> +                                               CRASH_ADDR_HIGH_MAX,
> +                                               crash_size, CRASH_ALIGN);
> 
> and yet I get back that falling back to "high" if the first allocation
> doesn't succeed is not something we should do by default because of
> reasons. But this patch *practically* *does* it.


Is your objection only to the second fallback of allocating
memory above >= 4GB?   Or are you objecting to allocating from
(896 .. 4GB) as well?

Falling back to allocating < 4GB probably satisfes most of the cases
where the original allocation fails.

thanks

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
