Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4658221872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549063276;
	bh=Qv3VBfomMi6ZPYRpdWyrNt/kdPKF+6QQjiVS89ghQiQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qqoUPlXl/zi9F5StFtV8PoT6JcPdY70BDqc4t0NVlsto79MVia0d5pVfbQ+PlysFC
	 o7wY8dCibbw1I+ADS6lqD9KAxge8yvbP+04tPrUdsUpttFRByepc8FJbtDKUVbtbID
	 l/CeDKL/tbVNhyz7w7D3mHb49/uSZWzl5ckgO0LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBAXVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:21:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfBAXVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:21:13 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB7F214C6;
        Fri,  1 Feb 2019 23:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549063272;
        bh=Qv3VBfomMi6ZPYRpdWyrNt/kdPKF+6QQjiVS89ghQiQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1+lEXmc9Sm529T7YqsybQE+mQ5KN5LPdExCt/xt9ilB7tOWjOCesMKtU9UYmq9laP
         Qs/T4ZQ62V7nmLHU1So5g1oODv+crniwKTTDVosdH7BGtOdX8RnYiI8utzfM2qjB38
         SsusvxiT72Y2SzbkuL3sVz8nlkPFEMorrafAEZuo=
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190131232359.27948-1-shuah@kernel.org>
 <20190201001414.GB4886@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <bd8194d1-facd-eed0-4a4c-6404626ccc27@kernel.org>
Date:   Fri, 1 Feb 2019 16:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201001414.GB4886@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 5:14 PM, Greg KH wrote:
> On Thu, Jan 31, 2019 at 04:23:59PM -0700, Shuah Khan wrote:
>> tty_set_termios() has the following WARN_ON which can be triggered with a
>> syscall to invoke TIOCSETD __NR_ioctl.
>>
>> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>>                  tty->driver->subtype == PTY_TYPE_MASTER);
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
>>   drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
> 
> I think the subject should be something like:
> 	"bluetooth: hci: Fix warning in tty_set_termios()"
> it isn't a tty core problem :)
> 

Yes. Sorry about that. Will get it right in my v3.

thanks,
-- Shuah

