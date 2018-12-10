Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D2920855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D2920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeLJNq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:46:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:11327 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeLJNq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:46:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 05:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; 
   d="scan'208";a="109184415"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2018 05:46:23 -0800
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech
 Flare|Meetup|Brio|Rally
To:     Kyle Williams <kdgwill@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Tim Anderson <tsa@biglakesoftware.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
References: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
 <Pine.LNX.4.44L0.1812041633580.1537-100000@iolanthe.rowland.org>
 <20181207221841.GA161210@google.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <9d5fc873-fc6d-797c-f1cb-573a784123b9@linux.intel.com>
Date:   Mon, 10 Dec 2018 15:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181207221841.GA161210@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.2018 00:18, Kyle Williams wrote:
> On Tue, Dec 04, 2018 at 04:36:18PM -0500, Alan Stern wrote:
>> On Tue, 4 Dec 2018, Kyle Williams wrote:
>>
>>> Description: Some USB device / host controller combinations seem to have
>>> problems with Link Power management. In particular it is described that
>>> the combination of certain Logitech devices and other powered media
>>> devices such as the Atrus device causes 'not enough bandwidth for
>>> new device state'error.
>>>
>>> This patch creates quirk entries for the tested Logitech device
>>> indicating LPM should remain disabled for the device.
>>>
>>> Signed-off-by: Kyle Williams <kdgwill@chromium.org>
>>> ---
>>>   drivers/usb/core/quirks.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>>> index 0690fcff0ea2..9403edee4797 100644
>>> --- a/drivers/usb/core/quirks.c
>>> +++ b/drivers/usb/core/quirks.c
>>> @@ -246,6 +246,22 @@ static const struct usb_device_id usb_quirk_list[] = {
>>>          /* Logitech Harmony 700-series */
>>>          { USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
>>>
>>> +       /* Logitech Flare */
>>> +       { USB_DEVICE(0x046d, 0x0876), .driver_info = USB_QUIRK_NO_LPM },
>>
>> This entry is out of order with the preceding entry.  And some of the
>> new entries below are out of order with each other (entries are
>> supposed to be sorted by Vendor ID, then Product ID).
>>
>> Also, perhaps instead of adding all these new entries, we should set
>> the NO_LPM quirk flag for all Logitech devices?
>>
>> Alan Stern
> Setting USB_QUIRK_NO_LPM for all Logitech devices instead of specific
> ones seem to be a better solution as there are a lot of other devices
> that have the issue as well
> 
> Kyle Williams

I recently found a cause for the "not enough bandwidth for new device state" error.
Patch just got applied to v4.20-rc6
0472bf0 xhci: Prevent U1/U2 link pm states if exit latency is too long

Does it work for your Logitech devices?

-Mathias

