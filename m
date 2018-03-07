Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbeCGOnb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCGOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:43:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4092172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 11:43:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v2] perf annotate: Fix s390 target function disassembly
Message-ID: <20180307144325.GK3701@kernel.org>
References: <20180307134325.96106-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307134325.96106-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 02:43:25PM +0100, Thomas Richter escreveu:
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
> Introduce a s390 specific call parsing function which skips
> the first operand on s390.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/s390/annotate/instructions.c | 53 +++++++++++++++++++++++++++-
>  tools/perf/util/annotate.c                   |  2 +-
>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
> index 8c72b44444cb..0a3e39b5143d 100644
> --- a/tools/perf/arch/s390/annotate/instructions.c
> +++ b/tools/perf/arch/s390/annotate/instructions.c
> @@ -1,6 +1,57 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/compiler.h>
>  
> +static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
> +			    struct map *map)
> +{
> +	char *endptr, *tok, *name;
> +	struct addr_map_symbol target = {
> +		.map = map,
> +	};
> +
> +	tok = strchr(ops->raw, ',');
> +	if (!tok)
> +		return -1;
> +
> +	ops->target.addr = strtoull(tok + 1, &endptr, 16);
> +
> +	name = strchr(endptr, '<');
> +	if (name == NULL)
> +		return -1;
> +
> +	name++;
> +
> +	if (arch->objdump.skip_functions_char &&
> +	    strchr(name, arch->objdump.skip_functions_char))
> +		return -1;
> +
> +	tok = strchr(name, '>');
> +	if (tok == NULL)
> +		return -1;
> +
> +	*tok = '\0';
> +	ops->target.name = strdup(name);
> +	*tok = '>';
> +
> +	if (ops->target.name == NULL)
> +		return -1;
> +	target.addr = map__objdump_2mem(map, ops->target.addr);
> +
> +	if (map_groups__find_ams(&target) == 0 &&
> +	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
> +		ops->target.sym = target.sym;
> +
> +	return 0;
> +}
> +
> +static int call__scnprintf(struct ins *ins, char *bf, size_t size,
> +			   struct ins_operands *ops);
> +
> +static struct ins_ops s390_call_ops = {
> +	.parse	   = s390_call__parse,
> +	.scnprintf = call__scnprintf,
> +};
> +
>  static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
>  {
>  	struct ins_ops *ops = NULL;
> @@ -14,7 +65,7 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
>  	if (!strcmp(name, "bras") ||
>  	    !strcmp(name, "brasl") ||
>  	    !strcmp(name, "basr"))
> -		ops = &call_ops;
> +		ops = &s390_call_ops;
>  	if (!strcmp(name, "br"))
>  		ops = &ret_ops;
>  
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 49ff825f745c..bc3302da702b 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -248,7 +248,7 @@ static struct ins_ops call_ops = {
>  
>  bool ins__is_call(const struct ins *ins)
>  {
> -	return ins->ops == &call_ops;
> +	return ins->ops == &call_ops || ins->ops == &s390_call_ops;

This is good enough so far, but I think we may end up just making this
be:

bool ins__is_call(const struct ins *ins)
{
	return ins->ops->is_call;
}

This way we remove this arch specific stuff from the core annotate.c
code, applying this patch, this can be done on top, later.

- Arnaldo
