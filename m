Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E95C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DEB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfAXPxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:53:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:50673 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:53:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 07:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,517,1539673200"; 
   d="scan'208";a="140990603"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2019 07:53:03 -0800
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        gregkh@linuxfoundation.org
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
 <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
 <CALaQ_hp4XoEbT7qYG58fbrODbHvOFS7-GQZcEoPw4CPDNZZ+6w@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <d65b37ba-c32f-a8d9-01a9-7dd54d354936@linux.intel.com>
Date:   Thu, 24 Jan 2019 17:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALaQ_hp4XoEbT7qYG58fbrODbHvOFS7-GQZcEoPw4CPDNZZ+6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.2019 00:11, Nathan Royce wrote:
> Wow, my system got wrecked (exaggeration) during this latest stretch...
> Pulseaudio was stretched to the limit and beyond and was forced to
> restart. Anything that was producing audio had to be restarted to get
> it back.
> This time was much like the first time and went from timestamp
> 573100.060927 (line 1) to 572506.604155 (line 11069), where 100%
> (literally) of it was that event 37 in the journal, no other kernel
> log entries except for the systemd-hostnamed audit before it all went
> down.
> And as usual, it was my USB TV tuner (tvheadend really) giving the
> Poll Timeout log entries.
> Those same uploaded trace files will be updated with the latest bugout.
> 

Hi.

Finally had a chance to look at this. Sorry about the delay.

Logs show event ring is full:

573047.104801: xhci_handle_event: EVENT: TRB 0000000000000000 status 'Event Ring Full Error' len 0 slot 0 ep 0 type 'Host Controller Event' flags e:C

It's filled with 0 length short transfer events due to a the following loop:

1. Class driver asks for 58658 bytes from device (queues BULK IN URB)
2. short transfer event, xhci interrupts, saying we got less than 58658 bytes.
    We actually got 0 bytes.
3. return URB with zero bytes to class driver
4. Class driver immediately queues a new URB, asking for 58658 bytes (see step 1)

Last 6ms before event ring is full this looped 255 times.

one cycle of the loop in log:

573047.104748: xhci_handle_event: EVENT: TRB 000000020b267770 status 'Short Packet' len 58658 slot 4 ep 7 type 'Transfer Event' flags e:C
573047.104749: xhci_handle_transfer: BULK: Buffer 000000001de20000 length 58658 TD size 0 intr 0 type 'Normal' flags b:i:I:c:s:I:e:c
573047.104749: xhci_inc_deq: BULK 0000000002f14758: enq 0x000000020b267860(0x000000020b267000) deq 0x000000020b267780(0x000000020b267000) segs 2 stream 0 free_trbs 495 bounce 512 cycle 0
573047.104752: xhci_urb_giveback: ep3in-bulk: urb 000000000bdcbe77 pipe 3225519232 slot 4 length 0/58658 sgs 0/0 stream 0 flags 00010200
573047.104758: xhci_urb_enqueue: ep3in-bulk: urb 000000000bdcbe77 pipe 3225519232 slot 4 length 0/58658 sgs 0/0 stream 0 flags 00010200
573047.104758: xhci_queue_trb: BULK: Buffer 000000001de20000 length 58658 TD size 0 intr 0 type 'Normal' flags b:i:I:c:s:I:e:C
573047.104759: xhci_inc_enq: BULK 0000000002f14758: enq 0x000000020b267870(0x000000020b267000) deq 0x000000020b267780(0x000000020b267000) segs 2 stream 0 free_trbs 494 bounce 512 cycle 0
573047.104759: xhci_inc_deq: EVENT 0000000022f906c2: enq 0x000000020b317000(0x000000020b317000) deq 0x000000020b3178d0(0x000000020b317000) segs 1 stream 0 free_trbs 254 bounce 0 cycle 1

I'll continue digging into this

-Mathias  




