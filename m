Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE5D22ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE5D22ACC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754477AbeGFV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:58:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754450AbeGFV6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:58:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12D99406AE3F;
        Fri,  6 Jul 2018 21:58:52 +0000 (UTC)
Received: from redhat.com (ovpn-124-65.rdu2.redhat.com [10.10.124.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id BEB2D111DD00;
        Fri,  6 Jul 2018 21:58:51 +0000 (UTC)
Date:   Fri, 6 Jul 2018 17:58:51 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
Message-ID: <20180706215851.sqpibusyqukbh55g@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
 <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
 <20180706175419.6irtvs64e6dbz7hk@redhat.com>
 <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
 <20180706184411.ilzbt7fxuje2nhx6@redhat.com>
 <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
 <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 06 Jul 2018 21:58:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 06 Jul 2018 21:58:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:36:28PM -0700, Joe Perches wrote:
> > > > > Just trying to find ways to minimize our collection of private patches.
> > > > 
> > > > Perhaps that could be extended for your purpose
> > > > with some additional argument like a specific
> > > > optional directory/path where every subdirectory
> > > > would be found.
> > > 
> > > So something like --find-maintainer-files=<dir> ?  I think that could work.
> > 
> > So --find-maintainers-files=./kernel/pci
> > 
> > would only look for MAINTAINERS files under kernel/pci?
> 
> Well, perhaps yes.   Perhaps it would also read
> a top level MAINTAINERS file.  Dunno.  What seems
> right to you?
> 
> I don't have an objection to
> --find-maintainer-files=<path_or_file> where
> the existing behavior of --find-maintainer-files
> without <path_or_file> is all subdirs.
> 
> Perhaps something like the below
> (some of this is whitespace change only)
> ---
>  scripts/get_maintainer.pl | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 

<snip>

> +
> +    if (defined $find_maintainer_files) {
> +	die "$P: invalid find-maintainer-files <$path>" if (!-d $path);

^^^^^

Hi Joe,

Thanks for the patch!!  If I remove the above 'die' line I can pass in a
file or a dir.  Otherwise the 'die' line prevents a 'file' from being used.

Not sure if that is important for this patch or not.

We have an internal use case of multiple MAINTAINER files, some folks have
more rights to patches than others so they are not allowed to be cc'd (think
embargoed stuff).

So the 'file' usage would be useful for us.   But if you are against it, we can
easily patch it out on our end.

Prarit,

I believe this patch still does what we want (and handles your pci example).

Cheers,
Don

> +	find( { wanted => \&find_is_maintainer_file,
> +		preprocess => \&find_ignore_git,
> +		no_chdir => 1,
> +	      }, "${path}");
>      } else {
> -        push(@mfiles, "${lk_path}MAINTAINERS") if -f "${lk_path}MAINTAINERS";
> +	push(@mfiles, "${path}MAINTAINERS") if -f "${path}MAINTAINERS";
>      }
>  
> +    die "$P: No MAINTAINER files found in $path\n" if (scalar(@mfiles) == 0);
>      foreach my $file (@mfiles) {
> -        read_maintainer_file("$file");
> +	read_maintainer_file("$file");
>      }
>  }
>  
