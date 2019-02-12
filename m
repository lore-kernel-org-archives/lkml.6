Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F0BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F423B2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549994656;
	bh=KQ1tAru26ad8K4/nTNyNOSY7OlDarcIC5Lvc6mgtAX4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=p/hKGOHS14VKLtKOTQmirlS4Dx08xDOO8UEwRjEDgtlXW2Rj3AszvHQYCc3Yp52Y2
	 CFRPuEpg54s9aj4JQFU6mo5x2dDz3LsJy4myP3hkJ60JFD6ulJOiDORs1Fun0b21hY
	 XttcM8aApAWsVfnfg84KAyOi4hcY35+bnSDAvZHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfBLSEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfBLSEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6142084E;
        Tue, 12 Feb 2019 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549994652;
        bh=KQ1tAru26ad8K4/nTNyNOSY7OlDarcIC5Lvc6mgtAX4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rJEcvzc2V1tAOeJb1ANqA7c5ymte/3Tgd9JRGPOgOTl6k9iieOEBMf4FLH3tGTVhs
         Kmhd5MAEY+LRYSpvqYqBwnjuQ+NJ6/w9sl4Z36zw6wKfFTw/vprYE3LIlkW0eXY3ef
         n6Jzn6nsHjb8e/Uke+kuZaTnVkygnveJpmTxgZik=
Subject: Re: [PATCH v5] bluetooth: Fix WARNING in tty_set_termios()
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190208230609.23926-1-shuah@kernel.org>
 <20190209094239.GQ4686@localhost>
From:   shuah <shuah@kernel.org>
Message-ID: <ba280f2b-9340-0f6b-cd16-e9ff7cc6304f@kernel.org>
Date:   Tue, 12 Feb 2019 11:04:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209094239.GQ4686@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/19 2:42 AM, Johan Hovold wrote:
> On Fri, Feb 08, 2019 at 04:06:09PM -0700, Shuah Khan wrote:
>> tty_set_termios() has the following WARN_ON which can be triggered with a
>> syscall to invoke TIOCSETD __NR_ioctl.
>>
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                  tty->driver->subtype == PTY_TYPE_MASTER);
>> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
>>
>> "The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
>> operational speed during setup") which introduced a new way for how
>> tty_set_termios() could end up being called for a master pty."
>>
>> Fix hci_uart_tty_open() to check if tty supports set_termios in addition
>> to write and error out, if it doesn't.
>>
>> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
>> Cc: Johan Hovold <johan@kernel.org>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   drivers/bluetooth/hci_ldisc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index fbf7b4df23ab..087ec2268744 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -474,10 +474,10 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>>   
>>   	BT_DBG("tty %p", tty);
>>   
>> -	/* Error if the tty has no write op instead of leaving an exploitable
>> -	 * hole
>> +	/* Error if the tty has no write/set_termios ops instead of leaving
>> +	 * an exploitable hole.
> 
> Why do you think that a tty driver not implementing set_termios() is
> exploitable?
> 
> Note that tty_set_termios() handles a missing set_termios() callback
> just fine without dereferencing a NULL-pointer. >
>>   	 */
>> -	if (tty->ops->write == NULL)
>> +	if (!tty->ops->write || !tty->ops->set_termios)
>>   		return -EOPNOTSUPP;
> 
> I know Marcel asked you do implement things like this, but what you're
> really doing is to try to uphold the invariant that tty_set_termios()
> should never be called for a pty master. The WARN_ON in that function
> was put in place to make sure line-disciplines use the correct ioctl
> helpers (and the commit I pointed you to earlier in the paragraph you
> quote in the commit message broke that invariant).
> 
> I'm afraid this is totally obscured by the above change and misleading
> comment update.
> 

We are discussing the right fix for a while now. :)

I did two versions of the patch

1. Check set_termios in hci_uart_tty_open() based on
Marcel's suggestion
2. Checks tty type in hci_uart_tty_open()

Both fix the problem I can reproduce on my system, however,
I think checking tty type is the right way to fix this problem.

The reason is that tty type is the direct and definitive way to
check if ldisc sets are supported ir unsupported.

Checking set_termios is an indirect way and I am not sure that it
would work in all cases.

That being said, I will wait for some consensus on how to fix the
problem, before I send another version of this patch.

thanks,
-- Shuah

