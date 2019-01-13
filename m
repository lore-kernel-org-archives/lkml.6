Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8389C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FBD206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="3VQ7BIjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfAMQBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:01:52 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:48446 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfAMQBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:01:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 252ED354;
        Sun, 13 Jan 2019 17:01:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1547395306; x=1549209707; bh=tXPWqHtF57CrLGQmxAEjSe9Sfd2iTq/dr3f
        EtWgozVQ=; b=3VQ7BIjX6dVOz2yVtVVEJF/CAqbBf5uUbCk/PvjfTNlOFZ4zZHN
        05cQHtny7Re585HepmBjRirm8YwSeQBCHE5UcXZLXKNRHo33xnIqS3l6la88NUaH
        AXAqLdvP9W7tAsx7CoPNl6vK/RITmbzHSasoRlv3fhgQGBRB+DZyPLfWpxHfBbvJ
        I4kwDujlYUI9S/U5AHRYuceN5kZqTnqReRIqnettaL1lpJ1uQuN634S+VDgwLeTg
        zMmZ84JDq2A99OeRGnX48tHrgiiYDXhhx958Ch7+XZPsW87oZofeghQC3ndxxjKH
        8DaUz3bGQ21I1FEdHbeWmibBzYqm/lJYO5TtlrxaHy6bNJ4RgaAWocOGdRbxSq62
        JBS2uOPZu6MD2ivmMf+eR/7WQDdDmIlzkUeS54kuisBVbQcA0rWuaWLoXP+7D320
        FzvIjOT3rGcYXvh3UnRj/rB/pZSMYzqw5LSTw2WBJls9IxNGCgtw0R+27BeYZkAX
        jFST4bHrLuHv9K3GF3o+ntjp+3AfHXoPCmO5ED1jsXkscSCev5afWv7t1cBO/oaZ
        1uva3Ip2HAB7W9R5oE0D2YMud+vwPmvO6OIMymjIhR9+e+go22v77nYEV6w9UOsW
        EZ+XlOl9AOfHFjyMW7tu2fjHEbJ9sg6Pe0IV2R51G24657bUojxR9lnA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bl4doZmTTcEN; Sun, 13 Jan 2019 17:01:46 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 68277125;
        Sun, 13 Jan 2019 17:01:46 +0100 (CET)
Received: from int-subm001.mykolab.com (unknown [10.9.37.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 1915B1E0;
        Sun, 13 Jan 2019 17:01:41 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 13 Jan 2019 17:01:39 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Joe Perches <joe@perches.com>, Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coding-style: Clarify the expectations around bool
In-Reply-To: <20190110234805.GN6890@ziepe.ca>
References: <20190110234805.GN6890@ziepe.ca>
Message-ID: <d09397d56df116e0d2b8e1a56ace0a37@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-11 00:48, Jason Gunthorpe wrote:
> There has been some confusion since checkpatch started warning about 
> bool
> use in structures, and people have been avoiding using it.
> 
> Many people feel there is still a legitimate place for bool in 
> structures,
> so provide some guidance on bool usage derived from the entire thread 
> that
> spawned the checkpatch warning.
> 
> Link:
> https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Joe Perches <joe@perches.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  Documentation/process/coding-style.rst | 38 +++++++++++++++++++++++---
>  scripts/checkpatch.pl                  | 13 ---------
>  2 files changed, 34 insertions(+), 17 deletions(-)
> 
> v4:
> - Describe true/false as definitions [Joe]
> - Use clearer language for the _Bool explanation [Bart]
> - Delete the checkpatch tests [Joe]
> 
> diff --git a/Documentation/process/coding-style.rst
> b/Documentation/process/coding-style.rst
> index b78dd680c03809..db3e030d0df908 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -921,7 +921,37 @@ result.  Typical examples would be functions that
> return pointers; they use
>  NULL or the ERR_PTR mechanism to report failure.
> 
> 
> -17) Don't re-invent the kernel macros
> +17) Using bool
> +--------------
> +
> +The Linux kernel bool type is an alias for the C99 _Bool type. bool 
> values can
> +only evaluate to 0 or 1, and implicit or explicit conversion to bool
> +automatically converts the value to true or false. When using bool 
> types the
> +!! construction is not needed, which eliminates a class of bugs.
> +
> +When working with bool values the true and false definitions should be 
> used
> +instead of 0 and 1.

A very minor thing. I would suggest to keep consistent, in the 
statement, the mapping
between definitions ("true and false [...]") and their correspondent 
integer values
("[...] instead of 1 and 0").

In few words, I propose to change "0 and 1" into "1 and 0".

> +
> +bool function return types and stack variables are always fine to use 
> whenever
> +appropriate. Use of bool is encouraged to improve readability and is 
> often a
> +better option than 'int' for storing boolean values.
> +
> +Do not use bool if cache line layout or size of the value matters, its 
> size
> +and alignment varies based on the compiled architecture. Structures 
> that are
> +optimized for alignment and size should not use bool.
> +
> +If a structure has many true/false values, consider consolidating them 
> into a
> +bitfield with 1 bit members, or using an appropriate fixed width type, 
> such as
> +u8.
> +
> +Similarly for function arguments, many true/false values can be 
> consolidated
> +into a single bitwise 'flags' argument and 'flags' can often a more 
> readable
> +alternative if the call-sites have naked true/false constants.

Of course, English is not my primary language, but it looks to me that 
here a "be"
is missing: "[...] and 'flags' can often a more readable alternative 
[...]".

> +
> +Otherwise limited use of bool in structures and arguments can improve
> +readability.

I'm going to update the Italian translations for this. Do you want me to 
contribute
directly to this patch? Otherwise I will send a dedicated patch later 
when this one
get accepted.

Thanks

> +18) Don't re-invent the kernel macros
>  -------------------------------------
> 
>  The header file include/linux/kernel.h contains a number of macros 
> that
> @@ -944,7 +974,7 @@ need them.  Feel free to peruse that header file
> to see what else is already
>  defined that you shouldn't reproduce in your code.
> 
> 
> -18) Editor modelines and other cruft
> +19) Editor modelines and other cruft
>  ------------------------------------
> 
>  Some editors can interpret configuration information embedded in 
> source files,
> @@ -978,7 +1008,7 @@ own custom mode, or may have some other magic
> method for making indentation
>  work correctly.
> 
> 
> -19) Inline assembly
> +20) Inline assembly
>  -------------------
> 
>  In architecture-specific code, you may need to use inline assembly to 
> interface
> @@ -1010,7 +1040,7 @@ the next instruction in the assembly output:
>  	     : /* outputs */ : /* inputs */ : /* clobbers */);
> 
> 
> -20) Conditional Compilation
> +21) Conditional Compilation
>  ---------------------------
> 
>  Wherever possible, don't use preprocessor conditionals (#if, #ifdef) 
> in .c
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b737ca9d720441..d62abd032885a1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6368,19 +6368,6 @@ sub process {
>  			}
>  		}
> 
> -# check for bool bitfields
> -		if ($sline =~ /^.\s+bool\s*$Ident\s*:\s*\d+\s*;/) {
> -			WARN("BOOL_BITFIELD",
> -			     "Avoid using bool as bitfield.  Prefer bool bitfields as
> unsigned int or u<8|16|32>\n" . $herecurr);
> -		}
> -
> -# check for bool use in .h files
> -		if ($realfile =~ /\.h$/ &&
> -		    $sline =~ /^.\s+bool\s*$Ident\s*(?::\s*d+\s*)?;/) {
> -			CHK("BOOL_MEMBER",
> -			    "Avoid using bool structure members because of possible
> alignment issues - see: https://lkml.org/lkml/2017/11/21/384\n" .
> $herecurr);
> -		}
> -
>  # check for semaphores initialized locked
>  		if ($line =~ /^.\s*sema_init.+,\W?0\W?\)/) {
>  			WARN("CONSIDER_COMPLETION",

-- 
Federico Vaga
http://www.federicovaga.it/
