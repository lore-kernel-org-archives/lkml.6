Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFECC282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D6A21934
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfBJAwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 19:52:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34224 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfBJAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 19:52:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so8395992qtj.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 16:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJkLelzdLzhK7WMM4z+zshrLTbNUKoX1y7BTB8bNEug=;
        b=ZTa4FT6ByE9V6J78OlPVnC4xzkHx9MxFL9lWI81z6Gf8elXd20/KD1d+NVTbfpWIhA
         J0rR3aikyijNULn1vUl20NJSrhLyqnMYZB62wkh+zLIFhEHr9oQ3qJemuHZ2prw+2vBz
         7N+SkVTINZsBNMrle4kO6+uLkAnu7npBDxfjV7tGrU5swjiNzE7MjW8XkYUekG9BaYXa
         xoGTiERbwDu6lgxzm2wKg7jvxQEFnBuc6cuJuiDdPINgxpUDnHN5qVVa0L/4EWSvaa1U
         MMJTW9nKgU7h5FqHUaFYutc5k0fhn8r1M+bpaTEHeARBmzWGkBekGYfhYB9D7WOjy1Rr
         aYLg==
X-Gm-Message-State: AHQUAubCA+otRGgFmZDBTu16ktpLGE7gynfhSiAwUT/9VPKUgAukIW6C
        bv0MZ2QKjtbrdrEhnUPPk4vLAQ==
X-Google-Smtp-Source: AHgI3IZTmPLlMBxSzkSawrG90tnOTcF+/r4MRX0lJPE9fQXEMCoIjJgJWuQBpx666vPlTv3Zzrm7tg==
X-Received: by 2002:a0c:8542:: with SMTP id n60mr21644167qva.205.1549759919435;
        Sat, 09 Feb 2019 16:51:59 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id w123sm19025314qkw.80.2019.02.09.16.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 16:51:58 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:51:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com,
        alexander.h.duyck@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 0/4] kvm: Report unused guest pages to host
Message-ID: <20190209194940-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204181118.12095.38300.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:15:33AM -0800, Alexander Duyck wrote:
> This patch set provides a mechanism by which guests can notify the host of
> pages that are not currently in use. Using this data a KVM host can more
> easily balance memory workloads between guests and improve overall system
> performance by avoiding unnecessary writing of unused pages to swap.

There's an obvious overlap with Nilal's work and already merged Wei's
work here.  So please Cc people reviewing Nilal's and Wei's
patches.


> In order to support this I have added a new hypercall to provided unused
> page hints and made use of mechanisms currently used by PowerPC and s390
> architectures to provide those hints. To reduce the overhead of this call
> I am only using it per huge page instead of of doing a notification per 4K
> page. By doing this we can avoid the expense of fragmenting higher order
> pages, and reduce overall cost for the hypercall as it will only be
> performed once per huge page.
> 
> Because we are limiting this to huge pages it was necessary to add a
> secondary location where we make the call as the buddy allocator can merge
> smaller pages into a higher order huge page.
> 
> This approach is not usable in all cases. Specifically, when KVM direct
> device assignment is used, the memory for a guest is permanently assigned
> to physical pages in order to support DMA from the assigned device. In
> this case we cannot give the pages back, so the hypercall is disabled by
> the host.
> 
> Another situation that can lead to issues is if the page were accessed
> immediately after free. For example, if page poisoning is enabled the
> guest will populate the page *after* freeing it. In this case it does not
> make sense to provide a hint about the page being freed so we do not
> perform the hypercalls from the guest if this functionality is enabled.
> 
> My testing up till now has consisted of setting up 4 8GB VMs on a system
> with 32GB of memory and 4GB of swap. To stress the memory on the system I
> would run "memhog 8G" sequentially on each of the guests and observe how
> long it took to complete the run. The observed behavior is that on the
> systems with these patches applied in both the guest and on the host I was
> able to complete the test with a time of 5 to 7 seconds per guest. On a
> system without these patches the time ranged from 7 to 49 seconds per
> guest. I am assuming the variability is due to time being spent writing
> pages out to disk in order to free up space for the guest.
> 
> ---
> 
> Alexander Duyck (4):
>       madvise: Expose ability to set dontneed from kernel
>       kvm: Add host side support for free memory hints
>       kvm: Add guest side support for free memory hints
>       mm: Add merge page notifier
> 
> 
>  Documentation/virtual/kvm/cpuid.txt      |    4 ++
>  Documentation/virtual/kvm/hypercalls.txt |   14 ++++++++
>  arch/x86/include/asm/page.h              |   25 +++++++++++++++
>  arch/x86/include/uapi/asm/kvm_para.h     |    3 ++
>  arch/x86/kernel/kvm.c                    |   51 ++++++++++++++++++++++++++++++
>  arch/x86/kvm/cpuid.c                     |    6 +++-
>  arch/x86/kvm/x86.c                       |   35 +++++++++++++++++++++
>  include/linux/gfp.h                      |    4 ++
>  include/linux/mm.h                       |    2 +
>  include/uapi/linux/kvm_para.h            |    1 +
>  mm/madvise.c                             |   13 +++++++-
>  mm/page_alloc.c                          |    2 +
>  12 files changed, 158 insertions(+), 2 deletions(-)
> 
> --
