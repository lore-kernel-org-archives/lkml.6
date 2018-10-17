Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA9ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98022150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98022150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJQUei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJQUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FE6680F79;
        Wed, 17 Oct 2018 12:39:06 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CCF11057047;
        Wed, 17 Oct 2018 12:39:05 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id A4440295E; Wed, 17 Oct 2018 09:39:02 -0300 (BRT)
Date:   Wed, 17 Oct 2018 09:39:02 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add Sparc annotate support.
Message-ID: <20181017123902.GA4041@redhat.com>
References: <20181016.205555.1070918198627611771.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016.205555.1070918198627611771.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 17 Oct 2018 12:39:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 16, 2018 at 08:55:55PM -0700, David Miller escreveu:

Great!

Could you try something like:

# perf record some_workload
# perf annotate --stdio2 hot_function

So that we can see this thing in action, i.e. sparc assembly annotated?
:-)

With 'perf annotate --tui hot_function' or 'perf top' 'A' you can
navigate, but for showing it in action in a git changelog comment
example --stdio is more convenient :-)

- Arnaldo
 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  tools/perf/arch/sparc/annotate/instructions.c | 169 ++++++++++++++++++
>  tools/perf/util/annotate.c                    |   8 +
>  2 files changed, 177 insertions(+)
>  create mode 100644 tools/perf/arch/sparc/annotate/instructions.c
> 
> diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/arch/sparc/annotate/instructions.c
> new file mode 100644
> index 000000000000..2614c010c235
> --- /dev/null
> +++ b/tools/perf/arch/sparc/annotate/instructions.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +static int is_branch_cond(const char *cond)
> +{
> +	if (cond[0] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'a' && cond[1] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'c' &&
> +	    (cond[1] == 'c' || cond[1] == 's') &&
> +	    cond[2] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'e' &&
> +	    (cond[1] == '\0' ||
> +	     (cond[1] == 'q' && cond[2] == '\0')))
> +		return 1;
> +
> +	if (cond[0] == 'g' &&
> +	    (cond[1] == '\0' ||
> +	     (cond[1] == 't' && cond[2] == '\0') ||
> +	     (cond[1] == 'e' && cond[2] == '\0') ||
> +	     (cond[1] == 'e' && cond[2] == 'u' && cond[3] == '\0')))
> +		return 1;
> +
> +	if (cond[0] == 'l' &&
> +	    (cond[1] == '\0' ||
> +	     (cond[1] == 't' && cond[2] == '\0') ||
> +	     (cond[1] == 'u' && cond[2] == '\0') ||
> +	     (cond[1] == 'e' && cond[2] == '\0') ||
> +	     (cond[1] == 'e' && cond[2] == 'u' && cond[3] == '\0')))
> +		return 1;
> +
> +	if (cond[0] == 'n' &&
> +	    (cond[1] == '\0' ||
> +	     (cond[1] == 'e' && cond[2] == '\0') ||
> +	     (cond[1] == 'z' && cond[2] == '\0') ||
> +	     (cond[1] == 'e' && cond[2] == 'g' && cond[3] == '\0')))
> +		return 1;
> +
> +	if (cond[0] == 'b' &&
> +	    cond[1] == 'p' &&
> +	    cond[2] == 'o' &&
> +	    cond[3] == 's' &&
> +	    cond[4] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'v' &&
> +	    (cond[1] == 'c' || cond[1] == 's') &&
> +	    cond[2] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'b' &&
> +	    cond[1] == 'z' &&
> +	    cond[2] == '\0')
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int is_branch_reg_cond(const char *cond)
> +{
> +	if ((cond[0] == 'n' || cond[0] == 'l') &&
> +	    cond[1] == 'z' &&
> +	    cond[2] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'z' &&
> +	    cond[1] == '\0')
> +		return 1;
> +
> +	if ((cond[0] == 'g' || cond[0] == 'l') &&
> +	    cond[1] == 'e' &&
> +	    cond[2] == 'z' &&
> +	    cond[3] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'g' &&
> +	    cond[1] == 'z' &&
> +	    cond[2] == '\0')
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int is_branch_float_cond(const char *cond)
> +{
> +	if (cond[0] == '\0')
> +		return 1;
> +
> +	if ((cond[0] == 'a' || cond[0] == 'e' ||
> +	     cond[0] == 'z' || cond[0] == 'g' ||
> +	     cond[0] == 'l' || cond[0] == 'n' ||
> +	     cond[0] == 'o' || cond[0] == 'u') &&
> +	    cond[1] == '\0')
> +		return 1;
> +
> +	if (((cond[0] == 'g' && cond[1] == 'e') ||
> +	     (cond[0] == 'l' && (cond[1] == 'e' ||
> +				 cond[1] == 'g')) ||
> +	     (cond[0] == 'n' && (cond[1] == 'e' ||
> +				 cond[1] == 'z')) ||
> +	     (cond[0] == 'u' && (cond[1] == 'e' ||
> +				 cond[1] == 'g' ||
> +				 cond[1] == 'l'))) &&
> +	    cond[2] == '\0')
> +		return 1;
> +
> +	if (cond[0] == 'u' &&
> +	    (cond[1] == 'g' || cond[1] == 'l') &&
> +	    cond[2] == 'e' &&
> +	    cond[3] == '\0')
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static struct ins_ops *sparc__associate_instruction_ops(struct arch *arch, const char *name)
> +{
> +	struct ins_ops *ops = NULL;
> +
> +	if (!strcmp(name, "call") ||
> +	    !strcmp(name, "jmp") ||
> +	    !strcmp(name, "jmpl")) {
> +		ops = &call_ops;
> +	} else if (!strcmp(name, "ret") ||
> +		   !strcmp(name, "retl") ||
> +		   !strcmp(name, "return")) {
> +		ops = &ret_ops;
> +	} else if (!strcmp(name, "mov")) {
> +		ops = &mov_ops;
> +	} else {
> +		if (name[0] == 'c' &&
> +		    (name[1] == 'w' || name[1] == 'x'))
> +			name += 2;
> +
> +		if (name[0] == 'b') {
> +			const char *cond = name + 1;
> +
> +			if (cond[0] == 'r') {
> +				if (is_branch_reg_cond(cond + 1))
> +					ops = &jump_ops;
> +			} else if (is_branch_cond(cond)) {
> +				ops = &jump_ops;
> +			}
> +		} else if (name[0] == 'f' && name[1] == 'b') {
> +			if (is_branch_float_cond(name + 2))
> +				ops = &jump_ops;
> +		}
> +	}
> +
> +	if (ops)
> +		arch__associate_ins_ops(arch, name, ops);
> +
> +	return ops;
> +}
> +
> +static int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> +{
> +	if (!arch->initialized) {
> +		arch->initialized = true;
> +		arch->associate_instruction_ops = sparc__associate_instruction_ops;
> +		arch->objdump.comment_char = '#';
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 28cd6a17491b..6936daf89ddd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -139,6 +139,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
>  #include "arch/x86/annotate/instructions.c"
>  #include "arch/powerpc/annotate/instructions.c"
>  #include "arch/s390/annotate/instructions.c"
> +#include "arch/sparc/annotate/instructions.c"
>  
>  static struct arch architectures[] = {
>  	{
> @@ -170,6 +171,13 @@ static struct arch architectures[] = {
>  			.comment_char = '#',
>  		},
>  	},
> +	{
> +		.name = "sparc",
> +		.init = sparc__annotate_init,
> +		.objdump = {
> +			.comment_char = '#',
> +		},
> +	},
>  };
>  
>  static void ins__delete(struct ins_operands *ops)
> -- 
> 2.19.1.328.g5a0cc8aca
