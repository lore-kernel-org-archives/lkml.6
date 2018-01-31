Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeAaCB5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:01:57 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47348 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeAaCBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:01:55 -0500
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [patch] tools, vm: new option to specify kpageflags file
Thread-Topic: [patch] tools, vm: new option to specify kpageflags file
Thread-Index: AQHTmh41VvxQd6FNp0elfDpUx/yWcqOMo7MA
Date: Wed, 31 Jan 2018 02:01:30 +0000
Message-ID: <dc1df2b9-9136-4b8d-799b-c22baff20478@ah.jp.nec.com>
References: <alpine.DEB.2.10.1801301458180.153857@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.10.1801301458180.153857@chino.kir.corp.google.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.2]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A8AB6FC77E3EEC47B5A3719FF8D5D6C5@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 08:01 AM, David Rientjes wrote:
> page-types currently hardcodes /proc/kpageflags as the file to parse.  
> This works when using the tool to examine the state of pageflags on the 
> same system, but does not allow storing a snapshot of pageflags at a given 
> time to debug issues nor on a different system.
> 
> This allows the user to specify a saved version of kpageflags with a new 
> page-types -F option.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Thanks for the work, looks good to me.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

one nitpicking below ... 

> ---
>  tools/vm/page-types.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
> --- a/tools/vm/page-types.c
> +++ b/tools/vm/page-types.c
> @@ -172,6 +172,7 @@ static pid_t		opt_pid;	/* process to walk */
>  const char *		opt_file;	/* file or directory path */
>  static uint64_t		opt_cgroup;	/* cgroup inode */
>  static int		opt_list_cgroup;/* list page cgroup */
> +static const char *	opt_kpageflags;	/* kpageflags file to parse */

checkpatch.pl emits a warning.

ERROR: "foo *	bar" should be "foo *bar"
#101: FILE: tools/vm/page-types.c:175:
+static const char *	opt_kpageflags;	/* kpageflags file to parse */


Thanks,
Naoya Horiguchi

>  
>  #define MAX_ADDR_RANGES	1024
>  static int		nr_addr_ranges;
> @@ -258,7 +259,7 @@ static int checked_open(const char *pathname, int flags)
>   * pagemap/kpageflags routines
>   */
>  
> -static unsigned long do_u64_read(int fd, char *name,
> +static unsigned long do_u64_read(int fd, const char *name,
>  				 uint64_t *buf,
>  				 unsigned long index,
>  				 unsigned long count)
> @@ -283,7 +284,7 @@ static unsigned long kpageflags_read(uint64_t *buf,
>  				     unsigned long index,
>  				     unsigned long pages)
>  {
> -	return do_u64_read(kpageflags_fd, PROC_KPAGEFLAGS, buf, index, pages);
> +	return do_u64_read(kpageflags_fd, opt_kpageflags, buf, index, pages);
>  }
>  
>  static unsigned long kpagecgroup_read(uint64_t *buf,
> @@ -293,7 +294,7 @@ static unsigned long kpagecgroup_read(uint64_t *buf,
>  	if (kpagecgroup_fd < 0)
>  		return pages;
>  
> -	return do_u64_read(kpagecgroup_fd, PROC_KPAGEFLAGS, buf, index, pages);
> +	return do_u64_read(kpagecgroup_fd, opt_kpageflags, buf, index, pages);
>  }
>  
>  static unsigned long pagemap_read(uint64_t *buf,
> @@ -743,7 +744,7 @@ static void walk_addr_ranges(void)
>  {
>  	int i;
>  
> -	kpageflags_fd = checked_open(PROC_KPAGEFLAGS, O_RDONLY);
> +	kpageflags_fd = checked_open(opt_kpageflags, O_RDONLY);
>  
>  	if (!nr_addr_ranges)
>  		add_addr_range(0, ULONG_MAX);
> @@ -790,6 +791,7 @@ static void usage(void)
>  "            -N|--no-summary            Don't show summary info\n"
>  "            -X|--hwpoison              hwpoison pages\n"
>  "            -x|--unpoison              unpoison pages\n"
> +"            -F|--kpageflags            kpageflags file to parse\n"
>  "            -h|--help                  Show this usage message\n"
>  "flags:\n"
>  "            0x10                       bitfield format, e.g.\n"
> @@ -1013,7 +1015,7 @@ static void walk_page_cache(void)
>  {
>  	struct stat st;
>  
> -	kpageflags_fd = checked_open(PROC_KPAGEFLAGS, O_RDONLY);
> +	kpageflags_fd = checked_open(opt_kpageflags, O_RDONLY);
>  	pagemap_fd = checked_open("/proc/self/pagemap", O_RDONLY);
>  	sigaction(SIGBUS, &sigbus_action, NULL);
>  
> @@ -1164,6 +1166,11 @@ static void parse_bits_mask(const char *optarg)
>  	add_bits_filter(mask, bits);
>  }
>  
> +static void parse_kpageflags(const char *name)
> +{
> +	opt_kpageflags = name;
> +}
> +
>  static void describe_flags(const char *optarg)
>  {
>  	uint64_t flags = parse_flag_names(optarg, 0);
> @@ -1188,6 +1195,7 @@ static const struct option opts[] = {
>  	{ "no-summary", 0, NULL, 'N' },
>  	{ "hwpoison"  , 0, NULL, 'X' },
>  	{ "unpoison"  , 0, NULL, 'x' },
> +	{ "kpageflags", 0, NULL, 'F' },
>  	{ "help"      , 0, NULL, 'h' },
>  	{ NULL        , 0, NULL, 0 }
>  };
> @@ -1199,7 +1207,7 @@ int main(int argc, char *argv[])
>  	page_size = getpagesize();
>  
>  	while ((c = getopt_long(argc, argv,
> -				"rp:f:a:b:d:c:ClLNXxh", opts, NULL)) != -1) {
> +				"rp:f:a:b:d:c:ClLNXxF:h", opts, NULL)) != -1) {
>  		switch (c) {
>  		case 'r':
>  			opt_raw = 1;
> @@ -1242,6 +1250,9 @@ int main(int argc, char *argv[])
>  			opt_unpoison = 1;
>  			prepare_hwpoison_fd();
>  			break;
> +		case 'F':
> +			parse_kpageflags(optarg);
> +			break;
>  		case 'h':
>  			usage();
>  			exit(0);
> @@ -1251,6 +1262,9 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (!opt_kpageflags)
> +		opt_kpageflags = PROC_KPAGEFLAGS;
> +
>  	if (opt_cgroup || opt_list_cgroup)
>  		kpagecgroup_fd = checked_open(PROC_KPAGECGROUP, O_RDONLY);
>  
> 
