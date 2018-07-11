Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C1920883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C1920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeGKEDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 00:03:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbeGKEDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 00:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4D248E68C;
        Wed, 11 Jul 2018 04:00:45 +0000 (UTC)
Received: from redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id C26F01C5B8;
        Wed, 11 Jul 2018 04:00:38 +0000 (UTC)
Date:   Wed, 11 Jul 2018 07:00:37 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Message-ID: <20180711064709-mutt-send-email-mst@kernel.org>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 04:00:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 04:00:45 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:33:08AM -0700, Linus Torvalds wrote:
> NAK.
> 
> On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
> >
> > +
> > +       buf_page = list_first_entry_or_null(pages, struct page, lru);
> > +       if (!buf_page)
> > +               return -EINVAL;
> > +       buf = (__le64 *)page_address(buf_page);
> 
> Stop this garbage.
> 
> Why the hell would you pass in some crazy "liost of pages" that uses
> that lru list?
> 
> That's just insane shit.
> 
> Just pass in a an array to fill in.
> No idiotic games like this with
> odd list entries (what's the locking?) and crazy casting to
> 
> So if you want an array of page addresses, pass that in as such. If
> you want to do it in a page, do it with
> 
>     u64 *array = page_address(page);
>     int nr = PAGE_SIZE / sizeof(u64);
> 
> and now you pass that array in to the thing. None of this completely
> insane crazy crap interfaces.

Question was raised what to do if there are so many free
MAX_ORDER pages that their addresses don't fit in a single MAX_ORDER
page. Yes, only a huge guest would trigger that but it seems
theoretically possible.

I guess an array of arrays then?

An alternative suggestion was not to pass an array at all,
instead peel enough pages off the list to contain
all free entries. Maybe that's too hacky.


> 
> Plus, I still haven't heard an explanation for why you want so many
> pages in the first place, and why you want anything but MAX_ORDER-1.
> 
> So no. This kind of unnecessarily complex code with completely insane
> calling interfaces does not make it into the VM layer.
> 
> Maybe that crazy "let's pass a chain of pages that uses the lru list"
> makes sense to the virtio-balloon code. But you need to understand
> that it makes ZERO conceptual sense to anybody else. And the core VM
> code is about a million times more important than the balloon code in
> this case, so you had better make the interface make sense to *it*.
> 
>                Linus
