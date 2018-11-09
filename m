Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C09C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF7420818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxrmCphr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF7420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKJGZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:25:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38606 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:25:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so1443342pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3SfWPtbWnrvTxx7ryc2hKc5WGKd/vHTE+uvsgMrSwU=;
        b=IxrmCphr2F0ucAcA3Nu750M2xfgN8DS2weNqjGcIbJ5w3VZ+VTQcDaGFBbtuKfjrTE
         zuVmvlRQ1TMa5Ra/BMV7iNMXny64QgPqrcir/6deAgqOdDuQon6nhfd6WW86f/vFW+Bu
         LujA/mn+3QP11E+U4n66JgFuMqMZbyeO3OJGYvP3K1dw/8dlrLeL+oFlrtyXM1bJERsv
         SiFEXLbxbXtiTuUQuvH6xYRDKdNHi0z0ZIPn30ECoAWKmMe4im2p5ay/J0MzNK96e66e
         DYN2OJQav3MuM3SZ6qdVQ5AyAZaqXMs8RDaYPUHOHuPdFn7EXfSdVMRS9i5akKWqyf3s
         h6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3SfWPtbWnrvTxx7ryc2hKc5WGKd/vHTE+uvsgMrSwU=;
        b=F2Q0TXEwxPmJkecaqkaZfpfOSZ/PQYV3gmJdPdZofJUqwOyOQu/LkcQrAPGP1teoFQ
         yTZinM8VvL4pQsf4AfDIAqbKDqXUUDkVeSAjLMxLE+rZlGUSk7B3dKM7jHYZE9vpeTLn
         LsY+fuzkNFTGGEttgYIqlkPmMxWWivXTkAm99+pxXCMkNlxTXPwOpsZHTVVwwl9iXKuy
         1uMHYNQfQgoBhN3RrQkWAOyXDoKAKxhBbNA/d6/jnJbl+Auv1b2Fk1XN45rCTADXQpMn
         4ZOR2UpPsNpgHbCWVBqdH3cwS4iNhgZUFhAcHmO4IwzcX0sKlo22VHInAjRGs/1nH2SK
         g/dg==
X-Gm-Message-State: AGRZ1gIR52tvJryvwI2jMbUtx4zCGXBO8xHACg8tysr4BIXGEkHRmIM1
        Gf586Zrbh0xU85llN/8coSs=
X-Google-Smtp-Source: AJdET5fxPEPymE3FYCuOeu3DLEjsxf3lUaCa9bLWne/snHESQiQG67PmzUW7KdBwKhCIP/h7txmlIQ==
X-Received: by 2002:a63:e101:: with SMTP id z1mr8853748pgh.310.1541796215244;
        Fri, 09 Nov 2018 12:43:35 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h62-v6sm9790920pfg.27.2018.11.09.12.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:43:34 -0800 (PST)
Date:   Fri, 9 Nov 2018 12:43:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Genki Sky <sky@genki.is>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
Message-ID: <20181109204333.GA8498@roeck-us.net>
References: <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com>
 <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net>
 <20181107.210731.330601031@genki.is>
 <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
 <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109183436.GA45531@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:34:37AM -0800, Brian Norris wrote:
> git-diff-index does not refresh the index for you, so using it for a
> "-dirty" check can give misleading results. Commit 6147b1cf19651
> ("scripts/setlocalversion: git: Make -dirty check more robust") tried to
> fix this by switching to git-status, but it overlooked the fact that
> git-status also writes to the .git directory of the source tree, which
> is definitely not kosher for an out-of-tree (O=) build. That is getting
> reverted.
> 
> Fortunately, git-status now supports avoiding writing to the index via
> the --no-optional-locks flag, as of git 2.14. It still calculates an
> up-to-date index, but it avoids writing it out to the .git directory.
> 
> So, let's retry the solution from commit 6147b1cf19651 using this new
> flag first, and if it fails, we assume this is an older version of git
> and just use the old git-diff-index method.
> 
> Cc: Genki Sky <sky@genki.is>
> Cc: Christian Kujau <lists@nerdbynature.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Working for me with git v2.7.4.

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> On Fri, Nov 09, 2018 at 11:55:26AM +0900, Masahiro Yamada wrote:
> > > On Wed, Nov 7, 2018 at 1:18 PM Doug Anderson <dianders@chromium.org> wrote:
> > > > On Wed, Nov 7, 2018 at 1:07 PM Genki Sky <sky@genki.is> wrote:
> > > > > On Wed, 7 Nov 2018 12:55:14 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > Ubuntu 16.04 ships with git version 2.7.4.
> > > > >
> > > > > Okay. I guess --no-optional-locks is a no-go then.
> > > >
> > > > In theory you could wrap it.  If passing git with
> > > > "--no-optional-locks" doesn't work you could fall back to the old
> > > > code?  That would mean only people with newer git would get your new
> > > > feature and everyone else would stick with the pre-existing behavior.
> > >
> > > +1, that's what I was going to suggest. Presumably older git would
> > > give non-zero exit status for unknown flags, and we take that as
> > > signal to try to the old way?
> > 
> > I also like this idea!
> > 
> > I will pick-up this revert patch soon.
> > 
> > 
> > Brian,
> > Could you please send a patch on top of that?
> 
> Done.
> 
> It's not supremely beautiful, but I believe it works. I tested with new
> git, and with a faked git wrapper that rejects --no-optional-locks,
> dumps an error to stderr, and returns a non-zero exit code. I don't
> happen to have an older copy of git lying around at the moment...
> 
>  scripts/setlocalversion | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 71f39410691b..eab1f90de50d 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -73,8 +73,19 @@ scm_version()
>  			printf -- '-svn%s' "`git svn find-rev $head`"
>  		fi
>  
> -		# Check for uncommitted changes
> -		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
> +		# Check for uncommitted changes.
> +		# First, with git-status, but --no-optional-locks is only
> +		# supported in git >= 2.14, so fall back to git-diff-index if
> +		# it fails. Note that git-diff-index does not refresh the
> +		# index, so it may give misleading results. See
> +		# git-update-index(1), git-diff-index(1), and git-status(1).
> +		local git_status
> +		git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
> +		if [ $? -eq 0 ]; then
> +			if echo "$git_status" | grep -qv '^.. scripts/package'; then
> +				printf '%s' -dirty
> +			fi
> +		elif git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
>  			printf '%s' -dirty
>  		fi
>  
> -- 
> 2.19.1.930.g4563a0d9d0-goog
