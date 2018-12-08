Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC39C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A02083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LrIzdi+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786A02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLHTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:25:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36317 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeLHTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:25:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so6314603ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwHXClNvtspF/1yG4BNNqr8nOes08zg16DPzczpsGE4=;
        b=LrIzdi+qYjkA4rK+6YE48F60n7XpwnH7Cp6OMfsRjbSpZkN6Ek23MD8Fcp+GsLWo6H
         MfU8nYpVUkQW8gyTnbfxtH+rQ6f1YMTs8313zGkbwitMl8TTpWiiDbLicSYT9oI60vCz
         AVCMXDPVTJqCfmzl4HHK+MxOvb/5Gs8O/BFTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwHXClNvtspF/1yG4BNNqr8nOes08zg16DPzczpsGE4=;
        b=p3i+lv2sK7w7YhNER1J9bMJGUbeAY7/JqO2/nA9aHq9r1j3meaoAeOuvw2T6HxrxUV
         kPcVajxy92QhmkZBEsfVxciDp4f0bd876bKi/W/MfAAAwtiCKsnI0ZHvBiSIDu+vHuOl
         17/nDmNxcW+42N89wFPFZd+F+DqQL5LbxFPMZLvb+xptCWEFcPsne6b3im+qGgeQLInG
         AyktMiuogcq3agpTlH8hf6DO6Y970MpSWhpqUDOt9mMIBjjUCWUSCytyuCSnoxTPP41O
         HvrArUggLuinPe9+Be74vNXppV7sYwZEJcyrZOeXtVRuDB7FTyOjuyR3LQJ7rX0eYtxi
         rGLw==
X-Gm-Message-State: AA+aEWaJckzScM34CSezg0nBg8KN9s3HHWlBk7o4YQ8H6AAFpNOd2Rtl
        QP6QOeCtrxhvkMeOxDMeUjTarqkACcs=
X-Google-Smtp-Source: AFSGD/X/g2ES+OtLgStgMbq9cLR2ZuM94Ql/izeDzHIFyre9vtGwc8clS/jb3hnMo8odYlNda2VqVQ==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr3923831ljg.150.1544297106105;
        Sat, 08 Dec 2018 11:25:06 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u12-v6sm1228014ljk.79.2018.12.08.11.25.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 11:25:05 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id c19-v6so6301713lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 11:25:04 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr4451416ljk.80.1544297104444;
 Sat, 08 Dec 2018 11:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20181208163639.GR24487@magnolia>
In-Reply-To: <20181208163639.GR24487@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Dec 2018 11:24:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
Message-ID: <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc6
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     david@fromorbit.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 8:36 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Finally, the most important fix is to the pipe splicing code (aka the
> generic copy_file_range fallback) to avoid pointless short directio
> reads by only asking the filesystem for as much data as there are
> available pages in the pipe buffer.  Our previous fix (simulated short
> directio reads because the number of pages didn't match the length of
> the read requested) caused subtle problems on overlayfs, so that part is
> reverted.

Honestly, I really wish you simply wouldn't send me "xfs" fixes that
aren't really xfs-specific at all.

All the splice patches (and honestly, I feel some of the iomap ones
too) that have come in through the xfs tree should have been handled
separately as actual VFS patches. Or at least had acks from Al or
something.

I'm looking at that splice patch, and my initial reaction was "Hmm.
but that breaks 0 vs -EAGAIN". But then I realized that that's why
you're validating pipe->nrbufs, because the special temporary
per-thread pipe is always supposed to be empty on entry, so a zero
length can't happen.

But just the fact that I felt like I had to go and look at one of
these commits makes me go "this is not an XFS fix at all, it shouldn't
have been treated as an XFS patch, and the original commit that
*caused* the problem shouldn't have been treated as one either".

So please. I want to feel like when I get a XFS pull from the XFS
maintainer, I don't need to worry about it, and I can just do the git
pull without having to check details.

But that means that when you do changes outside of XFS code, those
changes need to be handled _differently_. And they shouldn't be
bypassing Al etc. And even if you can't get an Ack from Al, send them
separately, so that I can check them without there being any XFS
issues that are mixed up with the pull.

So the patch looks good, and I'm merging this, but I really really
don't have to feel like I need to look at xfs pulls this way.

                 Linus
