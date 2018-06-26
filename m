Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86223C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E322430D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E322430D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935658AbeFZNef (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:34:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933522AbeFZNee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A88404067720;
        Tue, 26 Jun 2018 13:34:33 +0000 (UTC)
Received: from redhat.com (ovpn-122-22.rdu2.redhat.com [10.10.122.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 125221C5BA;
        Tue, 26 Jun 2018 13:34:27 +0000 (UTC)
Date:   Tue, 26 Jun 2018 16:34:27 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v34 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180626163139-mutt-send-email-mst@kernel.org>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <1529928312-30500-3-git-send-email-wei.w.wang@intel.com>
 <20180626002822-mutt-send-email-mst@kernel.org>
 <5B31B71B.6080709@intel.com>
 <20180626064338-mutt-send-email-mst@kernel.org>
 <5B323140.1000306@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B323140.1000306@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 13:34:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 13:34:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 08:27:44PM +0800, Wei Wang wrote:
> On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
> > On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
> > 
> 
> > > 
> > > > 
> > > > > +	if (!arrays)
> > > > > +		return NULL;
> > > > > +
> > > > > +	for (i = 0; i < max_array_num; i++) {
> > > > So we are getting a ton of memory here just to free it up a bit later.
> > > > Why doesn't get_from_free_page_list get the pages from free list for us?
> > > > We could also avoid the 1st allocation then - just build a list
> > > > of these.
> > > That wouldn't be a good choice for us. If we check how the regular
> > > allocation works, there are many many things we need to consider when pages
> > > are allocated to users.
> > > For example, we need to take care of the nr_free
> > > counter, we need to check the watermark and perform the related actions.
> > > Also the folks working on arch_alloc_page to monitor page allocation
> > > activities would get a surprise..if page allocation is allowed to work in
> > > this way.
> > > 
> > mm/ code is well positioned to handle all this correctly.
> 
> I'm afraid that would be a re-implementation of the alloc functions,

A re-factoring - you can share code. The main difference is locking.

> and
> that would be much more complex than what we have. I think your idea of
> passing a list of pages is better.
> 
> Best,
> Wei

How much memory is this allocating anyway?

-- 
MST
