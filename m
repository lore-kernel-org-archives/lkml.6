Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF85C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA56E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeJVVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:42:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46204 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeJVVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:42:01 -0400
Received: from [111.196.56.27] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1gEaB2-0000vv-0F; Mon, 22 Oct 2018 13:23:24 +0000
Subject: Re: [PATCH 1/2] usb: xhci: fix uninitialized completion when USB3
 port got wrong status
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
 <57b1da55-3213-8053-7002-f8798d6e1a10@linux.intel.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=aaron.ma@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAHNIUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPsLAdwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrazsBNBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAHCwF8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
Message-ID: <ebcc7c9e-7e5b-bda5-2f4a-05084de39eb7@canonical.com>
Date:   Mon, 22 Oct 2018 21:23:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <57b1da55-3213-8053-7002-f8798d6e1a10@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/18 9:12 PM, Mathias Nyman wrote:
> On 21.10.2018 20:08, Aaron Ma wrote:
>> Realtek USB3.0 Card Reader [0bda:0328] reports wrong port status on
>> Cannon lake PCH USB3.1 xHCI [8086:a36d] after resume from S3,
>> after clear port reset it works fine.
>>
>> Since this device is registered on USB3 roothub at boot,
>> when port status reports not superspeed, xhci_get_port_status will call
>> an uninitialized completion in bus_state[0].
>> Kernel will hang because of NULL pointer.
>>
>> Restrict the USB2 resume status check in USB2 roothub to fix hang issue.
>> No harm to initialize USB3 bus_state[0] in case it is called.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>>   drivers/usb/host/xhci-hub.c  | 2 +-
>>   drivers/usb/host/xhci-mem.c  | 1 +
>>   drivers/usb/host/xhci-ring.c | 2 +-
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index 7e2a531ba321..d30ca6ceffc9 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -876,7 +876,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
>>               status |= USB_PORT_STAT_SUSPEND;
>>       }
>>       if ((raw_port_status & PORT_PLS_MASK) == XDEV_RESUME &&
>> -        !DEV_SUPERSPEED_ANY(raw_port_status)) {
>> +        !DEV_SUPERSPEED_ANY(raw_port_status) && 1 == hcd_index(hcd)) {
>>           if ((raw_port_status & PORT_RESET) ||
>>                   !(raw_port_status & PORT_PE))
>>               return 0xffffffff;
> 
> Nice catch.
> 
> Maybe use "hcd->speed < HCD_USB3" instead of "1 == hcd_index(hcd)"
> It's easier to understand.
> 
> Turns out this isn't an issue with your Realtek device, it just happens
> to trigger
> a driver issue.
> 
> The original !DEV_SUPERSPEED_ANY() check was not suitable here.
> It checks the port-speed field of portsc register (bits 13:10), which
> are only valid for USB3
> ports if all link training is done and port reached its "enabled" state.
> Otherwise it will return 0, and USB3 ports may be mistaken for USB2 ports.
> 
> Just to make sure, Does your device stay as a USB 3 device, it's never
> enumerated as USB2, right?
> 
> I'm in the middle of refactoring the get_port_status(), it should solve
> this
> as well, but we need your solution stable releases.
> 
> Any chance you to check if the refactored code works with the Realtek
> device?
> I just created a "get_port_status_refactor" branch for it:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
> get_port_status_refactor

Let me try your branch, please wait a moment.

> 
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index b1f27aa38b10..dd2ad50c5289 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -2539,6 +2539,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t
>> flags)
>>           xhci->bus_state[0].resume_done[i] = 0;
>>           xhci->bus_state[1].resume_done[i] = 0;
>>           /* Only the USB 2.0 completions will ever be used. */
>> +        init_completion(&xhci->bus_state[0].rexit_done[i]);
>>           init_completion(&xhci->bus_state[1].rexit_done[i]);
>>       }
> 
> I don't think we should init the completion unnecessary for USB3 ports.
> 
>>   diff --git a/drivers/usb/host/xhci-ring.c
>> b/drivers/usb/host/xhci-ring.c
>> index f0a99aa0ac58..894d4625b8b9 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -1634,7 +1634,7 @@ static void handle_port_status(struct xhci_hcd
>> *xhci,
>>        * RExit to a disconnect state).  If so, let the the driver know
>> it's
>>        * out of the RExit state.
>>        */
>> -    if (!DEV_SUPERSPEED_ANY(portsc) &&
>> +    if (!DEV_SUPERSPEED_ANY(portsc) && 1 == hcd_index(hcd) &&
>>               test_and_clear_bit(hcd_portnum,
>>                   &bus_state->rexit_ports)) {
>>           complete(&bus_state->rexit_done[hcd_portnum]);
>>
> 
> Same here, prefer hcd->speed < HCD_USB3

Yes, I thought about this, bus_state[1/0] are defined to USB 2/3, so I
used "1 == hcd_index(hcd)".

Anyway, I will send V2 as your suggestion.

Thanks,
Aaron

> 
> Thanks
> Mathias
