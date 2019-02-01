Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14022C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AA0218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549063238;
	bh=YEoK6JtB8CT5QIB7wsQwfVDG62jR9l/ofe/ZfI21vZI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WDZfAo5YSTAz9PaIZvl1TUoAcHMveTtUOEGveNYOnxlcw9izBjxV7NNX1pNzjZW5a
	 NwCbr0HeOLconAVSMHNIFrLSXsTFTe3r9tyX0HwoQlQkL6Z2RvE23/gPqMxG0+FpFh
	 5cfLVXuyMk3/eejdHpU14g2RViJauto4Ru9AZFS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfBAXUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfBAXUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:20:36 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C289214C6;
        Fri,  1 Feb 2019 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549063236;
        bh=YEoK6JtB8CT5QIB7wsQwfVDG62jR9l/ofe/ZfI21vZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zydZOR06u9RihSyn+R29UsIMWaNLdIuS740tC7S2HDOLVpJiteuBE8qDe1Ix1Zs/I
         HM+tXadQ1E4Gr+dMv2zkhEA9453LHEKZnV5JdZZx3dLEXAfhwR9eCaaneEntidit31
         2QWb0N9qXXh1UoHN8UWhqjCfzJ0Zohkub+A6sbZk=
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190131232359.27948-1-shuah@kernel.org>
 <20190201092843.GA3691@localhost>
From:   shuah <shuah@kernel.org>
Message-ID: <d1388ad8-4607-7b4d-a68c-3c31be476601@kernel.org>
Date:   Fri, 1 Feb 2019 16:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201092843.GA3691@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 2:28 AM, Johan Hovold wrote:
> On Thu, Jan 31, 2019 at 04:23:59PM -0700, Shuah Khan wrote:
>> tty_set_termios() has the following WARN_ON which can be triggered with a
>> syscall to invoke TIOCSETD __NR_ioctl.
> 
> That's the only way to set the hci line discipline. And it's the
> consequent ioctl that sets the uart protocol that triggers the warning,
> but only if the tty is a pty master, as I mentioned before.
> 
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                  tty->driver->subtype == PTY_TYPE_MASTER);
>> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
>>
>> The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
>> operational speed during setup") which introduced a new way for how
>> tty_set_termios() could end up being called for a master pty.
> 
> Please always include reviewers on CC, and especially if you end up
> citing them directly as you do here. Perhaps add quotation marks or at
> least a reference to the discussion where this solution was suggested.
> 

Thanks for the feedback. I am folding in your and Marcel's input in my
v3.

thanks,
-- Shuah

