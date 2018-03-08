Return-Path: <kernel-hardening-return-12231-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsml79jWCtyYYTYa8RvhvC4ZaQYV0J84xiEK4oDANrF4e4HGGJUFR80K344VhV4nfA8LvL8
ARC-Seal: i=1; a=rsa-sha256; t=1520497522; cv=none;
        d=google.com; s=arc-20160816;
        b=VXYSjTBpqjR5LnC4XlJ3Bi6dKGKXyHGq1mDG6D611yEQrCIh+p/Fx6ccnMjC+//n8y
         c2B4cpIJwzGt7oe/BZYCSuog4uB7QmNVjcfqCHtX/OLqiCdlB8j0utqRLyCazIDIMFNr
         4+HZlJzlw1/zqjWrcD1YSawLvYd1vOiLYjWCwa5BS7ayQD7Ff9eXumgRN40G6nKFlQqY
         v67/dI+CFTYVCf0e+ErMgCP+XXohws4vg8KTnT1I8g1jXj8PIXl1CGttue18uk90oEda
         5gtMy2viW0shB5Dc80qguQC3QBc1403bSPt4rwbKp9qpAF6z/A+JSiQjO9cib1Z3+2qI
         Qyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=f1oqYFyjtQtPg1N0a58MO/tz1oIILjnHmHPvXqRkS0E=;
        b=XQC8oIuBASDeklyNugt6R6G+OJVYUdXEf3VRDN7OdIBWXmkSscFQRODkAvRrtOqRI7
         Om5XcliXOp6NPBZImxs/jGh+hOkMf49DmESj17PrAmQIpo6U/ao6G7ZXAlyUh4ioNFfd
         CfYqbFm/+3gvK/xwpv94QzZtAuAFEJX53nXXxiJtM5r3jPSNu0Q9IIQyaJHMhIqBDL1L
         BtXYYU6ENkulJtqlEYmy3+KfVH6jen/DgY/iZ+6TERmF127PVXPugGhbOU5pA5NQ8KO9
         RmFIhA6bNqpp2hMHOWpKKCjwfvgef5+WyjvBheKHetMp5xSap36h3zEOMX0OC9dBQoym
         366A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=NXGHCEjY;
       spf=pass (google.com: domain of kernel-hardening-return-12231-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12231-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=NXGHCEjY;
       spf=pass (google.com: domain of kernel-hardening-return-12231-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12231-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v2 1/3] vsprintf: Remove accidental VLA usage
To: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net, gustavo@embeddedor.com,
 rostedt@goodmis.org, Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
 David Sterba <dsterba@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov
 <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
 "Tobin C. Harding" <me@tobin.cc>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
 <1520479847-39174-2-git-send-email-keescook@chromium.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <49e6b509-d1e7-5916-ecb8-6bde026fde1e@rasmusvillemoes.dk>
Date: Thu, 8 Mar 2018 09:25:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520479847-39174-2-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594357210041446700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-08 04:30, Kees Cook wrote:
> In the quest to remove all stack VLAs from the kernel[1], this introduces
> a new "simple max" macro, and changes the "sym" array size calculation to
> use it. The value is actually a fixed size, but since the max() macro uses
> some extensive tricks for safety, it ends up looking like a variable size
> to the compiler.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/kernel.h | 11 +++++++++++
>  lib/vsprintf.c         |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 3fd291503576..1da554e9997f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -820,6 +820,17 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  	      x, y)
>  
>  /**
> + * SIMPLE_MAX - return maximum of two values without any type checking
> + * @x: first value
> + * @y: second value
> + *
> + * This should only be used in stack array sizes, since the type-checking
> + * from max() confuses the compiler into thinking a VLA is being used.
> + */
> +#define SIMPLE_MAX(x, y)	((size_t)(x) > (size_t)(y) ? (size_t)(x) \
> +							   : (size_t)(y))

This will be abused at some point, leading to the usual double
evaluation etc. etc. problems. The name is also too long (and in general
we should avoid adjectives like "simple", "safe", people reading the
code won't know what is simple or safe about it). I think this should work

#define MAX(x, y) (__builtin_choose_expr((x) > (y), x, y))

That forces (x)>(y) to be a compile-time constant, so x and y must also
be; hence there can be no side effects. The MIN version of this could
replace the custom __const_min in fs/file.c, and probably other places
as well.

I tested that this at least works in the vsprintf case, -Wvla no longer
complains. fs/file.c also compiles with the MIN version of this.

I suppose MIN and MAX will collide with other uses in the tree. Hmm.

Rasmus
