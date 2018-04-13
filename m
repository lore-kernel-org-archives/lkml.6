Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeDMHiR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:38:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60441 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeDMHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:38:16 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v4] tools/power turbostat: if --iterations, print for specific time of iterations
Date: Fri, 13 Apr 2018 09:38:18 +0200
Message-ID: <6001773.M4ClJSFhmh@aspire.rjw.lan>
In-Reply-To: <20180413034047.1240-1-yu.c.chen@intel.com>
References: <20180413034047.1240-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 13, 2018 5:40:47 AM CEST Yu Chen wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> There's a use case during test to only print specific round of iterations
> if --iterations is specified, for example, with this patch applied:
> 
> turbostat -i 5 -I 4
> will capture 4 samples with 5 seconds interval.
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rafael J Wysocki <rjw@rjwysocki.net>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Cc: Doug Smythies <dsmythies@telus.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..a2fe96f038f0 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -48,6 +48,7 @@ char *proc_stat = "/proc/stat";
>  FILE *outf;
>  int *fd_percpu;
>  struct timespec interval_ts = {5, 0};
> +int iterations;
>  unsigned int debug;
>  unsigned int quiet;
>  unsigned int sums_need_wide_columns;
> @@ -470,6 +471,7 @@ void help(void)
>  	"		{core | package | j,k,l..m,n-p }\n"
>  	"--quiet	skip decoding system configuration header\n"
>  	"--interval sec	Override default 5-second measurement interval\n"
> +	"--iterations count	Number of measurement iterations(requires '--interval'\n"

Why does it require --interval?  Surely it should work with the default interval too?

>  	"--help		print this help message\n"
>  	"--list		list column headers only\n"
>  	"--out file	create or truncate \"file\" for all output\n"
> @@ -2565,6 +2567,7 @@ void turbostat_loop()
>  {
>  	int retval;
>  	int restarted = 0;
> +	int done_iters = 0;
>  
>  restart:
>  	restarted++;
> @@ -2581,6 +2584,7 @@ void turbostat_loop()
>  		goto restart;
>  	}
>  	restarted = 0;
> +	done_iters = 0;
>  	gettimeofday(&tv_even, (struct timezone *)NULL);
>  
>  	while (1) {
> @@ -2607,6 +2611,10 @@ void turbostat_loop()
>  		compute_average(EVEN_COUNTERS);
>  		format_all_counters(EVEN_COUNTERS);
>  		flush_output_stdout();
> +
> +		if (iterations && (++done_iters >= iterations))
> +			break;
> +
>  		nanosleep(&interval_ts, NULL);
>  		if (snapshot_proc_sysfs_files())
>  			goto restart;
> @@ -2626,6 +2634,9 @@ void turbostat_loop()
>  		compute_average(ODD_COUNTERS);
>  		format_all_counters(ODD_COUNTERS);
>  		flush_output_stdout();
> +
> +		if (iterations && (++done_iters >= iterations))
> +			break;
>  	}
>  }
>  
> @@ -4999,6 +5010,7 @@ void cmdline(int argc, char **argv)
>  		{"Dump",	no_argument,		0, 'D'},
>  		{"debug",	no_argument,		0, 'd'},	/* internal, not documented */
>  		{"interval",	required_argument,	0, 'i'},
> +		{"iterations",	required_argument,	0, 'I'},

I would use "-r" rather (unless assigned already).  It may be interpreted as
"repetitions" and there's no confusion with "-i".

>  		{"help",	no_argument,		0, 'h'},
>  		{"hide",	required_argument,	0, 'H'},	// meh, -h taken by --help
>  		{"Joules",	no_argument,		0, 'J'},
> @@ -5014,7 +5026,7 @@ void cmdline(int argc, char **argv)
>  
>  	progname = argv[0];
>  
> -	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
> +	while ((opt = getopt_long_only(argc, argv, "+C:c:DdhI:i:JM:m:o:qST:v",
>  				long_options, &option_index)) != -1) {
>  		switch (opt) {
>  		case 'a':
> @@ -5036,6 +5048,15 @@ void cmdline(int argc, char **argv)
>  		default:
>  			help();
>  			exit(1);
> +		case 'I':
> +			iterations = strtod(optarg, NULL);
> +
> +			if (iterations <= 0) {
> +				fprintf(outf, "iterations %d should be positive number\n",
> +					iterations);
> +				exit(2);
> +			}
> +			break;
>  		case 'i':
>  			{
>  				double interval = strtod(optarg, NULL);
> 

What about the man page?
