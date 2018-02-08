Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBHGkf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:40:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:54657 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBHGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:40:34 -0500
Date: Thu, 8 Feb 2018 15:40:26 +0900
From: Benjamin Poirier <bpoirier@suse.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "e1000e: Do not read ICR in Other interrupt"
Message-ID: <20180208064026.ht4y5orcw4m5qyyl@f1.synalogic.ca>
References: <20180126091236.13044-1-bpoirier@suse.com>
 <20180126091236.13044-4-bpoirier@suse.com>
 <CAKgT0Ue+JNL91jr08Ks3+Oj21fNApwuQH=bDEs2o3BKPigpyEA@mail.gmail.com>
 <20180129072805.7ifsjr3r6eziwp7a@f1.synalogic.ca>
 <CAKgT0Ucozb6kyFavZUo=enjhpJkkiHDz-bZYG=KcCLoD=ByqoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ucozb6kyFavZUo=enjhpJkkiHDz-bZYG=KcCLoD=ByqoQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/01/29 09:22, Alexander Duyck wrote:
[...]
> 
> > Consequently, we must clear OTHER manually from ICR, otherwise the
> > interrupt is immediately re-raised after exiting the handler.
> >
> > These observations are the same whether the interrupt is triggered via a
> > write to ICS or in hardware.
> >
> > Furthermore, I tested that this behavior is the same for other Other
> > events (MDAC, SRPD, ACK, MNG). Those were tested via a write to ICS
> > only, not in hardware.
> >
> > This is a version of the test patch that I used to trigger lsc and rxo in
> > software and hardware. It applies over this patch series.
> 
> I plan to look into this some more over the next few days. Ideally if
> we could mask these "OTHER" interrupts besides the LSC we could comply
> with all the needed bits for MSI-X. My concern is that we are still
> stuck reading the ICR at this point because of this and it is going to
> make dealing with MSI-X challenging on 82574 since it seems like the
> intention was that you weren't supposed to be reading the ICR when
> MSI-X is enabled based on the list of current issues and HW errata.

I totally agree with you that it looks like the msi-x interface was
designed so you don't need to read icr. That's also why I was happy to
go that direction with the (now infamous) commit 16ecba59bc33 ("e1000e:
Do not read ICR in Other interrupt", v4.5-rc1).

However, we looked at it before and there seems to be no way to mask
individual Other interrupt causes (masking rxo but getting lsc). Because
of that, I think we have to keep reading icr in the Other interrupt
handler.

> 
> At this point it seems like the interrupts is firing and the
> INT_ASSERTED is all we really need to be checking for if I understand
> this all correctly. Basically if LSC is set it will trigger OTHER and
> INT_ASSERTED, if any of the other causes are set they are only setting
> OTHER.

I think that's right and it's related to the fact that currently LSC is
set in IMS but not the other causes. Since we have to read icr (as I
wrote above) but we want to avoid reading it without INT_ASSERTED set
(as per errata 12) the solution will be to set all of the causes related
to Other in IMS. Patches incoming...
