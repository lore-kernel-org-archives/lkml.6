Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A8F2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeLZU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:56:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727610AbeLZU4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:56:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EA9EAE61;
        Wed, 26 Dec 2018 20:56:23 +0000 (UTC)
Date:   Wed, 26 Dec 2018 21:56:16 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [GIT PULL] x86/cache updates for 4.21
Message-ID: <20181226205616.GA4557@zn.tnic>
References: <20181223124859.GA26860@zn.tnic>
 <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:26:12PM -0800, Linus Torvalds wrote:
> I've pulled this, but I think the new config option name is bad.
> 
> I think it should probably have been called "X86_RESCTRL" instead of
> just "RESCTRL". That's way too generic a name for something that is
> (at least currently) very much an x86 feature.

Right you are...

> It not only is x86-specific right now, it's specific to very few
> resources. It's not like this is some generic resource control, it's
> very much about low-level CPU resources. That should show in the name.
> 
> I've left it alone, and maybe it might even be cross-architecture some
> day (there's already a hack in the scheduler),
> but I think it's a bit misleading to have so a common name for such a
> specialized thing.
>
> Even if it some day gets to be cross-architecture and isn't limited to
> x86, at that point it _still_ wouldn't be "RESCTRL", it would be
> "CPU_RESCTRL" or something.

... and yap, that is already going in the cross-arch direction as
apparently there's work to have a similar thing on the ARM64 side:

https://lore.kernel.org/lkml/20180824104519.11203-1-james.morse@arm.com/T/#u

The intent is, AFAIU, to keep at least the user interface in the resctrl
fs the same as on x86 so that there's no unnecessary user confusion. And
from peeking at that patchset a bit, it looks like we'll need a generic

CONFIG_RESCTRL

which should enable the arch-agnostic piece in fs/ and then
the arch-specific counterpart which we'll probably put behind
CONFIG_X86_RESCTRL and CONFIG_ARM64_RESCTRL, respectively.

I guess I can send you a patch renaming the x86 config option to
X86_RESCTRL and the ARM64 side will fall into place when ready. And
it'll extract the generic bits into that separate generic config option.

Thoughts?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
