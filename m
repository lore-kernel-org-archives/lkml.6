Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E4ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13A52083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13A52083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeINVgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINVgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D58C30833C4;
        Fri, 14 Sep 2018 16:21:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91AF965F65;
        Fri, 14 Sep 2018 16:21:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 14 Sep 2018 18:21:06 +0200 (CEST)
Date:   Fri, 14 Sep 2018 18:21:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Message-ID: <20180914162103.GA11171@redhat.com>
References: <20180913160851.18169-1-vkuznets@redhat.com>
 <4793718.OcKebjM5bH@aspire.rjw.lan>
 <87d0tg88l3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0tg88l3.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Sep 2018 16:21:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14, Vitaly Kuznetsov wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
> ...
> 
> >> +static int hungtask_pm_notify(struct notifier_block *self,
> >> +			      unsigned long action, void *hcpu)
> >> +{
> >> +	switch (action) {
> >> +	case PM_SUSPEND_PREPARE:
> >> +	case PM_HIBERNATION_PREPARE:
> >> +		hung_detector_suspended = true;
> >> +		break;
> >> +	case PM_POST_SUSPEND:
> >> +	case PM_POST_HIBERNATION:
> >> +		hung_detector_suspended = false;
> >> +		break;
> >> +	default:
> >> +		break;
> >> +	}
> >> +	return NOTIFY_OK;
> >> +}
> >> +
> >>  /*
> >>   * kthread which checks for tasks stuck in D state
> >>   */
> >> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
> >>  		interval = min_t(unsigned long, interval, timeout);
> >>  		t = hung_timeout_jiffies(hung_last_checked, interval);
> >
> > Since you are adding the notifier anyway, what about designing it to make
> > the thread wait on _PREPARE until the notifier kicks it again on exit
> > fron suspend/hibernation?

Well. I agree that freezable kthreads are not nice, but it seems you are
going to add another questionable interface ;)

Vitaly, could you please update the changelog to explain in details whats
going on?

Where does the caller of pm_suspend() sleep in D state? Why it sleeps more
than 120 seconds?

And. given that it takes system_transition_mutex anyway, can't it use
lock_system_sleep() which marks the caller as PF_FREEZER_SKIP (checked
in check_hung_task()) ?

I have to admit I got lost...

> We can either park the kthread (kthread_park/unpark)

No, no, please don't. Nobody outside of smpboot.c should use this (and
this interface should be reworked). Yes, there are already abused, but
please don't add new users.

Oleg.

