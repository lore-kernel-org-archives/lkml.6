Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB58C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4A22449
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA4A22449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934468AbeGFSbS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:31:18 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:45774 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934251AbeGFSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:31:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C502718224D9E;
        Fri,  6 Jul 2018 18:31:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skirt30_7f4b5694a5619
X-Filterd-Recvd-Size: 3842
Received: from XPS-9350 (cpe-75-82-193-221.socal.res.rr.com [75.82.193.221])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 18:31:14 +0000 (UTC)
Message-ID: <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Don Zickus <dzickus@redhat.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Date:   Fri, 06 Jul 2018 11:31:13 -0700
In-Reply-To: <20180706175419.6irtvs64e6dbz7hk@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <20180706175419.6irtvs64e6dbz7hk@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 13:54 -0400, Don Zickus wrote:
> On Tue, Jun 26, 2018 at 01:16:11PM -0700, Joe Perches wrote:
> > On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
> > > OSes have additional maintainers that should be cc'd on patches or may
> > > want to circulate internal patches.
> > > 
> > > Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
> > > can begin with a '+' to indicate the email and list entries should be
> > > added to the exiting MAINTAINERS output, or a '-' to indicate that the
> > > entries should override the existing MAINTAINERS file.
> > > 
> > > Also add a help entry for the .get_maintainers.ignore file.
> > 
> > I see no reason for this patch to be applied.
> > Why should it?
> > Why shouldn't this be in your private repository?
> 
> Hi Joe,
> 
> Would you be open to a '--mfile=<path>/MAINTAINERS' option that would
> override the default ./MAINTAINERS file?  Then we could just add that to our
> .get_maintainers.conf file.

Hi Don.

Sure.

And that kinda already exists in mainline with
--find-maintainer-files where any subdirectory
that contains a MAINTAINER file is also read.

> Just trying to find ways to minimize our collection of private patches.

Perhaps that could be extended for your purpose
with some additional argument like a specific
optional directory/path where every subdirectory
would be found.

> Cheers,
> Don

cheers back, Joe

> > > +		$line =~ s/\s*\n?$//;
> > > +		push(@mfiles, $line);
> > > +	    }
> > > +	    close($conffile);
> > > +	    if ($add eq 0) {
> > > +		foreach my $file (@mfiles) {
> > > +		     read_maintainer_file("$file");
> > > +		}
> > > +		return;
> > > +	    }
> > > +	}
> > > +
> > >      if (-d "${lk_path}MAINTAINERS") {
> > >          opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
> > >          my @files = readdir(DIR);
> > > @@ -1068,6 +1094,14 @@ Notes:
> > >        Entries in this file can be any command line argument.
> > >        This file is prepended to any additional command line arguments.
> > >        Multiple lines and # comments are allowed.
> > > +  File ".get_maintainer.ignore", if it exists in the linux kernel source root
> > > +      directory, can contain a list of email addresses to ignore.  Multiple
> > > +      lines and # comments are allowed.
> > > +  File ".get_maintainer.MAINTAINERS", if it exists in the linux kernel source
> > > +      root directory, can change the location of the MAINTAINERS file.
> > > +      Entries beginning with a '+' are added to the default list, and
> > > +      entries beginning with a '-' override the existing MAINTAINERS list
> > > +      lookup.  Multiple lines and # comments are allowed.
> > >    Most options have both positive and negative forms.
> > >        The negative forms for --<foo> are --no<foo> and --no-<foo>.
> > >  
