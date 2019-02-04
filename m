Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D3DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4B2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549305902;
	bh=zSmvaG+m32guFRw2LAL7fhTCJKxgKBi/8sSS0M8esIE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Y6d3fL2KRuTRrnhewfGI62A42YvzbsJWAF3fuwCcKBPsN1r+0ek+/N6VaMk0af5yY
	 72aOMyKxhVbrjIfWUohYzSE1o0kFMinx9xo34KA2Rj52yt3mPCxaiXDRb2196l/QPF
	 Q5/JejctKDFI7uajaH7IzKeYiMb7+kDHMZo6u/5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfBDSpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbfBDSpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:45:00 -0500
Received: from [10.0.2.154] (host81-133-38-158.in-addr.btopenworld.com [81.133.38.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9494A2175B;
        Mon,  4 Feb 2019 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549305899;
        bh=zSmvaG+m32guFRw2LAL7fhTCJKxgKBi/8sSS0M8esIE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=14eDekgqL7wZEKO0+6W7zz4ubbrw3yYHockhcf9M7RCD8tT393WFnMaQ1lSY0UUep
         NJEucwgxJGrczI6Z/aeLz5StR2kchwDq9YOkUBNpYrtpyxmuYMm9DaKGcc6s/zgSN2
         0naUaAOBMcMzNAaZYLrp1WsohFTuTivvPlIiB1mA=
Subject: Re: [PATCH v4] bluetooth: Fix WARNING in tty_set_termios()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190203193848.12959-1-shuah@kernel.org>
 <EBD36B7C-0B26-4483-B7C8-736F27B9D267@holtmann.org>
From:   shuah <shuah@kernel.org>
Message-ID: <4a195213-aa12-c3d8-fd16-5cc2667a6c7f@kernel.org>
Date:   Mon, 4 Feb 2019 11:44:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <EBD36B7C-0B26-4483-B7C8-736F27B9D267@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/19 10:39 PM, Marcel Holtmann wrote:
> Hi Shuah,
> 
>> tty_set_termios() has the following WARN_ON which can be triggered with a
>> syscall to invoke TIOCSETD __NR_ioctl.
>>
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                 tty->driver->subtype == PTY_TYPE_MASTER);
>> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
>>
>> "The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
>> operational speed during setup") which introduced a new way for how
>> tty_set_termios() could end up being called for a master pty."
>>
>> Fix it by by preventing setting the HCI line discipline for PTYs in
>> hci_uart_tty_open().
>>
>> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
>> Cc: Johan Hovold <johan@kernel.org>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>> drivers/bluetooth/hci_ldisc.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index fbf7b4df23ab..c8faa4759cb7 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -475,9 +475,9 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>> 	BT_DBG("tty %p", tty);
>>
>> 	/* Error if the tty has no write op instead of leaving an exploitable
>> -	 * hole
>> +	 * hole. In addition check if setting HCI line discipline is allowed.
>> 	 */
> 
> this comment is wrong. The result of setting the HCI line discipline is a call into hci_uart_tty_open. You have to check ops->write and ops->set_termios since both are required. That is it.

I will fix the comment.

> 
>> -	if (tty->ops->write == NULL)
>> +	if (tty->ops->write == NULL || tty->ops->set_termios == NULL)
>> 		return -EOPNOTSUPP;
> 
> And while at it, change this to (!tty->ops->write).
> 

Okay. I will fix both.

thanks,
-- Shuah

