Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312CDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9247208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9247208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeGLOFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:05:24 -0400
Received: from nautica.notk.org ([91.121.71.147]:47522 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732281AbeGLOFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:05:24 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D1298C009; Thu, 12 Jul 2018 15:55:41 +0200 (CEST)
Date:   Thu, 12 Jul 2018 15:55:26 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] i915/intel_tv_get_modes: fix strncpy
 truncation warning
Message-ID: <20180712135526.GA5463@nautica>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
 <20180712124401.GZ5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712124401.GZ5565@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä wrote on Thu, Jul 12, 2018:
> On Wed, Jul 11, 2018 at 09:46:15AM +0200, Dominique Martinet wrote:
> > This is effectively no-op as the next line writes a nul at the final
> 
> What is "This". Please write self contained commit messages.

This could either be 'this commit' as a whole or if you look only at the
commit message 'this strncpy fix' from the title (which is arguably the
same), and both interpretations sound fairly understandable in the
context of the title line without seeing the patch to me... Although
I'll admit this is difficult to judge of that as the author.

Thanksfully, the v2 of the patch didn't use this wording but while I
agree the message could be better I do not think it was horrible.


> > drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
> > drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals destination size [-Werror=stringop-truncation]
> >    strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> 
> That warning should be in the actual commit message.

Yes and no, I gave it for referrence but when you update to gcc 8 you
will literally see it all over the place.
The words "strncpy truncation warning" is really precise once you've
seen them a few times and there are litteraly hundred of these warnings
in the kernel, some have already been fixed taking a glance at the git
log, some with and without the warning message.
I don't think it's worth polluting the git log with this many
warnings... Which leads to...

> This same pattern is used all over drm. Can you go and fix them all up?
> One might even consider writing a cocci patch for it ;)

Now this is something I can agree with.
This patch really was just a stop-gap measure because I could not build
the kernel at all without it, but yes I did consider having a look at
others.

Unfortunately coccinelle does not run on fedora 28 (and doesn't look
like it will fix itself any time soon, there is a bug report[1] open
since February that didn't get much love lately - I was just looking at
it a few days ago)

I think in this case it might actually be faster to look at gcc warnings
and s/strncpy/strlcpy/, but I am curious about Coccinelle so this is a
good excuse to look at it, I'll report back in a bit after poking at
that bug report and figuring out how coccinelle works.

I do not guarantee speed however, if anyone sees this and feels put off
from donig it themselves, please go ahead and just drop me a word.


[1] https://bugzilla.redhat.com/show_bug.cgi?id=1544204

Thanks, and sorry for the mail longer than I originally intended,
-- 
Dominique Martinet
