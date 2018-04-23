Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeDWItS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:49:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45987 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeDWIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:48:48 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v5] tools/power turbostat: if --iterations, print for specific count of iterations
Date: Mon, 23 Apr 2018 10:48:39 +0200
Message-ID: <1840879.edVvmFFlsp@aspire.rjw.lan>
In-Reply-To: <20180414041055.10159-1-yu.c.chen@intel.com>
References: <20180414041055.10159-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 14, 2018 6:10:55 AM CEST Yu Chen wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> There's a use case during test to only print specific round of iterations
> if --iterations is specified, for example, with this patch applied:
> 
> turbostat -i 5 -r 4
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
>  tools/power/x86/turbostat/turbostat.8 |  2 ++
>  tools/power/x86/turbostat/turbostat.c | 23 ++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
> index ccf2a69365cc..7452dc42273b 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -64,6 +64,8 @@ name as necessary to disambiguate it from others is necessary.  Note that option
>  .PP
>  \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
>  .PP
> +\fB--iterations count\fP number of the measurement iterations.
> +.PP
>  \fB--out output_file\fP turbostat output is written to the specified output_file.
>  The file is truncated if it already exists, and it is created if it does not exist.
>  .PP
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..ae9e3d08e3cf 100644
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
> +	"--iterations count	number of the measurement iterations\n"
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

The inner parens are not needed here (and similarly below).

If you fix this little one, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patch (FWIW). 

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
> +		{"iterations",	required_argument,	0, 'r'},
>  		{"help",	no_argument,		0, 'h'},
>  		{"hide",	required_argument,	0, 'H'},	// meh, -h taken by --help
>  		{"Joules",	no_argument,		0, 'J'},
> @@ -5014,7 +5026,7 @@ void cmdline(int argc, char **argv)
>  
>  	progname = argv[0];
>  
> -	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
> +	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qr:ST:v",
>  				long_options, &option_index)) != -1) {
>  		switch (opt) {
>  		case 'a':
> @@ -5063,6 +5075,15 @@ void cmdline(int argc, char **argv)
>  		case 'q':
>  			quiet = 1;
>  			break;
> +		case 'r':
> +			iterations = strtod(optarg, NULL);
> +
> +			if (iterations <= 0) {
> +				fprintf(outf, "iterations %d should be positive number\n",
> +					iterations);
> +				exit(2);
> +			}
> +			break;
>  		case 's':
>  			parse_show_hide(optarg, SHOW_LIST);
>  			break;
> 
