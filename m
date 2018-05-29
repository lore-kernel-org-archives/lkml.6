Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933121AbeE2KZG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:25:06 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:51670 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932793AbeE2KZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:25:03 -0400
Date: Tue, 29 May 2018 12:24:56 +0200
From: Christian Brauner <christian@brauner.io>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
Subject: Re: [PATCH 8/8] signal: simplify rt_sigaction()
Message-ID: <20180529102456.GA28700@mailbox.org>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-9-christian@brauner.io>
 <20180529064719.GA14800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180529064719.GA14800@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:47:19PM -0700, Christoph Hellwig wrote:
> > +	if (act)
> >  		if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
> >  			return -EFAULT;
> 
> 	if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
> 		return -EFAULT;

Yes, I agree and should have been bolder in making that change. But I
already wasn't sure how ok people would be with:

if (act) {} --> if (act)

> 
> >  	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> > -
> > -	if (!ret && oact) {
> > +	if (!ret && oact)
> >  		if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
> >  			return -EFAULT;
> > -	}
> 
> 	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> 	if (!ret && oact && copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
> 		return -EFAULT;
> 
> Althought I'd personaly write it as:
> 
> 	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> 	if (ret)
> 		return ret;
> 	if (oact && copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
> 		return -EFAULT;
> 	return 0;

Yeah, I can put that in v2.
I'd wait for a little until people have commmented/acked some of the
other changes so that I don't keep spamming inboxes. If you have a few
spare minutes it would be cool if you could take a quick look. It
shouldn't take long.

Thanks!
Christian
