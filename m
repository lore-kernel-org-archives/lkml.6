Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48835C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D02217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549222613;
	bh=uBkQR6YBCK36MC9rfTdeoJOo9f2kgSzhc8Rnxg7BKhg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zGNtuBB0HpaiLXqwCpkGth9/XyFTZbAm+8BDrwBJqTLc4BVwZ9/Rjqg7Ei4ke84A1
	 R9KScvS+5r7qyu13O/dXsaTgWQ0gTXqb3bCws/8MS3E9oGX7kFPh8mqdBLitMbR4HO
	 oh2VbxQXBBLJb9DetPsKH3ciarFpTnAgMjlOaCn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBCTgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfBCTgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:36:50 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2D221773;
        Sun,  3 Feb 2019 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549222609;
        bh=uBkQR6YBCK36MC9rfTdeoJOo9f2kgSzhc8Rnxg7BKhg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fyTrzYXK25Nofv1VP15W2ObgEAwOCKKMkPjplytT/5kiTFHsOP6Jxv9TaGNpU7cun
         orbkFfZPGffwYX0adJlI2Er93dhDBuYum0atKXZiNuypG2u3/Wi+0qiUZaLw+S6hSP
         dov5rEFLpO9DnLJ6Ux5fAG4zqyM90XsA0YPEwl/o=
Subject: Re: [PATCH v3] bluetooth: Fix WARNING in tty_set_termios()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, johan@kernel.org,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190203164825.9621-1-shuah@kernel.org>
 <0CC28468-8E2F-4DEE-8307-DA0CEA59A8D0@holtmann.org>
From:   shuah <shuah@kernel.org>
Message-ID: <a758f44b-24e5-6f5f-a809-228a4001f84a@kernel.org>
Date:   Sun, 3 Feb 2019 12:36:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0CC28468-8E2F-4DEE-8307-DA0CEA59A8D0@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/19 10:31 AM, Marcel Holtmann wrote:
> Hi Shuah,
> 
>> tty_set_termios() has the following WARN_ON which can be triggered with a
>> syscall to invoke TIOCSETD __NR_ioctl.
>>
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                 tty->driver->subtype == PTY_TYPE_MASTER);
>> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
>>
>> Johan Hovold said: "The problemm started with
>> commit 7721383f4199 ("Bluetooth: hci_uart: Support
>> operational speed during setup") which introduced a new way for how
>> tty_set_termios() could end up being called for a master pty."
>>
>> Fix it by by preventing setting the HCI line discipline for PTYs in
>> hci_uart_tty_open(). Looked into keying off of tty and ldisc ops, and
>> couldn't find any that would be conclusive. Checking tty as such clearly
>> tags the reason for rejecting the request to set ldisc.
>>
>> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
>> Cc: Johan Hovold <johan@kernel.org>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>> drivers/bluetooth/hci_ldisc.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index fbf7b4df23ab..a3d313fcc0f2 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -480,6 +480,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>> 	if (tty->ops->write == NULL)
>> 		return -EOPNOTSUPP;
>>
>> +	/* don't set HCI line discipline on PTYs */
>> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>> +	    tty->driver->subtype == PTY_TYPE_MASTER)
>> +		return -EINVAL;
>> +
> 
> this is turning in circles. What is wrong with checking !tty->ops->set_termios here?

Yeah. I looked into set_termios and thought that it is set in this path.
My bad. okay v4 is on its way. Sorry it took so long to get on the same
page with you. :(

thanks,
-- Shuah
