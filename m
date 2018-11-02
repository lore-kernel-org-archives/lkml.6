Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A099FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FF320831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FF320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeKCCHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeKCCHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:07:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41B1E58E3C;
        Fri,  2 Nov 2018 16:59:46 +0000 (UTC)
Received: from redhat.com (ovpn-124-238.rdu2.redhat.com [10.10.124.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19CA92635D;
        Fri,  2 Nov 2018 16:59:40 +0000 (UTC)
Date:   Fri, 2 Nov 2018 12:59:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mark.rutland@arm.com, Kees Cook <keescook@chromium.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20181102122937-mutt-send-email-mst@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
 <20181102083018-mutt-send-email-mst@kernel.org>
 <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 02 Nov 2018 16:59:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 09:14:51AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > I've tried making access_ok mask the parameter it gets.
> 
> PLEASE don't do this.

Okay.

> Just use "copy_to/from_user()".

Just for completeness I'd like to point out for vhost the copies are
done from the kernel thread.  So yes we can switch to copy_to/from_user
but for e.g. 32-bit userspace running on top of a 64 bit kernel it is
IIUC not sufficient - we must *also* do access_ok checks on control path
when addresses are passed to the kernel and when current points to the
correct task struct.

> We have had lots of bugs because code bitrots.

Yes, I wish we did not need these access_ok checks and could just rely
on copy_to/from_user.

> And no, the access_ok() checks aren't expensive, not even in a loop.
> They *used* to be somewhat expensive compared to the access, but that
> simply isn't true any more. The real expense in copy_to_user and
> friends are in the user access bit setting (STAC and CLAC on x86),
> which easily an order of magnitude more expensive than access_ok().
> 
> So just get rid of the double-underscore version. It's basically
> always a mis-optimization due to entirely historical reasons. I can
> pretty much guarantee that it's not visible in profiles.
> 
>                   Linus

OK. So maybe we should focus on switching to user_access_begin/end +
unsafe_get_user/unsafe_put_user in a loop which does seem to be
measureable.  That moves the barrier out of the loop, which seems to be
consistent with what you would expect.

-- 
MST
