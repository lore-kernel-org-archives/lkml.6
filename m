Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965102AbeBMOsj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:48:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:54882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933716AbeBMOsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:48:38 -0500
Date: Tue, 13 Feb 2018 15:48:36 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
Message-ID: <20180213144836.GU3443@dhcp22.suse.cz>
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-02-18 13:35:08, David Rientjes wrote:
> The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
> sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
> This can be up to 4096 entries on architectures such as arm64 and s390
> (and the upper bound may be increased on s390 eventually).
> 
> This can produce a vmalloc allocation failure warning:
> 
> vmalloc: allocation failure: 0 bytes, mode:0x24000c2(GFP_KERNEL|__GFP_HIGHMEM)

I am not arguing about the kvm change but do we actaully want to warn
for 0 sized allocations? This just doesn't make much sense to me.
In other words don't we want this?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 673942094328..c5d832510c54 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1748,7 +1748,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	unsigned long real_size = size;
 
 	size = PAGE_ALIGN(size);
-	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
+	if (!size)
+		return NULL;
+	if ((size >> PAGE_SHIFT) > totalram_pages)
 		goto fail;
 
 	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
-- 
Michal Hocko
SUSE Labs
