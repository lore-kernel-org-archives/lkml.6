Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA8C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0297420866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 09:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0297420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeIIOSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 10:18:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeIIOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 10:18:25 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BD4794B;
        Sun,  9 Sep 2018 09:29:20 +0000 (UTC)
Date:   Sun, 9 Sep 2018 11:29:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, christian@brauner.io, serge@hallyn.com,
        ebiederm@xmission.com, dan.rue@linaro.org,
        naresh.kamboju@linaro.org
Subject: Re: [PATCH 4.4 34/47] userns: move user access out of the mutex
Message-ID: <20180909092918.GB7927@kroah.com>
References: <20180907210904.607934824@linuxfoundation.org>
 <20180907210908.241189276@linuxfoundation.org>
 <CABdQkv8Oxmy7ZcwAhKJ-tYJyqJCWba9+vtGCSgMS2aGymEzhsQ@mail.gmail.com>
 <20180909091633.GC4195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909091633.GC4195@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 11:16:33AM +0200, Greg KH wrote:
> On Sun, Sep 09, 2018 at 12:56:45AM -0300, Rafael David Tinoco wrote:
> > Greg,
> > 
> > On Fri, Sep 7, 2018 at 6:41 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Jann Horn <jannh@google.com>
> > >
> > > commit 5820f140edef111a9ea2ef414ab2428b8cb805b1 upstream.
> > >
> > > The old code would hold the userns_state_mutex indefinitely if
> > > memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
> > > moving the memdup_user_nul in front of the mutex_lock().
> > >
> > > Note: This changes the error precedence of invalid buf/count/*ppos vs
> > > map already written / capabilities missing.
> > >
> > > Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Acked-by: Christian Brauner <christian@brauner.io>
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > ---
> > >  kernel/user_namespace.c |   22 ++++++++++------------
> > >  1 file changed, 10 insertions(+), 12 deletions(-)
> > >
> > > --- a/kernel/user_namespace.c
> > > +++ b/kernel/user_namespace.c
> > > @@ -604,7 +604,16 @@ static ssize_t map_write(struct file *fi
> > >         struct uid_gid_extent *extent = NULL;
> > >         unsigned long page = 0;
> > >         char *kbuf, *pos, *next_line;
> > > -       ssize_t ret = -EINVAL;
> > > +       ssize_t ret;
> > > +
> > > +       /* Only allow < page size writes at the beginning of the file */
> > > +       if ((*ppos != 0) || (count >= PAGE_SIZE))
> > > +               return -EINVAL;
> > > +
> > > +       /* Slurp in the user data */
> > > +       if (copy_from_user(kbuf, buf, count))
> > > +               return -EFAULT;
> > > +       kbuf[count] = '\0';
> > 
> > Naresh will soon report issues found by LKFT on user_ns for 4.4 kernel
> > for this review round.
> > 
> > selftests: mount_run_tests.sh [FAIL]
> > write to /proc/self/uid_map failed: Bad address
> > 
> > LTP: user_namespace2 1 TBROK : safe_macros.c:452: userns02.c:95:
> > write(6,0x7ffc133113d0,18446744073709551615) failed: errno=EFAULT(14):
> > Bad address
> > 
> > I believe the EFAULT was caused because when changing code from
> > "memdup_user_nul" to "copy_from_user", for the older kernels, you
> > missed allocating the slab object for "kbuf", like memdup_user_nul()
> > does.
> > 
> > Note: This likely applies to 3.18 as well.
> > 
> > We are finishing functional tests without this patch, but we wanted to
> > make you aware right away.
> 
> Ok, should now be fixed up, thanks for finding this and noticing it.
> I've pushed out a -rc3 with the fix.

And I've fixed it up in 3.18 as well, pushing out a -rc2 with the fix.

thanks,

greg k-h
