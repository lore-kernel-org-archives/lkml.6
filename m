Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCKTQ2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:16:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38520 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbeCKTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:16:26 -0400
X-Google-Smtp-Source: AG47ELsc2i+3bDk4Wueeh945OH/HYZvZO02kMbtxprpiJ2GhY+BcoRxyrMuNULUCs+CPaRESg6jAZFNPft3rfItbsHc=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iZFW9Lk=KdEy=0iYzM9GmQ4ccoN2imYNDq6XwXDgXsDw@mail.gmail.com>
References: <152066488891.40260.14605734226832760468.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152066489984.40260.2215636951958334858.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180310094633.GA31604@lst.de> <CAPcyv4iZFW9Lk=KdEy=0iYzM9GmQ4ccoN2imYNDq6XwXDgXsDw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 11 Mar 2018 12:16:25 -0700
Message-ID: <CAPcyv4ijGP_77VgLUekE53=i7JxMPjvUqpebKPnV2vXMqzpWcw@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] xfs, dax: introduce xfs_dax_aops
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 9:40 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sat, Mar 10, 2018 at 1:46 AM, Christoph Hellwig <hch@lst.de> wrote:
>>> +int dax_set_page_dirty(struct page *page)
>>> +{
>>> +     /*
>>> +      * Unlike __set_page_dirty_no_writeback that handles dirty page
>>> +      * tracking in the page object, dax does all dirty tracking in
>>> +      * the inode address_space in response to mkwrite faults. In the
>>> +      * dax case we only need to worry about potentially dirty CPU
>>> +      * caches, not dirty page cache pages to write back.
>>> +      *
>>> +      * This callback is defined to prevent fallback to
>>> +      * __set_page_dirty_buffers() in set_page_dirty().
>>> +      */
>>> +     return 0;
>>> +}
>>
>> Make this a generic noop_set_page_dirty maybe?
>>
>>> +EXPORT_SYMBOL(dax_set_page_dirty);
>>> +
>>> +void dax_invalidatepage(struct page *page, unsigned int offset,
>>> +             unsigned int length)
>>> +{
>>> +     /*
>>> +      * There is no page cache to invalidate in the dax case, however
>>> +      * we need this callback defined to prevent falling back to
>>> +      * block_invalidatepage() in do_invalidatepage().
>>> +      */
>>> +}
>>
>> Same here.
>
> I guess I'm not sure what you mean. These nops are specific to dax I
> don't think they make sense in another context besides dax.
>

I did the rename, and am housing these in fs/dax.c, I assume that's
what you wanted.
