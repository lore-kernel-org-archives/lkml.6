Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B38C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB01320831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB01320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKBTJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeKBTJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 547F388E4F;
        Fri,  2 Nov 2018 10:02:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6727E5EDE1;
        Fri,  2 Nov 2018 10:02:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Nov 2018 11:02:40 +0100 (CET)
Date:   Fri, 2 Nov 2018 11:02:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181102100234.GA12360@redhat.com>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181101134001.GA23232@redhat.com>
 <20181101195635.GG2180@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101195635.GG2180@cisco>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 02 Nov 2018 10:02:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01, Tycho Andersen wrote:
>
> On Thu, Nov 01, 2018 at 02:40:02PM +0100, Oleg Nesterov wrote:
> >
> > Somehow I no longer understand why do you need to take all locks. Isn't
> > the first filter's notify_lock enough? IOW,
> >
> > 		for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > 			if (cur->notif)
> > 				return ERR_PTR(-EBUSY);
> > 			first = cur;
> > 		}
> >
> > 		if (first)
> > 			mutex_lock(&first->notify_lock);
> >
> > 		... initialize filter->notif ...
> >
> > 	out:
> > 		if (first)
> > 			mutex_unlock(&first->notify_lock);
> >
> > 		return ret;
>
> The idea here is to prevent people from "nesting" notify filters. So
> if any filter in the chain has a listener attached, it refuses to
> install another filter with a listener.

Yes, I understand, so we need to check cur->notif. My point was, we do not
need to take all the locks in the ->prev chain, we need only one:
first->notify_lock.

But you know what? today I think that we do not need any locking at all,
all we need is the lockless

	for (cur = current->seccomp.filter; cur; cur = cur->prev)
		if (cur->notif)
			return ERR_PTR(-EBUSY);

at the start, nothing more.

> But it just occurred to me that we don't handle the TSYNC case
> correctly by doing it this way,

Why? Perhaps I missed your point, but TSYNC case looks fine. I mean, if 2
threads do seccomp_set_mode_filter(NEW_LISTENER | TSYNC) then only one can
win the race and succeed, but this has nothing to do with init_listener(),
we rely on ->siglock and is_ancestor() check.

No?

Oleg.

