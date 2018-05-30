Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030246AbeE3J0k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43321 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968802AbeE3J0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:26:36 -0400
Date: Wed, 30 May 2018 11:26:32 +0200
From: Borislav Petkov <bp@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from
 unknown source" message
Message-ID: <20180530092631.GA2599@zn.tnic>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic>
 <20180529161549.GB935@agluck-desk>
 <20180529174105.GF19870@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
 <20180529175313.GG19870@zn.tnic>
 <20180529185425.GA4174@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529185425.GA4174@agluck-desk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:54:25AM -0700, Luck, Tony wrote:
> Couple of thoughts:

Thanks for looking.

> In "x86/mce: Carve out bank scanning code" you drop the extra
> call to mce_severity() that I just added:

Yeah, did that before we talked about it.

> In "x86/mce: Exit properly when no banks to poll" you
> leap right to the end.  I'm wondering whether this can
> ever happen? I mean, if there are no machine check banks,
> then how did we get a machine check?

Right, so this looks like some remnant from old times, lemme do some
archeology...

/me goes and dusts off the full history linux repo...

I found this:

commit 7dd1e1d805d15ca63d05badf40026629ba75cbc8
Author: Andi Kleen <ak@suse.de>
Date:   Tue Feb 24 17:58:41 2004 -0800

    [PATCH] New machine check handler for x86-64

and there's no mention why the !banks check is there.

I'm wondering if we should simply remove it. I mean, as you say, if
there are no MCA banks, we won't be running in here in the first
place...

> Both the original, and your new code, skip the:
> 
> 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> 
> which seems bad. That leaves MCG_STATUS.MCIP set ... so a second
> machine check would just reset the machine.

That's a good point. It goes away as an issue if we simply drop the
check.

> P.S. What happened to my "part 3/3" (updating the Skylake quirk)
> ... does that belong in somebody else's tree?

Simply hadn't reached it yet. I will take it too, eventually.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
