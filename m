Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C7EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E17A218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfABNXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:23:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfABNXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:23:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B961076528;
        Wed,  2 Jan 2019 13:23:44 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5D7E1001947;
        Wed,  2 Jan 2019 13:23:40 +0000 (UTC)
Date:   Wed, 2 Jan 2019 14:23:38 +0100
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
Message-ID: <20190102142338.15bfe876.cohuck@redhat.com>
In-Reply-To: <20190102105314.0b4e2485.cohuck@redhat.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
        <20181230070600.512bbb8b@oc2783563651>
        <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
        <20190101004019.7f20aafa@oc2783563651>
        <20190102105314.0b4e2485.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 02 Jan 2019 13:23:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 10:53:14 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 1 Jan 2019 00:40:19 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:

> > As I said, at the moment I don't have a preference regarding the fix,
> > partly because I'm not sure if "reading config inside the handler" is OK
> > or not. Maybe Connie or Michael can help us here. I'm however sure that
> > commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
> > breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
> > virtio-balloon on s390): it used to work before and does not work
> > after.  
> 
> Yes, that's unfortunate.
> 
> > 
> > AFAICT tweaking the balloon code may be simpler than tweaking the
> > virtio-ccw (transport code). ccw_io_helper() relies on getting
> > an interrupt when the issued IO is done. If virtio-ccw is buggy, it
> > needs to be fixed, but I'm not sure it is.  
> 
> I would not call virtio-ccw buggy, but it has some constraints that
> virtio-pci apparently doesn't have (and which did not show up so far;
> e.g. virtio-blk schedules a work item on config change, so there's no
> deadlock there.)
> 
> One way to get out of that constraint (don't interact with the config
> space directly in the config changed handler) would be to schedule a
> work item in virtio-ccw that calls virtio_config_changed() for the
> device. My understanding is that delaying the notification to a work
> queue would be fine.

Unfortunately, calling virtio_config_changed() from a work item is not
enough: That function takes the config_lock, and the virtio-ccw code to
get the config both needs to allocate some memory and call schedule :/

The best option really seems to be
- have virtio-balloon move the handling of the config change onto a
  workqueue or something like that, and
- document that you cannot read/write the virtio config space from an
  atomic context

Unless someone has a better idea?
