Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161239AbeBNRdA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:33:00 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:33972 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161026AbeBNRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:32:58 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:965:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2553:2559:2562:2691:2693:2828:2909:2919:3138:3139:3140:3141:3142:3354:3622:3653:3865:3867:3870:3872:3873:3874:4321:4390:4605:5007:9040:10004:10400:10848:11026:11232:11658:11914:12043:12296:12438:12555:12740:12760:12895:13439:14093:14097:14181:14659:14721:21080:21221:21324:21433:21451:21611:21627:30003:30016:30022:30029:30054:30064:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: sort17_53b0b41563245
X-Filterd-Recvd-Size: 3622
Message-ID: <1518629573.3678.7.camel@perches.com>
Subject: Re: KASAN: use-after-free Read in rds_tcp_tune
From: Joe Perches <joe@perches.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        syzbot <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Date: Wed, 14 Feb 2018 09:32:53 -0800
In-Reply-To: <CACT4Y+Y4iK+xRUUssSSomqv59GDnVWt+O86tHHmUFESFQisrrw@mail.gmail.com>
References: <001a1141a524c513ca05628d8ad4@google.com>
         <20180112183046.GA26098@oracle.com>
         <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com>
         <20180214152109.GF11528@oracle.com>
         <CACT4Y+bKpi8he1ygwAxgm4F_RJ=BRPBPdMaVAK64SbvCVGt7ww@mail.gmail.com>
         <20180214153555.GG11528@oracle.com>
         <CACT4Y+ZZjE9fsnsQ-uab3RMt_Zpe98nKF1Pcj31ZGepYsi1UGA@mail.gmail.com>
         <1518627728.3678.2.camel@perches.com>
         <CACT4Y+Y4iK+xRUUssSSomqv59GDnVWt+O86tHHmUFESFQisrrw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 18:16 +0100, Dmitry Vyukov wrote:
> On Wed, Feb 14, 2018 at 6:02 PM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-02-14 at 16:55 +0100, Dmitry Vyukov wrote:
> > > On Wed, Feb 14, 2018 at 4:35 PM, Sowmini Varadhan <sowmini.varadhan@oracle.com> wrote:
> > > > btw, checkpatch.pl complains about the syzbot*@syzkaller.appspotmail.com
> > > > addresses as "Unrecognized email address", we should fix that
> > > > error from checkpatch at some point.
> > > 
> > > Interesting. Looking at checkpatch.pl I think it wants all addresses
> > > to be in <>, i.e.
> > > Reported-by: <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>
> > > There probably was some reason to enforce this, so I think I will
> > > change the syzbot email template to include <>.
> > > Thanks!
> > 
> > Not really.
> > 
> > It's the somewhat unusual + in the address
> > that perl needs quoted before a substitution.
> > 
> > I believe this fixes it in checkpatch.
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -1075,7 +1075,7 @@ sub parse_email {
> >         } elsif ($formatted_email =~ /(\S+\@\S+)(.*)$/) {
> >                 $address = $1;
> >                 $comment = $2 if defined $2;
> > -               $formatted_email =~ s/$address.*$//;
> > +               $formatted_email =~ s/\Q$address\E.*$//;
> >                 $name = $formatted_email;
> >                 $name = trim($name);
> >                 $name =~ s/^\"|\"$//g;
> 
> 
> I can confirm that running
> $ git show HEAD | scripts/checkpatch.pl -
> on a commit that contains a syzbot Reported-by tag does not produce
> the warning anymore.
> 
> Joe, do you mind mailing this as patch?

'course not.  It's nice you tested it.

I did on the last thousand commits without
apparent change.

$ git log --format=oneline --no-merges -1000 | \
  cut -f1 -d" " | \
  while read commit ; do \
    ./scripts/checkpatch.pl --git $commit --types=bad_sign_off --terse ; \
  done
