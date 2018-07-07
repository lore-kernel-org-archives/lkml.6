Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176D3C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C115C2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C115C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeGGMf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:35:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeGGMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:35:28 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0EE41210759E;
        Sat,  7 Jul 2018 05:17:08 -0700 (PDT)
Date:   Sat, 07 Jul 2018 21:17:07 +0900 (KST)
Message-Id: <20180707.211707.291855529179797010.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, gustavo@embeddedor.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] stmmac: fix signed 64-bit division
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180706133646.312427-1-arnd@arndb.de>
References: <20180706133646.312427-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Jul 2018 05:17:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  6 Jul 2018 15:36:07 +0200

> I link error on 32-bit ARM points to yet another arithmetic bug:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.o: In function `tc_setup_cbs':
> stmmac_tc.c:(.text+0x148): undefined reference to `__aeabi_uldivmod'
> stmmac_tc.c:(.text+0x1fc): undefined reference to `__aeabi_uldivmod'
> stmmac_tc.c:(.text+0x308): undefined reference to `__aeabi_uldivmod'
> stmmac_tc.c:(.text+0x320): undefined reference to `__aeabi_uldivmod'
> stmmac_tc.c:(.text+0x33c): undefined reference to `__aeabi_uldivmod'
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.o:stmmac_tc.c:(.text+0x3a4): more undefined references to `__aeabi_uldivmod' follow
> 
> I observe that the last change to add the 'ul' prefix was incorrect,
> as it did not turn the result of the multiplication into a 64-bit
> expression on 32-bit architectures. Further, it seems that the
> do_div() macro gets confused by the fact that we pass a signed
> variable rather than unsigned into it.
> 
> This changes the code to instead use the div_s64() helper that is
> meant for signed division, along with changing the constant suffix
> to 'll' to actually make it a 64-bit argument everywhere, fixing
> both of the issues I pointed out.
> 
> I'm not completely convinced that this makes the code correct, but
> I'm fairly sure that we have two problems less than before.
> 
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Fixes: c18a9c096683 ("net: stmmac_tc: use 64-bit arithmetic instead of 32-bit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
