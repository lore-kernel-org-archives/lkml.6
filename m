Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2CAC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDC620850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDC620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLDAKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:10:12 -0500
Received: from mail.hallyn.com ([178.63.66.53]:40792 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLDAKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:10:12 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 06F7B964; Mon,  3 Dec 2018 18:10:09 -0600 (CST)
Date:   Mon, 3 Dec 2018 18:10:09 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v9 3/4] seccomp: add a return code to trap to userspace
Message-ID: <20181204001009.GA8796@mail.hallyn.com>
References: <20181203032827.27978-1-tycho@tycho.ws>
 <20181203032827.27978-4-tycho@tycho.ws>
 <20181203052650.GC31406@mail.hallyn.com>
 <20181203155211.GB3504@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203155211.GB3504@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 08:52:11AM -0700, Tycho Andersen wrote:
> On Sun, Dec 02, 2018 at 11:26:50PM -0600, Serge E. Hallyn wrote:
> > On Sun, Dec 02, 2018 at 08:28:26PM -0700, Tycho Andersen wrote:
> > > +struct seccomp_knotif {
> > > +	/* The struct pid of the task whose filter triggered the notification */
> > > +	struct task_struct *task;
> > > +
> > > +	/* The "cookie" for this request; this is unique for this filter. */
> > > +	u64 id;
> > > +
> > > +	/*
> > > +	 * The seccomp data. This pointer is valid the entire time this
> > > +	 * notification is active, since it comes from __seccomp_filter which
> > 
> > define 'active' - is a notification in state REPLIED still active?
> 
> Yes,
> 
> > Actually while looking at that, I came to wondering - when are knotifs
> > freed?  Seems like only during seccomp_notify_release(), i.e. when the
> > tracing task stops polling for events?  Is that going to be a problem?
> > Or am I misreading this?
> 
> they're stack allocated in do_user_notification(). So "active" in this
> sense really means "somewhere in do_user_notification()".

D'oh!  I see, thanks :)

> > > +	if (ret == 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
> > > +		ret = -EFAULT;
> > > +
> > > +		/*
> > > +		 * Userspace screwed up. To make sure that we keep this
> > > +		 * notification alive, let's reset it back to INIT. It
> > 
> > Is keeping the notification alive the right thing to do?
> > 
> > If userspace has messed up in something this touchy, it seems unlikely
> > that it'll to better if we give it a do-over...  I'm not sure whether
> > killing the whole thing (victim and tracer) is the right thing or not.
> 
> I suppose we could do that too. I just didn't want to get into a
> situation where the notification is lost and the task is stuck because
> userspace screwed up here.

Yeah, that's probably best - I'm just trying to see whether there is
any way that this could be abused.  My underactive imagination hasn't
come up with anything yet.

-serge
