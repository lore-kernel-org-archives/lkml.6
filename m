Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2488B206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfBWMGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 07:06:02 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:33451 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfBWMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 07:06:01 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4466P21b0zz20Wy;
        Sat, 23 Feb 2019 13:05:58 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 185.220.102.6
Received: from uni-erlangen.de (unknown [185.220.102.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/9asskaP3oEHUZ5ckKlvrpu3mE4aEpZ+U=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4466Nx3426z20c1;
        Sat, 23 Feb 2019 13:05:53 +0100 (CET)
Date:   Sat, 23 Feb 2019 13:05:38 +0100
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Gardner <rob.gardner@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] perf machine: add inline symbols to callchains
Message-ID: <20190223120500.cltyzcb6ugun4fyw@studium.uni-erlangen.de>
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190221160652.1788-4-jonas.rabenstein@studium.uni-erlangen.de>
 <CAM9d7cgZCuKJ2RzTY-D5TduU3OLUFqGSmW6N5uLAXdkVjbrGag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgZCuKJ2RzTY-D5TduU3OLUFqGSmW6N5uLAXdkVjbrGag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 01:21:34PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Feb 22, 2019 at 1:07 AM Jonas Rabenstein
> <jonas.rabenstein@studium.uni-erlangen.de> wrote:
> >
> > Use map__inlines to resolve inlined functions for every entry with
> > an symbol that should be added to a callchain.
> >
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > ---
> >  tools/perf/util/machine.c | 115 ++++++++++++++++++++++++++++----------
> >  1 file changed, 87 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index dce29c21e4ea..070d074482b4 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1908,6 +1908,91 @@ struct iterations {
> >         u64 cycles;
> >  };
> >
> > +static int __add_callchain_location(struct callchain_cursor *cursor,
> > +                                   struct symbol **parent,
> > +                                   struct addr_location *root_al,
> > +                                   u64 addr, struct addr_location *al,
> > +                                   bool branch, struct branch_flags *flags,
> > +                                   u64 branch_from, struct iterations *iter)
> > +{
> > +       int nr_loop_iter = 0;
> > +       u64 iter_cycles = 0;
> > +
> > +       if (symbol_conf.hide_unresolved && al->sym == NULL)
> > +               return 0;
> > +
> > +       if (al->sym) {
> > +               if (perf_hpp_list.parent && !*parent &&
> > +                 symbol__match_regex(al->sym, &parent_regex))
> > +                       *parent = al->sym;
> > +               else if (have_ignore_callees && root_al &&
> > +                 symbol__match_regex(al->sym, &ignore_callees_regex)) {
> > +                       /* Treat this symbol as the root,
> > +                          forgetting its callees. */
> > +                       *root_al = *al;
> > +                       callchain_cursor_reset(cursor);
> > +               }
> > +       }
> > +
> > +       if (iter) {
> > +               nr_loop_iter = iter->nr_loop_iter;
> > +               iter_cycles = iter->cycles;
> > +       }
> > +       return callchain_cursor_append(cursor, addr, al->map, al->sym, branch,
> > +                                      flags, nr_loop_iter, iter_cycles,
> > +                                      branch_from, al->srcline);
> > +}
> > +
> > +static int __add_callchain_ip(struct callchain_cursor *cursor, u64 ip,
> > +                             struct addr_location *al, bool branch,
> > +                             struct branch_flags *flags, u64 branch_from,
> > +                             struct iterations *iter, struct symbol **parent,
> > +                             struct addr_location *root_al)
> > +{
> > +       struct inline_node *inline_node;
> > +       struct inline_list *inline_list;
> > +       const char *srcline;
> > +       struct symbol *symbol;
> > +       int err = 0;
> > +
> > +       al->srcline = callchain_srcline(al->map, al->sym, al->addr);
> > +       if (callchain_param.order == ORDER_CALLER)
> > +               err = __add_callchain_location(cursor, parent, root_al, ip, al,
> > +                                              branch, flags, branch_from, iter);
> > +       if (err || !al->map || !al->sym)
> > +               goto no_inline;
> > +
> > +       inline_node = map__inlines(al->map, ip, al->sym);
> > +       if (!inline_node || list_empty(&inline_node->val))
> > +               goto no_inline;
> > +
> > +       symbol = al->sym;
> > +       srcline = al->srcline;
> > +       list_for_each_entry(inline_list, &inline_node->val, list) {
> > +               if (inline_list->symbol == symbol)
> > +                       continue;
> > +               al->sym = inline_list->symbol;
> > +               al->srcline = inline_list->srcline;
> > +               err = __add_callchain_location(cursor, parent, root_al, ip,
> > +                                              al, branch, flags,
> > +                                              branch_from, iter);
> > +               if (err)
> > +                       break;
> > +       }
> 
> Does this loop do the job both for ORDER_CALLER and ORDER_CALLEE?
The list of inline symbols is already build in he correct order
depending on callchain_param.order (see util/srcline.c:37). As far as I
could see, perf-report in tui mode uses ORDER_CALLER and perf-script
uses ORDER_CALLEE and both show me a correct order (:
> 
> Thanks,
> Namhyung
> 
> 
> > +
> > +       if (callchain_param.order == ORDER_CALLEE) {
> > +               al->srcline = srcline;
> > +               al->sym = symbol;
> > +       }
> > +
> > +no_inline:
> > +       if (!err && callchain_param.order == ORDER_CALLEE)
> > +               err = __add_callchain_location(cursor, parent, root_al, ip, al,
> > +                                              branch, flags, branch_from, iter);
> > +       return err;
> > +}
> > +
> > +
> >  static int add_callchain_ip(struct thread *thread,
> >                             struct callchain_cursor *cursor,
> >                             struct symbol **parent,
> > @@ -1920,9 +2005,6 @@ static int add_callchain_ip(struct thread *thread,
> >                             u64 branch_from)
> >  {
> >         struct addr_location al;
> > -       int nr_loop_iter = 0;
> > -       u64 iter_cycles = 0;
> > -       const char *srcline = NULL;
> >
> >         al.filtered = 0;
> >         al.sym = NULL;
> > @@ -1955,31 +2037,8 @@ static int add_callchain_ip(struct thread *thread,
> >                 thread__find_symbol(thread, *cpumode, ip, &al);
> >         }
> >
> > -       if (al.sym != NULL) {
> > -               if (perf_hpp_list.parent && !*parent &&
> > -                   symbol__match_regex(al.sym, &parent_regex))
> > -                       *parent = al.sym;
> > -               else if (have_ignore_callees && root_al &&
> > -                 symbol__match_regex(al.sym, &ignore_callees_regex)) {
> > -                       /* Treat this symbol as the root,
> > -                          forgetting its callees. */
> > -                       *root_al = al;
> > -                       callchain_cursor_reset(cursor);
> > -               }
> > -       }
> > -
> > -       if (symbol_conf.hide_unresolved && al.sym == NULL)
> > -               return 0;
> > -
> > -       if (iter) {
> > -               nr_loop_iter = iter->nr_loop_iter;
> > -               iter_cycles = iter->cycles;
> > -       }
> > -
> > -       srcline = callchain_srcline(al.map, al.sym, al.addr);
> > -       return callchain_cursor_append(cursor, ip, al.map, al.sym,
> > -                                      branch, flags, nr_loop_iter,
> > -                                      iter_cycles, branch_from, srcline);
> > +       return __add_callchain_ip(cursor, ip, &al, branch, flags, branch_from,
> > +                                 iter, parent, root_al);
> >  }
> >
> >  struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
> > --
> > 2.19.2
> >
