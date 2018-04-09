Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDIPNw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:13:52 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:36998 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750759AbeDIPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:13:51 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:969:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2553:2559:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:4605:5007:6119:7557:7903:7904:8599:8660:9010:9025:9388:10004:10049:10400:10848:10967:11026:11232:11657:11658:11914:12043:12292:12296:12438:12679:12682:12740:12760:12895:13148:13200:13229:13230:13439:13845:13972:14096:14097:14181:14659:14721:14849:21080:21094:21323:21451:21622:21740:30054:30080:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: truck09_789050c5fe254
X-Filterd-Recvd-Size: 3243
Message-ID: <a15062721388e1d7a9bdfe2ad57d5f872d9daa7a.camel@perches.com>
Subject: Re: s390: defective uses of va_arg in __debug_sprintf_event
From: Joe Perches <joe@perches.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
In-Reply-To: <20180409143934.3f27902c@mschwideX1>
References: <1523041723.6127.33.camel@perches.com>
         <20180409143934.3f27902c@mschwideX1>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 09 Apr 2018 07:38:27 -0700
Mime-Version: 1.0
X-Mailer: Evolution 3.28.0-4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 14:39 +0200, Martin Schwidefsky wrote:
> On Fri, 06 Apr 2018 12:08:43 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > debug_sprintf_event calls __debug_sprintf_event
> > with a format and arguments.
> > 
> > There various types of arguments used in these
> > call, but __debug_sprintf_event uses va_arg
> > with only long as the type argument so random
> > errors could occur because the type and argument
> > are supposed to match.
> > 
> >     debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
> >     {
> >     	    [...]
> >     	    va_start(ap, string);
> >     	    curr_event->string = string;
> >     	    for (idx = 0; idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1); idx++)
> >     	    	    curr_event->args[idx] = va_arg(ap, long);
> >     	    va_end(ap);
> >     	    [...]
> >     }
> > 
> > from man va_arg
> > 
> >     va_arg()
> > 
> >     if type is not compatible with the type of the actual next argument
> >     (as promoted according to the default argument promotions),
> >     random errors will occur.
> > 
> > For instance, uses like:
> > 
> > arch/s390/kernel/perf_cpum_sf.c:919:    debug_sprintf_event(sfdbg, 6, "pmu_enable: es=%i cs=%i ed=%i cd=%i "
> > arch/s390/kernel/perf_cpum_sf.c-920-                        "tear=%p dear=%p\n", cpuhw->lsctl.es, cpuhw->lsctl.cs,
> > arch/s390/kernel/perf_cpum_sf.c-921-                        cpuhw->lsctl.ed, cpuhw->lsctl.cd,
> > arch/s390/kernel/perf_cpum_sf.c-922-                        (void *) cpuhw->lsctl.tear, (void *) cpuhw->lsctl.dear);
> > 
> > where the first 3 arguments are int but their type
> > as used by va_arg in __debug_sprintf_event is long
> > which could produce random errors.
> 
> In principle you are right that the va_arg handling is not 100%
> correct. It works though because the C ABI for s390x requires
> that arguments are sign- or zero-extended to 64 bits by the caller
> of a function. This is true for values passed in registers and for
> the variable argument list.

Thanks.

Reference:
http://legacy.redhat.com/pub/redhat/linux/7.1/es/os/s390x/doc/lzsabi0.pdf
(found via your explanation)

It might be nice to explain that somewhere in
Documentation/s390 if it's not there already.
