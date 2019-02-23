Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51EFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C4F2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550895710;
	bh=1UWUjdAdf2bFYVQO9Ncs839PiJ6nGJsSHsDQ1C5LGh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xj93AV8cHL0CkhDUhhl8/w/GdlJ+Ppug19i++Bmbb6nvJgrHIESzi0PPMJsH/q14l
	 VVMiFXXQ6W34FMkxSAz7/EtonztPKc1uDIHXcGZAZCvAAR4nzrLubHr/Hkf8yhSh2N
	 v8lTmtfnNnU8nvTCne+58/tT3xsVcX0HJ+lL4GTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfBWEVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:21:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43086 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWEVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 23:21:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id d17so4392109wre.10;
        Fri, 22 Feb 2019 20:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXW0p96zlVRhsm4jomk1Ut9zxTg9NVOTR6Gq0y2wsnE=;
        b=ffUR+xkSPtKfBVB1gmXB5LNR7mp0jfQiG/VFfYc4R+SmKUHmbfTOUZgl3lVKGRdc1w
         gDSmXy2xa6pk/jA8o9Heh/rtlgBSTBXtxOncvYQfsce77QRVgF4pthlkxvheRYneRNtS
         5RxAD8J3DDWUlXQXvijcXDGwcnUbD8q7zFyawesPdY0GZtg8kcdMrMiv7SQElNXKwJXS
         pr7yW/bNgwyUbfBfkJOXbUwp+arWfA8Ueyx5IG7QZV8iltn+vkXrQHkJRrAE1chESwAU
         3CT2TJtJ83EGOSaNLc1vko04g2CWjtgphoXeHY01U9fgzqEmeq5np4zQFiAkogt3RRoO
         LCbA==
X-Gm-Message-State: AHQUAuY4LkbKViqjZT2hw7YwbEuIadhwuWpQm13XM5hnyVsO9j4lED1B
        6db5JMEg6k5WtstPT+K0Zdmd+X+2Sr158DU9fOA=
X-Google-Smtp-Source: AHgI3IakuatVzck3xG1HaS0yfDXcf01IFmPkk7UN5tNieTeKEksFumffabaxL5YOOpVx+uD+7GFDgiKI3m4n9yYmZuo=
X-Received: by 2002:a5d:4145:: with SMTP id c5mr5094816wrq.256.1550895705418;
 Fri, 22 Feb 2019 20:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de> <20190221160652.1788-4-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20190221160652.1788-4-jonas.rabenstein@studium.uni-erlangen.de>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 23 Feb 2019 13:21:34 +0900
Message-ID: <CAM9d7cgZCuKJ2RzTY-D5TduU3OLUFqGSmW6N5uLAXdkVjbrGag@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf machine: add inline symbols to callchains
To:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Feb 22, 2019 at 1:07 AM Jonas Rabenstein
<jonas.rabenstein@studium.uni-erlangen.de> wrote:
>
> Use map__inlines to resolve inlined functions for every entry with
> an symbol that should be added to a callchain.
>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  tools/perf/util/machine.c | 115 ++++++++++++++++++++++++++++----------
>  1 file changed, 87 insertions(+), 28 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index dce29c21e4ea..070d074482b4 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1908,6 +1908,91 @@ struct iterations {
>         u64 cycles;
>  };
>
> +static int __add_callchain_location(struct callchain_cursor *cursor,
> +                                   struct symbol **parent,
> +                                   struct addr_location *root_al,
> +                                   u64 addr, struct addr_location *al,
> +                                   bool branch, struct branch_flags *flags,
> +                                   u64 branch_from, struct iterations *iter)
> +{
> +       int nr_loop_iter = 0;
> +       u64 iter_cycles = 0;
> +
> +       if (symbol_conf.hide_unresolved && al->sym == NULL)
> +               return 0;
> +
> +       if (al->sym) {
> +               if (perf_hpp_list.parent && !*parent &&
> +                 symbol__match_regex(al->sym, &parent_regex))
> +                       *parent = al->sym;
> +               else if (have_ignore_callees && root_al &&
> +                 symbol__match_regex(al->sym, &ignore_callees_regex)) {
> +                       /* Treat this symbol as the root,
> +                          forgetting its callees. */
> +                       *root_al = *al;
> +                       callchain_cursor_reset(cursor);
> +               }
> +       }
> +
> +       if (iter) {
> +               nr_loop_iter = iter->nr_loop_iter;
> +               iter_cycles = iter->cycles;
> +       }
> +       return callchain_cursor_append(cursor, addr, al->map, al->sym, branch,
> +                                      flags, nr_loop_iter, iter_cycles,
> +                                      branch_from, al->srcline);
> +}
> +
> +static int __add_callchain_ip(struct callchain_cursor *cursor, u64 ip,
> +                             struct addr_location *al, bool branch,
> +                             struct branch_flags *flags, u64 branch_from,
> +                             struct iterations *iter, struct symbol **parent,
> +                             struct addr_location *root_al)
> +{
> +       struct inline_node *inline_node;
> +       struct inline_list *inline_list;
> +       const char *srcline;
> +       struct symbol *symbol;
> +       int err = 0;
> +
> +       al->srcline = callchain_srcline(al->map, al->sym, al->addr);
> +       if (callchain_param.order == ORDER_CALLER)
> +               err = __add_callchain_location(cursor, parent, root_al, ip, al,
> +                                              branch, flags, branch_from, iter);
> +       if (err || !al->map || !al->sym)
> +               goto no_inline;
> +
> +       inline_node = map__inlines(al->map, ip, al->sym);
> +       if (!inline_node || list_empty(&inline_node->val))
> +               goto no_inline;
> +
> +       symbol = al->sym;
> +       srcline = al->srcline;
> +       list_for_each_entry(inline_list, &inline_node->val, list) {
> +               if (inline_list->symbol == symbol)
> +                       continue;
> +               al->sym = inline_list->symbol;
> +               al->srcline = inline_list->srcline;
> +               err = __add_callchain_location(cursor, parent, root_al, ip,
> +                                              al, branch, flags,
> +                                              branch_from, iter);
> +               if (err)
> +                       break;
> +       }

Does this loop do the job both for ORDER_CALLER and ORDER_CALLEE?

Thanks,
Namhyung


> +
> +       if (callchain_param.order == ORDER_CALLEE) {
> +               al->srcline = srcline;
> +               al->sym = symbol;
> +       }
> +
> +no_inline:
> +       if (!err && callchain_param.order == ORDER_CALLEE)
> +               err = __add_callchain_location(cursor, parent, root_al, ip, al,
> +                                              branch, flags, branch_from, iter);
> +       return err;
> +}
> +
> +
>  static int add_callchain_ip(struct thread *thread,
>                             struct callchain_cursor *cursor,
>                             struct symbol **parent,
> @@ -1920,9 +2005,6 @@ static int add_callchain_ip(struct thread *thread,
>                             u64 branch_from)
>  {
>         struct addr_location al;
> -       int nr_loop_iter = 0;
> -       u64 iter_cycles = 0;
> -       const char *srcline = NULL;
>
>         al.filtered = 0;
>         al.sym = NULL;
> @@ -1955,31 +2037,8 @@ static int add_callchain_ip(struct thread *thread,
>                 thread__find_symbol(thread, *cpumode, ip, &al);
>         }
>
> -       if (al.sym != NULL) {
> -               if (perf_hpp_list.parent && !*parent &&
> -                   symbol__match_regex(al.sym, &parent_regex))
> -                       *parent = al.sym;
> -               else if (have_ignore_callees && root_al &&
> -                 symbol__match_regex(al.sym, &ignore_callees_regex)) {
> -                       /* Treat this symbol as the root,
> -                          forgetting its callees. */
> -                       *root_al = al;
> -                       callchain_cursor_reset(cursor);
> -               }
> -       }
> -
> -       if (symbol_conf.hide_unresolved && al.sym == NULL)
> -               return 0;
> -
> -       if (iter) {
> -               nr_loop_iter = iter->nr_loop_iter;
> -               iter_cycles = iter->cycles;
> -       }
> -
> -       srcline = callchain_srcline(al.map, al.sym, al.addr);
> -       return callchain_cursor_append(cursor, ip, al.map, al.sym,
> -                                      branch, flags, nr_loop_iter,
> -                                      iter_cycles, branch_from, srcline);
> +       return __add_callchain_ip(cursor, ip, &al, branch, flags, branch_from,
> +                                 iter, parent, root_al);
>  }
>
>  struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
> --
> 2.19.2
>
