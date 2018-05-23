Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933746AbeEWREH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:04:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:37707 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932649AbeEWRED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:04:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="49426336"
Date: Wed, 23 May 2018 11:04:02 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 7/9] dax: report bytes remaining in dax_iomap_actor()
Message-ID: <20180523170402.GA1847@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152539240242.31796.4162676712193177396.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180523163442.GB29519@linux.intel.com>
 <CAPcyv4gaM+vMLQKzfQ3J0LBhN2L6uNUzqwH_m39pFN-TeQHavA@mail.gmail.com>
 <20180523164708.GD29519@linux.intel.com>
 <CAPcyv4heJgEc8=Y0FjxvqzieY8hh4yK0uJbnEEBnXYFQodOPKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4heJgEc8=Y0FjxvqzieY8hh4yK0uJbnEEBnXYFQodOPKg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 09:53:38AM -0700, Dan Williams wrote:
> On Wed, May 23, 2018 at 9:47 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > On Wed, May 23, 2018 at 09:39:04AM -0700, Dan Williams wrote:
> >> On Wed, May 23, 2018 at 9:34 AM, Ross Zwisler
> >> <ross.zwisler@linux.intel.com> wrote:
> >> > On Thu, May 03, 2018 at 05:06:42PM -0700, Dan Williams wrote:
> >> >> In preparation for protecting the dax read(2) path from media errors
> >> >> with copy_to_iter_mcsafe() (via dax_copy_to_iter()), convert the
> >> >> implementation to report the bytes successfully transferred.
> >> >>
> >> >> Cc: <x86@kernel.org>
> >> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> >> Cc: Borislav Petkov <bp@alien8.de>
> >> >> Cc: Tony Luck <tony.luck@intel.com>
> >> >> Cc: Al Viro <viro@zeniv.linux.org.uk>
> >> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> >> Cc: Andy Lutomirski <luto@amacapital.net>
> >> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> >> ---
> >> >>  fs/dax.c |   20 +++++++++++---------
> >> >>  1 file changed, 11 insertions(+), 9 deletions(-)
> >> >>
> >> >> diff --git a/fs/dax.c b/fs/dax.c
> >> >> index a64afdf7ec0d..34a2d435ae4b 100644
> >> >> --- a/fs/dax.c
> >> >> +++ b/fs/dax.c
> >> >> @@ -991,6 +991,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >> >>       struct iov_iter *iter = data;
> >> >>       loff_t end = pos + length, done = 0;
> >> >>       ssize_t ret = 0;
> >> >> +     size_t xfer;
> >> >>       int id;
> >> >>
> >> >>       if (iov_iter_rw(iter) == READ) {
> >> >> @@ -1054,19 +1055,20 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >> >>                * vfs_write(), depending on which operation we are doing.
> >> >>                */
> >> >>               if (iov_iter_rw(iter) == WRITE)
> >> >> -                     map_len = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> >> >> +                     xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> >> >>                                       map_len, iter);
> >> >>               else
> >> >> -                     map_len = dax_copy_to_iter(dax_dev, pgoff, kaddr,
> >> >> +                     xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
> >> >>                                       map_len, iter);
> >> >> -             if (map_len <= 0) {
> >> >> -                     ret = map_len ? map_len : -EFAULT;
> >> >> -                     break;
> >> >> -             }
> >> >>
> >> >> -             pos += map_len;
> >> >> -             length -= map_len;
> >> >> -             done += map_len;
> >> >> +             pos += xfer;
> >> >> +             length -= xfer;
> >> >> +             done += xfer;
> >> >> +
> >> >> +             if (xfer == 0)
> >> >> +                     ret = -EFAULT;
> >> >> +             if (xfer < map_len)
> >> >> +                     break;
> >> >
> >> > I'm confused by this error handling.  So if we hit an error on a given iov and
> >> > we don't transfer the expected number of bytes, we have two cases:
> >> >
> >> > 1) We transferred *something* on this iov but not everything - return success.
> >> > 2) We didn't transfer anything on this iov - return -EFAULT.
> >> >
> >> > Both of these are true regardless of data transferred on previous iovs.
> >> >
> >> > Why the distinction?  If a given iov is interrupted, regardless of whether it
> >> > transferred 0 bytes or 1, shouldn't the error path be the same?
> >>
> >> This is is the semantics of read(2) / write(2). Quoting the pwrite man page:
> >>
> >>        Note that is not an error for  a  successful  call  to
> >> transfer  fewer  bytes  than
> >>        requested (see read(2) and write(2)).
> >
> > Consider this case:
> >
> > I have 4 IOVs, each of a full page.  The first three transfer their full page,
> > but on the third we hit an error.
> >
> > If we transferred 0 bytes in the fourth page, we'll return -EFAULT.
> >
> > If we transferred 1 byte in the fourth page, we'll return the total length
> > transferred, so 3 pages + 1 byte.
> >
> > Why?  pwrite(2) says it returns the number of bytes written, which can be less
> > than the total requested.  Why not just return the length transferred in both
> > cases, instead of returning -EFAULT for one of them?
> 
> Ah, now I see. Yes, that's a bug. Once we have successfully completed
> any iovec we should be returning bytes transferred not -EFAULT.

Actually, your code is fine.  This is handled by the:

 return done ? done : ret;

at the end of the function.  So if we've transferred any data at all, we'll
return the number of bytes transferred, and if we didn't we'll return -EFAULT
because 0 is the special case which means EOF according to pread(2)/pwrite(2).

Looks good, then.  Thanks for answering my questions. 

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
