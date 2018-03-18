Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeCRVce (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:32:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33845 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeCRVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:32:32 -0400
X-Google-Smtp-Source: AG47ELvPLKCjb4rQO58Em5kiGS2ezGeXDZqqAyqkD33xmhtOaTXdkB9RbzkDTnfda5YR1vPkRUV+pw==
Subject: Re: [PATCH] vfs: make sure struct filename->iname is word-aligned
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180228231922.15796-1-linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <cf8b0832-5545-1f09-dfc7-bd9ac1c7cc16@rasmusvillemoes.dk>
Date: Sun, 18 Mar 2018 22:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228231922.15796-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-01 00:19, Rasmus Villemoes wrote:
> I noticed that offsetof(struct filename, iname) is actually 28 on 64
> bit platforms, so we always pass an unaligned pointer to
> strncpy_from_user. This is mostly a problem for those 64 bit platforms
> without HAVE_EFFICIENT_UNALIGNED_ACCESS, but even on x86_64, unaligned
> accesses carry a penalty.
> 
> A user-space microbenchmark doing nothing but strncpy_from_user from the
> same (aligned) source string runs about 5% faster when the destination
> is aligned. That number increases to 20% when the string is long
> enough (~32 bytes) that we cross a cache line boundary - that's for
> example the case for about half the files a "git status" in a kernel
> tree ends up stat'ing.
> 
> This won't make any real-life workloads 5%, or even 1%, faster, but path
> lookup is common enough that cutting even a few cycles should be
> worthwhile. So ensure we always pass an aligned destination pointer to
> strncpy_from_user. Instead of explicit padding, simply swap the refcnt
> and aname members, as suggested by Al Viro.

polite ping...
