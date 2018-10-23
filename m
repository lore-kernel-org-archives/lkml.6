Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A035C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60327207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60327207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJWKwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:52:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39836 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:52:04 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 249B3146BF274;
        Mon, 22 Oct 2018 19:30:50 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:30:49 -0700 (PDT)
Message-Id: <20181022.193049.377279605490719384.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mISDN: Fix type of switch control variable in
 ctrl_teimanager
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181019180030.920-1-natechancellor@gmail.com>
References: <20181019180030.920-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:30:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 19 Oct 2018 11:00:30 -0700

> Clang warns (trimmed for brevity):
> 
> drivers/isdn/mISDN/tei.c:1193:7: warning: overflow converting case value
> to switch condition type (2147764552 to 18446744071562348872) [-Wswitch]
>         case IMHOLD_L1:
>              ^
> drivers/isdn/mISDN/tei.c:1187:7: warning: overflow converting case value
> to switch condition type (2147764550 to 18446744071562348870) [-Wswitch]
>         case IMCLEAR_L2:
>              ^
> 2 warnings generated.
> 
> The root cause is that the _IOC macro can generate really large numbers,
> which don't find into type int. My research into how GCC and Clang are
> handling this at a low level didn't prove fruitful and surveying the
> kernel tree shows that aside from here and a few places in the scsi
> subsystem, everything that uses _IOC is at least of type 'unsigned int'.
> Make that change here because as nothing in this function cares about
> the signedness of the variable and it removes ambiguity, which is never
> good when dealing with compilers.
> 
> While we're here, remove the unnecessary local variable ret (just return
> -EINVAL and 0 directly).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/67
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
