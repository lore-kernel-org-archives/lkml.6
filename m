Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB96AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745C12086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745C12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeK1KZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:25:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45644 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1KZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:25:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E3F114E09804;
        Tue, 27 Nov 2018 15:25:40 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:25:39 -0800 (PST)
Message-Id: <20181127.152539.1127313634090592618.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     igor.russkikh@aquantia.com, nikita.danilov@aquantia.com,
        yana.esina@aquantia.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: aquantia: return 'err' if set MPI_DEINIT
 state fails
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181124101641.7072-1-yuehaibing@huawei.com>
References: <20181124101641.7072-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 27 Nov 2018 15:25:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 24 Nov 2018 18:16:41 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c:260:7:
>  warning: variable 'err' set but not used [-Wunused-but-set-variable]
> 
> 'err' should be returned while set MPI_DEINIT state fails
> in hw_atl_utils_soft_reset.
> 
> Fixes: cce96d1883da ("net: aquantia: Regression on reset with 1.x firmware")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.

But this AQ_HW_STATE_FOR macro _MUST_ be fixed.

No macro should have invisible references to variables like this, and
that is exactly what leads to bugs like this.  CPP macros written this
way make it impossible to properly audit code.

'err' should be an explicit argument given to this function instead of
how it works now.
