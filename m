Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F73ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA52154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA52154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbeIUTEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:04:41 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35811 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbeIUTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:04:41 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so11354950oic.2;
        Fri, 21 Sep 2018 06:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pr2VGYt7cscNKaIlBAzAGjG56ZnRsJp4bZYgylJmbN8=;
        b=XUs7nukO35H5x5BEIa3UF5Oc4TKVcYiIy6Y7etcAeaYVbVWFVEZW/MNaf7IqNCugVt
         d8fwW8/4F9yV1c4Z4EncNSiFJ7R+lCHwMinBAZrFqVuNNwmFx7UC3kCK6cupHnHLmtni
         EvnV5zXn/EK45uWK1s1lgO6AINkBhk+d+9pouQK4oeFqJDApaj2WpCgyEYFL0la8OEfg
         CuZQRN/ErrgPQTiqH5/ArDsRUHSlYil1um2IiRO3ZD+yf8ydMDZaqP5RpFfAk7hfmWvs
         EjxsIhV7HaEIZKt3sYZvhF3xB6FJqG9pc1D1ZJzAXIXEC7Z4rvhWblCSIBMx9n9YBe4P
         kyAA==
X-Gm-Message-State: APzg51DDcIliVYBix2P4LhNVE+ivupU2+we118EnnwREz1T3uR9cY0x0
        7eCR50tsjAcMA7nG529o6JaSIWUVQ1u4Wd2aj0I=
X-Google-Smtp-Source: ANB0VdbfbFMUXyGXcUOnVzcScpQXppjmEZ6UdtwL70btki4Lr3DOIfZbj31CIGRZ5jNRiR3en1vY85v9dUz//bOirok=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr1434693oih.31.1537535751404;
 Fri, 21 Sep 2018 06:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180913160851.18169-1-vkuznets@redhat.com> <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com> <20180914162103.GA11171@redhat.com>
 <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
 <20180917165518.GA25931@redhat.com> <87d0t70zdn.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d0t70zdn.fsf@vitty.brq.redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Sep 2018 15:15:40 +0200
Message-ID: <CAJZ5v0jumjrJN2YgeuXK9eZ-JM2Vv73SFoH_71qZxyax24C+-Q@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 3:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 09/17, Rafael J. Wysocki wrote:
> >>
> >> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >> >
> >> > > > Since you are adding the notifier anyway, what about designing it to make
> >> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
> >> > > > fron suspend/hibernation?
> >> >
> >> > Well. I agree that freezable kthreads are not nice, but it seems you are
> >> > going to add another questionable interface ;)
> >>
> >> Why would it be questionable?
> >>
> >> The watchdog needs to be disarmed somehow before tasks are frozen and
> >> re-armed after they have been thawed or it may report false-positives
> >> on the way out.  PM notifiers can be used for that.
> >
> > Or watchdog() can simply use set_freezable/freezing interface we already
> > have, without additional complications.
> >
> > Yes, this is not "before tasks are frozen", but probably should work?
> >
> > OK, I won't argue.
>
> I was hoping you and Rafael will come to an agreement but the discussion
> just died ... so where do we stand on this? I see the following options:
>
> 1) The v1 patch is good, no freezing/disabling/parking required.

This would work IMO, but it also is somewhat wasteful to run this
thread when "suspended", because it doesn't do anything then.

Maybe you could simply force "timeout" to be zero for the "suspension"
time?  That should effectively make the thread sleep then, right?

Thanks,
Rafael
