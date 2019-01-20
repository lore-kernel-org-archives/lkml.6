Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2B2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="sa77OWw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfATIgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 03:36:53 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:36350 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbfATIgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 03:36:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C7217403E6;
        Sun, 20 Jan 2019 09:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1547973407; x=1549787808; bh=TTVPnRcE+PRphWFfRW2KiIjaeeSDCecIt2g
        VMQUOmD0=; b=sa77OWw3WNHBmn7KSfLguBDPqNLpPuqhsad48sR40lQrhI0KPJ0
        iAPv1ueS8d6pn4GqXxosRTm1v5cE3RGenLM5PEU2yBSpeHjpSjEhHrx9xhcUlTnY
        JD4j0qPpAVrsnwueLlwtfI++CU196NF82Wbdes6JdbjaGLDsPh684JWTNK4OH7Xi
        wlizKMJ0xdc+6DE3vhXDcGe+hJWFApuVXF9+eqXO8s/jQr8fAWEShtrinvQNaiiD
        QUoQifg5jes+xTD+eMyKL7F8lKVII4Qtxu/PfUrhWsiSVO68O5R/SpzFB+6vlV8b
        4y4XHKWnFiTVdQ7Wzj5+qO/F6UKQNYD9LqOr17rKBPGF3RmFiCB06uCMsJQ4OYeY
        gEQhihJYQqbUjJPyp7CKG1OA6Pk6coJVc/wupIv7H/0a9onCEvXtDrUky2Q39APK
        +TIeX2G0nRleIz+LomkB9ZIOJHErVFVVVQIMSEWXGuEX3qAhJ9LlSZdKOV1LHkAY
        xZX/jxtI0aJF/7Rln4LfKn7HvHJaSzv0MvSCmAEi2CVPCem4qs0WW4AygJrAuLdN
        Bn6hnBugRAjkPHPbScpZ46bLyBZO+1sMVnWjmV+LIZl6f+APy6UDnJk5o4VIESeX
        sY7FmPfUeX0v3/dGTO6hsmwpKVR12wvaHENUiD1feT30V9C8l9t5+jdw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5hUV-TII8Ss6; Sun, 20 Jan 2019 09:36:47 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 781B840389;
        Sun, 20 Jan 2019 09:36:47 +0100 (CET)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id A7D9B18D;
        Sun, 20 Jan 2019 09:36:45 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Jan 2019 09:36:43 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Subject: Re: [PATCH v5] coding-style: Clarify the expectations around bool
In-Reply-To: <20190118225047.GH4759@ziepe.ca>
References: <20190118225047.GH4759@ziepe.ca>
Message-ID: <69366f385e6bdf23d67589850d98cf51@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 23:50, Jason Gunthorpe wrote:
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
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

> ---
>  Documentation/process/coding-style.rst | 38 +++++++++++++++++++++++---
>  scripts/checkpatch.pl                  | 13 ---------
>  2 files changed, 34 insertions(+), 17 deletions(-)
> 
> v5:
>  - Wording updates from JoeyP, MatthewW, FedericoV
> 
> diff --git a/Documentation/process/coding-style.rst
> b/Documentation/process/coding-style.rst
> index b78dd680c03809..de889deaf29c42 100644
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
> +instead of 1 and 0.
> +
> +bool function return types and stack variables are always fine to use 
> whenever
> +appropriate. Use of bool is encouraged to improve readability and is 
> often a
> +better option than 'int' for storing boolean values.
> +
> +Do not use bool if cache line layout or size of the value matters, as 
> its size
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
> +into a single bitwise 'flags' argument and 'flags' can often be a more
> +readable alternative if the call-sites have naked true/false 
> constants.
> +
> +Otherwise limited use of bool in structures and arguments can improve
> +readability.
> +
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
