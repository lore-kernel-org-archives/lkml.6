Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75DFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAFF20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cz2fd8sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfAJVNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:13:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52829 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:13:04 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so886677itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI+O4dLQsBNL6LtFgeqiFo/iUZFy+al9XMoWcHtF3Lg=;
        b=cz2fd8sWK/Ra272oZS5JeWOZhn/7W/I2p53HDa9kh2I9QPp+cO9vkMTEf8aXLvF3F2
         XYxJmPH0qYUQv/PIsqzrkc4ms8kyN4SbjN4LrAcIlbU6ZEmHx2Ddf6Mjogx2sb1D3tE9
         KFoGhSeHmB/jcI1zu2IXR3wZI2iW7gHp5xseE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI+O4dLQsBNL6LtFgeqiFo/iUZFy+al9XMoWcHtF3Lg=;
        b=un4tZQrBSCaoYM7eY9ObRSfglCJ/yCdCGQdpZagmN8/HY4iDISVm1gj8mwUFYbtoJ3
         H3pdB0FcQZBKiIjWzt0cYs0LgR8NLUQjpX/q7ZQE9KcFxDp9ilx5ieUPaU/32ukIwiBE
         qg881pO4TIWjVdtXF6ZtE+HHQj4k2fuiWOROKyCvH6bwBuhzKNB9zbTKr4h4nS5ngy4F
         F6B3xo3ldQerUEy8HToJznDJqZT99wHZ7XkWMDj69GRm5scqvH/k+kmFRRNJHSew/ZVz
         NnE0m1eAbQk9JbIot9JZ/ZCZT8nyOGbvGAG33QsQtQObTP033cmxqfH+H079TVPvdO2r
         e/Dg==
X-Gm-Message-State: AJcUukcm96Nu+mZdLPc5HJn9tJxQ44eNSBAYsarscOW3mmdBZo1ECDZ+
        RBNk3EEqYXnQ3LbSmu436V+McG6axFDnDfy4JhyZpg==
X-Google-Smtp-Source: ALg8bN5L8rpuvPfjOqn+5sEHApMe3s6uc7hZX1JBPSIqVNjuDY/oDOOyAClhHvleJpOW4Tpc/mp92bwM05yX/O03KQg=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr325910itc.103.1547154783611;
 Thu, 10 Jan 2019 13:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20181102230624.20064-1-linux@rasmusvillemoes.dk> <20181104192615.GC18517@krava>
In-Reply-To: <20181104192615.GC18517@krava>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Thu, 10 Jan 2019 22:12:52 +0100
Message-ID: <CAKwiHFhxgGWbEB7J8csejmmjTgJXEeXXc84ONarFDKN8A1tCLg@mail.gmail.com>
Subject: Re: [PATCH] perf: replace automatic const char[] variables by statics
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On Sun, 4 Nov 2018 at 20:26, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Nov 03, 2018 at 12:06:23AM +0100, Rasmus Villemoes wrote:
> > An automatic const char[] variable gets initialized at runtime, just
> > like any other automatic variable. For long strings, that uses a lot of
> > stack and wastes time building the string; e.g. for the "No %s
> > allocation events..." case one has
> >
> >   444516:       48 b8 4e 6f 20 25 73 20 61 6c   movabs $0x6c61207325206f4e,%rax # "No %s al"
> >   ...
> >   444674:       48 89 45 80                     mov    %rax,-0x80(%rbp)
> >   444678:       48 b8 6c 6f 63 61 74 69 6f 6e   movabs $0x6e6f697461636f6c,%rax # "location"
> >   444682:       48 89 45 88                     mov    %rax,-0x78(%rbp)
> >   444686:       48 b8 20 65 76 65 6e 74 73 20   movabs $0x2073746e65766520,%rax # " events "
> >   444690:       66 44 89 55 c4                  mov    %r10w,-0x3c(%rbp)
> >   444695:       48 89 45 90                     mov    %rax,-0x70(%rbp)
> >   444699:       48 b8 66 6f 75 6e 64 2e 20 20   movabs $0x20202e646e756f66,%rax
> >
> > Make them all static so that the compiler just references objects in .rodata.
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> sounds good
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
> > ---
> >  tools/perf/builtin-c2c.c        | 4 ++--
> >  tools/perf/builtin-kmem.c       | 4 ++--
> >  tools/perf/builtin-report.c     | 6 +++---
> >  tools/perf/builtin-sched.c      | 2 +-
> >  tools/perf/ui/browsers/header.c | 2 +-
> >  tools/perf/ui/browsers/hists.c  | 4 ++--
> >  6 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index f3aa9d02a5ab..ab6a89e5393c 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2343,7 +2343,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
> >       struct c2c_cacheline_browser *cl_browser;
> >       struct hist_browser *browser;
> >       int key = -1;
> > -     const char help[] =
> > +     static const char help[] =
> >       " ENTER         Toggle callchains (if present) \n"
> >       " n             Toggle Node details info \n"
> >       " s             Toggle full length of symbol and source line columns \n"
> > @@ -2424,7 +2424,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
> >  {
> >       struct hist_browser *browser;
> >       int key = -1;
> > -     const char help[] =
> > +     static const char help[] =
> >       " d             Display cacheline details \n"
> >       " ENTER         Toggle callchains (if present) \n"
> >       " q             Quit \n";
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index b63bca4b0c2a..088705c167bf 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -334,7 +334,7 @@ static int build_alloc_func_list(void)
> >       struct alloc_func *func;
> >       struct machine *machine = &kmem_session->machines.host;
> >       regex_t alloc_func_regex;
> > -     const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
> > +     static const char pattern[] = "^_?_?(alloc|get_free|get_zeroed)_pages?";
> >
> >       ret = regcomp(&alloc_func_regex, pattern, REG_EXTENDED);
> >       if (ret) {
> > @@ -1924,7 +1924,7 @@ int cmd_kmem(int argc, const char **argv)
> >               NULL
> >       };
> >       struct perf_session *session;
> > -     const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
> > +     static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
> >       int ret = perf_config(kmem_config, NULL);
> >
> >       if (ret)
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 257c9c18cb7e..ff615c624784 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -955,9 +955,9 @@ int cmd_report(int argc, const char **argv)
> >       int branch_mode = -1;
> >       bool branch_call_mode = false;
> >  #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
> > -     const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> > -                                          CALLCHAIN_REPORT_HELP
> > -                                          "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
> > +     static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> > +                                                 CALLCHAIN_REPORT_HELP
> > +                                                 "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
> >       char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
> >       const char * const report_usage[] = {
> >               "perf report [<options>]",
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index cbf39dab19c1..2e0f0c65964a 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -3336,7 +3336,7 @@ static int __cmd_record(int argc, const char **argv)
> >
> >  int cmd_sched(int argc, const char **argv)
> >  {
> > -     const char default_sort_order[] = "avg, max, switch, runtime";
> > +     static const char default_sort_order[] = "avg, max, switch, runtime";
> >       struct perf_sched sched = {
> >               .tool = {
> >                       .sample          = perf_sched__process_tracepoint_sample,
> > diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
> > index d75492189acb..5aeb663dd184 100644
> > --- a/tools/perf/ui/browsers/header.c
> > +++ b/tools/perf/ui/browsers/header.c
> > @@ -35,7 +35,7 @@ static int list_menu__run(struct ui_browser *menu)
> >  {
> >       int key;
> >       unsigned long offset;
> > -     const char help[] =
> > +     static const char help[] =
> >       "h/?/F1        Show this window\n"
> >       "UP/DOWN/PGUP\n"
> >       "PGDN/SPACE\n"
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index a96f62ca984a..eab9dc025b3a 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -2737,7 +2737,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
> >       "S             Zoom into current Processor Socket\n"            \
> >
> >       /* help messages are sorted by lexical order of the hotkey */
> > -     const char report_help[] = HIST_BROWSER_HELP_COMMON
> > +     static const char report_help[] = HIST_BROWSER_HELP_COMMON
> >       "i             Show header information\n"
> >       "P             Print histograms to perf.hist.N\n"
> >       "r             Run available scripts\n"
> > @@ -2745,7 +2745,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
> >       "t             Zoom into current Thread\n"
> >       "V             Verbose (DSO names in callchains, etc)\n"
> >       "/             Filter symbol by name";
> > -     const char top_help[] = HIST_BROWSER_HELP_COMMON
> > +     static const char top_help[] = HIST_BROWSER_HELP_COMMON
> >       "P             Print histograms to perf.hist.N\n"
> >       "t             Zoom into current Thread\n"
> >       "V             Verbose (DSO names in callchains, etc)\n"
> > --
> > 2.19.1.6.gbde171bbf5
> >
