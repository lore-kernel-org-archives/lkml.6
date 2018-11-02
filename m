Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281FBC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33822082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33822082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeKBUxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:53:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40560 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeKBUxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:53:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CF34A78;
        Fri,  2 Nov 2018 04:46:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 510453F71E;
        Fri,  2 Nov 2018 04:46:41 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:46:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, mst@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:06:19PM -0700, Linus Torvalds wrote:
> On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > +       memset(&rsp, 0, sizeof(rsp));
> > +       rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> > +       resp = vq->iov[out].iov_base;
> > +       ret = __copy_to_user(resp, &rsp, sizeof(rsp));
> >
> > Is it actually safe to trust that iov_base has passed an earlier
> > access_ok() check here? Why not just use copy_to_user() instead?
> 
> Good point.
> 
> We really should have removed those double-underscore things ages ago.

FWIW, on arm64 we always check/sanitize the user address as a result of
our sanitization of speculated values. Almost all of our uaccess
routines have an explicit access_ok().

All our uaccess routines mask the user pointer based on addr_limit,
which prevents speculative or architectural uaccess to kernel addresses
when addr_limit it USER_DS:

    4d8efc2d5ee4c9cc ("arm64: Use pointer masking to limit uaccess speculation")

We also inhibit speculative stores to addr_limit being forwarded under
speculation:

    c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use of the current addr_limit")

... and given all that, we folded explicit access_ok() checks into
__{get,put}_user():

    84624087dd7e3b48 ("arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user")

IMO we could/should do the same for __copy_{to,from}_user().

Thanks,
Mark.
