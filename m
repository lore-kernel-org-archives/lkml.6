Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBFC00 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeBFC0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:26:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FD7214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Tue, 6 Feb 2018 11:26:14 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] apparent bogosity in
 unregister_ftrace_function_probe_func()
Message-Id: <20180206112614.80e2a9cbfc55954ab904c3e3@kernel.org>
In-Reply-To: <20180205175433.6cd369db@gandalf.local.home>
References: <20180127031706.GE13338@ZenIV.linux.org.uk>
        <CAJwJo6YD4ds-AHZRm-zEyGCnu+PS-6g_FFeAmHDfaKQxQAUr=A@mail.gmail.com>
        <20180127170748.GF13338@ZenIV.linux.org.uk>
        <20180129225942.f2aec926e2ea223c52c34169@kernel.org>
        <20180205175433.6cd369db@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 17:54:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 29 Jan 2018 22:59:42 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Sat, 27 Jan 2018 17:07:48 +0000
> > Al Viro <viro@ZenIV.linux.org.uk> wrote:
> > 
> > > On Sat, Jan 27, 2018 at 01:59:56PM +0000, Dmitry Safonov wrote:  
> > > >   
> > > > > Incidentally, shouldn't filter_parse_regex("*[ab]", 5, &s, &not)
> > > > > end up with s = "*[ab]"?  We are returning MATCH_GLOB, after all,
> > > > > so we want the entire pattern there...  I would've assumed that
> > > > > this is what the code in unregister_ftrace_function_probe_func()
> > > > > is trying to compensate for, the first oddity predates MATCH_GLOB...  
> > > > 
> > > > No, I don't think filter_parse_regex() should return the full regex..
> > > > ftrace_match() expects search would be processed string, not a glob.
> > > > So, this unnecessary assignment broke unregistering multiple kprobs
> > > > with a middle/end pattern..  
> > > 
> > > For substring - sure, but what about something like "*a*b" and "a*b"?
> > > AFAICS, filter_parse_regex() ends up with identical results in both
> > > cases - MATCH_GLOB and *search = "a*b".  And no way for the caller
> > > to tell one from another.
> > > 
> > > IOW, it's a different bug sometimes obscured by the one in
> > > unregister_ftrace_function_probe_func().  filter_parse_regex()
> > > ought to revert to *search = buff; when it decides to return
> > > MATCH_GLOB.  Or something like
> > >         for (i = 0; i < len; i++) {
> > >                 if (buff[i] == '*') {
> > >                         if (!i) {
> > >                                 type = MATCH_END_ONLY;
> > >                         } else if (i == len - 1) {
> > >                                 if (type == MATCH_END_ONLY)
> > >                                         type = MATCH_MIDDLE_ONLY;
> > >                                 else
> > >                                         type = MATCH_FRONT_ONLY;
> > >                                 buff[i] = 0;
> > >                                 break;
> > >                         } else {        /* pattern continues, use full glob */
> > >                                 return MATCH_GLOB;
> > >                         }
> > >                 } else if (strchr("[?\\", buff[i])) {
> > >                         return MATCH_GLOB;
> > >                 }
> > >         }
> > >         if (buff[0] == '*')
> > >                 *search = buff + 1;
> > > for that matter - i.e. delay that "we want everything past the first character"
> > > until we are certain it's not a MATCH_GLOB.  
> > 
> > Looks nice to me!
> > 
> 
> I'll implement this code giving Al credit and referencing this email
> thread. Anyone have objections to that?

No, that code looks good to me. :)

BTW, did you also remove "search = buff;" line in 
unregister_ftrace_function_probe_func() too?

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
