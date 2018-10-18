Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52691C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08176208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08176208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeJRMw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:52:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJRMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:52:29 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E59713AE1A78;
        Wed, 17 Oct 2018 21:53:23 -0700 (PDT)
Date:   Wed, 17 Oct 2018 21:53:22 -0700 (PDT)
Message-Id: <20181017.215322.873219355646098517.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     Dept-GELinuxNICDev@cavium.com, netdev@vger.kernel.org,
        sudarsana.kalluru@cavium.com, Tomer.Tayar@cavium.com,
        Michal.Kalderon@cavium.com, Ariel.Elior@cavium.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qla3xxx: Remove overflowing shift statement
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181013021457.13608-1-natechancellor@gmail.com>
References: <20181013021457.13608-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 21:53:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 12 Oct 2018 19:14:58 -0700

> Clang currently warns:
> 
> drivers/net/ethernet/qlogic/qla3xxx.c:384:24: warning: signed shift
> result (0xF00000000) requires 37 bits to represent, but 'int' only has
> 32 bits [-Wshift-overflow]
>                     ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
>                       ~~~~~~~~~~~~~~ ^  ~~
> 1 warning generated.
> 
> The warning is certainly accurate since ISP_NVRAM_MASK is defined as
> (0x000F << 16) which is then shifted by 16, resulting in 64424509440,
> well above UINT_MAX.
> 
> Given that this is the only location in this driver where ISP_NVRAM_MASK
> is shifted again, it seems likely that ISP_NVRAM_MASK was originally
> defined without a shift and during the move of the shift to the
> definition, this statement wasn't properly removed (since ISP_NVRAM_MASK
> is used in the statenent right above this). Only the maintainers can
> confirm this since this statment has been here since the driver was
> first added to the kernel.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/127
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

If the qlogic/cavium folks aren't even going to look at and comment
on this, that is not fair to you and your change.

Applied, thanks Nathan.
