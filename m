Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFF721773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBSCqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:46:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41107 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBSCqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:46:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id u188so11183406qkh.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X3e123debaZrdatpF8LVVD50UxdmlznvaYsmfyo/Cts=;
        b=hCRapp6d/a/5yD4CJHJz1mrrZFXits5w2nDPDkNFywGJtrEz66Dm+ftaCZcmJ+NJEq
         sKXX78KFGoL0+Jc4ai9Si1+wb40RQz1hMn2Ms0F+sORZqVtbDWRdpYX5cUwvBg8R0ejd
         5pskFoLskL1tdmH/m0oH+brA9EenbYkNH9Qjnn5wO062WYCJT0APoXVB6z3mGOjd+3h3
         PldKXB6e6JhAQO1uQ9kUCHnJnXDb7VJAKs9Tji1i2+K7cHP1pInIPXLdJfDyaT8VYnd4
         ivI4o9wO2uyOs4nkozvoSd7BOZDgb3a31n01UvlK+gvdK5N/afAPyLVmui69eAzCdcxp
         Hr9A==
X-Gm-Message-State: AHQUAubPBaS61r5XVTdYyhJJYIBGDSZsQ5kmn7vKvs1RVwQ39lVK4QHU
        +96G7LMgh31qJJGCv0rP7msv4g==
X-Google-Smtp-Source: AHgI3IaXVaeMNud6jb1iPtXOiXG8xawflt8rMIwQQYEopAvsKRMnLqF6QvzXtzkya4o6SB8vRIgLNA==
X-Received: by 2002:a37:c04a:: with SMTP id o71mr18573661qki.234.1550544361882;
        Mon, 18 Feb 2019 18:46:01 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id m124sm7569556qkc.16.2019.02.18.18.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 18:46:00 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:45:57 -0500
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
Message-ID: <20190218214441-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
 <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 03:47:22PM -0800, Alexander Duyck wrote:
> > > So far with my patch set that hints at the PMD level w/ THP enabled I
> > > am not really seeing that much overhead for the hypercalls. The bigger
> > > piece that is eating up CPU time is all the page faults and page
> > > zeroing that is going on as we are cycling the memory in and out of
> > > the guest. Some of that could probably be resolved by using MADV_FREE,
> > > but if we are under actual memory pressure I suspect it would behave
> > > similar to MADV_DONTNEED.
> > >
> >
> > MADV_FREE is certainly the better thing to do for hinting in my opinion.
> > It should result in even less overhead. Thanks for the comment about the
> > hypercall overhead.
> 
> Yeah, no problem. The only thing I don't like about MADV_FREE is that
> you have to have memory pressure before the pages really start getting
> scrubbed with is both a benefit and a drawback. Basically it defers
> the freeing until you are under actual memory pressure so when you hit
> that case things start feeling much slower, that and it limits your
> allocations since the kernel doesn't recognize the pages as free until
> it would have to start trying to push memory to swap.

For sure if someone *wants* to spend cycles freeing memory,
we could add a system call that does exactly that. There's
no reason to force that on the same CPU while VCPU
is stopped though.

-- 
MST
