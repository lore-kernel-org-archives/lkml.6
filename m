Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79CC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E7020848
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iNUqVXmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E7020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeKDCZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:25:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37228 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeKDCZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:25:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id p17so3377826lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3ibbediXh19pwY3KOgadh8Joc4RsLZOAzNKmhxaQYI=;
        b=iNUqVXmtwuq0yQwqm4++hldawPPz7bA5hzAok5ZHHV79yFh4R+6//LbKDRyazSorj0
         wRWr8MxC5sP0EADIgEqJcCLvDgc7m+DkMHLGmvbIPDYXF5x/v8W3/8CegzZuJ8gn9XMu
         zpfVWfn/pPNsZ65v+PnqxiJZiHKOrclYwQhlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3ibbediXh19pwY3KOgadh8Joc4RsLZOAzNKmhxaQYI=;
        b=IZr7jLV9GDBUNSZ0Tu7TM7b8VuHeqJdG7gB4n34jYZ5QnNpIjqQi6e5hK6xRGJ6wDj
         f6KpcYn5aXPsH1lKOorK87Sk2bxztimfoNg+jLNAVepqeZIpVYHLRvd/7/CTLnb/wa6o
         Q+jzK8IECYV52somchRdce2J7BP5Q9SxfIoPkUkbmwh5IfsBnj0yi63PrmMHJHpntid/
         hMqVWSltAT00d1L6GxX1uava1XKd37bVfibB4v9ORwz47bFHFZgEp3dH1L2bDZHqQPQL
         2yVKR40UkkMca/ErTIcLaTZ7KtwHVYku9bwUx1VM4uIx54oPsgZD+YuL9ILPi5a7ppDl
         /40w==
X-Gm-Message-State: AGRZ1gJUvY7Mt46hLUFHoquSJEoMWbnbv3HEWqVZeqXJu8L5Fx3YdMYR
        SJKiKz4FZ/53fRE3rQx9Vjy1IHexSU7M1w==
X-Google-Smtp-Source: AJdET5fyBLK5GrZUiVq98HbahG6NYr/DjJwSrTzsspdOdm+KPHvrjvx+oNCIUiwDeE16WE0NAf2dPw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr9217900lfb.72.1541265235824;
        Sat, 03 Nov 2018 10:13:55 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y14-v6sm6018134lfh.10.2018.11.03.10.13.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:13:54 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id x3-v6so4377163lji.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:13:54 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr11224943lji.133.1541265233631;
 Sat, 03 Nov 2018 10:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181102051459.GS6311@dastard> <CAHk-=whrpyMSWM4wxYE+E4fSbpkD3yBATjLnzvvAKBfhGwUaAw@mail.gmail.com>
 <20181102233651.GH19305@dastard>
In-Reply-To: <20181102233651.GH19305@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 10:13:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJdzKEq2RsQCe5R1X2W0AEiOYOt8womcyTfkD=mgQAug@mail.gmail.com>
Message-ID: <CAHk-=wiJdzKEq2RsQCe5R1X2W0AEiOYOt8womcyTfkD=mgQAug@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: fix many problems in vfs clone/dedupe implementation
To:     david@fromorbit.com
Cc:     djwong@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 4:36 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Nov 02, 2018 at 09:35:23AM -0700, Linus Torvalds wrote:
> >
> > I don't love the timing of this at the end of the merge window, but pulled,
>
> When would have been a better time? It's too big for a late -rc, and
> it contains stuff that needs fixing pretty urgently. So if the merge
> window is not appropriate, what should we have done here?

No, I think that with the timing of the problem finding, it was
probably the only thing to do, but generally I like these kinds of
somewhat scary and disruptive patches (just because it touches
multiple filesystems) _early_ in the merge window if at all possible,
and showing that the development was done before and not some rushed
thing..

                Linus
