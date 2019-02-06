Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5734C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C099217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBFTwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:52:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:52:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C7F011400C0A0;
        Wed,  6 Feb 2019 11:52:43 -0800 (PST)
Date:   Wed, 06 Feb 2019 11:52:41 -0800 (PST)
Message-Id: <20190206.115241.1549120165262106425.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     bh74.an@samsung.com, ks.giri@samsung.com, vipul.pandya@samsung.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sxgbe: fix unintended sign extension
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190206102503.16929-1-colin.king@canonical.com>
References: <20190206102503.16929-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Feb 2019 11:52:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  6 Feb 2019 10:25:03 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Shifting a u8 by 24 will cause the value to be promoted to an integer. If
> the top bit of the u8 is set then the following conversion to an unsigned
> long will sign extend the value causing the upper 32 bits to be set in
> the result.

We feed this into a writel() which truncates to a 32-bit value, so nothing
bad can happen here.

This is a very canonical way to code up something like this, it works
properly in all situations, and therefore I'd rather not add all of
these fat ugly looking casts.

Thank you.

