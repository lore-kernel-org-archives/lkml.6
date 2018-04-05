Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDENa4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:30:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52970 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeDENaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:30:55 -0400
X-Google-Smtp-Source: AIpwx4+3tSbZfcEew9x2bEENOYHJ+ONIHqXHdgKrU2Pj3PLUUkOLc1wdu3TxdfImhm9aSRjwG3fnWw==
Subject: Re: [PATCH v4 3/9] vsprintf: Do not check address of well-known
 strings
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
 <20180404085843.16050-4-pmladek@suse.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0ff89c4e-e20d-467e-de36-61e3a5557c7d@rasmusvillemoes.dk>
Date: Thu, 5 Apr 2018 15:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404085843.16050-4-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 10:58, Petr Mladek wrote:
> We are going to check the address using probe_kernel_address(). It will
> be more expensive and it does not make sense for well known address.
> 
> This patch splits the string() function. The variant without the check
> is then used on locations that handle string constants or strings defined
> as local variables.
> 
> This patch does not change the existing behavior.

Please leave string() alone, except for moving the < PAGE_SIZE check to
a new helper checked_string (feel free to find a better name), and use
checked_string for handling %s and possibly the few other cases where
we're passing a user-supplied pointer. That avoids cluttering the entire
file with double-underscore calls, and e.g. in the %pO case, it's easier
to understand why one uses two different *string() helpers if the name
of one somehow conveys how it is different from the other.

Rasmus
