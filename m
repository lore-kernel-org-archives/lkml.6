Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62029C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF7A26AC4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF7A26AC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755004AbeFZUQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:16:16 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:54751 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752201AbeFZUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:16:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1A3C8181D3417;
        Tue, 26 Jun 2018 20:16:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blow08_19317d07db05e
X-Filterd-Recvd-Size: 3751
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 20:16:12 +0000 (UTC)
Message-ID: <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dzickus@redhat.com, jtoppins@redhat.com
Date:   Tue, 26 Jun 2018 13:16:11 -0700
In-Reply-To: <20180626182505.4176-1-prarit@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
> OSes have additional maintainers that should be cc'd on patches or may
> want to circulate internal patches.
> 
> Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
> can begin with a '+' to indicate the email and list entries should be
> added to the exiting MAINTAINERS output, or a '-' to indicate that the
> entries should override the existing MAINTAINERS file.
> 
> Also add a help entry for the .get_maintainers.ignore file.

I see no reason for this patch to be applied.
Why should it?
Why shouldn't this be in your private repository?

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: dzickus@redhat.com
> Cc: jtoppins@redhat.com
> ---
>  scripts/get_maintainer.pl | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index c87fa734e3e1..239f4d2ce972 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -384,6 +384,32 @@ sub find_ignore_git {
>  read_all_maintainer_files();
>  
>  sub read_all_maintainer_files {
> +	my $conf = which_conf(".get_maintainer.MAINTAINERS");
> +	if ( -f $conf) {
> +	    my @conf_args;
> +	    my $add = 0;
> +	    open(my $conffile, '<', "$conf")
> +		or warn "$P: Can't find a readable .get_maintainer.MAINTAINERS file $!\n";
> +	    while (<$conffile>) {
> +		my $line = $_;
> +		if ($line =~ m/^\+/ ) {
> +		    $add = 1;
> +		}
> +		next if ($line =~ m/^\s*#/);
> +		$line =~ s/^\+//g;
> +		$line =~ s/^\-//g;
> +		$line =~ s/\s*\n?$//;
> +		push(@mfiles, $line);
> +	    }
> +	    close($conffile);
> +	    if ($add eq 0) {
> +		foreach my $file (@mfiles) {
> +		     read_maintainer_file("$file");
> +		}
> +		return;
> +	    }
> +	}
> +
>      if (-d "${lk_path}MAINTAINERS") {
>          opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
>          my @files = readdir(DIR);
> @@ -1068,6 +1094,14 @@ Notes:
>        Entries in this file can be any command line argument.
>        This file is prepended to any additional command line arguments.
>        Multiple lines and # comments are allowed.
> +  File ".get_maintainer.ignore", if it exists in the linux kernel source root
> +      directory, can contain a list of email addresses to ignore.  Multiple
> +      lines and # comments are allowed.
> +  File ".get_maintainer.MAINTAINERS", if it exists in the linux kernel source
> +      root directory, can change the location of the MAINTAINERS file.
> +      Entries beginning with a '+' are added to the default list, and
> +      entries beginning with a '-' override the existing MAINTAINERS list
> +      lookup.  Multiple lines and # comments are allowed.
>    Most options have both positive and negative forms.
>        The negative forms for --<foo> are --no<foo> and --no-<foo>.
>  
