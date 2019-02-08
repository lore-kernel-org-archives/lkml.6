Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D45C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DF7218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfBHViO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:38:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39521 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHViN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:38:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so5669600qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5Pv6iBpz4UAFMvsa+Z4jhDBDBBgEdM56DJ6JZQc9+w=;
        b=YCjvGMP1r2AF9hvqMUm7XtbZ9NVjYsHKiUQdecziUM8RHrGZoI3exiQ0UDHHnamBhN
         nKJmBxOqInJ0rXJ+pFpM/I51tS3mx1UtdHaB6RpYorQkEWHBuZpjv1YYueNf85aOT3wX
         Be9ej7jbLTdFihdKCNii/Ptl4t/nzaEjmbLTWpcCqaFimMnQ5aDZyPSH0QtIdljgcya/
         Fw/e0riw3df5UIe3M4CSqK0rYAHgs4KWPOsjr2g9XRvNaXGp6Ox68MKuQ9GkOVTell/v
         zH6Qn87sqMMx2uYWxuA4LPhNZQWySLg6UIGTttFZDeNiTcCGakPCVIc8Vh+Yn7nQfGL3
         OchQ==
X-Gm-Message-State: AHQUAuZUwlrF9Zc9eSapFSHFhOJSSPT9PiKsqFaQs8M8G+v6kHemdBH4
        RauUIrdvOVkKZbfcz2CVr3RbDA==
X-Google-Smtp-Source: AHgI3IZxSExXKxLY5QF2bSpoGFcg0xI+6c7Bg1mDz91ZKzfyf9TLKoFG9+Vg1AvFrPE2LJZlTSapRQ==
X-Received: by 2002:ad4:4182:: with SMTP id e2mr4308819qvp.9.1549661892895;
        Fri, 08 Feb 2019 13:38:12 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id y33sm4352864qty.11.2019.02.08.13.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:38:12 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:38:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and
 report free pages
Message-ID: <20190208163601-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 03:41:55PM -0500, Nitesh Narayan Lal wrote:
> >> I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
> >> However I am still thinking about a workload which I can use to test its
> >> effectiveness.
> > You might want to look at doing something like min(MAX_ORDER - 1,
> > HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit for
> > THP which is the most likely to be used page size with the guest.
> Sure, thanks for the suggestion.

Given current hinting in balloon is MAX_ORDER I'd say
share code. If you feel a need to adjust down the road,
adjust both of them with actual testing showing gains.

-- 
MST
