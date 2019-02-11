Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1ECC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6609B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874890;
	bh=USbBreDmij9gGsyvuqdUdGistLyFa43WnOmvhiQ9Q8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JtbHHSJr9aPckyRlfYI5KkVEDBjLI+s24/NE42T6P+DxOL5INp0QNfCVSb9/bMY17
	 KsVpYYzStq2TZIFkVKxRiBYDXU+4o/oss1T2whKyg2WIBrHWeYImNCeP16q2hG7uUb
	 LwgqEp7FC4iouK87uVUnko6Jv00zhONYLr9Jrfas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfBKIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKIsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:48:08 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C578F217FA;
        Mon, 11 Feb 2019 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549874887;
        bh=USbBreDmij9gGsyvuqdUdGistLyFa43WnOmvhiQ9Q8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kk3/s48CG7NbiZrJzGE/MNLX8My1+8x8qVaEAV9kYdutCYQjUdarbxekRPv9/pKEc
         Osqf03nsRKWYC1gwn4NTHMN5n5PWrlJdabFG0GUx1AwcXEg4mUEhSO7Ofoco5fPdZB
         l6Bw2SbziuQJaoKfVA92yY4jWnjjwdQa4XIXRJvo=
Received: by mail-lj1-f171.google.com with SMTP id a16so3916423ljb.11;
        Mon, 11 Feb 2019 00:48:06 -0800 (PST)
X-Gm-Message-State: AHQUAuZOI9hu95OuQbOvHV4Ukx5856+AN0+4FJJeS3nsu3H3EIIiIRaC
        U8fhL7qfyiYdH9J6S0CWYjyNfT+0YzcGVaLJnQ0=
X-Google-Smtp-Source: AHgI3Ia1N07rYTM2frCVmNxEX7R2AR2aB9qS4yZTNFU64lu3FRLGxDbSBZLSShiqffpQDWeKCoSXBYP2U2t+PmfyZHc=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr21125806lja.184.1549874884990;
 Mon, 11 Feb 2019 00:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com> <20190210225114.20110-3-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210225114.20110-3-stuart.menefy@mathembedded.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 09:47:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeHMTZn0h8aVU4btg736XyHxpYHBFy1Up7jZgmQa17gtg@mail.gmail.com>
Message-ID: <CAJKOXPeHMTZn0h8aVU4btg736XyHxpYHBFy1Up7jZgmQa17gtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource: exynos_mct: Clear timer interrupt when shutdown
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 at 23:51, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> When shutting down the timer, ensure that after we have stopped the
> timer any pending interrupts are cleared. This fixes a problem when
> suspending, as interrupts are disabled before the timer is stopped,
> so the timer interrupt may still be asserted, preventing the system
> entering a low power state when the wfi is executed.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/clocksource/exynos_mct.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
