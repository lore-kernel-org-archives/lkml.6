Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F86C21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGKm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:42:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:4773 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfBGKmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:42:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 02:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,343,1544515200"; 
   d="scan'208";a="317049811"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2019 02:42:22 -0800
Subject: Re: [PATCH] xhci: Use ffs() to find page size in xhci_mem_init()
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190207000349.7816-1-andrew.smirnov@gmail.com>
 <1ecb0604-3e27-810e-9fae-18d9d1bf7ff9@linux.intel.com>
 <87mun8klxj.fsf@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <74208350-eba5-c299-376e-9df194fe71b5@intel.com>
Date:   Thu, 7 Feb 2019 12:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87mun8klxj.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2019 11:06, Felipe Balbi wrote:
> 
> Hi,
> 
> Mathias Nyman <mathias.nyman@linux.intel.com> writes:
>> On 07.02.2019 02:03, Andrey Smirnov wrote:
>>> Get page size order using ffs() instead of open coding it with a loop.
>>>
>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>> Cc: Mathias Nyman <mathias.nyman@intel.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: linux-usb@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>    drivers/usb/host/xhci-mem.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>>> index 36a3eb8849f1..44b43c3d819f 100644
>>> --- a/drivers/usb/host/xhci-mem.c
>>> +++ b/drivers/usb/host/xhci-mem.c
>>> @@ -2362,11 +2362,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>>>    	page_size = readl(&xhci->op_regs->page_size);
>>>    	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>>    			"Supported page size register = 0x%x", page_size);
>>> -	for (i = 0; i < 16; i++) {
>>> -		if ((0x1 & page_size) != 0)
>>> -			break;
>>> -		page_size = page_size >> 1;
>>> -	}
>>> +	i = ffs(page_size);
>>>    	if (i < 16)
>>>    		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>>    			"Supported page size of %iK", (1 << (i+12)) / 1024);
>>
>> Hi
>>
>> using ffs() is a welcome change, but it will give different a result than the loop.
>>
>> *old loop
>>     valid page_size value if i < 16
>> *ffs()
>>     valid page_size value if i >= 1 and i < 17
> 
> off-by-one, just use i = ffs() - 1. Or use __ffs().
> 

and handle the page_size == 0 case.

-Mathias  
