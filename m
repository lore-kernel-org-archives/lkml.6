Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D309C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AE42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AE42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeJWS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:59:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:10724 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeJWS7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:59:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 03:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="273696881"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2018 03:36:11 -0700
Subject: Re: [PATCH 1/2] usb: xhci: fix uninitialized completion when USB3
 port got wrong status
To:     Aaron Ma <aaron.ma@canonical.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
 <57b1da55-3213-8053-7002-f8798d6e1a10@linux.intel.com>
 <edd66255-4998-1cf4-2d9b-6185963a4ece@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <8b36fa3a-7999-a2e2-ec01-aa459ec89867@linux.intel.com>
Date:   Tue, 23 Oct 2018 13:39:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <edd66255-4998-1cf4-2d9b-6185963a4ece@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2018 20:53, Aaron Ma wrote:
> 
> 
> On 10/22/18 9:12 PM, Mathias Nyman wrote:
>> On 21.10.2018 20:08, Aaron Ma wrote:
>>> Realtek USB3.0 Card Reader [0bda:0328] reports wrong port status on
>>> Cannon lake PCH USB3.1 xHCI [8086:a36d] after resume from S3,
>>> after clear port reset it works fine.
>>>
>>> Since this device is registered on USB3 roothub at boot,
>>> when port status reports not superspeed, xhci_get_port_status will call
>>> an uninitialized completion in bus_state[0].
>>> Kernel will hang because of NULL pointer.
>>>
>>> Restrict the USB2 resume status check in USB2 roothub to fix hang issue.
>>> No harm to initialize USB3 bus_state[0] in case it is called.
>>>
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>> ---
>>>    drivers/usb/host/xhci-hub.c  | 2 +-
>>>    drivers/usb/host/xhci-mem.c  | 1 >>>    drivers/usb/host/xhci-ring.c | 2 +-
>>>    3 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>>> index 7e2a531ba321..d30ca6ceffc9 100644
>>> --- a/drivers/usb/host/xhci-hub.c
>>> +++ b/drivers/usb/host/xhci-hub.c
>>> @@ -876,7 +876,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
>>>                status |= USB_PORT_STAT_SUSPEND;
>>>        }
>>>        if ((raw_port_status & PORT_PLS_MASK) == XDEV_RESUME &&
>>> -        !DEV_SUPERSPEED_ANY(raw_port_status)) {
>>> +        !DEV_SUPERSPEED_ANY(raw_port_status) && 1 == hcd_index(hcd)) {
>>>            if ((raw_port_status & PORT_RESET) ||
>>>                    !(raw_port_status & PORT_PE))
>>>                return 0xffffffff;
>>
>> The original !DEV_SUPERSPEED_ANY() check was not suitable here.
>> It checks the port-speed field of portsc register (bits 13:10), which
>> are only valid for USB3
>> ports if all link training is done and port reached its "enabled" state.
>> Otherwise it will return 0, and USB3 ports may be mistaken for USB2 ports.
> 
> PORT_ENABLE should be already set to one.
> The same device ID card reader doesn't have issue on Sunrise Point.
> Maybe it is related to Cannon lake PCH USB controller?
> 

Ok, thanks for the info

> 
> V2 sent out. Cc-ed stable.
> 
>> Any chance you to check if the refactored code works with the Realtek
>> device?
>> I just created a "get_port_status_refactor" branch for it:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
>> get_port_status_refactor
> 
> The hang issue is not reproduced on this kernel branch.
> 

Great, thanks for testing it

-Mathias
