Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D5020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D5020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeIMUhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:37:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35134 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeIMUhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:37:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so1613865otl.2;
        Thu, 13 Sep 2018 08:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWBACdNhndPRe1m110y8zIJ9k2GWWuP+ZcQAq6Js6pQ=;
        b=CWKGddL4si6teowg2h2ej6Vn8H2WYhUx+9I+2WfHAopnFJMs01Y3TnSp8Rn/l8itdD
         JrpLgPk8abXpGxUH9cDkUowAqdAN1IZQ+ozQofUfg+dp1gmxuoPupwxPCjAsb9ynfKZZ
         3jYzEwNvl0HfavG6hWa62R3Fq4gJUOfRuAjgHf8QDNjR29hpR+/q8aYBH0+FWCAzq2+Y
         cB+94yJi6fcs5v33nbkvDDL0NMMhWwjA7aJXWT3I5TTEPiQwOxPWF3owx8RIcstrMvU6
         0RJ1LQWK8PwDSCB1O4Z8urNaAKjFXdgE+ewcyU15DrwP4uFjambM10kuDAGMckL8Cm+C
         YTyg==
X-Gm-Message-State: APzg51DevXSA9fvM+OYSZ0VEYLokSGSDLvCydvKphcQKdCPpRDY31Bbd
        udVp6wOTNOc4CbYruJzpliSX2sW8/FALAPSZojE=
X-Google-Smtp-Source: ANB0VdbP40Grqav5hJYZceYuBbbau4tH/xzArA4JrGLwDYWOyBir2TVFOWO+C5BLB9QPVx6CNKbczCyvg9hXB0HfJEk=
X-Received: by 2002:a9d:4287:: with SMTP id r7-v6mr1617669ote.282.1536852451669;
 Thu, 13 Sep 2018 08:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180912161119.2692-1-vkuznets@redhat.com> <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
 <20180913152307.GA31894@redhat.com>
In-Reply-To: <20180913152307.GA31894@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Sep 2018 17:27:20 +0200
Message-ID: <CAJZ5v0gmwvVa_YT8JQvDsW58xmubtKT58bH77zz8c5FdA8Py8Q@mail.gmail.com>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:23 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 09/13, Rafael J. Wysocki wrote:
> >
> > On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > >
> > > It is possible to observe hung_task complaints when system goes to
> > > suspend-to-idle state:
> > >
> > >  PM: Syncing filesystems ... done.
> > >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> > >  OOM killer disabled.
> > >  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> > >  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > >  INFO: task bash:1569 blocked for more than 120 seconds.
> > >        Not tainted 4.19.0-rc3_+ #687
> > >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > >  bash            D    0  1569    604 0x00000000
> > >  Call Trace:
> > >   ? __schedule+0x1fe/0x7e0
> > >   schedule+0x28/0x80
> > >   suspend_devices_and_enter+0x4ac/0x750
> > >   pm_suspend+0x2c0/0x310
> >
> > This actually is a good catch, but the problem is related to what
> > happens to the monotonic clock during suspend to idle.
> >
> > The clock issue needs to be addressed anyway IMO and then this problem
> > will go away automatically.
>
> I don't understand your discussion with Vitaly, but shouldn't we make
> khungtaskd thread freezable anyway?

Well, if the Vitaly's patch is applied, that shouldn't be necessary
and I wouldn't like to add more freezable kernel threads if that's
avoidable TBH.

Cheers,
Rafael
