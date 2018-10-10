Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B254C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E254D2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivBw6fli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E254D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJKAZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:25:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39562 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKAZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:25:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so2804119pgv.6;
        Wed, 10 Oct 2018 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H/aeCcXuEULT5Am8kmZxCptHnF6jj04f7i5EAvuvlWo=;
        b=ivBw6fliDhHu+9j8QxVCfVZHXDKhQnZJaVMraHptUtkieDIhxWlk6gnnnxggHcKBdd
         6knUm/3GtGBysMJqeKcfSoZuAW2uTrPDCugX6HmoYLZsmkbcM3i1L0v/GbeRjNyLM9zO
         JSey5JDvJvBIZoOI3aLxktB/ed0yeAgh8LC7Y9KWgLUGFjZzgiz/BUfWqShFG5wliB63
         LbLJl+EkZ+75wKM0nfpKb5rRnNW9zfh4tv4+4V48rxvgfMRqHdaBefCROILsLrX4b2Zo
         +f/L7Ij66ioPmutfVEswZDUoAM3EKIBacYm3fpKwnosU4X+pPKuRxL71C+bc7UipRoZm
         8O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/aeCcXuEULT5Am8kmZxCptHnF6jj04f7i5EAvuvlWo=;
        b=jN2U4wna52kfJVjuRLWaKW8PEHloAVK5ggGVndhFRkEQ55mmRPY9vXY79VopQJ09UO
         DihiYBC7wHOXYqdwwDp6xhatxEDe72DKsoxgi1ljHSwXTGvrN3c8jUq9VeDxIU7QLXNp
         Q/73/Y+yBk+OSHQFqYRN5E8VS+2qsWFrjRRt7Qt70bAQgkkhGrC36UWlX27MB4zpnR8c
         mwNj+3Acbb960cKQjmnLH1uaGub3z54FrdsCu259fMlMDm0lS1g3p9c7ynPRdLwmLRkf
         EC6j8xrdkF5G69ArYnQxybx0d4eqhJyhLfBwLTD6HkjLofWbtmjW2AywHszcx4aE/60v
         i0Qw==
X-Gm-Message-State: ABuFfoiUuLIdI/WTPK4iMjljX2m+0bdavz+DR1z3Ni8GqUlVt3amkT74
        NWRb0yUOdlu1zkLpvtgDvpQ=
X-Google-Smtp-Source: ACcGV61JLsb9kx4HQi9IMqMSRXTphc8SRfqBoo0LYeu8J/wVRz0jgwP4J+kj4+BwgiINdowSskqp5Q==
X-Received: by 2002:a63:31c8:: with SMTP id x191-v6mr29375266pgx.229.1539190943590;
        Wed, 10 Oct 2018 10:02:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 126-v6sm38432538pfd.16.2018.10.10.10.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:02:22 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:02:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010170219.GA47260@dtor-ws>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010142958.GF32006@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:29:58AM -0400, Sasha Levin wrote:
> On Mon, Oct 08, 2018 at 12:20:26PM -0700, Dmitry Torokhov wrote:
> > Hi Michael,
> > 
> > On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > > 
> > > Dmitry,
> > > 
> > > someone on debian-68k reported the bug, which (to me) indicates that the
> > > code is not just used by me.
> > > 
> > > Whether or not a functioning Capslock is essential to have? You be the
> > > judge of that. If you are OK with applying the keymap patch, why not
> > > this one?
> > 
> > I have exactly the same concerns about the keymap patch. This all has
> > not been working correctly for many many years (and it was not broken
> > in a subtly way as far as I understand, but rather quite obvious).
> > Thus I do not understand why this belongs to stable release. It is not
> > a [recent] regression, nor secutiry bug, nor even enabling of new
> > hardware, that is why I myself did not mark it as stable.
> > 
> > I still maintain that we pick up for stable too many patches for no
> > clear benefit. This is similar to the patch for Atmel controllers that
> > was picked to stable and I asked why, as it is not clear how many
> > users might be affected (or if the problem the patch was solving was
> > purely theoretical, or only affecting hardware that is not in
> > circulation yet).
> 
> If you belive that a certain piece of code has no actual users, why do
> you keep it in the upstream kernel to begin with?

Because obviously there are users. Maybe 5 of them, maybe 10. They do
not follow upstream very closely (otherwise these fixes would have
appeared in mainline long time ago) but they still exist. And it is not
hard to keep the driver in if there are not many changes.

> 
> I don't think it makes sense to keep something upstream because it might
> have users, but not backport fixes because there might not have any
> users.
> 
> You haven't seen evidence of anyone using/caring about it for a few
> years? Great! Remove the code and if someone complains we can always
> revert. This is how all those orphaned archs got removed a few releases
> back. I'll even submit the patch if you'd like.
> 
> It doesn't make sense to have "second class citizens" like how you
> suggested.

Sure does. Look, one of roles of a mantainer is basically a release
manager. We need to decide what goes into new release, what goes into
maintenance release, what stays until later milestone. Each release has
different criteria. With maintenance release you want to minimize the
disruption while alleviating most recent and critical/high visibility
issues, IOW you want to get the most bang for your buck. And these
particular fixes do not give you any bang, none at all.

Same goes for patches that deal with error handling in probe() functions
that your AUTOSEL scripts like to pick. Yes, they are fixing bugs. But
show me actually users affected by them? You encounter these issues with
probe when you do initial device bringup, but once device is stabilized
probes are expected to succeed. There won't be duplicate sysfs
attributes, memory will be allocated, and so on. Fixes to remove() might
be worthwhile if it is a hot-pluggable bus, but otherwise - no. Yes, the
box may OOPS if someone manually unbind device through sysfs, but the
solution is no to patch stable kernels, but simply tell user "dont to
that [yet]".

When selecting a patch for stable ask yourself: "if I do not pick this
for stable will a distribution be willing to patch this into their
kernel on their own"? If the answer is "no" it should be pretty strong
indicator whether a patch belongs to stable or not.

Thanks.

-- 
Dmitry
