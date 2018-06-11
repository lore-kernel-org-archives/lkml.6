Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oV1kIEmwHVu+XAAAmS7hNA
	; Mon, 11 Jun 2018 00:05:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3605960791; Mon, 11 Jun 2018 00:05:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6CC05604D4;
	Mon, 11 Jun 2018 00:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CC05604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeFKAFv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 20:05:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:39366 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753543AbeFKAFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 20:05:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5B05NhN007274;
        Sun, 10 Jun 2018 19:05:25 -0500
Message-ID: <22a505e0f094352b9cb883935fae9f494fb2cb0b.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 11 Jun 2018 10:05:22 +1000
In-Reply-To: <3187b544-e265-dfd9-e0e3-e2a742c190d5@gmail.com>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
         <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
         <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
         <m2h8mc4ejw.fsf@linux-m68k.org>
         <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
         <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
         <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
         <3187b544-e265-dfd9-e0e3-e2a742c190d5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-10 at 21:12 +1200, Michael Schmitz wrote:
> Hi Geert,

Top posting, sorry ...

We are painting that bike shed with way too many coats..

We can keep the existing definitions, stick a comment on them stating
"obsolete" and use new number if/when needed.

Ben.


> Am 10.06.2018 um 20:29 schrieb Geert Uytterhoeven:
> > Hi Finn,
> > 
> > On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > > > > Is this enum used by any user space code? If so, perhaps rather
> > > > > > leave the PMU_68K_V1 in there to avoid upsetting that?
> > > > > 
> > > > > It also changes the value of PMU_68K_V2, which is an ABI break.
> > > > 
> > > > Yes, that's what I worry about - but do we know of any users of that
> > > > particular interface?
> > > 
> > > There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
> > > only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
> > > series will make these UAPIs available on m68k, and for that reason I've
> > > chosen the value PMU_UNKNOWN for pmu_kind.
> > 
> > While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
> > include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
> > unless we are 100% sure there are no users.
> > 
> > If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
> > needing to check the PMU type, it would have a switch() statement with
> > all existing values defined in <linux/pmu.h>. So that would become broken
> > by your change.
> > 
> > Hence the enum is append-only.
> 
> The PMU type from pmu.h was never exposed to user space on m68k via 
> /proc/pmu/*, and /dev/pmu is used for ioctls to the PMU driver on 
> powerpc only (the 68k PMU driver doesn't have ioctl support). No way 
> that I can see for user space to make use of the PMU type definition 
> from pmu.h, so I suppose we can be sure there are no users.
> 
> The m68k PMU types cannot be said to be exposed on powerpc either (which 
> has ioctl support to interrogate the PMU type), as these only return 
> values up to PMU_KEYLARGO_BASED.
> 
> Applications like pbbuttonsd or pmud don't use the kernel PMU type at 
> all, but go straight to the PMU via the ADB bus to interrogate the 
> hardware type, so won't be affected either.
> 
> Is there any other way besides procfs and ioctl for user space to 
> interrogate the PMU type that I'm missing here?
> 
> (I understand that breaking the ABI should not be done as a rule, but 
> this may be a case where we can successfully argue the definitions were 
> never in use, so the rules may be bent a little).
