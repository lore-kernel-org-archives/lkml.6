Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F5C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC512075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC512075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeKUBIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:08:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:43015 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeKUBIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:08:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 06:38:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="92611581"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga006.jf.intel.com with ESMTP; 20 Nov 2018 06:38:50 -0800
Subject: Re: [PATCH] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC.
To:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <1542356426-10299-1-git-send-email-Sandeep.Singh@amd.com>
 <0B58593B-1CE2-49EB-9F13-A2BC449AB8E8@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <63e848ea-3694-fef1-fab0-8c17000a3581@linux.intel.com>
Date:   Tue, 20 Nov 2018 16:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0B58593B-1CE2-49EB-9F13-A2BC449AB8E8@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.2018 10:35, Kai Heng Feng wrote:
> Hi Sandeep,
> 
>> On Nov 16, 2018, at 16:21, Singh, Sandeep <Sandeep.Singh@amd.com> wrote:
>>
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> Occasionally AMD SNPS 3.0 xHC does not respond to
>> CSS when set, also it does not flag anything on SRE and HCE
>> to point the internal xHC errors on USBSTS register. This stalls
>> the entire system wide suspend and there is no point in stalling
>> just because of xHC CSS is not responding.
>>
>> To work around this problem, if the xHC does not flag
>> anything on SRE and HCE, we can skip the CSS
>> timeout and allow the system to continue the suspend. Once the
>> system resume happens we can internally reset the controller
>> using XHCI_RESET_ON_RESUME quirk.
> 
> What happens to the connected and suspended USB devices?
> Do USB devices lose remote wakeup functionality when this happens?
> 
>>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
>> cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
>> ---
>> drivers/usb/host/xhci-pci.c |  4 ++++
>> drivers/usb/host/xhci.c     | 25 +++++++++++++++++++++++++
>> drivers/usb/host/xhci.h     |  1 +
>> 3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 01c5705..72493c4 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -139,6 +139,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>> 		 pdev->device == 0x43bb))
>> 		xhci->quirks |= XHCI_SUSPEND_DELAY;
>>
>> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
>> +	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
>> +		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
>> +
>> 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
>> 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 0420eef..965b503 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -970,6 +970,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
>> 	unsigned int		delay = XHCI_MAX_HALT_USEC;
>> 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
>> 	u32			command;
>> +	u32			res;
>>
>> 	if (!hcd->state)
>> 		return 0;
>> @@ -1025,10 +1026,32 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
>> 	writel(command, &xhci->op_regs->command);
>> 	if (xhci_handshake(&xhci->op_regs->status,
>> 				STS_SAVE, 0, 10 * 1000)) {
>> +		if (xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) {
>> +		       /*
>> +			* AMD SNPS xHC 3.0 occasionally does not clear the
>> +			* SSS bit of USBSTS and when driver tries to poll
>> +			* to see if the xHC clears BIT(8) which never happens
>> +			* and driver assumes that controller is not responding
>> +			* and times out. To workaround this, its good to check
>> +			* if SRE and HCE bits are not set (as per xhci
>> +			* Section 5.4.2) and bypass the timeout.
>> +			*/
>> +
>> +			res = readl(&xhci->op_regs->status);
>> +			if (res & STS_SAVE) {
>> +				if (((res & STS_SRE) == 0) &&
>> +				    ((res & STS_HCE) == 0)) {
>> +					xhci->quirks |= XHCI_RESET_ON_RESUME;

Better to use some other way or variable, after this change quirks would become dynamic,
and depend on each other.

>> +					goto complete_suspend;
>> +				}
>> +			}
> 
> Maybe merge the two “ifs”? There are no other conditions to handle.
>> Kai-Heng

Or drop the if (res & STS_SAVE) check completely.
Only reason we are here is because STS_SAVE is still set.

I think the goto statement is not needed either, how about something like

if (BROKEN_SUSPEND_QUIRK && !(SRE || HCE))
   set some reset on resume flag
else
   unlock
   return -ETIMEDOUT
   
> 
>> +		}
>> +
>> 		xhci_warn(xhci, "WARN: xHC save state timeout\n");
>> 		spin_unlock_irq(&xhci->lock);
>> 		return -ETIMEDOUT;
>> 	}
>> + complete_suspend:
>> 	spin_unlock_irq(&xhci->lock);
>>
>> 	/*
>> @@ -1213,6 +1236,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
>> 	usb_hcd_poll_rh_status(xhci->shared_hcd);
>> 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
>> 	usb_hcd_poll_rh_status(hcd);
>> +	if (xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND)
>> +		xhci->quirks &= ~XHCI_RESET_ON_RESUME;

Again, I don't think its a good idea to create this kind of quirk dependency,
what about if a future controller needs both SNPS_BROKEN_SUSPEND and
always a RESET_ON_RESUME?

-Mathias

>>
>> 	return retval;
>> }
>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index bf0b369..eb99782 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1849,6 +1849,7 @@ struct xhci_hcd {
>> #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
>> #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
>> #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
>> +#define XHCI_SNPS_BROKEN_SUSPEND	BIT_ULL(34)
>>
>> 	unsigned int		num_active_eps;
>> 	unsigned int		limit_active_eps;
>> -- 
>> 2.7.4
>>
> 

