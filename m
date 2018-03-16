Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsGOf3mgITYbM22X3VirpJ/WPsNEvjT1fykzPWeMM/bw0WdAJxmkwp4A6dmVhS+jedzTGvz
ARC-Seal: i=1; a=rsa-sha256; t=1521211737; cv=none;
        d=google.com; s=arc-20160816;
        b=B3iI5w4UE0kbb9l6jJxx+6ZXQlvJNllrqH4qdYb0zv46FSRccz3QEsWgqQFgDEjc7J
         KxauR1J5gIWm0iEqkC817BAF5/nF54lUDH8DAe6GfpVVq9ru1BDoRi7FU/209fy4HWLk
         85VODE2x2GqUHHAJxRssRnNG2UKN45ag8Eqmmq6nD9Ik+pr4aT0kOiLQjTIcLjI9ZoZL
         6ENqCq5V6gMUbVDH/058kXoe8GG9Bc3USDKuL73u6Z9jKNwTiy1dhgqMsankRnQ8hQ8+
         rtQTEs1V0AEE7bTKPdiXAxke1evwhHbspUrsGQwU5UDbjyN5xFNZHLM7Fe8B8a36SIzB
         KedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=y8yuqBjObggpO3/Cf14/O13hdwIni4DYPzx66ngxehA=;
        b=Vi/8IhEPqI74Bx9lt7XCHgGmhjgfm8TLviA3QeeFwU067+bevx6EfHmcRpaVeZbIyp
         Wb6BHyEI4+z2NMLyFRA31ConoeF2xhao9Ocicgv9WVQ3IjxD97smmv/KLWSnScakAcWt
         ffUK4waEtXeDKopu3xUdqN6N/Yjgqi+wfxlO+B3zze76ZgsyYqtFsek3kYquGf47hfFO
         tewC5TS/zBNMEHUEo0MG0l+kwdCPuRR/FnwvH10GACKq6edxsFLsSEmTiN59Z1S5qkUw
         X6aVlrglO2qSXNu9OQiozIGl4QU/yuCKLZUrBDYTn1ba2u2gJ548e+uMMGZc1PmuPYqF
         nQKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeCPOs5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 10:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753320AbeCPOs4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 10:48:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B52021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 16 Mar 2018 23:48:52 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v5 16/19] tracing: probeevent: Add array type support
Message-Id: <20180316234852.530b7831ee6e242e3b535a16@kernel.org>
In-Reply-To: <152049905133.7289.17516121776689315422.stgit@devbox>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
        <152049905133.7289.17516121776689315422.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358839822578667?=
X-GMAIL-MSGID: =?utf-8?q?1595106119290941924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  8 Mar 2018 17:50:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add array type support for probe events.
> This allows user to get arraied types from memory address.
> The array type syntax is
> 
> 	TYPE[N]
> 
> Where TYPE is one of types (u8/16/32/64,s8/16/32/64,
> x8/16/32/64, symbol, string) and N is a fixed value less
> than 64.
> 
> The string array type is a bit different from other types. For
> other base types, <base-type>[1] is equal to <base-type>
> (e.g. +0(%di):x32[1] is same as +0(%di):x32.) But string[1] is not
> equal to string. The string type itself represents "char array",
> but string array type represents "char * array". So, for example,
> +0(%di):string[1] is equal to +0(+0(%di)):string.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v4:
>   - Fix to use calculated size correctly for field definition.
>     (Thank you Namhyung!)
>  Changes in v2:
>   - Add array description in README file
>   - Fix to init s3 code out of loop.
>   - Fix to proceed code when the last code is OP_ARRAY.
>   - Add string array type and bitfield array type.
> ---
>  Documentation/trace/kprobetrace.txt |   13 ++++
>  kernel/trace/trace.c                |    3 +
>  kernel/trace/trace_probe.c          |  130 +++++++++++++++++++++++++++--------
>  kernel/trace/trace_probe.h          |   14 ++++
>  kernel/trace/trace_probe_tmpl.h     |   63 +++++++++++++++--
>  5 files changed, 183 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.txt
> index 1d082f8ffeee..8bf752dfc072 100644
> --- a/Documentation/trace/kprobetrace.txt
> +++ b/Documentation/trace/kprobetrace.txt
> @@ -65,9 +65,22 @@ in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
>  or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
>  x86-64 uses x64).
>  
> +These value types can be an array. To record array data, you can add '[N]'
> +(where N is a fixed number, less than 64) to the base type.
> +E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
> +Note that the array can be applied to memory type fetchargs, you can not
> +apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
> +wrong, but '+8($stack):x8[8]' is OK.)
> +
>  String type is a special type, which fetches a "null-terminated" string from
>  kernel space. This means it will fail and store NULL if the string container
>  has been paged out.
> +The string array type is a bit different from other types. For other base
> +types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
> +as +0(%di):x32.) But string[1] is not equal to string. The string type itself
> +represents "char array", but string array type represents "char * array".
> +So, for example, +0(%di):string[1] is equal to +0(+0(%di)):string.
> +
>  Bitfield is another special type, which takes 3 parameters, bit-width, bit-
>  offset, and container-size (usually 32). The syntax is;
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bcd1fd87082d..b7c6698265e5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4614,7 +4614,8 @@ static const char readme_msg[] =
>  	"\t           $stack<index>, $stack, $retval, $comm\n"
>  #endif
>  	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
> -	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
> +	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
> +	"\t           <type>[<array-size>]\n"

Ah, this brace('[',']') should be escaped, like "<type>\[<array-size>\]", or we can not
distinguish it from other braces which mean "optional" syntax.
I'll update it in the next version.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
