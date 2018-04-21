Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeDUX47 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 19:56:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40411 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbeDUX45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 19:56:57 -0400
X-Google-Smtp-Source: AIpwx4/545MKdQTDvjqyb4tv3CF8yuR889zA3Q98m0yKpY7aaq2EYyc6blWND+0zRq8IwONQvYOx8czMWTe3Gl5fBFE=
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZoU0O_w6stq+47ndBUY+yqk950nsyP_1ShTArQfxsSeQ@mail.gmail.com>
References: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
 <20180421213401.GF14610@bombadil.infradead.org> <CAFqt6zZoU0O_w6stq+47ndBUY+yqk950nsyP_1ShTArQfxsSeQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 21 Apr 2018 16:56:56 -0700
Message-ID: <CAPcyv4jzyofOTrymiQchXyRdNPZ+BXn3-W3hjCJ4mvtpDD2g4w@mail.gmail.com>
Subject: Re: [PATCH v3] fs: dax: Adding new return type vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 2:54 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Sun, Apr 22, 2018 at 3:04 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> On Sun, Apr 22, 2018 at 02:35:29AM +0530, Souptick Joarder wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> There was an existing bug inside dax_load_hole()
>>> if vm_insert_mixed had failed to allocate a page table,
>>> we'd return VM_FAULT_NOPAGE instead of VM_FAULT_OOM.
>>> With new vmf_insert_mixed() this issue is addressed.
>>>
>>> vm_insert_mixed_mkwrite has inefficiency when it returns
>>> an error value, driver has to convert it to vm_fault_t
>>> type. With new vmf_insert_mixed_mkwrite() this limitation
>>> will be addressed.
>>>
>>> As new function vmf_insert_mixed_mkwrite() only called
>>> from fs/dax.c, so keeping both the changes in a single
>>> patch.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> There's a couple of minor things which could be tidied up, but not worth
>> doing them as a revision to this patch.
>
> Which tree this patch will go through ? mm or fsdevel ?

nvdimm, since that tree has some pending reworks for dax-vs-truncate.
