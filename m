Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B621CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E5521746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GGNGH5xb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dABprXWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5521746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeHRVhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:37:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRVhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:37:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0160361ED3; Sat, 18 Aug 2018 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534616955;
        bh=iBCpG9PDW5iXPT7JQTGAQXfp/dMIgDbgEvm1NLuUfic=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GGNGH5xb7Ibj5nVlTIhuU6g1YZ7gMMC15WcekLI4O5xBpnVGjNZQy7ze8Bq972yqm
         wSRPRZYkRWX1YyWgNlfQ8e+lu1XBtfvDPRdEzqU7d3woaWxmXZidlZVWCgsfjNnI6w
         TNU0HclInVe5uR6u8V/mAaZHaWU9TpyJFtlxlJCQ=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 096FF61698;
        Sat, 18 Aug 2018 18:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534616954;
        bh=iBCpG9PDW5iXPT7JQTGAQXfp/dMIgDbgEvm1NLuUfic=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dABprXWNT9MDvCFyEUjX05mjXuMOA67l4wO4Fup9gOFA1ulLKHzBkR9Xy4RCu1v6C
         6KXOTQlJdpitippwvyJEPq/qA5DEJHJ4j18/mEQZle7CwF/FJMIy6ehjqIUei3zGpY
         7iiillf7zVjV0cV0NhymATwYtKhx8r0AFc/1Hxu8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 096FF61698
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] wireless: Use dma_zalloc_coherent instead of dma_alloc_coherent + memset
References: <1534604707-10874-1-git-send-email-zhongjiang@huawei.com>
Date:   Sat, 18 Aug 2018 21:29:10 +0300
In-Reply-To: <1534604707-10874-1-git-send-email-zhongjiang@huawei.com> (zhong
        jiang's message of "Sat, 18 Aug 2018 23:05:07 +0800")
Message-ID: <87pnyfttop.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhong jiang <zhongjiang@huawei.com> writes:

> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset (),
> We prefer to dma_zalloc_coherent instead of open-codeing.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

The correct prefix is "wcn36xx: ", not "wireless:". I can fix it this
time.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_title_is_wrong

-- 
Kalle Valo
