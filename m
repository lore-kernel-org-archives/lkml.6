Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeBAMyp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:54:45 -0500
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:53027 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752338AbeBAMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:54:43 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:2110:2197:2199:2393:2553:2559:2562:2828:2906:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4184:4321:4605:5007:6119:7903:7974:8957:9010:9040:9121:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12048:12291:12438:12555:12740:12760:12895:13095:13439:14180:14181:14659:14721:21060:21080:21221:21324:21325:21433:21451:21611:21627:30012:30034:30054:30062:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: class13_631da31767c19
X-Filterd-Recvd-Size: 4532
Message-ID: <1517489679.7489.31.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
From: Joe Perches <joe@perches.com>
To: "Brown, Nicholas" <nb930b@intl.att.com>,
        "apw@canonical.com" <apw@canonical.com>, "me@tobin.cc" <me@tobin.cc>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 01 Feb 2018 04:54:39 -0800
In-Reply-To: <1517481518.3063.92.camel@intl.att.com>
References: <1517343904.3063.33.camel@intl.att.com>
         <20180130202655.22990-1-nick.brown@att.com>
         <1517481518.3063.92.camel@intl.att.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 10:38 +0000, Brown, Nicholas wrote:
> Hi,
> 
> Would one of you be happy to pick this patch up for carrying into the next release?

Not me.

I think the metric is too simplistic and
not particularly useful.

If others want it, I think you should
try to build or find a bit more agreement
from the many other linux developers that
this change is actually desired by them.

> Thanks,
> Nick

cheers, Joe

> 
> On Tue, 2018-01-30 at 20:26 +0000, Nicholas Brown wrote:
> > Changed lines is the total of inserted and deleted lines.
> > By default there is no limit, --max-changed-lines may be used to set a
> > value. Some users may wish to encourage that patches are split into
> > smaller parts using this.
> > See Documentation/process/submitting-patches.rst#split-changes
> > 
> > Signed-off-by: Nicholas Brown <nick.brown@att.com>
> > ---
> >  scripts/checkpatch.pl | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 31031f10fe56..a71bc4f15ce7 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -49,6 +49,7 @@ my @ignore = ();
> >  my $help = 0;
> >  my $configuration_file = ".checkpatch.conf";
> >  my $max_line_length = 80;
> > +my $max_changed_lines; # undef = no max
> >  my $ignore_perl_version = 0;
> >  my $minimum_perl_version = 5.10.0;
> >  my $min_conf_desc_length = 4;
> > @@ -92,6 +93,8 @@ Options:
> >    --ignore TYPE(,TYPE2...)   ignore various comma separated message types
> >    --show-types               show the specific message type in the output
> >    --max-line-length=n        set the maximum line length, if exceeded, warn
> > +  --max-changed-lines=n      set the maximum number of changed lines allowed,
> > +                             if exceeded, warn. (insertions + deletions)
> >    --min-conf-desc-length=n   set the min description length, if shorter, warn
> >    --root=PATH                PATH to the kernel tree root
> >    --no-summary               suppress the per-file summary
> > @@ -209,6 +212,7 @@ GetOptions(
> >  	'show-types!'	=> \$show_types,
> >  	'list-types!'	=> \$list_types,
> >  	'max-line-length=i' => \$max_line_length,
> > +	'max-changed-lines=i' => \$max_changed_lines,
> >  	'min-conf-desc-length=i' => \$min_conf_desc_length,
> >  	'root=s'	=> \$root,
> >  	'summary!'	=> \$summary,
> > @@ -2165,6 +2169,8 @@ sub process {
> >  	my $filename = shift;
> >  
> >  	my $linenr=0;
> > +	my $inserted_lines_total=0;
> > +	my $deleted_lines_total=0;
> >  	my $prevline="";
> >  	my $prevrawline="";
> >  	my $stashline="";
> > @@ -2233,6 +2239,14 @@ sub process {
> >  
> >  		push(@fixed, $rawline) if ($fix);
> >  
> > +		if ($rawline=~/^\+/ && $rawline!~/^\+\+\+/) {
> > +			$inserted_lines_total++
> > +		}
> > +
> > +		if ($rawline=~/^-/ && $rawline!~/^---/) {
> > +			$deleted_lines_total++;
> > +		}
> > +
> >  		if ($rawline=~/^\+\+\+\s+(\S+)/) {
> >  			$setup_docs = 0;
> >  			if ($1 =~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
> > @@ -2306,6 +2320,13 @@ sub process {
> >  
> >  	$prefix = '';
> >  
> > +	#print "inserted: $inserted_lines_total\n";
> > +	#print "deleted: $deleted_lines_total\n";

Not much utility in the debugging code either.

> > +	if (defined $max_changed_lines &&
> > +	    ($inserted_lines_total+$deleted_lines_total > $max_changed_lines)) {
> > +		WARN("MAX_CHANGED_LINES", "please split the change into smaller parts\n");
> > +	}
> > +
> >  	$realcnt = 0;
> >  	$linenr = 0;
> >  	$fixlinenr = -1;
