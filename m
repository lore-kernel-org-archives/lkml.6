Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E8C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051E52083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051E52083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbeHNGbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:31:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38172 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeHNGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:31:45 -0400
Received: from localhost (unknown [172.58.41.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DAC9912173DBF;
        Mon, 13 Aug 2018 20:46:31 -0700 (PDT)
Date:   Mon, 13 Aug 2018 20:46:30 -0700 (PDT)
Message-Id: <20180813.204630.1588025496006675499.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     michael.chan@broadcom.com, vasundhara-v.volam@broadcom.com,
        scott.branden@broadcom.com, gospo@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnxt_en: avoid string overflow for record->system_name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813212700.2681499-1-arnd@arndb.de>
References: <20180813212700.2681499-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 20:46:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Aug 2018 23:26:54 +0200

> The utsname()->nodename string may be 64 bytes long, and it gets
> copied without the trailing nul byte into the shorter record->system_name,
> as gcc now warns:
> 
> In file included from include/linux/bitmap.h:9,
>                  from include/linux/ethtool.h:16,
>                  from drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:13:
> In function 'strncpy',
>     inlined from 'bnxt_fill_coredump_record' at drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:2863:2:
> include/linux/string.h:254:9: error: '__builtin_strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
> 
> Using strlcpy() at least avoids overflowing the destination buffer
> and adds proper nul-termination. It may still truncate long names
> though, which probably can't be solved here.
> 
> Fixes: 6c5657d085ae ("bnxt_en: Add support for ethtool get dump.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
