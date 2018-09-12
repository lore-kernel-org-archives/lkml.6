Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A554BC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5046420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5046420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeILMJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:09:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeILMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:09:13 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B07AF12DE57E2;
        Wed, 12 Sep 2018 00:06:04 -0700 (PDT)
Date:   Wed, 12 Sep 2018 00:06:04 -0700 (PDT)
Message-Id: <20180912.000604.691229117082896536.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com
Subject: Re: [PATCH v2] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing
 RTL_FLAG_TASK_ENABLED
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180910175143.23878-1-kai.heng.feng@canonical.com>
References: <20180910175143.23878-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Sep 2018 00:06:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 11 Sep 2018 01:51:43 +0800

> After system suspend, sometimes the r8169 doesn't work when ethernet
> cable gets pluggued.
> 
> This issue happens because rtl_reset_work() doesn't get called from
> rtl8169_runtime_resume(), after system suspend.
> 
> In rtl_task(), RTL_FLAG_TASK_* only gets cleared if this condition is
> met:
> if (!netif_running(dev) ||
>     !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
>     ...
> 
> If RTL_FLAG_TASK_ENABLED was cleared during system suspend while
> RTL_FLAG_TASK_RESET_PENDING was set, the next rtl_schedule_task() won't
> schedule task as the flag is still there.
> 
> So in addition to clearing RTL_FLAG_TASK_ENABLED, also clears other
> flags.
> 
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Use bitmap_zero(), suggested by Florian Fainelli.
> - Assign zero to first enum member in rtl_flag, just in case.

Applied, thank you.
