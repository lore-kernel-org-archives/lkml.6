Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF3C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFAB2087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dWUTO4O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFAB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJHBBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 21:01:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46440 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeJHBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 21:00:59 -0400
Received: by mail-io1-f65.google.com with SMTP id t7-v6so14203653ioj.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0D9FJ/tNqXn0mWKd+FjlS3m4YZMqgMyhJ4YkYLIcRCo=;
        b=dWUTO4O3w/bd91e2GgIsGE4B6SZLshTW8Yyroxws1+VBmaXrj9J/TJw+biO6MP9Lve
         w746UNWZ/ZzGytuh1F7I6F8FS7trWVAcgOL5Oj8XGZgMf6uqFsETbMB13lGVOpgeBQtb
         meQpVPYYF152WAmrvICpY4hndfsBo7xXooqr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0D9FJ/tNqXn0mWKd+FjlS3m4YZMqgMyhJ4YkYLIcRCo=;
        b=afUckTGoABUSQFoHpfiSUOUFzczA/vftfPhPaVsMyaYiU/s8o1oTvGAQV+X61p5V1s
         ZnQQOgSV0FMtv3qY5MjL9tqidIaNlpaxkwdoVmGcQNsOthd+6G5BwTpkao6gngjDdgZ/
         9TN+sZPFtBKWLwTk7u/5i0vWHEScaBXVruxtM+g9vwEcXqc1USWCw61fEefJPmrQRNFZ
         rh3Tb1ztt4qyPbP73D/pkQC+eif675VhRhlBEHmWMJD6UgdO//iJUnWRqOHtrtQ8UVKS
         Nz9cQiXkNiWUzlxnQgXT5oIYGzkOpsx7cRYSUO167W3IED4i0qmSYGhrO/WF9zuOwUaG
         a0xg==
X-Gm-Message-State: ABuFfoiFKDIBpXGGvVjYXEUd1ynufXrNY88PSRA2yke9P8PndGR7DIQw
        x3Eciv+zC1TQDFgJ9XVV9j7IA7ClyfDTh/r485RdcA==
X-Google-Smtp-Source: ACcGV61LUJ+cv13yb0rsJfBSsHYB05MJUEXQWcRlvI7e0rBiZtIOJ8f1gChNER8Vix8OY3Ircwvjgj79BhjIHPUUlGc=
X-Received: by 2002:a6b:8d88:: with SMTP id p130-v6mr14577460iod.34.1538934776611;
 Sun, 07 Oct 2018 10:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com> <1538934030.4010.1.camel@HansenPartnership.com>
In-Reply-To: <1538934030.4010.1.camel@HansenPartnership.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sun, 7 Oct 2018 19:52:45 +0200
Message-ID: <CAKMK7uG9pZX5_r_9q5O0+3f1vRjMb8xErBY=oup6RP2QxOunag@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 0/2] code of conduct fixes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 7:40 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2018-10-07 at 19:11 +0200, Daniel Vetter wrote:
> > Hi James,
> >
> > On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > We've had several threads discussing potential changes to the code
> > > of
> > > conduct but Mauro is the only person to have proposed an actual
> > > patch.
> > > In order to move the debate on, I'm presenting two patches, one to
> > > fix
> > > the email problem Mauro identified and the other to strip the
> > > enforcement section pending community discussion as Shuah
> > > suggested.
> > >
> > > I'll take responsibility for collecting any tags people want to add
> > > (review/ack/sign off, etc) and sending the patch in as a signed
> > > pull
> > > request before 4.19 final if they get enough community support.
> > >
> > > Note, I've sent both patches in as a series to facilitate review
> > > and
> > > discussion, but they are separable if one is looked on with less
> > > favour
> > > than the other.
> > >
> > > It was also a bit unclear which list to send this to, but I finally
> > > settled on linux-kernel as the catch all and ksummit-discuss since
> > > that's where most of the current discussion is.  I can add other
> > > lists
> > > as people suggest them.
> >
> > Personally I'm not happy at all with how the new code of conduct was
> > rushed in, least because I still don't understand why it happened,
> > but also for all the other reasons we've discussed here in the past
> > few weeks.
> >
> > For all the same reasons I don't think it's a good idea to now rush
> > in a few edits, just a few days before the 4.19 release. In my
> > experience, and I've discussed code of conducts and their enforcement
> > for years even before we implemented the fd.o/dri-devel one, mailing
> > lists aren't the best place to have this discussion. Definitely not
> > under the time pressure of just a few days to get it all sorted. I
> > hope that we can have these discussiones at the maintainer summit and
> > kernel summit/plumbers, and will have more clarity in a few weeks
> > (probably more likely months).
> >
> > But I also understand that there's lots of people (me included) who
> > don't want to ship a release with the code of conduct in it's current
> > in-between state. I think adding a disclaimer at the top, along the
> > lines of
> >
> > "Please note that this code of conduct and it's enforcement are still
> > under discussion."
>
> I don't disagree with the position, but eliminating our old code of
> conduct in favour of another we cast doubt on with this disclaimer
> effectively leaves us with nothing at all, which seems to be a worse
> situation.  In that case, I think reverting the CoC commit
> (8a104f8b5867c682) and then restarting the replacement process is
> better than adding a disclaimer to the new one.
>
> My preference is to try to fix what we have instead of starting over,
> but it's not a strong one, so if people want to go for the revert
> instead of the amendment, I'd be happy to redo the patch series with
> that.

I thought about adding something like "meanwhile the old Code of
Conflict stays in effect", but that already felt like editorializing,
and so could prevent the big pile of acks I think we need for any such
change. That's why I tried to limit my suggestion as much as possible
to stricly undisputed facts only (we _are_ discussing it still after
all). Personally I don't want to ack or nack any concrete changes
(including going back to the old one, if temporarily), as long as
Linus hasn't clarified why this was rushed and why he felt the change
was necessary.

Long term I'm all for getting this right of course, but figuring out
what "right" is in the context of the linux kernel community will take
a while longer than what we have until 4.19 ships (even with the 1
week extension, just read the -rc7 release announcement)..

Thanks, Daniel

> > would make this clear and ameliorate the concerns from many people
> > about the open questions we still have, at least for now. This would
> > give us the time to discuss all the details properly and with all due
> > deliberation. I'm travelling next week, so not the right guy to push
> > this, but I'd be happy to ack such a patch (or something along the
> > same lines). I also believe that this statement is undisputed enough
> > that we can gather widespread support for it in the few days left
> > until 4.19 ships to make it happen.
> >
> > Thanks, Daniel
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
