Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543AD21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfBSUfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:35:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44696 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:35:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id r21so523113qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUt6sJ49rTCFCTY7OXH0axGKeFz1kBU+YkLIo7sABdY=;
        b=ZEHN7hkaQg9MpVEFCe4hi9Nf4II21NbYfje7NeCHCISEjnHrt2pMCcbmjBhcTK7WfO
         aFi82CU6wC6QQiFTXBPO/34ZmkI7PREdgiun3uAM81tzurVoPI77CTkNGNumtF11Buni
         75b+ihmNocyWBwqA2h2bo0FnbLEwBm8+5M928FHyGhbli+rR2kIQMJ98dt1LF9qQCwcQ
         NWaP3cKDWhDc3M6S/jyhYGvwrn8XKdDE7tYmico3eRdlBXMOIKoH1hI7GKpmeWxJHwTo
         Zao0Z8VZoEz0fE63YsW1wFsBDEisAVYjBuAyvtqJ8Ir7igixdUqJzpOj3oK7KzVgZmZo
         pFOA==
X-Gm-Message-State: AHQUAuZFFiK5CSmJ1htmZBYQZqQXInk9be4t0vZIJhoS4tQybo4G1A6n
        DhWTu4jJB43zjstobYe1oCeiIA==
X-Google-Smtp-Source: AHgI3Ibg+9JCNCoPn/oXM+Zrbjr9z7ZdD0k4uojgzvxawU2vhxGryLKbwFVbUwB/ZHqlbFEnDEAnfA==
X-Received: by 2002:a37:9fd7:: with SMTP id i206mr19203091qke.278.1550608533151;
        Tue, 19 Feb 2019 12:35:33 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 188sm9729628qkd.67.2019.02.19.12.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:35:32 -0800 (PST)
Date:   Tue, 19 Feb 2019 15:35:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190219152504-mutt-send-email-mst@kernel.org>
References: <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
 <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
 <20190219145241-mutt-send-email-mst@kernel.org>
 <0118482c-e633-3949-6797-94d7deb8a382@redhat.com>
 <20190219151552-mutt-send-email-mst@kernel.org>
 <488d4113-fef5-17cb-c000-41ece1cdd4ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488d4113-fef5-17cb-c000-41ece1cdd4ca@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:21:20PM +0100, David Hildenbrand wrote:
> On 19.02.19 21:17, Michael S. Tsirkin wrote:
> > On Tue, Feb 19, 2019 at 09:02:52PM +0100, David Hildenbrand wrote:
> >> On 19.02.19 20:58, Michael S. Tsirkin wrote:
> >>> On Tue, Feb 19, 2019 at 10:06:35AM -0800, Alexander Duyck wrote:
> >>>>> I tend to like an asynchronous reporting approach as discussed in this
> >>>>> thread, we would have to see if Nitesh could get it implemented.
> >>>>
> >>>> I agree it would be great if it could work. However I have concerns
> >>>> given that work on this patch set dates back to 2017, major issues
> >>>> such as working around device assignment have yet to be addressed,
> >>>
> >>> BTW for device assignment to work, your idea of sending
> >>> data directly to kvm won't work, will it?
> >>> You need to update userspace so it can update VFIO right?
> >>> Another blocker for assignment is ability to make holes
> >>> an an existing mapping - supported by hardware but
> >>> not by IOMMU drivers.
> >>
> >> I had the exact same thought and then realized that we decided to block
> >> the balloon in user space until we figured out how to handle this properly.
> >>
> >> I wonder if MADV_FREE behaves differently compared to MADV_DONTNEED when
> >> finding pinned pages, but I doubt it. Most probably we'll have to
> >> disable hinting for device assignments as well.
> > 
> > OK but let's recognize it as a bug not a feature.
> > 
> 
> Yes, btw interesting read: https://lwn.net/Articles/198380/

There's also slideware from Rik van Riel circa 2011. His idea
was tagging pages in guest memory, freeing a page involves
- drop the EPT PTE
- check page is still free
- unpin page

This way you can hint without exits at all if you like.

> 
> "Pages which have been locked into memory pose an extra challenge here -
> they can be part of the page cache, but they still shouldn't be taken
> away by the host system. So such pages cannot be marked as "volatile."
> The problem is that figuring out if a page is locked is harder than it
> might seem; it can involve scanning a list of virtual memory area (VMA)
> structures, which is slow. So the hinting patches add a new flag to the
> address_space structure to note that somebody has locked pages from that
> address space in memory."
> 
> I assume locked here actually means pinned.

Locked seems to mean mlock there.

This seems to also resemble Xen's tmem a bit.


> -- 
> 
> Thanks,
> 
> David / dhildenb
