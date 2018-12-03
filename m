Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F5FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C552E2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C552E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLCNlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:41:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCNlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:41:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 296D6394D29;
        Mon,  3 Dec 2018 13:40:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id D832F6717D;
        Mon,  3 Dec 2018 13:40:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  3 Dec 2018 14:40:19 +0100 (CET)
Date:   Mon, 3 Dec 2018 14:40:17 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203134016.GC31795@redhat.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203123857.GS31738@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 03 Dec 2018 13:40:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Michal Hocko wrote:
>
> On Mon 03-12-18 13:31:49, Oleg Nesterov wrote:
> > On 12/03, Michal Hocko wrote:
> > >
> > > Now, I wouldn't mind to revert this because the code is really old and
> > > we haven't seen many bug reports about failing suspend yet. But what is
> > > the actual plan to make this work properly?
> >
> > I don't see a simple solution...
> >
> > But we need to fix exec/de_thread anyway, then we can probably reconsider
> > this patch.
>
> My concern is that de_thread fix might be too disruptive for stable
> kernels while we might want to have a simple enough fix for the the
> suspend issue in the meantime. That was actually the primary reason I've
> acked the hack even though I didn't like it.
>
> So can we find a way to shut the lockdep up

You have already mentioned freezable_schedule_unsafe(), but I agree with
"DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION" above it ...

> when this is not really a
> deadlock?

not a deadlock, but lockdep is obviously right, suspend still can fail if
another task needs the same mutex.

Again, we have already discussed this, in my opinion we should blame exec/
de_thread for this and other problems.

> Or maybe this really is one and then we need a real fix for
> stable as well.

Well, strace -f can hang if it races with mt exec, it would be nice to have
a fix for stable.

Oleg.

