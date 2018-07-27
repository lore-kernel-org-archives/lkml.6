Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F201C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3586D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3586D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbeG0CPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:15:42 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:43219 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731479AbeG0CPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:15:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D8E41180A885C;
        Fri, 27 Jul 2018 00:56:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quilt45_8eebc54036c52
X-Filterd-Recvd-Size: 3253
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 00:56:22 +0000 (UTC)
Message-ID: <bb5ceade84df0a3c067eac2deabd6d62acd24fa0.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Allow usage outside of kernel tree
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Antonio Nino Diaz <antonio.ninodiaz@arm.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 26 Jul 2018 17:56:20 -0700
In-Reply-To: <20180726153946.3d81bf367cef7fe241bb3741@linux-foundation.org>
References: <04452ac6-1575-f612-72c6-6ea88e70a9d5@arm.com>
         <20180726153946.3d81bf367cef7fe241bb3741@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 15:39 -0700, Andrew Morton wrote:
> On Tue, 26 Jun 2018 11:07:03 +0100 Antonio Nino Diaz <antonio.ninodiaz@arm.com> wrote:
> 
> > Add option '--no-tree' to get_maintainer.pl script to allow using this
> > script in projects that aren't the Linux kernel if they use the same
> > format for their MAINTAINERS file. This command is also available in
> > checkpatch.pl, for example.
> > 
> 
> Seems OK to me?

Me too. (modulo the spaces)

> Please note that your email client is converting tabs to spaces.
> 
> > --- a/scripts/get_maintainer.pl
> > +++ b/scripts/get_maintainer.pl
> > @@ -48,6 +48,7 @@ my $output_roles = 0;
> >  my $output_rolestats = 1;
> >  my $output_section_maxlen = 50;
> >  my $scm = 0;
> > +my $tree = 1;
> >  my $web = 0;
> >  my $subsystem = 0;
> >  my $status = 0;
> > @@ -255,6 +256,7 @@ if (!GetOptions(
> >                 'subsystem!' => \$subsystem,
> >                 'status!' => \$status,
> >                 'scm!' => \$scm,
> > +               'tree!' => \$tree,
> >                 'web!' => \$web,
> >                 'letters=s' => \$letters,
> >                 'pattern-depth=i' => \$pattern_depth,
> > @@ -319,7 +321,7 @@ if ($email &&
> >      die "$P: Please select at least 1 email option\n";
> >  }
> > 
> > -if (!top_of_kernel_tree($lk_path)) {
> > +if ($tree && !top_of_kernel_tree($lk_path)) {
> >      die "$P: The current directory does not appear to be "
> >         . "a linux kernel source tree.\n";
> >  }
> > @@ -1031,13 +1033,14 @@ Other options:
> >    --sections => print all of the subsystem sections with pattern matches
> >    --letters => print all matching 'letter' types from all matching sections
> >    --mailmap => use .mailmap file (default: $email_use_mailmap)
> > +  --no-tree => run without a kernel tree
> >    --self-test => show potential issues with MAINTAINERS file content
> >    --version => show version
> >    --help => show this help information
> > 
> >  Default options:
> > -  [--email --nogit --git-fallback --m --r --n --l --multiline --pattern-depth=0
> > -   --remove-duplicates --rolestats]
> > +  [--email --tree --nogit --git-fallback --m --r --n --l --multiline
> > +   --pattern-depth=0 --remove-duplicates --rolestats]
> > 
> >  Notes:
> >    Using "-f directory" may give unexpected results:
> 
> 
