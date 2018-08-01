Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B81C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137B720841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137B720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbeHAUua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:50:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeHAUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:50:30 -0400
Received: from localhost (c-71-59-158-49.hsd1.or.comcast.net [71.59.158.49])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D2ABE100A24C1;
        Wed,  1 Aug 2018 12:03:18 -0700 (PDT)
Date:   Wed, 01 Aug 2018 12:03:17 -0700 (PDT)
Message-Id: <20180801.120317.1723805727309880042.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qede: fix null pointer dereference on skb on
 allocation failure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180801163947.22743-1-colin.king@canonical.com>
References: <20180801163947.22743-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 12:03:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  1 Aug 2018 17:39:47 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> If skb fails to be allocated with the call to build_skb then a
> null pointer dereference will occur on the call to skb_reserve.
> Fix this by checking for a null skb and returning NULL.
> 
> Detected by CoverityScan, CID#1469485 ("Dereference null return value")
> 
> Fixes: 8a8633978b84 ("qede: Add build_skb() support.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This is in no way sufficient.

The caller doesn't check the return value, so you're just pushing
the problem one function level up.

In fact, the caller is going to take a reference on the page
whether this returns NULL or not, thus leaking that memory.

The whole call chain needs to be fixed to handle build_skb()
errors, not just this one function.

Thanks.
