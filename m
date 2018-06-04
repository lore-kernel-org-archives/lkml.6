Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeFDXYT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:24:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:50318 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbeFDXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:24:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,477,1520924400";
   d="scan'208";a="45261480"
Date: Mon, 4 Jun 2018 17:24:16 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Mike Snitzer <snitzer@redhat.com>, Toshi Kani <toshi.kani@hpe.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.orgw
Subject: Re: [PATCH v2 5/7] dm: remove DM_TYPE_DAX_BIO_BASED dm_queue_mode
Message-ID: <20180604232416.GB10666@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Mike Snitzer <snitzer@redhat.com>, Toshi Kani <toshi.kani@hpe.com>,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-xfs@vger.kernel.orgw
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-6-ross.zwisler@linux.intel.com>
 <20180601220443.GB18712@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601220443.GB18712@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:04:43PM -0400, Mike Snitzer wrote:
> On Tue, May 29 2018 at  3:51pm -0400,
> Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
> 
> > The DM_TYPE_DAX_BIO_BASED dm_queue_mode was introduced to prevent DM
> > devices that could possibly support DAX from transitioning into DM devices
> > that cannot support DAX.
> > 
> > For example, the following transition will currently fail:
> > 
> >  dm-linear: [fsdax pmem][fsdax pmem] => [fsdax pmem][fsdax raw]
> > 	      DM_TYPE_DAX_BIO_BASED       DM_TYPE_BIO_BASED
> > 
> > but these will both succeed:
> > 
> >  dm-linear: [fsdax pmem][brd ramdisk] => [fsdax pmem][fsdax raw]
> >  	      DM_TYPE_DAX_BIO_BASED        DM_TYPE_BIO_BASED
> > 
> 
> I fail to see how this succeeds given
> drivers/md/dm-ioctl.c:is_valid_type() only allows transitions from:
> 
> DM_TYPE_BIO_BASED => DM_TYPE_DAX_BIO_BASED

Right, sorry, that was a typo.  What I meant was:

> For example, the following transition will currently fail:
> 
>  dm-linear: [fsdax pmem][fsdax pmem] => [fsdax pmem][fsdax raw]
>               DM_TYPE_DAX_BIO_BASED       DM_TYPE_BIO_BASED
> 
> but these will both succeed:
> 
>  dm-linear: [fsdax pmem][brd ramdisk] => [fsdax pmem][fsdax raw]
>                 DM_TYPE_BIO_BASED        DM_TYPE_BIO_BASED
> 
>  dm-linear: [fsdax pmem][fsdax raw] => [fsdax pmem][fsdax pmem]
>                 DM_TYPE_BIO_BASED        DM_TYPE_DAX_BIO_BASED

So we allow 2 of the 3 transitions, but the reason that we disallow the third
isn't fully clear to me.

> >  dm-linear: [fsdax pmem][fsdax raw] => [fsdax pmem][fsdax pmem]
> >  		DM_TYPE_BIO_BASED        DM_TYPE_DAX_BIO_BASED
> > 
> > This seems arbitrary, as really the choice on whether to use DAX happens at
> > filesystem mount time.  There's no guarantee that the in the first case
> > (double fsdax pmem) we were using the dax mount option with our file
> > system.
> > 
> > Instead, get rid of DM_TYPE_DAX_BIO_BASED and all the special casing around
> > it, and instead make the request queue's QUEUE_FLAG_DAX be our one source
> > of truth.  If this is set, we can use DAX, and if not, not.  We keep this
> > up to date in table_load() as the table changes.  As with regular block
> > devices the filesystem will then know at mount time whether DAX is a
> > supported mount option or not.
> 
> If you don't think you need this specialization that is fine.. but DM
> devices supporting suspending (as part of table reloads) so is there any
> risk that there will be inflight IO (say if someone did 'dmsetup suspend
> --noflush').. and then upon reload the device type changed out from
> under us.. anyway, I don't have all the PMEM DAX stuff paged back into
> my head yet.
> 
> But this just seems like we really shouldn't be allowing the
> transition from what was DM_TYPE_DAX_BIO_BASED back to DM_TYPE_BIO_BASED

I admit I don't fully understand all the ways that DM supports suspending and
resuming devices.  Is there actually a case where we can change out the DM
devices while I/O is running, and somehow end up trying to issue a DAX I/O to
a device that doesn't support DAX?

Toshi, do you have a test case that shows this somehow?
