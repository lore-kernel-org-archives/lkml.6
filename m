Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCLPGX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeCLPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:06:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4ADA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 12:06:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Message-ID: <20180312150613.GA23720@kernel.org>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 11:38:06AM +0100, Thomas Richter escreveu:
> This patch introduces support for s390 transaction counters
> displayed with command 'perf stat -T -- sleep 2'
> 
> Right now there is only hard coded support for x86.
> 
> This patch introduces architecture specfic counter
> tables for x86 and s390. The architecture is queried
> and the event string for transaction counters is constructed
> depending on the architecture and the CPU measurement
> facility counter list.
> 
> Output Before:
> [root@s35lp76 perf]# perf stat -T -- sleep 1
> Cannot set up transaction events
> [root@s35lp76 perf]#
> 
> Output after:
> [root@s35lp76 perf]# ./perf stat -T -- sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>    0.939985      task-clock (msec)         #    0.001 CPUs utilized
>   2,557,145      instructions              #    0.53  insn per cycle
>   4,785,929      cycles                    #    5.091 GHz
>           0      cpum_cf/TX_C_TABORT_NO_SPECIAL/ #    0.000 K/sec
>           0      cpum_cf/TX_C_TABORT_SPECIAL/ #    0.000 K/sec
>           0      cpum_cf/TX_C_TEND/        #    0.000 K/sec
>           0      cpum_cf/TX_NC_TABORT/     #    0.000 K/sec
>           0      cpum_cf/TX_NC_TEND/       #    0.000 K/sec
> 
>   1.001934710 seconds time elapsed
> 
> [root@s35lp76 perf]#
> 
> Output on x86 is unchanged.

Please break this patch in multiple ones, for instance, that part that
converts the hardcoded string to a table with events, etc, should be
done first, just for x86, then when you add the s/390 support that patch
will have mostly + lines, i.e. will be _just_ for s/390.

I.e. the logic that discovers which events should be used instead of
trying out of two possible sets ("full featured" and that limited one)
is an improvement that works for x86 or any other arch where there are
processors with different sets of transaction counters.

See other comments below.
 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Reviewed--by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-stat.c | 162 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 135 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 86c8c8a9229c..75b4f1c9cd78 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -95,22 +95,8 @@ static const char *transaction_attrs = {
>  	"task-clock,"
>  	"{"
>  	"instructions,"
> -	"cycles,"
> -	"cpu/cycles-t/,"
> -	"cpu/tx-start/,"
> -	"cpu/el-start/,"
> -	"cpu/cycles-ct/"
> -	"}"
> -};
> -
> -/* More limited version when the CPU does not have all events. */
> -static const char * transaction_limited_attrs = {
> -	"task-clock,"
> -	"{"
> -	"instructions,"
> -	"cycles,"
> -	"cpu/cycles-t/,"
> -	"cpu/tx-start/"
> +	"cycles"
> +	"%s"
>  	"}"
>  };
>  
> @@ -2149,13 +2135,123 @@ __weak void arch_topdown_group_warn(void)
>  {
>  }
>  
> +struct pmu_tx_events {			/* Define transaction counters */
> +	const char *pmu;		/* PMU name */
> +	const char *name;		/* Counter name */
> +};
> +
> +static struct pmu_tx_events x86_tx_events[] = {/* x86 transaction counters */
> +	{
> +		.pmu = "cpu",
> +		.name = "cycles-t",
> +	},
> +	{
> +		.pmu = "cpu",
> +		.name = "tx-start",
> +	},
> +	{
> +		.pmu = "cpu",
> +		.name = "el-start",
> +	},
> +	{
> +		.pmu = "cpu",
> +		.name = "cycles-ct",
> +	},
> +	{
> +		.pmu = 0
> +	}
> +};
> +
> +static struct pmu_tx_events s390_tx_events[] = {/* s390 transaction counters */
> +	{
> +		.pmu = "cpum_cf",
> +		.name = "TX_C_TABORT_NO_SPECIAL",
> +	},
> +	{
> +		.pmu = "cpum_cf",
> +		.name = "TX_C_TABORT_SPECIAL",
> +	},
> +	{
> +		.pmu = "cpum_cf",
> +		.name = "TX_C_TEND",
> +	},
> +	{
> +		.pmu = "cpum_cf",
> +		.name = "TX_NC_TABORT",
> +	},
> +	{
> +		.pmu = "cpum_cf",
> +		.name = "TX_NC_TEND",
> +	},
> +	{
> +		.pmu = 0
> +	}
> +};
> +
> +struct arch_pmu_tx_events {
> +	const char *archname;		/* Architecture name */
> +	struct pmu_tx_events *tx;	/* Architecture specific counters */
> +} arch_pmu_tx_events[] = {
> +	{
> +		.archname = "s390",
> +		.tx = s390_tx_events
> +	},
> +	{
> +		.archname = "x86",
> +		.tx = x86_tx_events
> +	},
> +	{
> +		.archname = 0
> +	}
> +};
> +
> +static struct pmu_tx_events *pmu_tx_find_arch(const char *name)
> +{
> +	struct arch_pmu_tx_events *p = arch_pmu_tx_events;
> +
> +	for (; p->archname; ++p)
> +		if (!strcmp(name, p->archname))
> +			return p->tx;
> +	return NULL;
> +}
> +
> +/* Search the list of transaction events and test if they are valid for
> + * this PMU. The events are named cpu/cycles-t/ or cpum_cf/TX_NC_TEND/
> + * that is the PMU name followed by the event name surrounded by slashes.
> + *
> + * The function returns a string which contains the tested (and existing)
> + * PMU transaction events. The caller must free this string.
> + *
> + * If no PMU transaction events are found, a NULL pointer is returned.
> + */
> +static char *build_tx_string(const char *fmt, struct pmu_tx_events *txp)
> +{
> +	struct pmu_tx_events *p = txp;
> +	char buffer[512], *result;
> +	int rc, i = 0;
> +
> +	memset(buffer, 0, sizeof(buffer));
> +	for (p = txp; p->pmu; ++p) {
> +		if (pmu_have_event(p->pmu, p->name)) {
> +			rc = snprintf(buffer + i, sizeof(buffer) - i, ",%s/%s/",
> +				      p->pmu, p->name);

Please use scnprintf(), we've been using it instead of snprintf due to
this in its man page:

RETURN VALUE
       The  functions snprintf() and vsnprintf() do not write more than size bytes (including the terminating null byte ('\0')).  If
       the output was truncated due to this limit, then the return value is the number of characters (excluding the terminating null
       byte)  which would have been written to the final string if enough space had been available.  Thus, a return value of size or
       more means that the output was truncated.

---

It doesn't return the number of characters printed, but the number of
characters that would be printed if there was space, so that you can
check for truncation.

> +			i += rc;
> +			if (i >= (int)sizeof(buffer))
> +				break;
> +		}
> +	}
> +	if (i)			/* Transaction counters found */
> +		return asprintf(&result, fmt, buffer) < 0 ? NULL : result;
> +	return NULL;
> +}
> +
>  /*
>   * Add default attributes, if there were no attributes specified or
>   * if -d/--detailed, -d -d or -d -d -d is used:
>   */
>  static int add_default_attributes(void)
>  {
> -	int err;
> +	int err = -1;
>  	struct perf_event_attr default_attrs0[] = {
>  
>    { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
> @@ -2274,20 +2370,32 @@ static int add_default_attributes(void)
>  		return 0;
>  
>  	if (transaction_run) {
> -		struct parse_events_error errinfo;
> +		struct parse_events_error errinfo = { .str = NULL };
> +		char *tx_str;
> +		struct pmu_tx_events *tx_archp;
>  
> -		if (pmu_have_event("cpu", "cycles-ct") &&
> -		    pmu_have_event("cpu", "el-start"))
> -			err = parse_events(evsel_list, transaction_attrs,
> -					   &errinfo);
> -		else
> -			err = parse_events(evsel_list,
> -					   transaction_limited_attrs,
> -					   &errinfo);
> -		if (err) {
> +		/* Find architecture transaction counter string table */
> +		tx_archp = pmu_tx_find_arch(perf_env__arch(NULL));
> +		if (!tx_archp) {
> +			fprintf(stderr, "Cannot set up transaction events\n");
> +			return -1;
> +		}
> +
> +		/* Build architecture transaction counter string */
> +		tx_str = build_tx_string(transaction_attrs, tx_archp);
> +		if (!tx_str) {
>  			fprintf(stderr, "Cannot set up transaction events\n");
>  			return -1;
>  		}
> +
> +		err = parse_events(evsel_list, tx_str, &errinfo);
> +		free(tx_str);
> +		if (err) {
> +			fprintf(stderr, "Cannot set up transaction events:%s\n",
> +				errinfo.str);

Can't we use the parse_events_print_error() function here? Or why is it
better to do it this way (using errinfo.str)?

> +			free(errinfo.str);
> +			return -1;
> +		}
>  		return 0;
>  	}
>  
> -- 
> 2.14.3
