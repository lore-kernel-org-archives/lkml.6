Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A96AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4779C21746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eQmvMbm3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eQmvMbm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4779C21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeHRVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:40:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRVkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:40:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A415161EF8; Sat, 18 Aug 2018 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534617092;
        bh=iKMX7tg3Wau16Gn8jDgfrTTZEDz4dsj9WBb9/Ru1Lao=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eQmvMbm35xNxw5QpFgAM9Wbf7KXbQnNvO8ykodaEeK/OM63DmD9Gdo6MZN7qUKwIn
         sywjwL4Ms9OAEIn+tw7gSP54DoTvljNO6jDdkLN1q2msdx1wJ8xGTchYvaFG/SFTdL
         rfXhunBY4BYJFM5wwAbhEpdEuag2aXjxy8ckMzsA=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0CBB61ECD;
        Sat, 18 Aug 2018 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534617092;
        bh=iKMX7tg3Wau16Gn8jDgfrTTZEDz4dsj9WBb9/Ru1Lao=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eQmvMbm35xNxw5QpFgAM9Wbf7KXbQnNvO8ykodaEeK/OM63DmD9Gdo6MZN7qUKwIn
         sywjwL4Ms9OAEIn+tw7gSP54DoTvljNO6jDdkLN1q2msdx1wJ8xGTchYvaFG/SFTdL
         rfXhunBY4BYJFM5wwAbhEpdEuag2aXjxy8ckMzsA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0CBB61ECD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] wireless: Use dma_zalloc_coherent instead of dma_alloc_coherent + memset
References: <1534604707-10874-1-git-send-email-zhongjiang@huawei.com>
        <87pnyfttop.fsf@kamboji.qca.qualcomm.com>
Date:   Sat, 18 Aug 2018 21:31:28 +0300
In-Reply-To: <87pnyfttop.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Sat, 18 Aug 2018 21:29:10 +0300")
Message-ID: <87lg93ttkv.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> zhong jiang <zhongjiang@huawei.com> writes:
>
>> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset (),
>> We prefer to dma_zalloc_coherent instead of open-codeing.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> The correct prefix is "wcn36xx: ", not "wireless:". I can fix it this
> time.
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_title_is_wrong

Actually please resend this patch and CC linux-wireless so that
patchwork sees this.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#who_to_address

-- 
Kalle Valo
