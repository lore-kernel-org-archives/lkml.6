Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932543AbeCFOEx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753069AbeCFOEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:04:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8A520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Mar 2018 11:04:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH Resent] perf annotate: Fix s390 target function
 disassembly
Message-ID: <20180306140449.GD10176@kernel.org>
References: <20180306123955.98802-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306123955.98802-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 01:39:55PM +0100, Thomas Richter escreveu:
> Perf annotate displays function call assembler instructions
> with a right arrow. Hitting enter on this line/instruction
> causes the browser to disassemble this target function and
> show it on the screen.  On s390 this results in an error
> message 'The called function was not found.'
> 
> The function call assembly line parsing does not handle
> the s390 bras and brasl instructions. Function call__parse
> expects the target as first operand:
> 	callq	e9140 <__fxstat>
> S390 has a register number as first operand:
> 	brasl	%r14,41d60 <abort>
> Therefore the target addresses on s390 are always zero
> which is an invalid address.
> 
> Fix this by skipping the first operand on s390.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/util/annotate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 49ff825f745c..feb6006b676d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -192,6 +192,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
>  	};
>  
>  	ops->target.addr = strtoull(ops->raw, &endptr, 16);
> +	if (!strcmp(arch->name, "s390")) {
> +		/* s390 function call 1st operand is register */
> +		tok = strchr(ops->raw, ',');
> +		if (tok)
> +			ops->target.addr = strtoull(tok + 1, &endptr, 16);
> +		else
> +			ops->target.addr = 0;
> +	} else
> +		ops->target.addr = strtoull(ops->raw, &endptr, 16);

Do we have to do this here? Can't we have a s390_call__parse() and set
that in the s/390 instructions?

We should avoid arch specific stuff in the common code, and we could
even have a call_reg__parse() perhaps? One that knows that the first
operand is a reg and it should _always_ skip te first one, be it on
s/390 or elsewhere?

- Arnaldo
  
>  	name = strchr(endptr, '<');
>  	if (name == NULL)
> -- 
> 2.14.3
