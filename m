Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F255217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVivxx3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfBDSPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:15:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41100 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBDSPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:15:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so264094pgq.8;
        Mon, 04 Feb 2019 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YbgwgPfTgR6RtE7F+vI0MmFOmUqaJ06bNhtl9pXn92s=;
        b=EVivxx3zf3BECuE6OKnATN/wV4n+PQUGCg+NbojhIFckrkIugDtHvtRXly/Ho6uEGF
         quuKkvi+6vb8VkGYDjrNwqxTLE4X8wD4UIxTWltdzDOiGCZYQ/0j9HChN5tXdGQt8llQ
         wlvqR7bI42IxMNEhqP1j1Wojt3fBgK+4skyNEXbvJZ1YW3lTauav4irVYoNez68sim9z
         dmiLUVGkthOoZBrYjvzitJYoIVCGoC4f0iwzLQAnVjgakyQ/iIGuuFMXtbh2AkgXREj7
         Gn6Bv3Yq7k1i7IaPEgpG84u4CItcQMzeHX4JEn4aPeh/IcYVWR54IOd4BEnLl9ZSH89A
         Jveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=YbgwgPfTgR6RtE7F+vI0MmFOmUqaJ06bNhtl9pXn92s=;
        b=OYEX7mvV6pMZKx3PY391W9Hn2AHlexJnjMIcSW+VydoO3774pIeyCFW39wNttXwfDE
         AtvJO8g5FG1fYUYR4vHe+rmcuuKngj9+CCyNXoZWXFXAt09l/PktjAS6yPErjwEV2oJF
         l5aQL0m3KhFr60LI0IVo6gmqkzauzbGwN0U8WARwRFN5fn+/MmsMKNxATPlb/uxBBAXO
         /pSr6MccGgDpVCkSybi3gssqtmwkdn/mYP/klXwrdX25ADqkZpszO10/TaYd/cSBT6i2
         WoIcsOocE7X3TeWeg6xcdF5E8hBrjoiVtjbhC4duzFsbyHqSw9FRoBSf5SdG5K+AmMXS
         NsYQ==
X-Gm-Message-State: AHQUAuYkvk8GTd8uy3wKjW2+447qwFFC/8hVRkKZeAIA6MvNt3qvK8bj
        9woUFT+Ivs6j429adFp5PQRzF+ZVutc=
X-Google-Smtp-Source: AHgI3IYdUC2KYnsIvatwFAItCTG9QdAywv9GyQbmcX0uwgxjOHlfiVJgi/57nTVo6HelLpv6X8ouSg==
X-Received: by 2002:a63:2406:: with SMTP id k6mr565655pgk.229.1549304135284;
        Mon, 04 Feb 2019 10:15:35 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id v12sm853005pgg.41.2019.02.04.10.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:15:34 -0800 (PST)
Subject: [RFC PATCH 0/4] kvm: Report unused guest pages to host
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 10:15:33 -0800
Message-ID: <20190204181118.12095.38300.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides a mechanism by which guests can notify the host of
pages that are not currently in use. Using this data a KVM host can more
easily balance memory workloads between guests and improve overall system
performance by avoiding unnecessary writing of unused pages to swap.

In order to support this I have added a new hypercall to provided unused
page hints and made use of mechanisms currently used by PowerPC and s390
architectures to provide those hints. To reduce the overhead of this call
I am only using it per huge page instead of of doing a notification per 4K
page. By doing this we can avoid the expense of fragmenting higher order
pages, and reduce overall cost for the hypercall as it will only be
performed once per huge page.

Because we are limiting this to huge pages it was necessary to add a
secondary location where we make the call as the buddy allocator can merge
smaller pages into a higher order huge page.

This approach is not usable in all cases. Specifically, when KVM direct
device assignment is used, the memory for a guest is permanently assigned
to physical pages in order to support DMA from the assigned device. In
this case we cannot give the pages back, so the hypercall is disabled by
the host.

Another situation that can lead to issues is if the page were accessed
immediately after free. For example, if page poisoning is enabled the
guest will populate the page *after* freeing it. In this case it does not
make sense to provide a hint about the page being freed so we do not
perform the hypercalls from the guest if this functionality is enabled.

My testing up till now has consisted of setting up 4 8GB VMs on a system
with 32GB of memory and 4GB of swap. To stress the memory on the system I
would run "memhog 8G" sequentially on each of the guests and observe how
long it took to complete the run. The observed behavior is that on the
systems with these patches applied in both the guest and on the host I was
able to complete the test with a time of 5 to 7 seconds per guest. On a
system without these patches the time ranged from 7 to 49 seconds per
guest. I am assuming the variability is due to time being spent writing
pages out to disk in order to free up space for the guest.

---

Alexander Duyck (4):
      madvise: Expose ability to set dontneed from kernel
      kvm: Add host side support for free memory hints
      kvm: Add guest side support for free memory hints
      mm: Add merge page notifier


 Documentation/virtual/kvm/cpuid.txt      |    4 ++
 Documentation/virtual/kvm/hypercalls.txt |   14 ++++++++
 arch/x86/include/asm/page.h              |   25 +++++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h     |    3 ++
 arch/x86/kernel/kvm.c                    |   51 ++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                     |    6 +++-
 arch/x86/kvm/x86.c                       |   35 +++++++++++++++++++++
 include/linux/gfp.h                      |    4 ++
 include/linux/mm.h                       |    2 +
 include/uapi/linux/kvm_para.h            |    1 +
 mm/madvise.c                             |   13 +++++++-
 mm/page_alloc.c                          |    2 +
 12 files changed, 158 insertions(+), 2 deletions(-)

--
