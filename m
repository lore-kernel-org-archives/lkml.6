Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeFDUyw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:54:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbeFDUyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:54:51 -0400
Date: Mon, 4 Jun 2018 16:54:44 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@redhat.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] branch-check: fix long->int truncation when profiling
 branches
In-Reply-To: <20180604165024.3be78887@gandalf.local.home>
Message-ID: <alpine.LRH.2.02.1806041653260.18196@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180528155432.2864616-1-arnd@arndb.de> <alpine.LRH.2.02.1805300818140.24812@file01.intranet.prod.int.rdu2.redhat.com> <20180604165024.3be78887@gandalf.local.home>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Jun 2018, Steven Rostedt wrote:

> On Wed, 30 May 2018 08:19:22 -0400 (EDT)
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > The function __builtin_expect returns long type (see the gcc
> > documentation), and so do macros likely and unlikely. Unfortunatelly, when
> > CONFIG_PROFILE_ANNOTATED_BRANCHES is selected, the macros likely and
> > unlikely expand to __branch_check__ and __branch_check__ truncates the
> 
> Nice catch.
> 
> > long type to int. This unintended truncation may cause bugs in various
> > kernel code (we found a bug in dm-writecache because of it), so it's
> 
> I'm curious to what that bug was.

printk("%ld", writecache_has_error(wc))

... and writecache_has_error was defined as
#define writecache_has_error(wc)	(unlikely(READ_ONCE((wc)->error)))

Mikulas
