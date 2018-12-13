Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7121C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9572320645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9572320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeLMMUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:20:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:54884 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeLMMUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:20:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 04:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="109230844"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2018 04:20:18 -0800
Subject: Re: [PATCH 4.19 014/110] usb: xhci: Prevent bus suspend if a port
 connect change or polling state is detected
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135921.817957465@linuxfoundation.org> <20181212225334.GA2651@x1>
 <20181213073640.GA31371@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <06384740-496f-ce37-34bc-3e55fd9ed538@linux.intel.com>
Date:   Thu, 13 Dec 2018 14:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181213073640.GA31371@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2018 09:36, Greg Kroah-Hartman wrote:
> On Wed, Dec 12, 2018 at 11:53:34PM +0100, Thomas Zeitlhofer wrote:
>> Hello,
>>
>> On Thu, Nov 29, 2018 at 03:11:45PM +0100, Greg Kroah-Hartman wrote:
>>> 4.19-stable review patch.  If anyone has any objections, please let me
>>> know.
>>>
>>> ------------------
>>>
>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>
>>> commit 2f31a67f01a8beb22cae754c53522cb61a005750 upstream.
>> [...]
>>
>> on a current Thinkpad X1 Yoga, this breaks resume from hibernate such
>> that opening the lid has (in the regular use case, see below) no effect
>> any more:
>>
>> The system is configured to hibernate when the lid is closed. So, the
>> expected behavior, which is restored by reverting this patch, is:
>>
>> 	close lid => system hibernates
>> 	open lid => system resumes
>>
>> With this patch, the following two cases are observed:
>>
>> 	1)
>> 		close lid => system hibernates
>> 		open lid => system stays off
>> 		press power button => system boots and resumes
>>
>> 	2)
>> 		# systemctl hibernate => system hibernates
>> 		close lid
>> 		open lid => system resumes
>>
> 
> So this is a problem in Linus's tree?  If so, let's work to get this
> fixed there first.
> 
> If not, then we have other issues :)
> 

That patch incorrectly reacts to USB2 polling states as well,
which could cause issues like this.

Does applying the below code help?

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 94aca1b..01b5818 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1507,7 +1507,8 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
                 portsc_buf[port_index] = 0;
  
                 /* Bail out if a USB3 port has a new device in link training */
-               if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
+               if ((hcd->speed >= HCD_USB3) &&
+                   (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
                         bus_state->bus_suspended = 0;
                         spin_unlock_irqrestore(&xhci->lock, flags);
                         xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");
