Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8A19FC004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF6D208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF6D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935324AbeFLBg7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935027AbeFLBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B17427D84D;
        Tue, 12 Jun 2018 01:36:55 +0000 (UTC)
Received: from redhat.com (ovpn-120-248.rdu2.redhat.com [10.10.120.248])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD28A6B58E;
        Tue, 12 Jun 2018 01:36:54 +0000 (UTC)
Date:   Tue, 12 Jun 2018 04:36:54 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wei.w.wang@intel.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20180612042600-mutt-send-email-mst@kernel.org>
References: <20180611192353-mutt-send-email-mst@kernel.org>
 <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
 <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 12 Jun 2018 01:36:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 12 Jun 2018 01:36:55 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:44:05AM -0700, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 11:32 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So now we apparently do a GFP_KERNEL allocation insider the mm zone
> > lock, which is broken on just _so_ many levels.
> 
> Oh, I see the comment about how it doesn't actually do an allocation
> at all because it's a single-entry.
> 
> Still too damn ugly to live, and much too fragile. No way in hell do
> we even _hint_ at a GFP_KERNEL when we're inside a context that can't
> do any memory allocation at all.
> 
> Plus I'm not convinced it's a "no allocation" path even despite that
> comment, because it also does a "dma_map_page()" etc, which can cause
> allocations to do the dma mapping thing afaik. No?

Well no because DMA is triggered by the IOMMU flag and
that is always off for the balloon. But I hear what you
are saying about it being fragile.

> Maybe there's some reason why that doesn't happen either, but
> basically this whole callchain looks *way* to complicated to be used
> under a core VM spinlock.
> 
>                 Linus

Maybe it will help to have GFP_NONE which will make any allocation
fail if attempted. Linus, would this address your comment?
-- 
MST
