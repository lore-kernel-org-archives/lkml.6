Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFEUTZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbeFEUTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:19:23 -0400
Date: Tue, 5 Jun 2018 16:19:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: use match_string() to simplify the code
Message-ID: <20180605161920.1f57aad1@gandalf.local.home>
In-Reply-To: <CAHp75VekpcEVjZy5+i-R-+QWtt8GED_MmF8Pffqm+MZ-LcuuYA@mail.gmail.com>
References: <1526546163-4609-1-git-send-email-xieyisheng1@huawei.com>
        <CAHp75VekpcEVjZy5+i-R-+QWtt8GED_MmF8Pffqm+MZ-LcuuYA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 19:32:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, May 17, 2018 at 11:36 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> > match_string() returns the index of an array for a matching string,
> > which can be used to simplify the code.
> >  
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for the reminder, I was going to add this patch, but haven't
gotten to it.

-- Steve

> 
> > Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> > ---
> >  kernel/trace/trace.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 414d721..4bd653a 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4395,8 +4395,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
> >  {
> >         char *cmp;
> >         int neg = 0;
> > -       int ret = -ENODEV;
> > -       int i;
> > +       int ret;
> >         size_t orig_len = strlen(option);
> >
> >         cmp = strstrip(option);
> > @@ -4408,16 +4407,12 @@ static int trace_set_options(struct trace_array *tr, char *option)
> >
> >         mutex_lock(&trace_types_lock);
> >
> > -       for (i = 0; trace_options[i]; i++) {
> > -               if (strcmp(cmp, trace_options[i]) == 0) {
> > -                       ret = set_tracer_flag(tr, 1 << i, !neg);
> > -                       break;
> > -               }
> > -       }
> > -
> > +       ret = match_string(trace_options, -1, cmp);
> >         /* If no option could be set, test the specific tracer options */
> > -       if (!trace_options[i])
> > +       if (ret < 0)
> >                 ret = set_tracer_option(tr, cmp, neg);
> > +       else
> > +               ret = set_tracer_flag(tr, 1 << ret, !neg);
> >
> >         mutex_unlock(&trace_types_lock);
> >
> > --
> > 1.7.12.4
> >  
> 
> 
> 
