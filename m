Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F36C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F19C20882
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AEvz53ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLWQmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:42:40 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:35562 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLWQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1545583359; x=1577119359;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G/bYWMA0pyiMWuDzmo4NgdlFCMjxCm2KagjL+udLSDY=;
  b=AEvz53eeV4XvhTD9Wi0BhhnTsO2sDvGU2eLuycLdiQm/82WP0I8s4tmj
   qbsRXEhjo7sqOyw8QeHpz2QFVQTTG7P12VYx2Y7cgbFrY7v+QmgwLvf7g
   uMW9Dcg8/O1ZjGkvWy7+dP/lYpHJNFe5B69SbCyvoXpFvi6LH/XM0KRz1
   0=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="649762489"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Dec 2018 16:42:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wBNGgWa8125849
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 23 Dec 2018 16:42:34 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 23 Dec 2018 16:42:34 +0000
Received: from [10.218.62.26] (10.43.161.54) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 23 Dec
 2018 16:42:25 +0000
Subject: Re: rfc: bool structure members (was Re: [PATCH V3] net/mlx4: Get rid
 of page operation after dma_alloc_coherent)
To:     Jason Gunthorpe <jgg@ziepe.ca>, Joe Perches <joe@perches.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, <xavier.huwei@huawei.com>,
        <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Stephen Warren" <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>
References: <20181219182031.8675-1-swarren@wwwdotorg.org>
 <20181220174318.GA21404@ziepe.ca> <20181220174448.GA21149@lst.de>
 <1545328145.185366.500.camel@acm.org>
 <072c2d9d187daf0672bf54ab035e47a05fd1cd1d.camel@perches.com>
 <20181221033159.GF23877@ziepe.ca>
 <b906bec0fd12d25474561263087a26b8b0519fe4.camel@perches.com>
 <20181221235230.GC13168@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <dc6d4923-63bd-e133-310b-7b164b0c92f5@amazon.com>
Date:   Sun, 23 Dec 2018 18:42:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221235230.GC13168@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.54]
X-ClientProxiedBy: EX13D19UWA003.ant.amazon.com (10.43.160.170) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Dec-18 01:52, Jason Gunthorpe wrote:
> On Thu, Dec 20, 2018 at 09:12:43PM -0800, Joe Perches wrote:
>> Care to submit a coding_style.rst patch or
>> improve the one below this?
> 
> I took yours and revised it a little bit. I spent some time looking at
> assembly and decided to drop the performance note, the number of cases
> that run into overhead seems pretty small and probably already
> requires !! to be correct. There is also an equally unlikely gain, ie
> 'if (a & b)' optimizes a tiny bit better for bool types.
> 
> I also added a small intro on bool, as I know some people are
> unfamiliar with C11 _Bool and might think bool is just '#define bool
> u8'
> 
> (for those added to the cc) I'm looking at cases, like the patch that
> spawned this, where the struct has a single bool and no performance
> considerations. As CH said, seeing that get converted to int due to
> checkpatch is worse than having used bool. Using u8 won't make this
> struct smaller or faster.
> 
> Cheers,
> Jason
> 
> From c5e2c887f6326e1c4369876f39996417da5e90cc Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Fri, 21 Dec 2018 16:29:22 -0700
> Subject: [PATCH] coding-style: Clarify the expectations around bool
> 
> There has been some confusion since checkpatch started warning about bool
> use in structures, and people have been avoiding using it.
> 
> Many people feel there is still a legitimate place for bool in structures,
> so provide some guidance on bool usage derived from the entire thread that
> spawned the checkpatch warning.

Since a "Using bool" section is added, perhaps it's worth documenting the bool
usage as a function parameter [1]?

[1] https://www.spinics.net/lists/linux-rdma/msg72336.html

> 
> Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  Documentation/process/coding-style.rst | 33 ++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 4e7c0a1c427a9a..efdb1d32035fe1 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -918,7 +918,32 @@ result.  Typical examples would be functions that return pointers; they use
>  NULL or the ERR_PTR mechanism to report failure.
>  
>  
> -17) Don't re-invent the kernel macros
> +17) Using bool
> +--------------
> +
> +The Linux kernel uses the C11 standard for the bool type. bool values can only
> +evaluate to 0 or 1, and implicit or explicit conversion to bool automatically
> +converts the value to true or false. When using bool types the !! construction
> +is not needed, which eliminates a class of bugs.
> +
> +When working with bool values the true and false labels should be used instead
> +of 0 and 1.
> +
> +bool function return types, arguments and stack variables are always fine to
> +use whenever appropriate. Use of bool is encouraged to improve readability and
> +is often a better option than 'int' for storing boolean values.
> +
> +Do not use bool if cache line layout or size of the value matters, its size
> +and alignment varies based on the compiled architecture. Structures that are
> +optimized for alignment and size should not use bool.
> +
> +If a structure has many true/false values, consider consolidating them into a
> +bitfield with 1 bit members, or using an appropriate fixed width type, such as
> +u8.
> +
> +Otherwise limited use of bool in structures does improve readability.
> +
> +18) Don't re-invent the kernel macros
>  -------------------------------------
>  
>  The header file include/linux/kernel.h contains a number of macros that
> @@ -941,7 +966,7 @@ need them.  Feel free to peruse that header file to see what else is already
>  defined that you shouldn't reproduce in your code.
>  
>  
> -18) Editor modelines and other cruft
> +19) Editor modelines and other cruft
>  ------------------------------------
>  
>  Some editors can interpret configuration information embedded in source files,
> @@ -975,7 +1000,7 @@ own custom mode, or may have some other magic method for making indentation
>  work correctly.
>  
>  
> -19) Inline assembly
> +20) Inline assembly
>  -------------------
>  
>  In architecture-specific code, you may need to use inline assembly to interface
> @@ -1007,7 +1032,7 @@ the next instruction in the assembly output:
>  	     : /* outputs */ : /* inputs */ : /* clobbers */);
>  
>  
> -20) Conditional Compilation
> +21) Conditional Compilation
>  ---------------------------
>  
>  Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> 

