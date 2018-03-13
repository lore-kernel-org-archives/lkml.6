Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeCMNEa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:04:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48825 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752156AbeCMNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:04:29 -0400
X-ME-Sender: <xms:XMynWshEoPFk3ahOqjytSxc2nR57E7APY7wNnwt9zQCgWx7M5NYIbg>
Message-Id: <1520946268.2518488.1301423472.4D7861CD@webmail.messagingengine.com>
From: "Jacob S. Moroni" <mail@jakemoroni.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-54087d22
Date: Tue, 13 Mar 2018 09:04:28 -0400
Subject: Should the VM_PFNMAP flag be cleared after a call to dma_mmap_coherent?
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First, let me just say that this is more of a question rather than a proposal.

I have a question regarding the behavior of the dma_mmap_coherent routine, and
the VM_PFNMAP flag in general.

Right now, it seems like the dma_mmap_coherent routine is essentially just a
wrapper for remap_pfn_range, which itself sets the VM_PFNMAP and VM_IO flags.

However, dma_mmap_coherent is explicitly designed to map in buffers that have
been previously allocated with dma_alloc_coherent, which therefore means that
there is always a struct page backing for the entire buffer, right?

The reason this matters is because when the VM_PFNMAP flag is set, the user
can't make any calls that end up doing a get_user_pages. The main case I can
think of is direct IO. Consider the case where there's some specialized hardware
that is generating raw file data and placing it in host memory, which is then
mapped in to an application. It would be beneficial to be able to do a
direct IO write straight from the mapping in user space to avoid an unnecessary
copy. This matters more on some embedded systems where the PCIe bandwidth
is in the same ballpark as the memcpy bandwidth.

This can be accomplished by more manual mapping methods, but it would be nice
if it could be done with the standard dma_alloc/mmap_coherent pair.

Is there a reason this flag should not be cleared before returning from
dma_mmap_coherent?

Is there a benefit of this flag being set? Perhaps performance?

I understand that the flag indicates that there's no struct page behind a
given page, but is there a reason to have this flag be set when all pages
are in fact true RAM?

Would there be any issues if I were to just clear these flags myself after
dma_mmap_coherent returns?

Also, in my attempts to understand this, I have found what may be a few bugs,
primarily in some GPU drivers.

For example, in the "exynox_drm_gem_mmap_buffer" function in
drivers/gpu/drm/exynos/exynos_drm_gem.c, the VM_PFNMAP flag is explicitly
cleared, but then it goes on to call dma_mmap_attrs, which I think ends up just
re-setting the flag.

This is found in a few other places as well. Thoughts?

Any advice would be appreciated.

Thanks!

Jake Moroni
