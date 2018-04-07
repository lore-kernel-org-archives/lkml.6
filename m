Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeDGBBE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 21:01:04 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:50034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752128AbeDGBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 21:01:03 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3743:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:8825:9108:10004:10400:10848:11026:11232:11658:11914:12043:12050:12438:12555:12679:12740:12760:12895:12986:13095:13161:13229:13439:14180:14181:14659:14721:21060:21080:21324:21433:21451:21627:21740:30029:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: work98_7d57b5be7f54c
X-Filterd-Recvd-Size: 3693
Message-ID: <1523062859.6127.59.camel@perches.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Joe Perches <joe@perches.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 18:00:59 -0700
In-Reply-To: <20180407003301.GB386@tigerII.localdomain>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
         <1522971908.11185.46.camel@perches.com>
         <1522972535.11185.49.camel@perches.com>
         <20180406235214.GA386@tigerII.localdomain>
         <1523059179.6127.45.camel@perches.com>
         <20180407003301.GB386@tigerII.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-07 at 09:33 +0900, Sergey Senozhatsky wrote:
> Hi Joe,
> 
> On (04/06/18 16:59), Joe Perches wrote:
> > > 
> > > Can we tweak checkpatch to catch such things?
> > 
> > Not really, no.
> > 
> > Adding regex logic for this is tricky at best
> > and probably not worth the effort because of
> > the various bits of patch contexts aren't
> > necessarily visible.
> 
> Agreed. I was more thinking about catching "... %p" and saying
> that we'd rather prefer either "... %p," or "... %p " or "... %p\n".
> Doesn't sound so complex, can probably catch something fishy one day
> (or may be not), and more or less is visible to checkpatch. Well,
> more or less...

This finds the current two bad uses in addition to
the existing similar message for string concatenation
without a space char between concatenated fragments.

For example:

WARNING: break quoted strings at a space character
#3550: FILE: drivers/scsi/megaraid/megaraid_sas_base.c:3550:
+			dev_notice(&instance->pdev->dev, "moving cmd[%d]:%p:%d:%p"
+					"on the defer queue as internal\n",

WARNING: vsprintf %p<extension> string concatenation
#3550: FILE: drivers/scsi/megaraid/megaraid_sas_base.c:3550:
+			dev_notice(&instance->pdev->dev, "moving cmd[%d]:%p:%d:%p"
+					"on the defer queue as internal\n",

I think the new message is not that useful really as the
existing warning is probably enough.

---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eb534d48140e..a0e43232431e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5313,6 +5313,12 @@ sub process {
 			     "break quoted strings at a space character\n" . $hereprev);
 		}
 
+# check for vsprintf pointer extension concatenation
+		if ($prevrawline =~ /\%p"\s*$/ && $rawline =~ /^\+\s*"\w/) {
+			WARN('POINTER_CONCATENATION',
+			     "vsprintf %p<extension> string concatenation\n" . $hereprev);
+		}
+
 # check for an embedded function name in a string when the function is known
 # This does not work very well for -f --file checking as it depends on patch
 # context providing the function name or a single line form for in-file
