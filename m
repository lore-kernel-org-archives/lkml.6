Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F52C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BAE2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BAE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJCXO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:14:58 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53382 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:14:58 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7jy8-0003m0-QO; Wed, 03 Oct 2018 17:25:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Oct 2018 17:25:48 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     netdev@vger.kernel.org, oneukum@suse.com, davem@davemloft.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: RE: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
In-Reply-To: <55e4b55bae6148b18a27a23aab7d7501@AcuMS.aculab.com>
References: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
 <20181002165602.21033-1-ben.dooks@codethink.co.uk>
 <55e4b55bae6148b18a27a23aab7d7501@AcuMS.aculab.com>
Message-ID: <3cc20777c2d8747898a8b7148a046cbb@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-03 14:36, David Laight wrote:
> From: Ben Dooks
>> Sent: 02 October 2018 17:56
>> 
>> The smsc95xx_tx_fixup is doing multiple calls to skb_push() to
>> put an 8-byte command header onto the packet. It would be easier
>> to do one skb_push() and then copy the data in once the push is
>> done.
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  drivers/net/usb/smsc95xx.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
>> index cb19aea139d3..813ab93ee2c3 100644
>> --- a/drivers/net/usb/smsc95xx.c
>> +++ b/drivers/net/usb/smsc95xx.c
>> @@ -2006,6 +2006,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct 
>> usbnet *dev,
>>  	bool csum = skb->ip_summed == CHECKSUM_PARTIAL;
>>  	int overhead = csum ? SMSC95XX_TX_OVERHEAD_CSUM : 
>> SMSC95XX_TX_OVERHEAD;
>>  	u32 tx_cmd_a, tx_cmd_b;
>> +	void *ptr;
> 
> It might be useful to define a structure for the header.
> You might need to find the 'store unaligned 32bit word' macro though.
> (Actually that will probably be better than the memcpy() which might
> end up doing memory-memory copies rather than storing the register.)
> Although if/when you add the tx alignment that won't be needed because 
> the
> header will be aligned.

Ok, might be worth doing.

I did try to do a "u32 tx_cmd[2]" but the code generated ended up 
storing
stuff onto the stack before copying into the packet. I agree that 
possibly
going to the "put_unaligned" function might be nicer too.

If we did enable tx-align all the time then we'd not have to care about 
the
alignment, but I didn't want to do that if possible as that would end up
sending up to 3 bytes extra per packet.

I am trying not too do too many changes at one time to allow roll back.

>>  	/* We do not advertise SG, so skbs should be already linearized */
>>  	BUG_ON(skb_shinfo(skb)->nr_frags);
>> @@ -2019,6 +2020,9 @@ static struct sk_buff *smsc95xx_tx_fixup(struct 
>> usbnet *dev,
>>  		return NULL;
>>  	}
>> 
>> +	tx_cmd_b = (u32)skb->len;
>> +	tx_cmd_a = tx_cmd_b | TX_CMD_A_FIRST_SEG_ | TX_CMD_A_LAST_SEG_;
>> +
>>  	if (csum) {
>>  		if (skb->len <= 45) {
>>  			/* workaround - hardware tx checksum does not work
>> @@ -2035,21 +2039,18 @@ static struct sk_buff 
>> *smsc95xx_tx_fixup(struct usbnet *dev,
>>  			skb_push(skb, 4);
>>  			cpu_to_le32s(&csum_preamble);
> 
> Not related, but csum_preamble = cpu_to_le32(csum_preamble) is likely 
> to
> generate better code (at least for some architectures).
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)
