Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649B320882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWEd45GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfA1K52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:57:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42535 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1K52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:57:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so7819439pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 02:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVYWtGcMYfFrMfJPBE9msQ46Zw2VTYoiELafs7+LoJc=;
        b=IWEd45GCMqZObIwFOhKrEAxo92cSxfHp/ZJiXp0hgf1CSZa312empmTbYb+/w9YTqf
         zeenJOs95bvTnIyOWQ4+nBec2Ea76OcmiVaz0CbtM+KvmNf+Pt6KywNkMQCu3Jdf2sZe
         jaUZlSF8qLoTMIh+Mf7Eakv/gppQwvDpIQFkyYn90tOyK3SAwBIzqzb+JIN/k7ezypNV
         SKcNf7EGAtaXu36vQxUcnU4cnieF/DS2uQHZpG1TDdpMmbOy8iUfJNChs5mizX4z01pH
         zLzKDvCH8kRjgHRx4k+I8/ELhekVxXoKPoFHBynGwxUfpyPKZ0Fz9MmQx06pvEvbgreA
         mGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVYWtGcMYfFrMfJPBE9msQ46Zw2VTYoiELafs7+LoJc=;
        b=K8AjHSWJrK82BOFSGqLALMOXxtILKOU5gP9sNSE512tXjrVv7DCKWnbuz/4fr57l3S
         rvPL7AMx/rHFDYf9GYS5Jkb7wBYDl9nEL2ZNEHAMWxHyjG2aMgtLDz15QJ4JhCTrDK2e
         shLnWTdXkflnIFbSW/8HXhwoKy5IMSDSCeTJDWMnjDfps10XEC0wCUU0N9lSsV2WO1ME
         KmH23FgCA9SRswwTF3gOk+NkzIwwmThmS5UqJ85f8RVwjK5GyG1jBUFrvt3WeTBLMCM5
         O5DJuNBvLyNwnU0v8E6TTaSU4XJJhCwdA7hR7rUA5Evokl0ig2kPoDrDhawnCRVFWVca
         5UjQ==
X-Gm-Message-State: AJcUukeOCUk5IIq3BLbFZweUau0tFj0VHlvAWQpwEYwKsikR/1BouOp/
        tuYznhn8rJmO1olBnXHU5Eo=
X-Google-Smtp-Source: ALg8bN7cKZzqabNZqs7bfU5SRdpB/X6QKQSgIjrpBZhNELkoV9wtMkpVAEMJ1RTqOzkOyFDR5Csulg==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr19120353pgh.394.1548673047647;
        Mon, 28 Jan 2019 02:57:27 -0800 (PST)
Received: from localhost ([175.223.18.40])
        by smtp.gmail.com with ESMTPSA id s190sm43732837pfb.103.2019.01.28.02.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 02:57:26 -0800 (PST)
Date:   Mon, 28 Jan 2019 19:57:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     valdis.kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20190128105723.GA10453@jagdpanzerIV>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu>
 <20190128091627.GA27972@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128091627.GA27972@quack2.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/28/19 10:16), Jan Kara wrote:
> On Sun 27-01-19 16:36:34, valdis.kletnieks@vt.edu wrote:
> > On Sun, 27 Jan 2019 17:00:27 +0100, Pavel Machek said:
> > > > > I've noticed this as well on earlier kernels (next-20181224 to 20190115)
> > > > > Some more info:
> > > > > 1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.
> > > > This aspect is curious as it indicates that kcompactd could potentially
> > > > be infinite looping but it's not something I've experienced myself. By
> > > > any chance is there a preditable reproduction case for this?
> > >
> > > I seen it exactly once, so not sure how reproducible this is. x86-32
> > > machine, running chromium browser, so yes, there was some swapping
> > > involved.
> > 
> > I don't have a surefire replicator, but my laptop (x86_64, so it's not a 32-bit
> > only issue) triggers it fairly often, up to multiple times a day. Doesn't seem to
> > be just the Chrome browser that triggers it - usually I'm doing other stuff as
> > well, like a compile or similar.  The fact that 'drop_caches' clears it  makes me
> > wonder if we're hitting a corner case where cache data isn't being automatically
> > cleared and clogging something up.
> 
> So my buffer_migrate_page_norefs() is certainly buggy in its current
> incarnation (as a result block device page cache is not migratable at all).
> I've sent Andrew a patch over week ago but so far it got ignored. The patch
> is attached, can you give it a try whether it changes something for you?
> Thanks!

Hello Jan,

Just for note,
I'm seeing the same problems on my x86 box [1]. Don't have a reproducer
for the issue yet, but will try to test your patch.

Thanks.

[1] https://lore.kernel.org/lkml/20190128085747.GA14454@jagdpanzerIV/T/#u

	-ss
