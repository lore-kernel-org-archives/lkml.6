Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDCUpW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:45:22 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:35680 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeDCUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:45:20 -0400
X-Google-Smtp-Source: AIpwx4/FnZIMr/DGPprReqVCyU6IsbxL4xkzV6qsImmhISfrt0Kr2Vgwf9+iNwuf4uWyJPaXiDFxxA==
Date: Tue, 3 Apr 2018 13:45:18 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Jerome Glisse <jglisse@redhat.com>
cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v9 15/24] mm: Introduce __vm_normal_page()
In-Reply-To: <20180403193927.GD5935@redhat.com>
Message-ID: <alpine.DEB.2.20.1804031343360.172772@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com> <1520963994-28477-16-git-send-email-ldufour@linux.vnet.ibm.com> <20180403193927.GD5935@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Jerome Glisse wrote:

> > When dealing with the speculative fault path we should use the VMA's field
> > cached value stored in the vm_fault structure.
> > 
> > Currently vm_normal_page() is using the pointer to the VMA to fetch the
> > vm_flags value. This patch provides a new __vm_normal_page() which is
> > receiving the vm_flags flags value as parameter.
> > 
> > Note: The speculative path is turned on for architecture providing support
> > for special PTE flag. So only the first block of vm_normal_page is used
> > during the speculative path.
> 
> Might be a good idea to explicitly have SPECULATIVE Kconfig option depends
> on ARCH_PTE_SPECIAL and a comment for !HAVE_PTE_SPECIAL in the function
> explaining that speculative page fault should never reach that point.

Yeah, I think that's appropriate but in a follow-up patch since this is 
only propagating vma_flags.  It will require that __HAVE_ARCH_PTE_SPECIAL 
become an actual Kconfig entry, however.
