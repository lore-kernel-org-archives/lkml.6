Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B630DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B4222465
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B4222465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeGFTrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:47:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934654AbeGFTrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9501A407446D;
        Fri,  6 Jul 2018 19:47:23 +0000 (UTC)
Received: from redhat.com (ovpn-124-65.rdu2.redhat.com [10.10.124.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5278879DC;
        Fri,  6 Jul 2018 19:47:23 +0000 (UTC)
Date:   Fri, 6 Jul 2018 15:47:23 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
Message-ID: <20180706194723.ikdwl77xtntl2bfz@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
 <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
 <20180706175419.6irtvs64e6dbz7hk@redhat.com>
 <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 19:47:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 19:47:23 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:31:13AM -0700, Joe Perches wrote:
> On Fri, 2018-07-06 at 13:54 -0400, Don Zickus wrote:
> > On Tue, Jun 26, 2018 at 01:16:11PM -0700, Joe Perches wrote:
> > > On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
> > > > OSes have additional maintainers that should be cc'd on patches or may
> > > > want to circulate internal patches.
> > > > 
> > > > Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
> > > > can begin with a '+' to indicate the email and list entries should be
> > > > added to the exiting MAINTAINERS output, or a '-' to indicate that the
> > > > entries should override the existing MAINTAINERS file.
> > > > 
> > > > Also add a help entry for the .get_maintainers.ignore file.
> > > 
> > > I see no reason for this patch to be applied.
> > > Why should it?
> > > Why shouldn't this be in your private repository?
> > 
> > Hi Joe,
> > 
> > Would you be open to a '--mfile=<path>/MAINTAINERS' option that would
> > override the default ./MAINTAINERS file?  Then we could just add that to our
> > .get_maintainers.conf file.
> 
> Hi Don.
> 
> Sure.
> 
> And that kinda already exists in mainline with
> --find-maintainer-files where any subdirectory
> that contains a MAINTAINER file is also read.
> 
> > Just trying to find ways to minimize our collection of private patches.
> 
> Perhaps that could be extended for your purpose
> with some additional argument like a specific
> optional directory/path where every subdirectory
> would be found.

Would you be ok with something like this?  This seems to solve our problem
cleanly.  If you are ok with it or need some tweaks, I will send a more
formal patch.

Cheers,
Don

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 8e8ac50f018c..ced7fd664862 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -60,7 +60,7 @@ my $pattern_depth = 0;
 my $self_test = undef;
 my $version = 0;
 my $help = 0;
-my $find_maintainer_files = 0;
+my $find_maintainer_files = '';
 my $rh_only = 1;
 
 my $vcs_used = 0;
@@ -263,7 +263,7 @@ if (!GetOptions(
 		'sections!' => \$sections,
 		'fe|file-emails!' => \$file_emails,
 		'f|file' => \$from_filename,
-		'find-maintainer-files' => \$find_maintainer_files,
+		'find-maintainer-files=s' => \$find_maintainer_files,
 		'self-test:s' => \$self_test,
 		'v|version' => \$version,
 		'h|help|usage' => \$help,
@@ -425,7 +425,7 @@ sub read_all_maintainer_files {
         find( { wanted => \&find_is_maintainer_file,
                 preprocess => \&find_ignore_git,
                 no_chdir => 1,
-        }, "${lk_path}");
+        }, "${lk_path}$find_maintainer_files");
     } else {
         push(@mfiles, "${lk_path}MAINTAINERS") if -f "${lk_path}MAINTAINERS";
     }
