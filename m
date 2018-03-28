Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeC1KU2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:20:28 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:40081 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC1KU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:20:26 -0400
X-Google-Smtp-Source: AIpwx48hxA8azLS3l0rU/mMiIATOEP2St04nnuJPlma4I3kiObY27Xt/DjZ5QPOT9Q34JnlwAfNtOg==
Date: Wed, 28 Mar 2018 03:20:23 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
        ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
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
Subject: Re: [PATCH v9 06/24] mm: make pte_unmap_same compatible with SPF
In-Reply-To: <fd9eedf4-b885-d8f5-2daa-4cc450e72427@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1803280318440.69353@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com> <1520963994-28477-7-git-send-email-ldufour@linux.vnet.ibm.com> <alpine.DEB.2.20.1803271417510.31115@chino.kir.corp.google.com>
 <fd9eedf4-b885-d8f5-2daa-4cc450e72427@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Laurent Dufour wrote:

> >> @@ -2913,7 +2921,8 @@ int do_swap_page(struct vm_fault *vmf)
> >>  	int exclusive = 0;
> >>  	int ret = 0;
> > 
> > Initialization is now unneeded.
> 
> I'm sorry, what "initialization" are you talking about here ?
> 

The initialization of the ret variable.

@@ -2913,7 +2921,8 @@ int do_swap_page(struct vm_fault *vmf)
 	int exclusive = 0;
 	int ret = 0;
 
-	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
+	ret = pte_unmap_same(vmf);
+	if (ret)
 		goto out;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);

"ret" is immediately set to the return value of pte_unmap_same(), so there 
is no need to initialize it to 0.
