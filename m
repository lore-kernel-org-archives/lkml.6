Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7758CC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC4F2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC4F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJSHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:47:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42886 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSHrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:47:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F1DFC140A72D5;
        Thu, 18 Oct 2018 16:43:50 -0700 (PDT)
Date:   Thu, 18 Oct 2018 16:43:50 -0700 (PDT)
Message-Id: <20181018.164350.528381990407930636.davem@davemloft.net>
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: socket: fix a missing-check bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539873406-5967-1-git-send-email-wang6495@umn.edu>
References: <1539873406-5967-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 16:43:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Thu, 18 Oct 2018 09:36:46 -0500

> In ethtool_ioctl(), the ioctl command 'ethcmd' is checked through a switch
> statement to see whether it is necessary to pre-process the ethtool
> structure, because, as mentioned in the comment, the structure
> ethtool_rxnfc is defined with padding. If yes, a user-space buffer 'rxnfc'
> is allocated through compat_alloc_user_space(). One thing to note here is
> that, if 'ethcmd' is ETHTOOL_GRXCLSRLALL, the size of the buffer 'rxnfc' is
> partially determined by 'rule_cnt', which is actually acquired from the
> user-space buffer 'compat_rxnfc', i.e., 'compat_rxnfc->rule_cnt', through
> get_user(). After 'rxnfc' is allocated, the data in the original user-space
> buffer 'compat_rxnfc' is then copied to 'rxnfc' through copy_in_user(),
> including the 'rule_cnt' field. However, after this copy, no check is
> re-enforced on 'rxnfc->rule_cnt'. So it is possible that a malicious user
> race to change the value in the 'compat_rxnfc->rule_cnt' between these two
> copies. Through this way, the attacker can bypass the previous check on
> 'rule_cnt' and inject malicious data. This can cause undefined behavior of
> the kernel and introduce potential security risk.
> 
> This patch avoids the above issue via copying the value acquired by
> get_user() to 'rxnfc->rule_cn', if 'ethcmd' is ETHTOOL_GRXCLSRLALL.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

This isn't pretty, but I can't come up with a better fix.

Note that we check and validate the rule count value even a third time
when we copy the rules back out to userspace.

Applied and queued up for -stable, thank you.
