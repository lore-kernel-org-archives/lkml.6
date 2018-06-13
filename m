Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DCC68C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919DE208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jSsKyXTo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k3uhRj5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919DE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935463AbeFMLv0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:51:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935287AbeFMLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:51:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3D0F60717; Wed, 13 Jun 2018 11:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890684;
        bh=HZJ1qRzSb11OoVFwjdAAzWyY97Tln12uSF+s33p6Ekg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jSsKyXTozgc5Kgdlflzy3KVCjLKhrJQd2wbSXiWO9kXyFCBBkj8wVvCpd2CNmmOQW
         vxztugoX5yuEdiduZeudVT2pp0sdptjKjqDNg6RpWUAsLOcP2lmSDrdwLp6LWr7jB4
         EvpjYI/RU1blKNveq5LOwrENvb2TFYs1eOHrWbKM=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 024C76022C;
        Wed, 13 Jun 2018 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528890683;
        bh=HZJ1qRzSb11OoVFwjdAAzWyY97Tln12uSF+s33p6Ekg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=k3uhRj5WOYn8hy6gANCyee5kH2Cs9y40KK2w5d5oLtShwtgtsJg8ycw/FexA8vzyw
         QpH6dtF5CYqdZ4FeaQ/A8Dnj1RIwB1cN3xbd0cu/E7/E/wL/gP8kCS6UoEVCNqTgwR
         UOuORAwzMzoKcBUXWpgkmB9vyzU34w7JBEX3ltYg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 024C76022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath10k: fix memory leak of tpc_stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180527211702.23778-1-colin.king@canonical.com>
References: <20180527211702.23778-1-colin.king@canonical.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180613115123.F3D0F60717@smtp.codeaurora.org>
Date:   Wed, 13 Jun 2018 11:51:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> Currently tpc_stats is allocated and is leaked on the return
> path if num_tx_chain is greater than WMI_TPC_TX_N_CHAIN. Avoid
> this leak by performing the check on num_tx_chain before the
> allocation of tpc_stats.
> 
> Detected by CoverityScan, CID#1469422 ("Resource Leak")
> Fixes: 4b190675ad06 ("ath10k: fix kernel panic while reading tpc_stats")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

260e629bbf44 ath10k: fix memory leak of tpc_stats

-- 
https://patchwork.kernel.org/patch/10429553/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

