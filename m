Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B7320851
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfBSURq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:17:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39375 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:17:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id x6so508582qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCcuAPQu7uM1twjELqEskJaLGGZmSZUiGg97ChszaOQ=;
        b=q63Q6mJTKtCgdO0Jr/ovUu/y2yWenDaWuZQg21YlRmbjIXSc4xOFC4AsjTnSFIa9tJ
         5c4viefShuauwswDueD0x3Tk82slrMK4VEvgZJyrZVVAHT8+JNKdlUCw7SQdUH19FsSU
         JtSVRyrgV2f2dnhCxErJ1rp2gc2dz/KCwTlmqz7tGYDd4W2t4K2Y7wrDyBFI6okdpIXm
         bJBbrR5YDBIHWUay+GYrBWPLCtYuKsn9pNzxtFpuf88JjiXxbPVb9e+ASSuyPQsg5vXQ
         Fh0n+lphNEjqCakQKQZ0k6q2U45tKIqSvQvQh7VO1B/NVQVgM7ptRjMaaoWN+6Uvtjy4
         dYWA==
X-Gm-Message-State: AHQUAubU+kupYOgq7mkf5neWtGInIVmmBn4CeT0Uq4oOP1+fvlct0401
        VlZMKNMKO5YnPQcJV6mbFNPKgA==
X-Google-Smtp-Source: AHgI3IYN0a3df1axZWdu8fr7a1cy+OK+ivSSggslX/I2TMxGVQWcq2AxyxqRLlJrR3dsugFlWN+EtQ==
X-Received: by 2002:a37:c505:: with SMTP id p5mr22148960qki.257.1550607463215;
        Tue, 19 Feb 2019 12:17:43 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id f33sm11359847qta.91.2019.02.19.12.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:17:42 -0800 (PST)
Date:   Tue, 19 Feb 2019 15:17:40 -0500
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
Message-ID: <20190219151552-mutt-send-email-mst@kernel.org>
References: <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
 <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
 <20190219145241-mutt-send-email-mst@kernel.org>
 <0118482c-e633-3949-6797-94d7deb8a382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0118482c-e633-3949-6797-94d7deb8a382@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:02:52PM +0100, David Hildenbrand wrote:
> On 19.02.19 20:58, Michael S. Tsirkin wrote:
> > On Tue, Feb 19, 2019 at 10:06:35AM -0800, Alexander Duyck wrote:
> >>> I tend to like an asynchronous reporting approach as discussed in this
> >>> thread, we would have to see if Nitesh could get it implemented.
> >>
> >> I agree it would be great if it could work. However I have concerns
> >> given that work on this patch set dates back to 2017, major issues
> >> such as working around device assignment have yet to be addressed,
> > 
> > BTW for device assignment to work, your idea of sending
> > data directly to kvm won't work, will it?
> > You need to update userspace so it can update VFIO right?
> > Another blocker for assignment is ability to make holes
> > an an existing mapping - supported by hardware but
> > not by IOMMU drivers.
> 
> I had the exact same thought and then realized that we decided to block
> the balloon in user space until we figured out how to handle this properly.
> 
> I wonder if MADV_FREE behaves differently compared to MADV_DONTNEED when
> finding pinned pages, but I doubt it. Most probably we'll have to
> disable hinting for device assignments as well.

OK but let's recognize it as a bug not a feature.

-- 
MST
