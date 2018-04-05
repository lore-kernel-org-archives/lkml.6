Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeDEOZq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:25:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38659 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:25:44 -0400
X-Google-Smtp-Source: AIpwx495unCRnV5v6hrsNnpRoJnaCmBQR/x6BQC44jj6K/qRAKeJOxn+zfxrl8ttUY0dhiNcDxPJZg==
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
Date: Thu, 5 Apr 2018 16:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404085843.16050-5-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 10:58, Petr Mladek wrote:
> There are few printk formats that make sense only with two or more
> specifiers. Also some specifiers make sense only when a kernel feature
> is enabled.
> 
> The handling of unknown specifiers is strange, inconsistent, and
> even leaking the address. For example, netdev_bits() prints the
> non-hashed pointer value or clock() prints "(null)".
> 
> The best solution seems to be in flags_string(). It does not print any
> misleading value. Instead it calls WARN_ONCE() describing the unknown
> specifier. Therefore it clearly shows the problem and helps to find it.
>

I'm not sure it's actually worth WARNing about the unknown variants
since we have static analysis (at least checkpatch and smatch) that
should catch that. Even just git grep -1 -E '%p"$' finds %pt and %po
which should get fixed before somebody claims those extensions.

But, I don't disagree with trying to fix up the inconsistency, and
certainly not with fixing netdev_bits(), but it seems you've missed that
e.g. the "case: 'g'" is completely compiled out for !CONFIG_BLOCK.
There's also %pOF which is effectively disabled for !CONFIG_OF (which
obviously makes sense), but with yet a different fallback behaviour.

Hm. I think we should somehow distinguish between the cases of "%po" and
"%pNX", i.e. specifiers/variants that are always bogus, and the cases of
a %pOF or %pC that somehow happens even though nobody should have a
struct device_node* or struct clk* to pass.

Rasmus
