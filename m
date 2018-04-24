Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756155AbeDXF7p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:59:45 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33654 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeDXF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:59:41 -0400
X-Google-Smtp-Source: AB8JxZoozTRup3pUvVJm4psy7VEF9j3gH/akIpOelMjyLHRR80c0IET5cVbBuSZr95VXKC4dDGIgsRTpi36zAWwOiF4=
MIME-Version: 1.0
In-Reply-To: <20180423194917.GF13383@bombadil.infradead.org>
References: <20180423180625.GA16101@jordon-HP-15-Notebook-PC> <20180423194917.GF13383@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 24 Apr 2018 11:29:39 +0530
Message-ID: <CAFqt6zatfzk8PmBN110LD_x8goU+vO4U9TAGaamJ4UqwRm+g_g@mail.gmail.com>
Subject: Re: [PATCH v5] fs: dax: Adding new return type vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: jack@suse.cz, Al Viro <viro@zeniv.linux.org.uk>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, kirill.shutemov@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 1:19 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Apr 23, 2018 at 11:36:25PM +0530, Souptick Joarder wrote:
>> If the insertion of PTE failed because someone else
>> already added a different entry in the mean time, we
>> treat that as success as we assume the same entry was
>> actually inserted.
>
> No, Jan said to *make it a comment*.  In the source file.  That's why
> he formatted it with the /* */.  Not in the changelog.
Sorry, got confused.

I think this should be fine -

+/*
+If the insertion of PTE failed because someone else
+already added a different entry in the mean time, we
+treat that as success as we assume the same entry was
+actually inserted.
+*/

-int vm_insert_mixed_mkwrite(struct vm_area_struct *vma, unsigned long addr,
-                       pfn_t pfn)
+vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
+               unsigned long addr, pfn_t pfn)
 {
-       return __vm_insert_mixed(vma, addr, pfn, true);
+       int err;
+
+       err =  __vm_insert_mixed(vma, addr, pfn, true);
+       if (err == -ENOMEM)
+               return VM_FAULT_OOM;
+       if (err < 0 && err != -EBUSY)
+               return VM_FAULT_SIGBUS;
+       return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL(vm_insert_mixed_mkwrite);
+EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
