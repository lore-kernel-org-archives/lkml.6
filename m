Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513ED214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513ED214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIQWXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:23:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQWXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D90583082137;
        Mon, 17 Sep 2018 16:55:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id EEBB618001;
        Mon, 17 Sep 2018 16:55:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Sep 2018 18:55:20 +0200 (CEST)
Date:   Mon, 17 Sep 2018 18:55:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Message-ID: <20180917165518.GA25931@redhat.com>
References: <20180913160851.18169-1-vkuznets@redhat.com>
 <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com>
 <20180914162103.GA11171@redhat.com>
 <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jpK-KWE7Pv1fKAWFXweW7jNH26fFDM=sXMPRNPJ96u7g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 17 Sep 2018 16:55:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17, Rafael J. Wysocki wrote:
>
> On Fri, Sep 14, 2018 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > > Since you are adding the notifier anyway, what about designing it to make
> > > > the thread wait on _PREPARE until the notifier kicks it again on exit
> > > > fron suspend/hibernation?
> >
> > Well. I agree that freezable kthreads are not nice, but it seems you are
> > going to add another questionable interface ;)
>
> Why would it be questionable?
>
> The watchdog needs to be disarmed somehow before tasks are frozen and
> re-armed after they have been thawed or it may report false-positives
> on the way out.  PM notifiers can be used for that.

Or watchdog() can simply use set_freezable/freezing interface we already
have, without additional complications.

Yes, this is not "before tasks are frozen", but probably should work?

OK, I won't argue.

> > Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
> > than 120 seconds?
>
> It need not be sleeping for over 2 minutes, but if suspend-to-idle
> advances the clock sufficiently, the watchdog will regard that as the
> task sleep time.

As I already said, I don't understand this magic, so you can ignore me.

But again, it would be nice to explain this in the changelog, I mean, how
exactly (and why) jiffies can grow for over 2 minutes in this case.

> > And. given that it takes system_transition_mutex anyway, can't it use
> > lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
> > in check_hung_task()) ?
>
> Well, it could, but that would be somewhat confusing and slightly
> abusing the flag IMO.

OK, I won't insist.

Oleg.

