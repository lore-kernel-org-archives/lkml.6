Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA29C65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DF82147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DF82147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJFSaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 14:30:24 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51644 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeJFSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 14:30:24 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g8kk3-0005v1-Dl; Sat, 06 Oct 2018 12:27:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 06 Oct 2018 12:27:27 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, David.Laight@aculab.com, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
In-Reply-To: <20181005.142412.601607260441380535.davem@davemloft.net>
References: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
 <20181002165602.21033-1-ben.dooks@codethink.co.uk>
 <20181005.142412.601607260441380535.davem@davemloft.net>
Message-ID: <40033993674bb8b5ef33ac33f28f3aff@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-10-05 22:24, David Miller wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> Date: Tue,  2 Oct 2018 17:56:02 +0100
> 
>> -	memcpy(skb->data, &tx_cmd_a, 4);
>> +	ptr = skb_push(skb, 8);
>> +	tx_cmd_a = cpu_to_le32(tx_cmd_a);
>> +	tx_cmd_b = cpu_to_le32(tx_cmd_b);
>> +	memcpy(ptr, &tx_cmd_a, 4);
>> +	memcpy(ptr+4, &tx_cmd_b, 4);
> 
> Even a memcpy() through a void pointer does not guarantee that gcc will
> not emit word sized loads and stores.
> 
> You must use the get_unaligned()/put_unaligned() facilities to do this
> properly.

Thanks, got a new version of the series just being tested with this.
Should it go into the original, or as a separate change?

> 
> I also agree that making a proper type and structure instead of using
> a void pointer would be better.
