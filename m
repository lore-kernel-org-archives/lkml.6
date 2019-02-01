Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB8DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CE8218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548980060;
	bh=Txl2QhRayY1EpDwDGftAF6Ka2WpdFG8ZpK+Jcw3lJmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kmPwynHMXS/3w3bRc1D9s7DFJxpo3FdcXSHBnJlKIqA67ArbIYoQMxjgOT6lxkEGI
	 1TLET2g3ehf3CV9YRqG2s8mm8oOGBWSWWmVGD90EtnSW6okmH5mNdPZN6fCud1U3Qj
	 a9FfK70EsPO1tx7kMGGddfZ2s+AQHzmJ7klor2n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfBAAOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfBAAOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:14:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3E921872;
        Fri,  1 Feb 2019 00:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548980056;
        bh=Txl2QhRayY1EpDwDGftAF6Ka2WpdFG8ZpK+Jcw3lJmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePYHJsHtFb3Gg7bGNPpotvPhK/eJ05BQBUJ6GSJDbrZk6GtEC73uEeBD4qkY2BL3u
         c7WBktyxaybSXrySWwFcBEQuT6qlH+2zO/5oTXey/k3Q4OYX56IB1Q+vC2CBITsn6w
         7vqVnSZDgdZUdw8T4mXwCOpbSrNIGFQYR/YejKSU=
Date:   Fri, 1 Feb 2019 01:14:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
Message-ID: <20190201001414.GB4886@kroah.com>
References: <20190131232359.27948-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131232359.27948-1-shuah@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 04:23:59PM -0700, Shuah Khan wrote:
> tty_set_termios() has the following WARN_ON which can be triggered with a
> syscall to invoke TIOCSETD __NR_ioctl.
> 
> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>                 tty->driver->subtype == PTY_TYPE_MASTER);
> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
> 
> The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
> operational speed during setup") which introduced a new way for how
> tty_set_termios() could end up being called for a master pty.
> 
> Fix the problem by preventing setting the HCI line discipline for PTYs
> from hci_uart_setup() and hci_uart_set_flow_control().
> 
> The reproducer is used to reproduce the problem and verify the fix.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I think the subject should be something like:
	"bluetooth: hci: Fix warning in tty_set_termios()"
it isn't a tty core problem :)

thanks,

greg k-h
