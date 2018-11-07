Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1696C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940D2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IhkqhTGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbeKGLu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:50:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43321 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbeKGLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:50:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so6667384pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 18:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXJuwMdnKdcZmg2PYlRQXcRxbjBtideLzDOVmrUYhJI=;
        b=IhkqhTGudBFosrjaOk8xYs0YPT10wBRytOEDkDrIEdWT1y8HZCz9dh0C2RSMJiSYHf
         MI89IkprFxOKlmEFhielrzBBIN7HeSNE2x+1+AChHbCcDrWLtz6ZjeZuW78cdP4bS3mu
         EBW1f8pVv1gbPHna/kktfE7zI6zB49i7VDO5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXJuwMdnKdcZmg2PYlRQXcRxbjBtideLzDOVmrUYhJI=;
        b=Nqt/tMQXmZgACNu+6Wbj6Gk4UpzgtQNKXly3NzBohebTyrSMzgp+mkqQj+FtS90Y/r
         bST2RgL+YovzCvHMUwQxiyVZPGiv+QF0DoUc1Kjj7BWSxMPeD7ELiI2n8GpwX1bpthIV
         2pgYzZKVLlRwFcv9sBcKEDROPAnEit89/CQqJeRolas14GBAIfjXZeZBsQGT/XyKEE4Y
         itkefFoB7foTRw0bfn6n1EMOEB+VJ8zdMu/uV65JkDj3zdVDLhC3mkIirNlbupGEfPm4
         LwGCKk7a4Vm6+6VyoycfwH73FM/m1wEr9RVWB96f9U1zAY9x+6pOqFOijfiH6ELgX3lK
         TpDw==
X-Gm-Message-State: AGRZ1gKpngWbJgGpXcUbPmWuoq2mRoojS+5xQoVNtF3LVWW04W1n4Ha8
        WKvmHcYqHAmfKZAkbqDEPhZa1g==
X-Google-Smtp-Source: AJdET5cf8iBWMZtt1QMH+I9ywq05kuQo8Z+h1l3FUpn1k0nHD4EQ89kIv+2yLgdyaaEShrJT59krjg==
X-Received: by 2002:a62:500c:: with SMTP id e12-v6mr84059pfb.30.1541557328320;
        Tue, 06 Nov 2018 18:22:08 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id v37sm30279491pgn.5.2018.11.06.18.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 18:22:07 -0800 (PST)
Date:   Tue, 6 Nov 2018 18:22:04 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Genki Sky <sky@genki.is>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christian Kujau <lists@nerdbynature.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
Message-ID: <20181107022156.GA254567@google.com>
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106.192305.406697677@genki.is>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Genki,

On Tue, Nov 06, 2018 at 11:23:05AM -0800, Genki Sky wrote:
> On Tue,  6 Nov 2018 10:10:38 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> > This reverts commit 6147b1cf19651c7de297e69108b141fb30aa2349.
> >
> > The reverted patch results in attempted write access to the source
> > repository, even if that repository is mounted read-only.
> >
> > Output from "strace git status -uno --porcelain":
> >
> > getcwd("/tmp/linux-test", 129)          = 16
> > open("/tmp/linux-test/.git/index.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =
> > 	-1 EROFS (Read-only file system)
> >
> > While git appears to be able to handle this situation, a monitored build
> > environment (such as the one used for Chrome OS kernel builds) may detect
> > it and bail out with an access violation error. On top of that, the attempted
> > write access suggests that git _will_ write to the file even if a build output
> > directory is specified. Users may have the reasonable expectation that the
> > source repository remains untouched in that situation.

I've seen the same problem, by way of working with the same kernel build
system ;)

> Hmm, so in summary: According to 6147b1cf1965
> ("scripts/setlocalversion: git: Make -dirty check more robust",
> 2018-08-28), one scenario requires the index to be refreshed to get a
> correct "dirty" or "not dirty" status. But according to your commit
> here, another scenario requires the kernel build system to not even
> attempt to update the git index, and doesn't care / aren't impacted by
> the cases where the index needs to be refreshed.

I agree with Guenter, that if you're specifying a different build
directory, the source tree should not be written to at all.

> Perhaps both scenarios could be satisfied by having
> scripts/setlocalversion first check if .git has write permissions, and
> acting accordingly. Looking into history, this actually used to be
> done, but cdf2bc632ebc ("scripts/setlocalversion on write-protected
> source tree", 2013-06-14) removed the updating of the index.

A "writeable" check (e.g., [ -w . ]) would be sufficient for our case.
But I'm not so sure about that older NFS report, and I'm also not sure
that we should be writing to the source tree at all in this case. Maybe
we can also check whether there's a build output directory specified?

> However, I admit I don't understand the justification in that commit
> from 2013. I'm no NFS expert, but perhaps the real problem there is an
> incorrectly configured NFS setup (uid/gid mismatch between NFS
> client/server, or permissions mismatch between mount options and NFS
> server?). Christian Kujau: can you speak to that?
> 
> Well, we could also make our check $(touch .git/some-file-here
> 2>/dev/null && ...) instead of $(test -w .git) to handle misconfigured
> NFS setups. But not sure if that has its own problems.

Trying to 'touch' the source tree will also break us. No matter whether
you redirect stderr, our sandbox will still notice the build is doing
something fishy and complain.

In any case, I'd be very happy with a Revert for now (for 4.20, and even
-stable), and a follow-up replacement, so:

Reviewed-by: Brian Norris <briannorris@chromium.org>

for the $subject patch.
