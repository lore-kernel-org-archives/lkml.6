Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCTTgu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:36:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751320AbeCTTgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:36:47 -0400
Date: Tue, 20 Mar 2018 15:36:43 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Patrik Torstensson <totte@google.com>,
        Eric Biggers <ebiggers@google.com>
Cc: gkaiser@google.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        samitolvanen@google.com, Alasdair Kergon <agk@redhat.com>,
        paulcrowley@google.com
Subject: Re: Add an option to dm-verity to validate hashes at most once
Message-ID: <20180320193643.GA11080@redhat.com>
References: <20180306231456.210504-1-totte@google.com>
 <20180314190957.GB183724@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314190957.GB183724@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14 2018 at  3:09pm -0400,
Eric Biggers <ebiggers@google.com> wrote:

> Hi Patrik,
> 
> On Tue, Mar 06, 2018 at 03:14:56PM -0800, Patrik Torstensson wrote:
> > Add an option to dm-verity to validate hashes at most once
> > to allow platforms that is CPU/memory contraint to be
> > protected by dm-verity against offline attacks.
> > 
> > The option introduces a bitset that is used to check if
> > a block has been validated before or not. A block can
> > be validated more than once as there is no thread protection
> > for the bitset.
> > 
> > This patch has been developed and tested on entry-level
> > Android Go devices.
> > 
> > Signed-off-by: Patrik Torstensson <totte@google.com>
> > ---
> >  drivers/md/dm-verity-target.c | 58 +++++++++++++++++++++++++++++++++--
> >  drivers/md/dm-verity.h        |  1 +
> >  2 files changed, 56 insertions(+), 3 deletions(-)
> 
> The new option needs to be documented in Documentation/device-mapper/verity.txt,
> including a description of what the option does as well as how it affects the
> security properties of dm-verity.  There should also be a mention of why the
> option applies to data blocks but not hash blocks, assuming that's intentional.
> 
> verity_status() also needs to be updated to show the new option, otherwise it
> will not be visible via the DM_TABLE_STATUS ioctl ('dmsetup table' on the
> command line).
> 
> Also the minor version number in the struct target_type needs to be incremented,
> so that userspace can determine whether the option is supported.
> 
> >  
> >  	for (b = 0; b < io->n_blocks; b++) {
> >  		int r;
> > +		sector_t cur_block = io->block + b;
> >  		struct ahash_request *req = verity_io_hash_req(v, io);
> >  
> > +		if (v->validated_blocks &&
> > +		    likely(test_bit(cur_block, v->validated_blocks))) {
> > +			verity_bv_skip_block(v, io, &io->iter);
> > +			continue;
> > +		}
> > +
> >  		r = verity_hash_for_block(v, io, io->block + b,
> 
> Can you replace 'io->block + b' with 'cur_block' here as well?

Patrik, any chance you could act on Eric's review feedback and post v2
of this patch (assuming you still have a need for it)?

Thanks,
Mike
