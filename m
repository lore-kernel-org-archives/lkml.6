Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeCWDKX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:10:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752209AbeCWDKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:10:20 -0400
Date: Fri, 23 Mar 2018 11:10:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <20180323031013.GB11150@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
 <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
 <20180323005845.GA25740@localhost.localdomain>
 <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/18 at 07:06pm, Andrew Morton wrote:
> On Fri, 23 Mar 2018 08:58:45 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > erk, this is pretty nasty.  Isn't there a better way :(
> > 
> > Yes, this is not efficient.
> > 
> > In struct resource{}, ->sibling list is a singly linked list. I ever
> > thought about changing it to doubly linked list, yet not very sure if
> > it will have effect since struct resource is a core data structure.
> 
> Switching to a list_head sounds OK.  The only issue really is memory
> consumption and surely we don't have tens of thousands of struct
> resources floating about(?).  Or if we do have a lot, the machine is
> presumably huge (hope?).

Yes. It doubles the memory consumption.

AFAIK, the biggest number of resrouces I heard of possibly is mentioned
in this user space kexec_tools commit. In this commit, Xunlei told on
SGI system with 64TB RAM, the array which we have been using to store
"System RAM"|"Reserved"|"ACPI **" regions is not big enough. In that
case, we need extra 8Byte*2048=16KB at most. With my understanding, this
increase is system wide, since each resource instance only needs its own
list_head member, right?

commit 4a6d67d9e938a7accf128aff23f8ad4bda67f729
Author: Xunlei Pang <xlpang@redhat.com>
Date:   Thu Mar 23 19:16:59 2017 +0800

    x86: Support large number of memory ranges
    
    We got a problem on one SGI 64TB machine, the current kexec-tools
    failed to work due to the insufficient ranges(MAX_MEMORY_RANGES)
    allowed which is defined as 1024(less than the ranges on the machine).
    The kcore header is insufficient due to the same reason as well.
    
    To solve this, this patch simply doubles "MAX_MEMORY_RANGES" and
    "KCORE_ELF_HEADERS_SIZE".
    
    Signed-off-by: Xunlei Pang <xlpang@redhat.com>
    Tested-by: Frank Ramsay <frank.ramsay@hpe.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 33df352..51855f8 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -1,7 +1,7 @@
 #ifndef KEXEC_X86_H
 #define KEXEC_X86_H
 
-#define MAX_MEMORY_RANGES 1024
+#define MAX_MEMORY_RANGES 2048


> 
> > AKASHI's method is more acceptable, and currently only kexec has this
> > requirement.
> 
> What method is that?

I meant this patch is made by AKASHI, he posted a patchset to add
kexec_file support for arm64. Among those patches this one is used to
arm64 kernel at top of system RAM. Later they change a different way to
search memory region to load kernel, so he dropped this patch.
