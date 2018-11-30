Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F962145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F962145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLAAxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLAAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:53:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69C543164669;
        Fri, 30 Nov 2018 13:44:22 +0000 (UTC)
Received: from redhat.com (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id CECBE1057075;
        Fri, 30 Nov 2018 13:44:16 +0000 (UTC)
Date:   Fri, 30 Nov 2018 08:44:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20181130084227-mutt-send-email-mst@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 30 Nov 2018 13:44:23 +0000 (UTC)
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
> 
> Also, apart from the address, what about the size? Wouldn't it be
> better to use copy_to_iter() rather than implement it badly by hand?
> 
>                Linus

Bijan can you respond please?
Are you going to look into this and convert code to copy_to_iter?
I don't think we should release Linux like this, so if you don't
have the time I'd rather revert for now and you can look
into reposting for the next release.

Thanks,

-- 
MST

