Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeDBOSR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:18:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:24033 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeDBOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:18:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,395,1517904000";
   d="scan'208";a="216828720"
Message-ID: <1522678692.21176.179.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] lib: vsprintf: Implement %pCOW
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, pantelis.antoniou@konsulko.com,
        mark.rutland@arm.com, pmladek@suse.com, joe@perches.com,
        corbet@lwn.net, me@tobin.cc, sergey.senozhatsky@gmail.com
Date: Mon, 02 Apr 2018 17:18:12 +0300
In-Reply-To: <20180401085622.7754-2-richard@nod.at>
References: <20180401085622.7754-1-richard@nod.at>
         <20180401085622.7754-2-richard@nod.at>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-01 at 10:56 +0200, Richard Weinberger wrote:
> Add a new format string to print in cowsay format.
> 

Apparently NAK b/c missed test cases!

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  lib/vsprintf.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index d7a708f82559..a48df6f1c3f0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1693,6 +1693,55 @@ static int __init initialize_ptr_random(void)
>  }
>  early_initcall(initialize_ptr_random);
>  
> +static char *cowsay(char *buf, char *end, void *ptr)
> +{
> +	static char dashes[] = {[0 ... 256] = '-'};
> +	static char unders[] = {[0 ... 256] = '_'};
> +	static char spaces[] = {[0 ... 256] = ' '};
> +	static struct cow_type {
> +		int num_lines;
> +		char *cow_lines[];
> +	} default_cow = {
> +		.num_lines = 5,
> +		.cow_lines = {
> +			"\\   ^__^",
> +			" \\  (oo)\\_______",
> +			"    (__)\\       )\\/\\",
> +			"        ||----w |",
> +			"        ||     ||",
> +		},
> +	};
> +
> +	int i, n;
> +	char *orig_buf = buf;
> +	char *str = ptr;
> +	int len = strlen(str);
> +
> +	n = snprintf(buf, end - buf, "  %.*s\n< %s >\n  %.*s\n", len,
> unders,
> +		     str, len, dashes);
> +	if (n < 0 || buf + n >= end)
> +		goto cow_too_fat;
> +
> +	buf += n;
> +
> +	for (i = 0; i < default_cow.num_lines; i++) {
> +		n = snprintf(buf, end - buf, "%.*s%s\n", len / 2,
> spaces,
> +			     default_cow.cow_lines[i]);
> +		if (n < 0 || buf + n >= end)
> +			goto cow_too_fat;
> +
> +		buf += n;
> +	}
> +
> +	return buf;
> +
> +cow_too_fat:
> +	n = snprintf(orig_buf, end - orig_buf, "%s\n", str);
> +	if (n > 0)
> +		orig_buf += n;
> +	return orig_buf;
> +}
> +
>  /* Maps a pointer to a 32 bit unique identifier. */
>  static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> printf_spec spec)
>  {
> @@ -1941,6 +1990,9 @@ char *pointer(const char *fmt, char *buf, char
> *end, void *ptr,
>  	case 'd':
>  		return dentry_name(buf, end, ptr, spec, fmt);
>  	case 'C':
> +		if (fmt[1] == 'O' && fmt[2] == 'W')
> +			return cowsay(buf, end, ptr);
> +
>  		return clock(buf, end, ptr, spec, fmt);
>  	case 'D':
>  		return dentry_name(buf, end,

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
