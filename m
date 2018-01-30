Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeA3TJs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:09:48 -0500
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:40417 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751662AbeA3TJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:09:48 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1801:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3874:4321:4605:4823:5007:7903:8957:9010:9040:9121:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12295:12438:12555:12740:12760:12895:13095:13439:14181:14659:14721:21080:21221:21433:21451:21627:30034:30054:30062:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wound01_3816bc3380b4b
X-Filterd-Recvd-Size: 3821
Message-ID: <1517339384.765.31.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
From: Joe Perches <joe@perches.com>
To: Nicholas Brown <nickbroon@gmail.com>, apw@canonical.com
Cc: linux-kernel@vger.kernel.org, Nicholas Brown <nick.brown@att.com>
Date: Tue, 30 Jan 2018 11:09:44 -0800
In-Reply-To: <20180130190123.9669-1-nick.brown@att.com>
References: <1517335455.3063.28.camel@intl.att.com>
         <20180130190123.9669-1-nick.brown@att.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 19:01 +0000, Nicholas Brown wrote:
> Changed lines is the total of inserted and deleted lines.
> By default there is no limit, --max-changed-lines may be used to set a
> value. Some users may wish to encourage that patches are split into
> smaller parts using this.
> See Documentation/process/submitting-patches.rst#split-changes

Still whitespace damaged.
Indentations use tabs not 2 spaces.

and another issue below

> Signed-off-by: Nicholas Brown <nick.brown@att.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 31031f10fe56..2847109b4def 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -49,6 +49,7 @@ my @ignore = ();
>  my $help = 0;
>  my $configuration_file = ".checkpatch.conf";
>  my $max_line_length = 80;
> +my $max_changed_lines; # undef = no max
>  my $ignore_perl_version = 0;
>  my $minimum_perl_version = 5.10.0;
>  my $min_conf_desc_length = 4;
> @@ -92,6 +93,8 @@ Options:
>    --ignore TYPE(,TYPE2...)   ignore various comma separated message types
>    --show-types               show the specific message type in the output
>    --max-line-length=n        set the maximum line length, if exceeded, warn
> +  --max-changed-lines=n      set the maximum number of changed lines allowed,
> +                             if exceeded, warn. (insertions + deletions)
>    --min-conf-desc-length=n   set the min description length, if shorter, warn
>    --root=PATH                PATH to the kernel tree root
>    --no-summary               suppress the per-file summary
> @@ -209,6 +212,7 @@ GetOptions(
>  	'show-types!'	=> \$show_types,
>  	'list-types!'	=> \$list_types,
>  	'max-line-length=i' => \$max_line_length,
> +	'max-changed-lines=i' => \$max_changed_lines,
>  	'min-conf-desc-length=i' => \$min_conf_desc_length,
>  	'root=s'	=> \$root,
>  	'summary!'	=> \$summary,
> @@ -2165,6 +2169,8 @@ sub process {
>  	my $filename = shift;
>  
>  	my $linenr=0;
> +	my $inserted_lines_total=0;
> +	my $deleted_lines_total=0;
>  	my $prevline="";
>  	my $prevrawline="";
>  	my $stashline="";
> @@ -2233,6 +2239,14 @@ sub process {
>  
>  		push(@fixed, $rawline) if ($fix);
>  
> +		if ($rawline=~/^\+/) {
> +		  $inserted_lines_total++

This counts patch header blocks with \+\+\+

> +		}
> +
> +		if ($rawline=~/^-/) {
> +		  $deleted_lines_total++
> +		}

and \-\-\-

> +
>  		if ($rawline=~/^\+\+\+\s+(\S+)/) {
>  			$setup_docs = 0;
>  			if ($1 =~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
> @@ -2306,6 +2320,11 @@ sub process {
>  
>  	$prefix = '';
>  
> +	if (defined $max_changed_lines &&
> +	    ($inserted_lines_total+$deleted_lines_total > $max_changed_lines)) {
> +	  WARN("MAX_CHANGED_LINES", "please split the change into smaller parts\n");
> +	}
> +
>  	$realcnt = 0;
>  	$linenr = 0;
>  	$fixlinenr = -1;
