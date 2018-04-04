Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeDDXfS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:35:18 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:38076 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeDDXfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:35:16 -0400
X-Google-Smtp-Source: AIpwx49/v6uErR2QcYH6VPhgQEZx8U0okJG/FyAPQSgJHsxeItUxmnK0Go+piIAi3+so18g8Y3rPjw==
Date: Thu, 5 Apr 2018 08:35:11 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 7/9] vsprintf: Factor out %pO handler as
 kobject_string()
Message-ID: <20180404233511.GB622@jagdpanzerIV>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404085843.16050-8-pmladek@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/04/18 10:58), Petr Mladek wrote:
>  static noinline_for_stack
> +char *kobject_string(char *buf, char *end, void *ptr,
> +		     struct printf_spec spec, const char *fmt)
> +{
> +	switch (fmt[1]) {
> +	case 'F':
> +		return device_node_string(buf, end, ptr, spec, fmt + 1);
> +	}
> +
> +	WARN_ONCE(1, "Unsupported pointer format specifier: %%pO%c\n", fmt[1]);
> +	return buf;
> +}
> +
> +static noinline_for_stack
>  char *pointer_string(char *buf, char *end, const void *ptr,
>  		     struct printf_spec spec)
>  {
> @@ -1982,10 +1995,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	case 'G':
>  		return flags_string(buf, end, ptr, fmt);
>  	case 'O':
> -		switch (fmt[1]) {
> -		case 'F':
> -			return device_node_string(buf, end, ptr, spec, fmt + 1);
> -		}
> +		return kobject_string(buf, end, ptr, spec, fmt);
>  	case 'x':
>  		return pointer_string(buf, end, ptr, spec);
>  	}

So, previously, unsupported 'O' would end up in ptr_to_id()

	case 'O':
		switch (fmt[1]) {
		case 'F':
			return device_node_string()
		}
	}

	return ptr_to_id();



now we will just return `buf' without doing ptr_to_id()?

	case 'O':
		return kobject_string();  // which does device_node_string()
					  // for fmt 'O' or return buf
					  // for unknown fmt.
	}

	return ptr_to_id();


Was this your intention?

	-ss
