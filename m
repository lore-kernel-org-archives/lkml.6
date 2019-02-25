Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E6520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfBYP52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfBYP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:57:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4ACE5308624A;
        Mon, 25 Feb 2019 15:57:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id E7C6960863;
        Mon, 25 Feb 2019 15:57:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 25 Feb 2019 16:57:28 +0100 (CET)
Date:   Mon, 25 Feb 2019 16:57:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Roman Gushchin <guroan@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190225155725.GA8096@redhat.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
 <20190221162923.GA26064@redhat.com>
 <20190221173422.GY50184@devbig004.ftw2.facebook.com>
 <20190222163441.GA5596@redhat.com>
 <20190222181740.GZ50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222181740.GZ50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 25 Feb 2019 15:57:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22, Tejun Heo wrote:
>
> > So I think it too should somehow interact with freezable_schedule/etc.
>
> You mean freezer_do_not_count(), right?

yes,

> As long as the task is
> guaranteed to be trapped by signal stop afterwards (and they are), we
> likely can use them the same way.  The only thing to be careful about
> would be ensuring that we don't end up flipping group level frozen
> state inbetween.  Would something like that work?

I have no idea because I do not understand what exactly do you mean ;)

However. Thinking more about this, I am not sure my concerns were valid.
Yes, cg freezer can "hang" if it races with vfork(). But probably we should
blame vfork(), not freezer.

The problem is, even ^Z can "hang" if the foreground process does vfork()
and the new child stops before exit/exec. Now I recall that I even tried
to make a patch to fix this using ERESTART_RESTARTBLOCK, but had some nasty
problems with blocked signals...

de_thread() should use freezable_schedule() in TASK_KILLABLE too. Currently
it doesn't, but only because we have other (much more serious) problems with
cred_guard_mutex/exec. However, this is is fine wrt cg freezer, other threads
can't be frozen exactly because it is killable.

Anything else does freezer_do_not_count() in TASK_KILLABLE and waits for
another freezable process?

So it seems I have to take my words back, perhaps we can forget about
freezable_schedule/etc.

Oleg.

