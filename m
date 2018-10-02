Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF2C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADFD2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADFD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbeJBU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:26:29 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59519 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbeJBUT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:28 -0400
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7KqG-0002bn-JD; Tue, 02 Oct 2018 14:36:00 +0100
Subject: Re: [PATCH 2/4] usbnet: smsc95xx: align tx-buffer to word
To:     David Laight <David.Laight@ACULAB.COM>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "oneukum@suse.com" <oneukum@suse.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
 <20181002092645.1115-3-ben.dooks@codethink.co.uk>
 <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <ee3ad7ff-3110-67ff-a4a4-3e647f311dbd@codethink.co.uk>
Date:   Tue, 2 Oct 2018 14:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/18 14:19, David Laight wrote:
> From: Ben Dooks
>> Sent: 02 October 2018 10:27
>>
>> The tegra driver requires alignment of the buffer, so try and
>> make this better by pushing the buffer start back to an word
>> aligned address. At the worst this makes memcpy() easier as
>> it is word aligned, at best it makes sure the usb can directly
>> map the buffer.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> [todo - make this configurable]
>> ---
>>   drivers/net/usb/Kconfig    | 12 ++++++++++++
>>   drivers/net/usb/smsc95xx.c | 22 ++++++++++++++++++++--
>>   2 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> ...
>> +static bool align_tx = IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TXALIGN);
>> +module_param(align_tx, bool, 0644);
>> +MODULE_PARM_DESC(align_tx, "Align TX buffers to word boundaries");
> 
> DM doesn't like module parameters.
> 
>>   static bool turbo_mode = IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TURBO);
>>   module_param(turbo_mode, bool, 0644);
>>   MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
>> @@ -2005,10 +2009,18 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
>>   	bool csum = skb->ip_summed == CHECKSUM_PARTIAL;
>>   	int overhead = csum ? SMSC95XX_TX_OVERHEAD_CSUM : SMSC95XX_TX_OVERHEAD;
>>   	u32 tx_cmd_a, tx_cmd_b;
>> +	u32 data_len;
>> +	uintptr_t align = 0;
>>
>>   	/* We do not advertise SG, so skbs should be already linearized */
>>   	BUG_ON(skb_shinfo(skb)->nr_frags);
>>
>> +	if (IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TXALIGN) && align_tx) {
>> +		align = (uintptr_t)skb->data & 3;
>> +		if (align)
>> +			overhead += 4 - align;
> 
> Better to calculate the pad size once:
> 		align = (-(long)skb->data) & 3;
> should do it - and you can unconditionally add it in.
> 
>> +	}
>> +
>>   	/* Make writable and expand header space by overhead if required */
>>   	if (skb_cow_head(skb, overhead)) {
>>   		/* Must deallocate here as returning NULL to indicate error
>> @@ -2037,16 +2049,22 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
>>   		}
>>   	}
>>
>> +	data_len = skb->len;
>> +	if (align)
>> +		skb_push(skb, 4 - align);
>> +
>>   	skb_push(skb, 4);
> 
> You don't want to call skb_push() twice.
> IIRC really horrid things happen if the data has to be copied.
> (Actually what happens to the alignment in that case??)
> And there is another skb_push() below....

The driver does it /multiple/ times depending on the path used.
Is it wise to try and make a separate patch to skb_push() once
and also move the tx_cmd_a and tx_cmd_b bit to a single point?

>> -	tx_cmd_b = (u32)(skb->len - 4);
>> +	tx_cmd_b = (u32)(data_len);
> 
> You don't need the cast here at all (if it was ever needed).
> Actually you don't need the new 'data_len' variable.
> Just set tx_cmd_b earlier.
> 
> ...
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
