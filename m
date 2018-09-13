Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A260B20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A260B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIMONT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:13:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44216 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeIMONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:13:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so577412oth.11;
        Thu, 13 Sep 2018 02:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTBDTCN+avDE0VHfH/L88RANFkgm8jULENDyOcOUNhw=;
        b=j7aNeOy0IggDYiry74Ki65zmh/8TgrlHe02jj8UHmZUz2QUPYESKOXh9VGqBtt/jbA
         RZweFeVsAHO30LYpRq6yp+bnBDuGm5Lx1mokeccGbpTQBS6OqC+KL6Y2Kn1txwGLt+qn
         v5cnit5MDH6d5sjGO+KXeewKlT218+zhYhPx7svypP3YYxVMnOMljXiBT3ra+TPCxUn8
         jt/siq6fqB8zvG0XAVgLDLAj98+23NE4MD7RlbguFR+v69nFLFCOcxKA16sYsat5+vd3
         QcwootZ3OtuLHF6oh2dQW0cqKfx3QyDRvl9h0AizAfpWonoj5uiBal9TiYf+D9ERvcQa
         S7Mw==
X-Gm-Message-State: APzg51A9aJ71wMcnnQS/HRV5/LiFeei60XuLTk3bhJFl5aKTsYUvGucO
        z5vAavUOPxwhA/zoROIYs6M17B2YKoowUlVr0Kchew==
X-Google-Smtp-Source: ANB0VdblEq2S5oXvRSSGDp7fVlzvYG5BgOy8bUQTMSMQ2DQugVacGN6bO+ZlOKMTRHUDDQiX+4VsFl4tXVvg/mI/gPk=
X-Received: by 2002:a9d:26ee:: with SMTP id i43-v6mr570660otd.35.1536829486460;
 Thu, 13 Sep 2018 02:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180912161119.2692-1-vkuznets@redhat.com> <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
 <875zz9ainn.fsf@vitty.brq.redhat.com>
In-Reply-To: <875zz9ainn.fsf@vitty.brq.redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Sep 2018 11:04:34 +0200
Message-ID: <CAJZ5v0gEGfHTEPQ3MpFQeviDBv174aoJjGR45NJfzkRerxQhjQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Sep 13, 2018 at 10:47 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> It is possible to observe hung_task complaints when system goes to
> >> suspend-to-idle state:
> >>
> >>  PM: Syncing filesystems ... done.
> >>  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >>  OOM killer disabled.
> >>  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >>  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >>  INFO: task bash:1569 blocked for more than 120 seconds.
> >>        Not tainted 4.19.0-rc3_+ #687
> >>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>  bash            D    0  1569    604 0x00000000
> >>  Call Trace:
> >>   ? __schedule+0x1fe/0x7e0
> >>   schedule+0x28/0x80
> >>   suspend_devices_and_enter+0x4ac/0x750
> >>   pm_suspend+0x2c0/0x310
> >
> > This actually is a good catch, but the problem is related to what
> > happens to the monotonic clock during suspend to idle.
> >
> > The clock issue needs to be addressed anyway IMO and then this problem
> > will go away automatically.
>
> Do I understand it correctly that the suggestion is to fully suspend
> monothonic clock in s2idle (and don't advance it after resume)?

Something like that.

We already do that to some extent, but kind of with the assumption
that it will not grow too much in s2idle_loop(), but it may actually
grow too much in there, so we need to compensate for that to make the
s2idle behavior reflect the suspend-to-RAM one.

I have a patch for that, will post it shortly.

Thanks,
Rafael
