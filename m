Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE6ADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B02208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B02208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935020AbeFLB5y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:57:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934894AbeFLB5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF9357D84D;
        Tue, 12 Jun 2018 01:57:51 +0000 (UTC)
Received: from redhat.com (ovpn-120-248.rdu2.redhat.com [10.10.120.248])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EC3B39D60;
        Tue, 12 Jun 2018 01:57:51 +0000 (UTC)
Date:   Tue, 12 Jun 2018 04:57:51 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wei.w.wang@intel.com, nilal@redhat.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20180612043723-mutt-send-email-mst@kernel.org>
References: <20180611192353-mutt-send-email-mst@kernel.org>
 <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 12 Jun 2018 01:57:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 12 Jun 2018 01:57:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:32:41AM -0700, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> 
> Is this really a good idea?

Well knowing which pages are unused does seem to be useful.  Do you
refer to this generally or to the idea of scanning the free list,
or to the specific implementation issues you listed below?


> Plus it seems entirely broken.
> 
> The report_pfn_range() callback is done under the zone lock, but
> virtio_balloon_send_free_pages() (which is the only callback used that
> I can find) does add_one_sg(), which does virtqueue_add_inbuf(vq, &sg,
> 1, vq, GFP_KERNEL);
> 
> So now we apparently do a GFP_KERNEL allocation insider the mm zone
> lock, which is broken on just _so_ many levels.
> 
> Pulled and then unpulled again.
> 
> Either somebody needs to explain why I'm wrong and you can re-submit
> this, or this kind of garbage needs to go away.
> 
> I do *not* want to be in the situation where I pull stuff from the
> virtio people that adds completely broken core VM functionality.
> 
> Because if I'm in that situation, I will stop pulling from you guys.
> Seriously. You have *no* place sending me broken shit that is outside
> the virtio layer.
> 
> Subsystems that break code MM will get shunned. You just aren't
> important enough to allow you breaking code VM.
> 
>                 Linus

So no, it doesn't do any allocations - GFP_KERNEL or otherwise, but I
agree how it might be confusing.

So I'll drop this for now, but it would be nice if there is a bit more
direction on this feature since I know several people are trying to work
on this.


-- 
MST
