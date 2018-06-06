Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AXYhHSRgGFsVPAAAmS7hNA
	; Wed, 06 Jun 2018 22:29:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D91C060861; Wed,  6 Jun 2018 22:29:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 130726074D;
	Wed,  6 Jun 2018 22:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 130726074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeFFW34 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:29:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752042AbeFFW3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:29:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC501818BAF3;
        Wed,  6 Jun 2018 22:29:53 +0000 (UTC)
Received: from localhost (ovpn-112-19.rdu2.redhat.com [10.10.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00CE46B5A1;
        Wed,  6 Jun 2018 22:29:50 +0000 (UTC)
Date: Wed, 6 Jun 2018 18:29:49 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dm: remove DM_TYPE_DAX_BIO_BASED dm_queue_mode
Message-ID: <20180606222949.GA4465@redhat.com>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-6-ross.zwisler@linux.intel.com>
 <20180601220443.GB18712@redhat.com>
 <20180604232416.GB10666@linux.intel.com>
 <20180605004558.GB6898@redhat.com>
 <20180606172421.GA2208@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606172421.GA2208@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:29:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:29:54 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06 2018 at  1:24P -0400,
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> On Mon, Jun 04, 2018 at 08:46:28PM -0400, Mike Snitzer wrote:
> > On Mon, Jun 04 2018 at  7:24pm -0400,
> > Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
> > 
> > > On Fri, Jun 01, 2018 at 06:04:43PM -0400, Mike Snitzer wrote:
> > > > On Tue, May 29 2018 at  3:51pm -0400,
> > > > Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
> > > > 
> > > > > The DM_TYPE_DAX_BIO_BASED dm_queue_mode was introduced to prevent DM
> > > > > devices that could possibly support DAX from transitioning into DM devices
> > > > > that cannot support DAX.
> > > > > 
> > > > > For example, the following transition will currently fail:
> > > > > 
> > > > >  dm-linear: [fsdax pmem][fsdax pmem] => [fsdax pmem][fsdax raw]
> > > > > 	      DM_TYPE_DAX_BIO_BASED       DM_TYPE_BIO_BASED
> > > > > 
> > > > > but these will both succeed:
> > > > > 
> > > > >  dm-linear: [fsdax pmem][brd ramdisk] => [fsdax pmem][fsdax raw]
> > > > >  	      DM_TYPE_DAX_BIO_BASED        DM_TYPE_BIO_BASED
> > > > > 
> > > > 
> > > > I fail to see how this succeeds given
> > > > drivers/md/dm-ioctl.c:is_valid_type() only allows transitions from:
> > > > 
> > > > DM_TYPE_BIO_BASED => DM_TYPE_DAX_BIO_BASED
> > > 
> > > Right, sorry, that was a typo.  What I meant was:
> > > 
> > > > For example, the following transition will currently fail:
> > > > 
> > > >  dm-linear: [fsdax pmem][fsdax pmem] => [fsdax pmem][fsdax raw]
> > > >               DM_TYPE_DAX_BIO_BASED       DM_TYPE_BIO_BASED
> > > > 
> > > > but these will both succeed:
> > > > 
> > > >  dm-linear: [fsdax pmem][brd ramdisk] => [fsdax pmem][fsdax raw]
> > > >                 DM_TYPE_BIO_BASED        DM_TYPE_BIO_BASED
> > > > 
> > > >  dm-linear: [fsdax pmem][fsdax raw] => [fsdax pmem][fsdax pmem]
> > > >                 DM_TYPE_BIO_BASED        DM_TYPE_DAX_BIO_BASED
> > > 
> > > So we allow 2 of the 3 transitions, but the reason that we disallow the third
> > > isn't fully clear to me.
> > > 
> > > > >  dm-linear: [fsdax pmem][fsdax raw] => [fsdax pmem][fsdax pmem]
> > > > >  		DM_TYPE_BIO_BASED        DM_TYPE_DAX_BIO_BASED
> > > > > 
> > > > > This seems arbitrary, as really the choice on whether to use DAX happens at
> > > > > filesystem mount time.  There's no guarantee that the in the first case
> > > > > (double fsdax pmem) we were using the dax mount option with our file
> > > > > system.
> > > > > 
> > > > > Instead, get rid of DM_TYPE_DAX_BIO_BASED and all the special casing around
> > > > > it, and instead make the request queue's QUEUE_FLAG_DAX be our one source
> > > > > of truth.  If this is set, we can use DAX, and if not, not.  We keep this
> > > > > up to date in table_load() as the table changes.  As with regular block
> > > > > devices the filesystem will then know at mount time whether DAX is a
> > > > > supported mount option or not.
> > > > 
> > > > If you don't think you need this specialization that is fine.. but DM
> > > > devices supporting suspending (as part of table reloads) so is there any
> > > > risk that there will be inflight IO (say if someone did 'dmsetup suspend
> > > > --noflush').. and then upon reload the device type changed out from
> > > > under us.. anyway, I don't have all the PMEM DAX stuff paged back into
> > > > my head yet.
> > > > 
> > > > But this just seems like we really shouldn't be allowing the
> > > > transition from what was DM_TYPE_DAX_BIO_BASED back to DM_TYPE_BIO_BASED
> > > 
> > > I admit I don't fully understand all the ways that DM supports suspending and
> > > resuming devices.  Is there actually a case where we can change out the DM
> > > devices while I/O is running, and somehow end up trying to issue a DAX I/O to
> > > a device that doesn't support DAX?
> > 
> > Yes, provided root permissions, it's very easy to dmsetup suspend/load/resume
> > to replace any portion of the DM device's logical address space to map to an
> > entirely different DM target (with a different backing store).  It's
> > pretty intrusive to do such things, but easily done and powerful.
> > 
> > Mike
> 
> Hmmm, I don't understand how you can do this if there is a filesystem built on
> your DM device?  Say you have a DM device, either striped or linear, that is
> made up of 2 devices, and then you use dmsetup to replace one of the DM member
> devices with something else.  You've just swapped out half of your LBA space
> with new data, right? 
> 
> I don't understand how you can expect a filesystem built on the old DM device
> to still work?  You especially can't do this while the filesystem is mounted -
> all the in-core filesystem metadata would be garbage because the on-media data
> would have totally changed.

Sure it can cause you to no longer have access to the original backing
store (e.g. swapping in an "error" target instead of linear).

But this ability to suspend a DM device with a table that is using
"linear", load a new table (that uses a different target) into the
inactive table slot, and then resume to make the device active is how
things like snapshot support are achieved.  The "linear" target gets
replaced with "snapshot-origin', etc.
 
> So, when dealing with a filesystem, the flow must be:
> 
> unmount your filesystem
> redo your DM device, changing out devices
> reformat your filesystem on the new DM device
> remount your filesystem
> 
> Right?

No.

> If so, then I don't see how a transition of the DM device from
> supporting DAX to not supporting DAX or vice versa could harm us, as we can't
> be doing filesystem I/O at the time when we change the composition of the DM
> device.

Yes you can.  That is the entire point.

BTW, I'm not saying you have to change the backing store.  I'm saying
you _can_ if you would like.  Obviously if you remove the backing store
with the filesystem then you'll not be able to access the filesystem.

The point of all this is to say, DM table swaps can be good and
powerful.  But they can also be harmful.  The goal of preventing
transitions from DM_TYPE_DAX_BIO_BASED to DM_TYPE_BIO_BASED was to
shield users from doing obviously wrong things... things they might not
realize are problematic because of the relatively opaque nature of "DAX"
support.

Mike
