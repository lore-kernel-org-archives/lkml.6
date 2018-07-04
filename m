Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF7C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6975623EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DJBvfm3Q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EgHCCP+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6975623EBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeGDPP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:15:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbeGDPP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:15:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62BF460B26; Wed,  4 Jul 2018 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530717325;
        bh=ojqh/Il83V1pJEtglQBcZeNfHqa4VMCH//ycFu11dvQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DJBvfm3Qd5Gg5f7w0vdXr7KlHLw/B1kM55tgIZbJ+5LDENFZ6/FBGcK6sN+IAYy91
         VFObP5aAqK92plBAhOjvMsPR0AJ7MnuzQCE5D5CvMyA9TfpZ6aDpyjUrlbe5tTO9jT
         OO6ycBZXOo2dY6OfAZXMR7ZDJw+ZRdXel1k+ostA=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C1D56037C;
        Wed,  4 Jul 2018 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530717324;
        bh=ojqh/Il83V1pJEtglQBcZeNfHqa4VMCH//ycFu11dvQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EgHCCP+RoZHvsPK+RqVxLgJC3kPms7bWhCuSVgV9dPL1FprYbBK63ANX+ErAt4+KD
         Wrg3lvHMT6QGuJPTCNwt3rYHIqmkVc8eD+uNdGTGP5tXjQdXGffdEAmrzzNla1AwED
         vHf/af3CBP1Tp8fzw8apaaXGFlnMz3g57cQkHNhg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C1D56037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] atmel: using strlcpy() to avoid possible buffer overflows
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180630063341.9900-1-yuehaibing@huawei.com>
References: <20180630063341.9900-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <simon@thekelleys.org.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, <andy.shevchenko@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180704151525.62BF460B26@smtp.codeaurora.org>
Date:   Wed,  4 Jul 2018 15:15:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> 'firmware' is a module param which may been longer than firmware_id,
> so using strlcpy() to guard against overflows. Also priv is allocated
> with zeroed memory,no need to set firmware_id[0] to '\0'.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

f9cbaeb52930 atmel: using strlcpy() to avoid possible buffer overflows

-- 
https://patchwork.kernel.org/patch/10498009/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

