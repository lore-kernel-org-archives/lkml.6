Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0427C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0C022ACD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0C022ACD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeGFWJW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:09:22 -0400
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:44618 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932412AbeGFWJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:09:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 61B74182CED2A;
        Fri,  6 Jul 2018 22:09:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flame12_8b9cc4907d94c
X-Filterd-Recvd-Size: 3172
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 22:09:19 +0000 (UTC)
Message-ID: <5ebb181efcdd2cdb3c1ee8eac9bba26f5759a0ea.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Don Zickus <dzickus@redhat.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Date:   Fri, 06 Jul 2018 15:09:17 -0700
In-Reply-To: <20180706215851.sqpibusyqukbh55g@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <20180706175419.6irtvs64e6dbz7hk@redhat.com>
         <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
         <20180706184411.ilzbt7fxuje2nhx6@redhat.com>
         <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
         <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
         <20180706215851.sqpibusyqukbh55g@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 17:58 -0400, Don Zickus wrote:
> On Fri, Jul 06, 2018 at 02:36:28PM -0700, Joe Perches wrote:
> > > > > > Just trying to find ways to minimize our collection of private patches.
> > > > > 
> > > > > Perhaps that could be extended for your purpose
> > > > > with some additional argument like a specific
> > > > > optional directory/path where every subdirectory
> > > > > would be found.
> > > > 
> > > > So something like --find-maintainer-files=<dir> ?  I think that could work.
> > > 
> > > So --find-maintainers-files=./kernel/pci
> > > 
> > > would only look for MAINTAINERS files under kernel/pci?
> > 
> > Well, perhaps yes.   Perhaps it would also read
> > a top level MAINTAINERS file.  Dunno.  What seems
> > right to you?
> > 
> > I don't have an objection to
> > --find-maintainer-files=<path_or_file> where
> > the existing behavior of --find-maintainer-files
> > without <path_or_file> is all subdirs.
> > 
> > Perhaps something like the below
> > (some of this is whitespace change only)
> > ---
> >  scripts/get_maintainer.pl | 40 ++++++++++++++++++++++------------------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> > 
> 
> <snip>
> 
> > +
> > +    if (defined $find_maintainer_files) {
> > +	die "$P: invalid find-maintainer-files <$path>" if (!-d $path);
> 
> ^^^^^
> 
> Hi Joe,
> 
> Thanks for the patch!!  If I remove the above 'die' line I can pass in a
> file or a dir.  Otherwise the 'die' line prevents a 'file' from being used.

Change it to (!-e $file), I was just spitballing.

> Not sure if that is important for this patch or not.

It's not.

> We have an internal use case of multiple MAINTAINER files, some folks have
> more rights to patches than others so they are not allowed to be cc'd (think
> embargoed stuff).
> 
> So the 'file' usage would be useful for us.   But if you are against it, we can
> easily patch it out on our end.

cheers, Joe
