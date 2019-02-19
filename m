Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C267C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50E20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfBST67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:58:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38550 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfBST65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:58:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so472278qkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 11:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxj+G0sNKNaSYFN6jDA8KSosnNrPgcvqT9FcW0DMnlM=;
        b=q4Fir75PJatoHXmPN2KI7gP+kVhb91JrsZaFTkKsaAVZMAEGSN3OVHyyojHEBCU5Ki
         xzu0RQ3MMmiQaBWhmSEK3vKsVxH5f8BCwiS0U8Jqra1cgkgsyT5CcAjVL26pVixSX1wN
         v49hBiaSZ1YPJ/508A/E8xAVCTHqntKh2ZCnsmo2QmhTxamrUwXqLGBSURZDchNhfbrQ
         e9GLrE0B5opAGNtnWYapkzz9uOUyQkPTY0wU8U9x0sRnbhkwSn/wrCzi61rEUq/UmNPE
         DhYjMLzJBu2TrESNDbVAzDdimin+zuAikOXIa0+AWDeOgw7A2kdzViFsjonfBmrRBqP4
         ehSA==
X-Gm-Message-State: AHQUAuYYss96g7oPxSaVF5Ol4Fk6vs4t6CYsFuSjL63V1fVGX5g6QHq4
        aL4oVSW/h/xEt7bWhKI51pZYFw==
X-Google-Smtp-Source: AHgI3IbgQHxNgMz3z/gbEtLOCqAcVJDwkK7wDfo3qNI4Pn2T7WhTVAPQEybnQ/RkhDiCm1lbER3dpg==
X-Received: by 2002:a37:aa0b:: with SMTP id t11mr21675517qke.241.1550606335110;
        Tue, 19 Feb 2019 11:58:55 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id q25sm3490434qtk.73.2019.02.19.11.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:58:54 -0800 (PST)
Date:   Tue, 19 Feb 2019 14:58:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
Message-ID: <20190219145241-mutt-send-email-mst@kernel.org>
References: <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
 <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:06:35AM -0800, Alexander Duyck wrote:
> > I tend to like an asynchronous reporting approach as discussed in this
> > thread, we would have to see if Nitesh could get it implemented.
> 
> I agree it would be great if it could work. However I have concerns
> given that work on this patch set dates back to 2017, major issues
> such as working around device assignment have yet to be addressed,

BTW for device assignment to work, your idea of sending
data directly to kvm won't work, will it?
You need to update userspace so it can update VFIO right?
Another blocker for assignment is ability to make holes
an an existing mapping - supported by hardware but
not by IOMMU drivers.

All the issues are shared with balloon btw, so that
could be another reason to use the balloon.

> and
> it seems like most of the effort is being focused on things that in my
> opinion are being over-engineered for little to no benefit.
> 
> I really think that simpler would be much better in terms of design in
> this case.
> 
> Thanks.
> 
> - Alex

I personally learned a lot from Wei's work on hinting.


All this doesn't mean you approach is not the right one.

-- 
MST
