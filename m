Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeA3QKQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:10:16 -0500
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:55892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751836AbeA3QKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:10:13 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3871:3872:3874:4321:4605:5007:7903:8603:8957:9010:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12438:12555:12740:12760:12895:13439:14181:14659:14721:21080:21221:21433:21451:21627:30012:30054:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: train26_5906014db530e
X-Filterd-Recvd-Size: 3691
Message-ID: <1517328610.765.22.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
From: Joe Perches <joe@perches.com>
To: "Brown, Nicholas" <nb930b@intl.att.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>
Date: Tue, 30 Jan 2018 08:10:10 -0800
In-Reply-To: <1517327844.3063.19.camel@intl.att.com>
References: <1517327844.3063.19.camel@intl.att.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 15:57 +0000, Brown, Nicholas wrote:
> Changed lines is the total of inserted and deleted lines.
> By default there is no limit, --max-changed-lines may be used to set a
> value. Some users may wish to encourage that patches are split into
> smaller parts using this.
> See Documentation/process/submitting-patches.rst#split-changes

(This patch seems whitespace damaged)

I don't care for this much as is either.

This patch doesn't add help text and it
should probably add a check for
	"if (!$file"
so new files aren't size limited.

Also, it double counts lines that are
added and deleted so doing things like
refactoring a block of code into a new
separate function would potentially trip
this.

> Signed-off-by: Nicholas Brown <nick.brown@att.com>
> ---
>  scripts/checkpatch.pl | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 31031f10fe56..1217d782b6bb 100755
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
> @@ -209,6 +210,7 @@ GetOptions(
>         'show-types!'   => \$show_types,
>         'list-types!'   => \$list_types,
>         'max-line-length=i' => \$max_line_length,
> +       'max-changed-lines=i' => \$max_changed_lines,
>         'min-conf-desc-length=i' => \$min_conf_desc_length,
>         'root=s'        => \$root,
>         'summary!'      => \$summary,
> @@ -2165,6 +2167,8 @@ sub process {
>         my $filename = shift;
>  
>         my $linenr=0;
> +       my $inserted_lines_total=0;
> +       my $deleted_lines_total=0;
>         my $prevline="";
>         my $prevrawline="";
>         my $stashline="";
> @@ -2233,6 +2237,14 @@ sub process {
>  
>                 push(@fixed, $rawline) if ($fix);
>  
> +               if ($rawline=~/^\+/) {
> +                 $inserted_lines_total++
> +               }
> +
> +               if ($rawline=~/^-/) {
> +                 $deleted_lines_total++
> +               }
> +
>                 if ($rawline=~/^\+\+\+\s+(\S+)/) {
>                         $setup_docs = 0;
>                         if ($1 =~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
> @@ -2306,6 +2318,11 @@ sub process {
>  
>         $prefix = '';
>  
> +       if (defined $max_changed_lines &&
> +           ($inserted_lines_total+$deleted_lines_total > $max_changed_lines)) {
> +         WARN("MAX_CHANGED_LINES", "please split the change into smaller parts\n");
> +       }
> +
>         $realcnt = 0;
>         $linenr = 0;
>         $fixlinenr = -1;
> -- 
> 2.14.1
