Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbeE2QP1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:15:27 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:43394 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934877AbeE2QP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:15:26 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:2894:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3868:3870:3871:3872:3873:3874:4321:4823:5007:7904:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12114:12296:12438:12555:12740:12895:13180:13229:13439:13894:14181:14659:14721:21080:21221:21611:21627:30012:30051:30054:30070:30075:30079:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: salt44_4c2afb6f9124d
X-Filterd-Recvd-Size: 3524
Message-ID: <0ccd6834d0c4a24f351050d0cd7581e2d2aecd7c.camel@perches.com>
Subject: Re: [PATCH] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
From: Joe Perches <joe@perches.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 09:15:21 -0700
In-Reply-To: <59492aa2-a12d-4f74-0a5a-14f89de64908@c-s.fr>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
         <20180528131914.32231-1-msuchanek@suse.de>
         <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
         <20180529164640.02faedcd@kitsune.suse.cz>
         <59492aa2-a12d-4f74-0a5a-14f89de64908@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 15:24 +0000, Christophe Leroy wrote:
> On 05/29/2018 02:46 PM, Michal Suchánek wrote:
> > On Tue, 29 May 2018 16:13:49 +0200 Christophe LEROY <christophe.leroy@c-s.fr> wrote:
[]
> > diff --git a/arch/powerpc/kernel/security.c
> > > > b/arch/powerpc/kernel/security.c index 0239383c7e4d..a0c32d53980b
> > > > 100644 --- a/arch/powerpc/kernel/security.c
> > > > +++ b/arch/powerpc/kernel/security.c
> > > > @@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device
> > > > *dev, struct device_attribute *attr, c if
> > > > (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) return
> > > > sprintf(buf, "Not affected\n");
> > > > -	return sprintf(buf, "Vulnerable\n");
> > > > +	if (barrier_nospec_enabled)
> > > > +		return sprintf(buf, "Mitigation: __user pointer
> > > > sanitization\n");
> > > > +	else
> > > > +		return sprintf(buf, "Vulnerable\n");
> > > 
> > > Checkpatch would tell you that an else is unneeded after a return. So
> > > just leave it as it was before.
> > 
> > Where did you get your copy of checkpatch? The one in Linux tree does
> > not do that.

Correct as this particular style is a maintainer preference.

> Strange, it should, as checkpatch.pl includes the following code:
> 
> # check indentation of any line with a bare else
> # (but not if it is a multiple line "if (foo) return bar; else return baz;")

Note this comment and also that this case is

	if (foo)
		return bar;
	else
		return baz;

so no warning is generated.

> # if the previous line is a break or return and is indented 1 tab more...
> 		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
> 			my $tabs = length($1) + 1;
> 			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> 			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
> 			     defined $lines[$linenr] &&
> 			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
> 				WARN("UNNECESSARY_ELSE",
> 				     "else is not generally useful after a break or return\n" . 
> $hereprev);
> 			}
> 		}
> 
> 
> Anyway, you should remove that 'else' in your patch.
> And the other sprintf line is over 80 characters.
> 
> Christophe
> 
> > 
> > Thanks
> > 
> > Michal
> > 
