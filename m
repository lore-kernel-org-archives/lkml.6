Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDDJg7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:36:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34127 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:36:55 -0400
Message-ID: <1522834611.3779.3.camel@pengutronix.de>
Subject: Re: [RFC] Per file OOM badness
From: Lucas Stach <l.stach@pengutronix.de>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian.Koenig@amd.com, linux-mm@kvack.org,
        amd-gfx@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
Date: Wed, 04 Apr 2018 11:36:51 +0200
In-Reply-To: <3778a205-8b30-d147-b1f6-0a93d1de8beb@daenzer.net>
References: <20180118170006.GG6584@dhcp22.suse.cz>
         <20180123152659.GA21817@castle.DHCP.thefacebook.com>
         <20180123153631.GR1526@dhcp22.suse.cz>
         <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
         <20180124092847.GI1526@dhcp22.suse.cz>
         <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
         <20180124110141.GA28465@dhcp22.suse.cz>
         <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
         <20180124115059.GC28465@dhcp22.suse.cz>
         <60e18da8-4d6e-dec9-7aef-ff003605d513@daenzer.net>
         <20180130102855.GY21609@dhcp22.suse.cz>
         <1522074988.1196.1.camel@pengutronix.de>
         <3778a205-8b30-d147-b1f6-0a93d1de8beb@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 04.04.2018, 11:09 +0200 schrieb Michel Dänzer:
> On 2018-03-26 04:36 PM, Lucas Stach wrote:
> > Am Dienstag, den 30.01.2018, 11:28 +0100 schrieb Michal Hocko:
> > > On Tue 30-01-18 10:29:10, Michel Dänzer wrote:
> > > > On 2018-01-24 12:50 PM, Michal Hocko wrote:
> > > > > On Wed 24-01-18 12:23:10, Michel Dänzer wrote:
> > > > > > On 2018-01-24 12:01 PM, Michal Hocko wrote:
> > > > > > > On Wed 24-01-18 11:27:15, Michel Dänzer wrote:
> > > > > 
> > > > > [...]
> > > > > > > > 2. If the OOM killer kills a process which is sharing BOs
> > > > > > > > with another
> > > > > > > > process, this should result in the other process dropping
> > > > > > > > its references
> > > > > > > > to the BOs as well, at which point the memory is released.
> > > > > > > 
> > > > > > > OK. How exactly are those BOs mapped to the userspace?
> > > > > > 
> > > > > > I'm not sure what you're asking. Userspace mostly uses a GEM
> > > > > > handle to
> > > > > > refer to a BO. There can also be userspace CPU mappings of the
> > > > > > BO's
> > > > > > memory, but userspace doesn't need CPU mappings for all BOs and
> > > > > > only
> > > > > > creates them as needed.
> > > > > 
> > > > > OK, I guess you have to bear with me some more. This whole stack
> > > > > is a
> > > > > complete uknonwn. I am mostly after finding a boundary where you
> > > > > can
> > > > > charge the allocated memory to the process so that the oom killer
> > > > > can
> > > > > consider it. Is there anything like that? Except for the proposed
> > > > > file
> > > > > handle hack?
> > > > 
> > > > How about the other way around: what APIs can we use to charge /
> > > > "uncharge" memory to a process? If we have those, we can experiment
> > > > with
> > > > different places to call them.
> > > 
> > > add_mm_counter() and I would add a new counter e.g. MM_KERNEL_PAGES.
> > 
> > So is anyone still working on this? This is hurting us bad enough that
> > I don't want to keep this topic rotting for another year.
> > 
> > If no one is currently working on this I would volunteer to give the
> > simple "just account private, non-shared buffers in process RSS" a
> > spin.
> 
> Sounds good. FWIW, I think shared buffers can also be easily handled by
> accounting them in each process which has a reference. But that's more
> of a detail, shouldn't make a big difference overall either way.

Yes, both options to wither never account shared buffers or to always
account them into every process having a reference should be pretty
easy. Where it gets hard is when trying to account the buffer only in
the last process holding a reference or something like this.

For the OOM case I think it makes more sense to never account shared
buffers, as this may lead to a process (like the compositor) to have
its RSS inflated by shared buffers, rendering it the likely victim for
the OOM killer/reaper, while killing this process will not lead to
freeing of any shared graphics memory, at least if the clients sharing
the buffer survive killing of the compositor.

This opens up the possibility to "hide" buffers from the accounting by
sharing them, but I guess it's still much better than the nothing we do
today to account for graphics buffers.

Regards,
Lucas
