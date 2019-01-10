Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86953218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfAJO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:56:01 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49986 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfAJO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:56:01 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id DF50F200999; Thu, 10 Jan 2019 14:55:59 +0000 (UTC)
Date:   Thu, 10 Jan 2019 15:55:59 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        mcgrof@kernel.org, joe.lawrence@redhat.com, longman@redhat.com,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20190110145559.relfx37ocq5xu4by@isilmar-4.linta.de>
References: <20190107222700.15954-1-christian@brauner.io>
 <20190107222700.15954-3-christian@brauner.io>
 <20190108070110.GA7998@light.dominikbrodowski.net>
 <20190110145004.zhc2t42aasni7wnq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110145004.zhc2t42aasni7wnq@brauner.io>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:50:05PM +0100, Christian Brauner wrote:
> On Tue, Jan 08, 2019 at 08:01:10AM +0100, Dominik Brodowski wrote:
> > On Mon, Jan 07, 2019 at 11:27:00PM +0100, Christian Brauner wrote:
> > > @@ -2833,6 +2836,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> > >  				break;
> > >  			if (neg)
> > >  				continue;
> > > +			if ((max && val > *max) || (min && val < *min)) {
> > > +				err = -EINVAL;
> > > +				break;
> > > +			}
> > >  			val = convmul * val / convdiv;
> > >  			if ((min && val < *min) || (max && val > *max))
> > >  				continue;
> > 
> > This is a generic change which affects all users of
> > do_proc_doulongvec_minmax() that have extra1 or extra2 set. In sysctl.c, I
> > do not see another user of proc_doulongvec_minmax() that has extra1 or
> > extra2 set. However, have you verified whether your patch changes the
> > behaviour for other files that make use of proc_doulongvec_minmax() or
> > proc_doulongvec_ms_jiffies_minmax(), and not only of the file-max sysctl?
> 
> Sorry for the delayed reply. I did look at the callers. The functions
> that are of interest afaict are:
> 
> proc_doulongvec_ms_jiffies_minmax
> proc_doulongvec_minmax
> 
> So this could be visible when users write values that would overflow the
> type used in the kernel.
>
> I guess your point is whether we are venturing into userspace break
> territory. Hm... We should probably make sure that we're not regressing
> anyone else! What do you think if instead of the above patch we did:

Hm, I prefer the original patch -- as the same (valid) reasons which apply
for the file-max sysctl might also apply to other users of this function
where extra1 and/or2 extra2 are set.

If there are no other users of this function where extra1 or extra2 are set,
just add a comment in the commit message:

	While this changes the behaviour of __do_proc_doulongvec_minmax(),
	no other existing users in the kernel are affected by this change.

If there are other users of this function where extra1 or extra2 are set,
you would need to generalize the commit message overall.

Thanks,
	Dominik
