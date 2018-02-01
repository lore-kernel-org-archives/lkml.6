Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeBARYT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:24:19 -0500
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:49869 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751783AbeBARYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:24:16 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:152:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7903:10004:10400:10450:10455:10848:11026:11232:11658:11914:12294:12296:12679:12740:12895:13069:13138:13231:13311:13357:13894:14096:14097:14181:14659:14721:19904:19999:21080:21433:21451:21611:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tramp10_7c503aefb2219
X-Filterd-Recvd-Size: 2594
Message-ID: <1517505852.7489.38.camel@perches.com>
Subject: Re: [PATCH] xfs: Add missing braces around xfs_scrub_agfl_info
 initializer
From: Joe Perches <joe@perches.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 01 Feb 2018 09:24:12 -0800
In-Reply-To: <20180201170826.GP4849@magnolia>
References: <1517480584-4588-1-git-send-email-geert@linux-m68k.org>
         <CAK8P3a1N-Yh65y6bEb+d7DwVOqB8ee=T1gM1cc7k6=cg1c3Jtw@mail.gmail.com>
         <20180201170826.GP4849@magnolia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 09:08 -0800, Darrick J. Wong wrote:
> On Thu, Feb 01, 2018 at 12:31:36PM +0100, Arnd Bergmann wrote:
> > On Thu, Feb 1, 2018 at 11:23 AM, Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > With gcc-4.1.2:
> > > 
> > >     fs/xfs/scrub/agheader.c: In function ‘xfs_scrub_agfl’:
> > >     fs/xfs/scrub/agheader.c:770: warning: missing braces around initializer
> > >     fs/xfs/scrub/agheader.c:770: warning: (near initialization for ‘sai.oinfo’)
> > > 
> > > The first member of struct xfs_scrub_agfl_info is no longer an integral
> > > type, but a struct.  Add the missing curly braces to fix this.
> > 
> > I suspect gcc-4.5 is affected as well, but not 4.6+
> > 
> > > --- a/fs/xfs/scrub/agheader.c
> > > +++ b/fs/xfs/scrub/agheader.c
> > > @@ -767,7 +767,7 @@ int
> > >  xfs_scrub_agfl(
> > >         struct xfs_scrub_context        *sc)
> > >  {
> > > -       struct xfs_scrub_agfl_info      sai = { 0 };
> > > +       struct xfs_scrub_agfl_info      sai = { { 0 } };
> > >         struct xfs_agf                  *agf;
> > 
> > Looks ok to me, but
> > 
> >         struct xfs_scrub_agfl_info      sai = { };
> > 
> > might be slightly better in case the first member changes again.
> 
> Frankly I'd rather see it changed to memset(&sai, 0, sizeof(sai)); and
> stop having to field all these gcc warnings that vary depending on
> compiler version...

trivia:

memset should also be preferred if the structure
could be copied to userspace as the "= {}" is not
guaranteed to zero any possible padding or member
alignment holes.
