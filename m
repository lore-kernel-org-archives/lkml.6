Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1719E218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfABJxW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:53:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfABJxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:53:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF9B8461F8;
        Wed,  2 Jan 2019 09:53:20 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 003A619C65;
        Wed,  2 Jan 2019 09:53:16 +0000 (UTC)
Date:   Wed, 2 Jan 2019 10:53:14 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation
 issues
Message-ID: <20190102105314.0b4e2485.cohuck@redhat.com>
In-Reply-To: <20190101004019.7f20aafa@oc2783563651>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
        <20181230070600.512bbb8b@oc2783563651>
        <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
        <20190101004019.7f20aafa@oc2783563651>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 02 Jan 2019 09:53:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2019 00:40:19 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 31 Dec 2018 06:03:51 +0000
> "Wang, Wei W" <wei.w.wang@intel.com> wrote:
> 
> > On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote:  
> > > 
> > > I guess you are the first one trying to read virtio config from within interrupt
> > > context. AFAICT this never worked.  
> > 
> > I'm not sure about "never worked". It seems to work well with virtio-pci.
> > But looking forward to hearing a solid reason why reading config inside
> > the handler is forbidden (if that's true).  
> 
> By "never worked" I meant "never worked with virtio-ccw". Sorry
> about the misunderstanding. Seems I've also failed to convey that I don't
> know if reading config inside the handler is forbidden or not. So please
> don't expect me providing the solid reasons you are looking forward to.

It won't work with the current code, and this is all a bit ugly :( More
verbose explanation below.

> 
> >   
> > > About what happens. The apidoc of ccw_device_start() says it needs to be
> > > called with the ccw device lock held, so ccw_io_helper() tries to take it (since
> > > forever I guess). OTOH do_cio_interrupt() takes the subchannel lock and
> > > io_subchannel_initialize_dev() makes the ccw device lock be the subchannel
> > > lock. That means when one tries to get virtio config form within a cio
> > > interrupt context we deadlock, because we try to take a lock we already have.
> > > 
> > > That said, I don't think this limitation is by design (i.e. intended).
> > > Maybe Connie can help us with that question. AFAIK we have nothing
> > > documented regarding this (neither that can nor can't).

The main problem is that channel I/O is a fundamentally asynchronous
mechanism. As channel devices don't have the concept of config spaces
(or some other things that virtio needs), I decided to map
reading/writing the config space to channel commands. Starting I/O on a
subchannel always needs the lock (to avoid races on the subchannel),
and the asynchronous interrupt for that I/O needs the lock as well (for
the same reason; things like the scsw contain state that you want to
access without races). A config change also means that the subchannel
becomes state pending (and an interrupt is made pending), so the
subchannel lock is taken for that path as well. (Virtqueue
notifications are handled differently on modern QEMU, but that does not
come into play here.)

> > > 
> > > Obviously, there are multiple ways around this problem, and at the moment
> > > I can't tell which would be my preferred one.  
> > 
> > Yes, it's also not difficult to tweak the virtio-balloon code to avoid that issue.
> > But if that's just an issue with ccw itself, I think it's better to tweak ccw and
> > remain virtio-balloon unchanged.
> >   
> 
> As I said, at the moment I don't have a preference regarding the fix,
> partly because I'm not sure if "reading config inside the handler" is OK
> or not. Maybe Connie or Michael can help us here. I'm however sure that
> commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
> breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
> virtio-balloon on s390): it used to work before and does not work
> after.

Yes, that's unfortunate.

> 
> AFAICT tweaking the balloon code may be simpler than tweaking the
> virtio-ccw (transport code). ccw_io_helper() relies on getting
> an interrupt when the issued IO is done. If virtio-ccw is buggy, it
> needs to be fixed, but I'm not sure it is.

I would not call virtio-ccw buggy, but it has some constraints that
virtio-pci apparently doesn't have (and which did not show up so far;
e.g. virtio-blk schedules a work item on config change, so there's no
deadlock there.)

One way to get out of that constraint (don't interact with the config
space directly in the config changed handler) would be to schedule a
work item in virtio-ccw that calls virtio_config_changed() for the
device. My understanding is that delaying the notification to a work
queue would be fine.

From what I can see, that should make us safe on any modern QEMU (that
uses adapter interrupts). There still might be problems if we are using
classic subchannel interrupts for virtqueue notifications and the
handler interacts with the config space, but I'm not sure whether it is
worth spending time on that.
