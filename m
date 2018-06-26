Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F9BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E76C26822
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76C26822
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeFZJrc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:47:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:52738 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932963AbeFZJr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:47:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 02:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="52315406"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2018 02:47:27 -0700
Subject: Re: 4.17.0-rc3+ BUG kmalloc-2048: Poison overwritten (USB hub
 disconnect)
To:     Vegard Nossum <vegard.nossum@gmail.com>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <CAOMGZ=ErZHAY7XF8XnPP-rAZahx4giOcntJj+JENuZOH-kZ3kg@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <e81b49c5-4239-3e45-21bc-23e842b7ebf5@linux.intel.com>
Date:   Tue, 26 Jun 2018 12:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOMGZ=ErZHAY7XF8XnPP-rAZahx4giOcntJj+JENuZOH-kZ3kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 26.06.2018 11:20, Vegard Nossum wrote:
> Hi,
> 
> I've been seeing variants of this when I plug/unplug my ThinkPad T460
> from the docking station:
> 
> usb 2-4: USB disconnect, device number 30
> usb 2-4.1: USB disconnect, device number 31
> thinkpad_acpi: undocked from hotplug port replicator
> thinkpad_acpi: EC reports that Thermal Table has changed
> usb 1-4: USB disconnect, device number 61
> usb 1-4.1: USB disconnect, device number 63
> usb 1-4.4: USB disconnect, device number 62
> =============================================================================
> BUG kmalloc-2048 (Tainted: G    B            ): Poison overwritten
> -----------------------------------------------------------------------------
> 
> INFO: 0x00000000f262b063-0x00000000ccb4f11c. First byte 0x0 instead of 0x6b
> INFO: Allocated in usb_alloc_dev+0x35/0x329 age=6894431 cpu=0 pid=27384
>          __slab_alloc+0x20/0x40
>          kmem_cache_alloc_trace+0x1ee/0x230
>          usb_alloc_dev+0x35/0x329
>          hub_event+0xba8/0x15c0
>          process_one_work+0x148/0x3d0
>          worker_thread+0x4b/0x460
>          kthread+0x102/0x140
>          ret_from_fork+0x35/0x40
> INFO: Freed in usb_release_dev+0x60/0x70 age=0 cpu=0 pid=32750
>          kfree+0x176/0x1a0
>          usb_release_dev+0x60/0x70
>          device_release+0x32/0x90
>          kobject_put+0x82/0x190
>          put_device+0x17/0x20
>          usb_disconnect+0x1b2/0x290
>          usb_disconnect+0x1f3/0x290
>          hub_event+0x94f/0x15c0
>          process_one_work+0x148/0x3d0
>          worker_thread+0x4b/0x460
>          kthread+0x102/0x140
>          ret_from_fork+0x35/0x40
> INFO: Slab 0x00000000f6509278 objects=13 used=13 fp=0x          (null)
> flags=0x17fffc000008100
> INFO: Object 0x00000000a7692b6c @offset=4776 fp=0x0000000078ed8ddc
> 
> I don't have the source/config for this kernel anymore, sorry. Will
> probably try a newer kernel at some point to see if it's still
> present, it might already be fixed. I just wanted to send a report
> just in case it has enough info for somebody to spot what went wrong
> without too much effort.
> 
> See attachment for fuller log + timestamps. The tainted bits are from
> earlier reports of the same type.
> 
> 

Does  patch
2278446 xhci: Fix USB3 NULL pointer dereference at logical disconnect.
help?

It should be in 4.17-rc6

-Mathias
