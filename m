Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3351A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3351A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeIQNwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:52:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37689 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeIQNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:52:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id o13-v6so10417330otl.4;
        Mon, 17 Sep 2018 01:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypu6GC/X0Rc4nGXarfF3HH2ufX6J83ZggtiXzqbwJjc=;
        b=VH8qlYl9uSKjSRvboTjk2Wp8VNeiu7k9D3g3KC8DrmZTYWkcYYgqqv/b758d00DqpS
         /TtHCMAnFNIMIdxhNSNQtorbzukf9wGS5TKlYQG56Z4Ha7+NSG4B98YeQm8+iwbKpWqr
         qeNQtGywDapapZ5pu0RjWG2VxVlKsAjRd+hE++30QR4fkki2Aprjwm7d+1gmNbPrjdWn
         KxV43Ph35t3ZTw1qHEoKIYdWpkfd+dsFl0pcAAfN/KPsNrm0HcS7KsnZHb9D4AAVEJ4U
         aHOEq2Xmhs0BaVaPCCjf5J2jgtg+0Co09yON5m4BknPWyg3RS6pt/aarMbn9ceYBNg8e
         9v1A==
X-Gm-Message-State: APzg51C05IJOZQxtuy6dik+BhPuGSYXlXgTxvMrR6DK8qq6TIK0OCDyW
        dlBMumuMXT0O9F960DS/y0o+zp6W/OBw3ihpciY=
X-Google-Smtp-Source: ANB0VdYmf3dv/3fLEcudtWJ4AcZ/T7n62Bzr2iaQAvpuOVsCbmp15CVVX+Z1YV2OFTi7C5DEwDFZpjeXU2CJPaNzjhw=
X-Received: by 2002:a9d:42ee:: with SMTP id c43-v6mr11205806otj.54.1537172755224;
 Mon, 17 Sep 2018 01:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180913160851.18169-1-vkuznets@redhat.com> <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com> <20180914162103.GA11171@redhat.com>
In-Reply-To: <20180914162103.GA11171@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Sep 2018 10:25:44 +0200
Message-ID: <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
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

On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 09/14, Vitaly Kuznetsov wrote:
> >
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >
> > > On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
> > ...
> >
> > >> +static int hungtask_pm_notify(struct notifier_block *self,
> > >> +                        unsigned long action, void *hcpu)
> > >> +{
> > >> +  switch (action) {
> > >> +  case PM_SUSPEND_PREPARE:
> > >> +  case PM_HIBERNATION_PREPARE:
> > >> +          hung_detector_suspended = true;
> > >> +          break;
> > >> +  case PM_POST_SUSPEND:
> > >> +  case PM_POST_HIBERNATION:
> > >> +          hung_detector_suspended = false;
> > >> +          break;
> > >> +  default:
> > >> +          break;
> > >> +  }
> > >> +  return NOTIFY_OK;
> > >> +}
> > >> +
> > >>  /*
> > >>   * kthread which checks for tasks stuck in D state
> > >>   */
> > >> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
> > >>            interval = min_t(unsigned long, interval, timeout);
> > >>            t = hung_timeout_jiffies(hung_last_checked, interval);
> > >
> > > Since you are adding the notifier anyway, what about designing it to make
> > > the thread wait on _PREPARE until the notifier kicks it again on exit
> > > fron suspend/hibernation?
>
> Well. I agree that freezable kthreads are not nice, but it seems you are
> going to add another questionable interface ;)

Why would it be questionable?

The watchdog needs to be disarmed somehow before tasks are frozen and
re-armed after they have been thawed or it may report false-positives
on the way out.  PM notifiers can be used for that.

Or do you mean that the synchronization between it and the freezer
that's already there should be sufficient?

> Vitaly, could you please update the changelog to explain in details whats
> going on?
>
> Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
> than 120 seconds?

It need not be sleeping for over 2 minutes, but if suspend-to-idle
advances the clock sufficiently, the watchdog will regard that as the
task sleep time.

> And. given that it takes system_transition_mutex anyway, can't it use
> lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
> in check_hung_task()) ?

Well, it could, but that would be somewhat confusing and slightly
abusing the flag IMO.

Also, if the watchdog is stopped before the task freezing kicks in and
restarted after they have been all thawed, it will not have to
synchronize with the freezer any more I suppose?

Cheers,
Rafael
