Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4FAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C634720827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfAHTTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:19:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbfAHTTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:19:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E32B67AE9E;
        Tue,  8 Jan 2019 19:19:49 +0000 (UTC)
Received: from ovpn-120-48.rdu2.redhat.com (ovpn-120-48.rdu2.redhat.com [10.10.120.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8691F8;
        Tue,  8 Jan 2019 19:19:48 +0000 (UTC)
Message-ID: <1546975187.3632.10.camel@redhat.com>
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Jan 2019 13:19:47 -0600
In-Reply-To: <20190107165056.2lhd53umgt4vod5o@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
         <20190107165056.2lhd53umgt4vod5o@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 08 Jan 2019 19:19:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 17:50 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-04 15:33:21 [-0500], Scott Wood wrote:
> > __down_read() bypasses the rtmutex frontend to call
> > rt_mutex_slowlock_locked() directly, and thus it needs to call
> > blk_schedule_flush_flug() itself.
> 
> we don't do this in the spin_lock() case because !RT doesn't do it.

And because spin_lock() is called inside the flush path.

>  We
> do it for rtmutex because !RT does it for mutex.
> Now I can't remember why this was skipped for a rw_sem since it is
> performed for !RT as part of the schedule() invocation.

Without this we were seeing XFS hangs on our internal kernel.  I wasn't able
to reproduce it on a newer kernel, but it's very timing-dependant so I
wouldn't read too much into that.

> If I don't come up with a plausible explanation then I will apply this
> plus a hunk for the __down_write_common() case which should also be
> required (right?).

I don't think it's needed, as it doesn't call into the rtmutex code via a
backdoor.  When blocking on sem->rtmutex, rt_mutex_fastlock() will call the
flush.  When blocking with a direct call to schedule(), tsk_is_pi_blocked()
will not be true, and thus schedule() will do the flush via
sched_submit_work().

-Scott

