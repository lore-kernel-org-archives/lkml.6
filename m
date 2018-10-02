Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C707BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964332064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964332064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJBPLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:11:10 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44166 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJBPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:11:10 -0400
Received: by mail-ot1-f53.google.com with SMTP id 36-v6so1046758oth.11;
        Tue, 02 Oct 2018 01:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6FNWhcpFys3Rg2iv1YKrFduKPbg8m4AkSTRPFtraaw=;
        b=lOOjvCkDySymA2o8+OgkxpwK0oAwsTOxNT+t1xfcTc16LcU+cqKRTdRmK31+dLz+hW
         UbqnfsbPwcqkcOfr72loJ2D7qt8OPLdtASSBZslUChKbCX/PNN164mb4jPJ3L7lYBa0R
         S7MitQjHw+oCvtemEq4GY7chzzD2klkFSiYjzKMyLTVKoY+24LkFJeFJRAPuYkMNu0tj
         bqS+/pFaUrkwEZotALb6kPky3yss01OjGCwCB5MkeullQ/dkEoNbZPTlgfjtdT6sg1rN
         yMH9LVoxkqAHoyCdLXNfNGpaeK8yLMepFSsYFhz6bCNJdmVEnOxZcgY6y3TlrgoY9C2+
         CgBw==
X-Gm-Message-State: ABuFfohwQ9PphRe6aWdHhMOidZPNjmYiVr6XSwzKwD0XGg0t8bJ+/oy2
        VuAMNiwptniWajpjfOHUyo0VfKRQjmzAmZBV5a4=
X-Google-Smtp-Source: ACcGV60R0NKRLFjJwijP5GHn76b6s5+SCcZERx1qbBO77yfnRAc3y3XidqkgqdVRU8fC0ZwBeTGQYfwyHS4w7Jse85c=
X-Received: by 2002:a9d:7303:: with SMTP id e3-v6mr8038972otk.124.1538468944873;
 Tue, 02 Oct 2018 01:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
In-Reply-To: <20181002080554.GC19677@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Oct 2018 10:28:53 +0200
Message-ID: <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
To:     Pavel Machek <pavel@ucw.cz>, Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, dkota@codeaurora.org,
        Dmitry Torokhov <dtor@chromium.org>, swboyd@chromium.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 10:05 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > In general Linux doesn't behave super great if you get an error while
> > executing a device's resume handler.  Nothing will come along later
> > and and try again to resume the device (and all devices that depend on
> > it), so pretty much you're left with a non-functioning device and
> > that's not good.
> >
> > However, even though you'll end up with a non-functioning device we
> > still don't consider resume failures to be fatal to the system.  We'll
> > keep chugging along and just hope that the device that failed to
> > resume wasn't too critical.  This establishes the precedent that we
> > should at least try our best not to fully bork the system after a
> > resume failure.
> >
> > I will argue that the best way to keep the system in the best shape is
> > to assume that if a resume callback failed that it did as close to
> > no-op as possible.  Because of this we should consider the device
> > still suspended and shouldn't try to suspend the device again next
> > time around.  Today that's not what happens.  AKA if you have a
> > device
>
> I don't think there are many guarantees when device resume fail. It
> may have done nothing, and it may have resumed the device almost
> fully.
>
> I guess the best option would be to refuse system suspend after some
> device failed like that.
>
> That leaves user possibility to debug it...

I guess so.

Doing that in all cases is kind of risky IMO, because we haven't taken
the return values of the ->resume* callbacks into account so far
(except for printing the information that is), so there may be
non-lethal cases when that happens and the $subject patch would make
them not work any more.

Thanks,
Rafael
