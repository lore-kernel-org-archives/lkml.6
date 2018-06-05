Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeFEPLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:11:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55129 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbeFEPLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:11:22 -0400
Date: Tue, 5 Jun 2018 17:08:34 +0200
From: David Sterba <dsterba@suse.cz>
To: dsterba@suse.cz, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org, snitzer@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: Use kzalloc for all structs with embedded
 biosets/mempools
Message-ID: <20180605150834.zed7tjvmm7livrbe@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org, snitzer@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180605092633.29583-1-kent.overstreet@gmail.com>
 <e78b0f9f-d4f9-d865-0727-5e1ed074928d@kernel.dk>
 <20180605143507.2o3qm4r6euvyhe5g@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605143507.2o3qm4r6euvyhe5g@twin.jikos.cz>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:35:07PM +0200, David Sterba wrote:
> On Tue, Jun 05, 2018 at 08:22:22AM -0600, Jens Axboe wrote:
> > > I fucked up majorly on the bioset/mempool conversion - I forgot to check that
> > > everything biosets/mempools were being embedded in was actually being zeroed on
> > > allocation. Device mapper currently explodes, you'll probably want to apply this
> > > patch post haste.
> > > 
> > > I have now done that auditing, for every single conversion - this patch fixes
> > > everything I found. There do not seem to be any incorrect ones outside of device
> > > mapper...
> > > 
> > > We'll probably want a second patch that either a) changes
> > > bioset_init()/mempool_init() to zero the passed in bioset/mempool first, or b)
> > > my preference, WARN() or BUG() if they're passed memory that isn't zeroed.
> > 
> > Odd, haven't seen a crash, but probably requires kasan or poisoning to
> > trigger anything? Mike's tree also had the changes, since they were based
> > on the block tree.
> 
> eg. fstests/generic/081 crashes (trace below), no KASAN, PAGE_POISONING=y,
> PAGE_POISONING_NO_SANITY=y.
> 
> > I can queue this up and ship it later today. Mike, you want to review
> > this one?
> 
> Would be great to push that soon. The fstests build on several DM targets, the
> crashes lead to many test failures. I'm going to test the kzalloc fix now.

Tested-by: David Sterba <dsterba@suse.com>

on targets snapshot and thin.
