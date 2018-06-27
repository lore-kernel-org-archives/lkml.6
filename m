Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1C258A6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fwFlNYhu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XKNANbZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD1C258A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965640AbeF0P5J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:57:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeF0P5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:57:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 176F660714; Wed, 27 Jun 2018 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115027;
        bh=oMJwxi6PKV5GiWdhT0ML92/lIKg+OcSF1ciJ/p5y9p4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fwFlNYhu5zE2okUTLuiDgl6qLqHynAbsxlXH5JAVaUilQUFjRph4eibbJt1rPKQe/
         ZKQ1kHCJ5L6DJg+c+2RBne+4A36i2anikfJ7V79klm5pEagTjcLwsIoDKwGssreAJJ
         3g/Z4fpvlvUQOkhfcg8jb/eCaVixWPJiXVUHNL/Y=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F201601EA;
        Wed, 27 Jun 2018 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115026;
        bh=oMJwxi6PKV5GiWdhT0ML92/lIKg+OcSF1ciJ/p5y9p4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=XKNANbZZR5+V3eMI6iLQrnDuzJRVi1GIN/w4WfAHd4KV3Go9qn6OmIjBAGXgY2nMf
         VMYRIa/F8cyxz9xB67cfS4iWumqr+y5C9Y5JW2fM4vqroWgRKwjmGpe+mTqDsjDTm9
         qi3JkQvRxVHhQp/V3kCc1TX9XrXZn3BKNZbpwJiE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F201601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: brcmsmac: fix wrap around in conversion from constant to s16
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180617103407.27819-1-stefan@agner.ch>
References: <20180617103407.27819-1-stefan@agner.ch>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Stefan Agner <stefan@agner.ch>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627155707.176F660714@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 15:57:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Agner <stefan@agner.ch> wrote:

> The last value in the log_table wraps around to a negative value
> since s16 has a value range of -32768 to 32767. This is not what
> the table intends to represent. Use the closest positive value
> 32767.
> 
> This fixes a warning seen with clang:
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c:216:2: warning:
>       implicit conversion from 'int' to 's16' (aka 'short') changes
> value from 32768
>       to -32768 [-Wconstant-conversion]
>         32768
>         ^~~~~
> 1 warning generated.
> 
> Fixes: 4c0bfeaae9f9 ("brcmsmac: fix array out-of-bounds access in qm_log10")
> Cc: Tobias Regnery <tobias.regnery@gmail.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied to wireless-drivers-next.git, thanks.

c9a61469fc97 brcmsmac: fix wrap around in conversion from constant to s16

-- 
https://patchwork.kernel.org/patch/10468755/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

