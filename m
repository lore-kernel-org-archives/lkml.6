Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B1AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F330221872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549063154;
	bh=c+CIRAu4FBfC7IKBpa3fgtfdJ9zpErEqRqLBiWnIniA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uH39ZhBQ2TztqAKX0AkyiaHdtDOLH3Zo3WbCBoft5BEXOpniEOmVsI816CI/b8rYs
	 ETfggWGMj9PeNld6vtj8MY0H9EfkdPmVurX8v5np6orA5tAbB/kYfjZCREf7ODABDV
	 7E7RNaLZEhGxiHqM0gmesuF04RKr+4XYfQq1N5dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfBAXTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfBAXTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:19:12 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899E5214C6;
        Fri,  1 Feb 2019 23:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549063151;
        bh=c+CIRAu4FBfC7IKBpa3fgtfdJ9zpErEqRqLBiWnIniA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EdfNV68pVHTPXiDVpmkk0t7Va234BzcGaV5DuKfbAn/u4DNlvbim1tI6vpR79v58d
         4mZLFoJwCH/twvx69lMRrMuSqIpOnIO58l49pcOlRVgbKJ6A2SRmUT0V7WDpMzZ/+3
         tlfbluaePXVxcpErF7xQvznwt23A1qnxjrA5n6ss=
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
To:     Marcel Holtmann <marcel@holtmann.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        shuah <shuah@kernel.org>
References: <20190131232359.27948-1-shuah@kernel.org>
 <2EA87A3C-BC0D-4CDA-998D-BA7A6D829356@holtmann.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7dc2f2b5-95f4-4809-7719-d214443966eb@kernel.org>
Date:   Fri, 1 Feb 2019 16:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2EA87A3C-BC0D-4CDA-998D-BA7A6D829356@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 3:00 AM, Marcel Holtmann wrote:
> Hi Shuah,
> 
>> tty_set_termios() has the following WARN_ON which can be triggered with a
>> syscall to invoke TIOCSETD __NR_ioctl.
>>
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                 tty->driver->subtype == PTY_TYPE_MASTER);
>> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
>>
>> The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
>> operational speed during setup") which introduced a new way for how
>> tty_set_termios() could end up being called for a master pty.
>>
>> Fix the problem by preventing setting the HCI line discipline for PTYs
>> from hci_uart_setup() and hci_uart_set_flow_control().
>>
>> The reproducer is used to reproduce the problem and verify the fix.
>>
>> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>> drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index fbf7b4df23ab..ce84ca91ca70 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -314,6 +314,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>> 		return;
>> 	}
>>
>> +	/* don't set HCI line discipline on PTYs */
>> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>> +	    tty->driver->subtype == PTY_TYPE_MASTER)
>> +		return;
>> +
> 
> just do it once in hci_uart_tty_open. Actually we already check for ops->write and so lets just ensure all ops we ever call are present. If they are not, then bail out. I wouldn’t even bother with the TTY type. Wouldn’t that be a lot simpler?
> 

As you said, hci_uart_tty_open()is a good place to check it. I think
checking tty type is necessary. I couldn't find any missing ops I could
base the check on to prevent the ldisc set.

I have the patch that does the tty check in hci_uart_tty_open() tested
and ready for sending.

thanks,
-- Shuah





