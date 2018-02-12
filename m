Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeBLXFN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:05:13 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38995 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbeBLXFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:05:11 -0500
X-Google-Smtp-Source: AH8x227bwaFNXLIY2b16wo/HYYcWP8TSg+wwmiaLn6IJphITdNlZd69owoiZO6qE3b1goaSNKuiDXeNDoORHgaATqTo=
MIME-Version: 1.0
In-Reply-To: <x49inb1n7kb.fsf@segfault.boston.devel.redhat.com>
References: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
 <x49inb1n7kb.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 12 Feb 2018 15:05:10 -0800
Message-ID: <CAPcyv4gt88pEivOyEGdYbTx9H2LV7+mQQ9H1ESWhzM+gpbtW0g@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: re-enable deep flush for pmem devices
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
        "Zwisler, Ross" <ross.zwisler@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 2:53 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dave Jiang <dave.jiang@intel.com> writes:
>
>> Re-enable deep flush so that users always have a way to be sure that a write
>> does make it all the way out to the NVDIMM. The PMEM driver writes always
>> make it "all the way to the NVDIMM", and it relies on the ADR mechanism to
>> flush the write buffers on power failure. Deep flush is there to explicitly
>> flush those write buffers to protect against (rare) ADR failure.
>> This change prevents a regression in deep flush behavior so that applications
>> can continue to depend on fsync() as a mechanism to trigger deep flush in the
>> filesystem-dax case.
>
> That's still very confusing text.  Specifically, the part where you say
> that pmem driver writes always make it to the DIMM.  I think the
> changelog could start with "Deep flush is there to explicitly flush
> write buffers...."  Anyway, the fix looks right to me.

I ended up changing the commit message to this, let me know if it reads better:


    libnvdimm: re-enable deep flush for pmem devices via fsync()

    Re-enable deep flush so that users always have a way to be sure that a
    write makes it all the way out to media. The PMEM driver writes always
    arrive at the NVDIMM, and it relies on the ADR (Asynchronous DRAM
    Refresh) mechanism to flush the write buffers on power failure. Deep
    flush is there to explicitly flush those write buffers to protect
    against (rare) ADR failure.  This change prevents a regression in deep
    flush behavior so that applications can continue to depend on fsync() as
    a mechanism to trigger deep flush in the filesystem-DAX case.

    Fixes: 06e8ccdab15f4 ("acpi: nfit: Add support for detect platform
CPU cache...")
    Signed-off-by: Dave Jiang <dave.jiang@intel.com>
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>
