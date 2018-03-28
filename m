Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeC1VVd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:21:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38539 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbeC1VVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:21:31 -0400
X-Google-Smtp-Source: AIpwx49GWYqLSuSmYDxj3HrHjy1teiV31e4M5eJvC1TH8PJ4+orb8cjKQTAuruohiReqTbUM+dH9CA==
Date: Wed, 28 Mar 2018 14:21:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
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
Subject: Re: [PATCH v9 09/24] mm: protect mremap() against SPF hanlder
In-Reply-To: <1fe7529a-947c-fdb2-12d2-b38bdd41bb04@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1803281419460.167685@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com> <1520963994-28477-10-git-send-email-ldufour@linux.vnet.ibm.com> <alpine.DEB.2.20.1803271500540.43106@chino.kir.corp.google.com>
 <1fe7529a-947c-fdb2-12d2-b38bdd41bb04@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Laurent Dufour wrote:

> >> @@ -326,7 +336,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >>  		mremap_userfaultfd_prep(new_vma, uf);
> >>  		arch_remap(mm, old_addr, old_addr + old_len,
> >>  			   new_addr, new_addr + new_len);
> >> +		if (vma != new_vma)
> >> +			vm_raw_write_end(vma);
> >>  	}
> >> +	vm_raw_write_end(new_vma);
> > 
> > Just do
> > 
> > vm_raw_write_end(vma);
> > vm_raw_write_end(new_vma);
> > 
> > here.
> 
> Are you sure ? we can have vma = new_vma done if (unlikely(err))
> 

Sorry, what I meant was do

if (vma != new_vma)
	vm_raw_write_end(vma);
vm_raw_write_end(new_vma);

after the conditional.  Having the locking unnecessarily embedded in the 
conditional has been an issue in the past with other areas of core code, 
unless you have a strong reason for it.
