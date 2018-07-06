Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346C22147E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346C22147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbeGFRyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:54:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933964AbeGFRyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:54:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD0A972647;
        Fri,  6 Jul 2018 17:54:19 +0000 (UTC)
Received: from redhat.com (ovpn-124-65.rdu2.redhat.com [10.10.124.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id 74B452026D68;
        Fri,  6 Jul 2018 17:54:19 +0000 (UTC)
Date:   Fri, 6 Jul 2018 13:54:19 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
Message-ID: <20180706175419.6irtvs64e6dbz7hk@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
 <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 17:54:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 17:54:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 01:16:11PM -0700, Joe Perches wrote:
> On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
> > OSes have additional maintainers that should be cc'd on patches or may
> > want to circulate internal patches.
> > 
> > Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
> > can begin with a '+' to indicate the email and list entries should be
> > added to the exiting MAINTAINERS output, or a '-' to indicate that the
> > entries should override the existing MAINTAINERS file.
> > 
> > Also add a help entry for the .get_maintainers.ignore file.
> 
> I see no reason for this patch to be applied.
> Why should it?
> Why shouldn't this be in your private repository?

Hi Joe,

Would you be open to a '--mfile=<path>/MAINTAINERS' option that would
override the default ./MAINTAINERS file?  Then we could just add that to our
.get_maintainers.conf file.

Just trying to find ways to minimize our collection of private patches.

Cheers,
Don

> 
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: dzickus@redhat.com
> > Cc: jtoppins@redhat.com
> > ---
> >  scripts/get_maintainer.pl | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > index c87fa734e3e1..239f4d2ce972 100755
> > --- a/scripts/get_maintainer.pl
> > +++ b/scripts/get_maintainer.pl
> > @@ -384,6 +384,32 @@ sub find_ignore_git {
> >  read_all_maintainer_files();
> >  
> >  sub read_all_maintainer_files {
> > +	my $conf = which_conf(".get_maintainer.MAINTAINERS");
> > +	if ( -f $conf) {
> > +	    my @conf_args;
> > +	    my $add = 0;
> > +	    open(my $conffile, '<', "$conf")
> > +		or warn "$P: Can't find a readable .get_maintainer.MAINTAINERS file $!\n";
> > +	    while (<$conffile>) {
> > +		my $line = $_;
> > +		if ($line =~ m/^\+/ ) {
> > +		    $add = 1;
> > +		}
> > +		next if ($line =~ m/^\s*#/);
> > +		$line =~ s/^\+//g;
> > +		$line =~ s/^\-//g;
> > +		$line =~ s/\s*\n?$//;
> > +		push(@mfiles, $line);
> > +	    }
> > +	    close($conffile);
> > +	    if ($add eq 0) {
> > +		foreach my $file (@mfiles) {
> > +		     read_maintainer_file("$file");
> > +		}
> > +		return;
> > +	    }
> > +	}
> > +
> >      if (-d "${lk_path}MAINTAINERS") {
> >          opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
> >          my @files = readdir(DIR);
> > @@ -1068,6 +1094,14 @@ Notes:
> >        Entries in this file can be any command line argument.
> >        This file is prepended to any additional command line arguments.
> >        Multiple lines and # comments are allowed.
> > +  File ".get_maintainer.ignore", if it exists in the linux kernel source root
> > +      directory, can contain a list of email addresses to ignore.  Multiple
> > +      lines and # comments are allowed.
> > +  File ".get_maintainer.MAINTAINERS", if it exists in the linux kernel source
> > +      root directory, can change the location of the MAINTAINERS file.
> > +      Entries beginning with a '+' are added to the default list, and
> > +      entries beginning with a '-' override the existing MAINTAINERS list
> > +      lookup.  Multiple lines and # comments are allowed.
> >    Most options have both positive and negative forms.
> >        The negative forms for --<foo> are --no<foo> and --no-<foo>.
> >  
