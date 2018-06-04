Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeFDUvE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbeFDUu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:50:27 -0400
Date: Mon, 4 Jun 2018 16:50:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] branch-check: fix long->int truncation when profiling
 branches
Message-ID: <20180604165024.3be78887@gandalf.local.home>
In-Reply-To: <alpine.LRH.2.02.1805300818140.24812@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180528155432.2864616-1-arnd@arndb.de>
        <alpine.LRH.2.02.1805300818140.24812@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 08:19:22 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> The function __builtin_expect returns long type (see the gcc
> documentation), and so do macros likely and unlikely. Unfortunatelly, when
> CONFIG_PROFILE_ANNOTATED_BRANCHES is selected, the macros likely and
> unlikely expand to __branch_check__ and __branch_check__ truncates the

Nice catch.

> long type to int. This unintended truncation may cause bugs in various
> kernel code (we found a bug in dm-writecache because of it), so it's

I'm curious to what that bug was.

> better to fix __branch_check__ to return long.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

Anyway, I can pull this in my tree and test it.

-- Steve

> 
> ---
>  include/linux/compiler.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/include/linux/compiler.h
> ===================================================================
> --- linux-2.6.orig/include/linux/compiler.h	2018-02-26 20:34:17.000000000 +0100
> +++ linux-2.6/include/linux/compiler.h	2018-05-30 14:11:53.000000000 +0200
> @@ -21,7 +21,7 @@ void ftrace_likely_update(struct ftrace_
>  #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
>  
>  #define __branch_check__(x, expect, is_constant) ({			\
> -			int ______r;					\
> +			long ______r;					\
>  			static struct ftrace_likely_data		\
>  				__attribute__((__aligned__(4)))		\
>  				__attribute__((section("_ftrace_annotated_branch"))) \
