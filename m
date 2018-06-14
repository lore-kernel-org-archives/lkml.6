Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 337AAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F9A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDmLqnJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F9A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936095AbeFNPsD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:48:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41061 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbeFNPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:47:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so10167499lfa.8;
        Thu, 14 Jun 2018 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TDpCWFYvy1rsZmUIsxZ0ANar41MVN4h8xF6745KkPbo=;
        b=IDmLqnJrNrIpDL0vzqZl1F0ySMQkpIgkE+mtHoK2wOm2Z/L5gcXRdxha6KVadPnyno
         SwdcL5XQ+8WhMBHaftPLaKdNPfSiKsQZFmTqFHctNGT64iIAz8GGwyIEMpzKcA16x94V
         FkVp9U8BD+cRXabXoITy9peS9B9TA4ZqFinxrUk7afyq6RFj+8wzqwSvbv0FKwVvbPie
         WJAld1h50JeiD9k7xWitwKgMTxZ/hzFOsFeqOOuTJIpc1/NeUSrG0j3QG3o9rEDKBrBv
         ty1x/Zkm4wc2itJsxHjDgy3C8WrXQScs4V+DtMb5LiY71TQaD9F4JPO2wJ3DBciiCDEA
         mbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TDpCWFYvy1rsZmUIsxZ0ANar41MVN4h8xF6745KkPbo=;
        b=rggb/0W9vW7TNc+dV2b2wjYl8SEr3mAqh7XA8eTVIR8mWT5bvNbaqLR8TERUkNVRBS
         VdnihtlAjjkngQiHYRZlsA5+vxP6M6zf7fU0tv8DkLPXHmP0u3n+K9BDKi8hoXWOp0o8
         C5CnWaBFTOdgjQ+m7VpjhLJK+IqsWqIi/umzyhzQ7fjqgvIfQOd/4kYoLawHQAknhyqv
         y/D0C52X7uTqnQGLTVe8uE0vRLm69aMup5q1S1AH1ho6vS3k3CJR1TcFfvYBBAVdhdRN
         pnfEBjnzOCdmccjM0nPh+/Xs7c8d5UaxNv6p+3BE+bzKI0hI6SdaHpIx8FPGWEr9O1Dp
         IPWA==
X-Gm-Message-State: APt69E2rpymHycrEoi3sWL1BaXdPqX5fOxsuGrXBvC67+68S5rlsf5kP
        EAwCeyZBy5+/46t7NLEANq8=
X-Google-Smtp-Source: ADUXVKLIQzzXEkQO6KfvUevggclNa/Y++gtYsMDREcBbXDPEyePQyFNEDjMV8p7K9KL5I8OtbHVC9Q==
X-Received: by 2002:a19:1099:: with SMTP id 25-v6mr6187448lfq.112.1528991268313;
        Thu, 14 Jun 2018 08:47:48 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id l20-v6sm1127799lfg.14.2018.06.14.08.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 08:47:47 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fTUT7-0003ux-8X; Thu, 14 Jun 2018 17:47:26 +0200
Date:   Thu, 14 Jun 2018 17:47:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Message-ID: <20180614154725.GF32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost>
 <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost>
 <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
 <20180614145531.GE32411@localhost>
 <CAPybu_1ps+tEr5W_uvMSeH4_gwbjgKHnz0MoSEJO=Ut0a4sx6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPybu_1ps+tEr5W_uvMSeH4_gwbjgKHnz0MoSEJO=Ut0a4sx6Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 05:20:40PM +0200, Ricardo Ribalda Delgado wrote:
> Hi Johan,
> On Thu, Jun 14, 2018 at 4:55 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Jun 14, 2018 at 04:06:18PM +0200, Ricardo Ribalda Delgado wrote:
> > > Hi Johan,
> > > On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > And there are more issues with the series which are less apparent than
> > > > the rx (and partial tx) regression.
> > >
> > > Any hints about this? What else should I change on the series?
> >
> > There are implementation issues and there's the more fundamental
> > question about whether your approach to this is the right one.
> >
> > Like Rob, I'm not sure we want to have the device topology depend on a
> > kernel config symbol (serdev and your ttydev driver). We may need to
> > explore Rob's sibling-device idea further.
> 
> From my point of view, if the user enables serdev, then everything has
> to be a serdev, because serdev does not provide the same functionality
> as a core tty device I had to implement, serdev-ttydev.c. Which is
> nothing more than a wrapper.
> 
> It is very hacky, but allows replacing the core tty device with
> another serdev.

Yes, and I'm a bit surprised (and impressed) that you got it to work
(mostly) so easily.

My point was that we probably don't want the tty devices to move around
in the device hierarchy depending on if serdev (and your ttydev driver)
is enabled or not.

> > I also want to make sure that this can be used for discoverable buses
> > (e.g. the USB CEC device the I've used as an example before).
> >
> 
> I have tried your patch:
> 
> https://github.com/ribalda/linux/commit/5cb30b4ce6477132a23492c674d8b3dc81ecff86
> 
> the only issue is that the serdev device sometimes explotes (OOPS)
> when the usb is unplugged :S.
> 
> And that might be quite tricy to solve

Yes, we all know serdev doesn't support hotplug, that's why it's not
enabled for usbserial.

But when/if we get that sorted, we may want to be able to reuse some of
the matching infrastructure that a sysfs interface would use also for
discoverable buses (e.g. passing a compatible string to serdev core).

Also note that the interface you're proposing suffers from similar
problems as hotplug in that serdev drivers must be prepared to handle
devices going away at anytime; be it through your delete_device
interface or from a sysfs driver unbind (i.e. already an issue today!).

This would be were the oops comes from.

> > As for the current implementation there are both larger and smaller
> > issues, like for example:
> >
> >  - the fact that your sysfs and lookup interface does not use any
> >    locking whatsoever and thus is susceptible to races
> 
> I thought that sysfs access where serialised. If that is not the case
> yes, we need a lock.

It's only serialised per attribute.

> >  - your ttyport driver currently breaks the sysfs interface for all
> >    serial (core) devices by ignoring the attribute groups
> 
> Yep, you are right, I screwed up that one :).

Easy to miss.

> >  - the ttyport driver is arguably a hack with layering issues (which
> >    admittedly may be hard to avoid given the retrofitting of serdev into
> >    the tty layer)
> >
> > Again, I suggest you submit a subset of your series (aim at 10 patches
> > or so) as an RFC which can be used as a basis for further discussion. No
> > point in discussing every implementation detail if the underlying
> > approach needs to be revised.
> 
> Will do. Give me some time to give it a hand of paint.
> 
> Thanks for time reviewing my little moster

You're welcome.

Johan
