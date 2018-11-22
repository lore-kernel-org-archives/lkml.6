Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976ED20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976ED20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392625AbeKVSTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:19:30 -0500
Received: from mail.hallyn.com ([178.63.66.53]:57082 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKVSTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:19:30 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id C570F74E; Thu, 22 Nov 2018 01:41:14 -0600 (CST)
Date:   Thu, 22 Nov 2018 01:41:14 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian@brauner.io>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181122074114.GA15484@mail.hallyn.com>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin>
 <20181119212343.yikfoxob7f4hio7h@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119212343.yikfoxob7f4hio7h@yavin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:23:43AM +1100, Aleksa Sarai wrote:
> On 2018-11-20, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> > > > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > > > +	if (info) {
> > > > > +		ret = __copy_siginfo_from_user(sig, &kinfo, info);
> > > > > +		if (unlikely(ret))
> > > > > +			goto err;
> > > > > +		/*
> > > > > +		 * Not even root can pretend to send signals from the kernel.
> > > > > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > > > > +		 * source info.
> > > > > +		 */
> > > > > +		ret = -EPERM;
> > > > > +		if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
> > > > > +		    (task_pid(current) != pid))
> > > > > +			goto err;
> > > > > +	} else {
> > > > > +		prepare_kill_siginfo(sig, &kinfo);
> > > > > +	}
> > > > 
> > > > I wonder whether we should also have a pidns restriction here, since
> > > > currently it isn't possible for a container process using a pidns to
> > > > signal processes outside its pidns. AFAICS, this isn't done through an
> > > > explicit check -- it's a side-effect of processes in a pidns not being
> > > > able to address non-descendant-pidns processes.
> > > > 
> > > > But maybe it's reasonable to allow sending a procfd to a different pidns
> > > > and the same operations working on it? If we extend the procfd API to
> > > 
> > > No, I don't think so. I really don't want any fancy semantics in here.
> > > Fancy doesn't get merged and fancy is hard to maintain. So we should do
> > > something like:
> > > 
> > > if (proc_pid_ns() != current_pid_ns)
> > > 	return EINVAL
> > 
> > This isn't quite sufficient. The key thing is that you have to be in an
> > *ancestor* (or same) pidns, not the *same* pidns. Ideally you can re-use
> > the check already in pidns_get_parent, and expose it. It would be
> > something as trivial as:
> > 
> > bool pidns_is_descendant(struct pid_namespace *ns,
> >                          struct pid_namespace *ancestor)
> > {
> >     for (;;) {
> >         if (!ns)
> >             return false;
> >         if (ns == ancestor)
> >             break;
> >         ns = ns->parent;
> >     }
> >     return true;
> > }
> > 
> > And you can rewrite pidns_get_parent to use it. So you would instead be
> > doing:
> > 
> >     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
> >         return -EPERM;
> 
> Scratch the last bit, -EPERM is wrong here. I would argue that -EINVAL
> is *somewhat* wrong because arguable the more semantically consistent
> error (with kill(2)) would be -ESRCH -- but then you're mixing the "pid
> is dead" and "pid is not visible to you" cases. I'm not sure what the
> right errno would be here (I'm sure some of the LKML greybeards will
> have a better clue.) :P

Actually I like EXDEV for this.  ERMOTE also works.
