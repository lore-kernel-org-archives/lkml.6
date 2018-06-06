Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Z853GRSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72171601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeFFSgu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:36:50 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37525 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeFFSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:36:48 -0400
X-Google-Smtp-Source: ADUXVKJWkTES9L+y41/ctAQAbKmgfg4ZtYkS1xceW72zXIuGeXGPj26p6LyhUVW1mc5XLBEMW21p54gdQeZTh4kBuyQ=
MIME-Version: 1.0
In-Reply-To: <20180606181619.GA13076@linux.intel.com>
References: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
 <20180606164515.25677-2-ross.zwisler@linux.intel.com> <CAPcyv4h8NBfCOMUiY_0Do0YgwA18Lqb_QTiAJVO0x3t5+TPMBQ@mail.gmail.com>
 <20180606181619.GA13076@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 6 Jun 2018 11:36:47 -0700
Message-ID: <CAPcyv4h8LRZHJmmCDjO2CoOCax0W_XkcKfiP2iAUg6dj31tYmQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] libnvdimm: unconditionally deep flush on *sync
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:16 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Wed, Jun 06, 2018 at 10:57:59AM -0700, Dan Williams wrote:
>> On Wed, Jun 6, 2018 at 9:45 AM, Ross Zwisler
>> <ross.zwisler@linux.intel.com> wrote:
>> > Prior to this commit we would only do a "deep flush" (have nvdimm_flush()
>> > write to each of the flush hints for a region) in response to an
>> > msync/fsync/sync call if the nvdimm_has_cache() returned true at the time
>> > we were setting up the request queue.  This happens due to the write cache
>> > value passed in to blk_queue_write_cache(), which then causes the block
>> > layer to send down BIOs with REQ_FUA and REQ_PREFLUSH set.  We do have a
>> > "write_cache" sysfs entry for namespaces, i.e.:
>> >
>> >   /sys/bus/nd/devices/pfn0.1/block/pmem0/dax/write_cache
>> >
>> > which can be used to control whether or not the kernel thinks a given
>> > namespace has a write cache, but this didn't modify the deep flush behavior
>> > that we set up when the driver was initialized.  Instead, it only modified
>> > whether or not DAX would flush CPU caches via dax_flush() in response to
>> > *sync calls.
>> >
>> > Simplify this by making the *sync deep flush always happen, regardless of
>> > the write cache setting of a namespace.  The DAX CPU cache flushing will
>> > still be controlled the write_cache setting of the namespace.
>> >
>> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Looks, good. I believe we want this one and ["PATCH v3 4/4] libnvdimm:
>> don't flush power-fail protected CPU caches" marked for -stable and
>> tagged with:
>>
>> Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices
>> via fsync()")
>>
>> ...any concerns with that?
>
> Nope, sounds good.  Can you fix that up when you apply, or would it be helpful
> for me to send another revision with those tags?

I'll fix it up, thanks Ross.
