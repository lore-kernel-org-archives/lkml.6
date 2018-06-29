Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FFBC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A11927E93
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hkNNCVf+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jHt6m8So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A11927E93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbeF2Lti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:49:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeF2Ltg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:49:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 03E1760452; Fri, 29 Jun 2018 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530272976;
        bh=wHxPL3a4FP58u77ECjDCnCSXdXNR2hT7kjrsoYaurZk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hkNNCVf+oy1igYN6yxo33S3Je2QvMpTB9OlTCeghdpthGevDqafSESwbfY6eio7c8
         P8OhCAVzLHth0awOoqjOFr7tYUfPL3KCHxiBESN6YoXDKiIoFbusZ8t5tTSbYeuyaf
         P6zMctA1EPurw0+CVkPGPiLON25n8SUTdcaMngE4=
Received: from x230.qca.qualcomm.com (85-76-151-243-nat.elisa-mobile.fi [85.76.151.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBDB460452;
        Fri, 29 Jun 2018 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530272974;
        bh=wHxPL3a4FP58u77ECjDCnCSXdXNR2hT7kjrsoYaurZk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jHt6m8SotEw2/uAkYIx/ZpXyisLXrVG5bY0Xc2Wb/HG70DpyTOslAmJ064Lmi/EA8
         RjABSjIwQfKjo/KUj87jovg/OCGWOr4ymtk9iSMiI2rLofS1caxhstcY/yPudQgrCe
         e5WOw/LQpUsWiH9y5zwuUWni7aAsuEst1oA2Xw+A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBDB460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        alagusankar@silex-india.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 1/3] ath10k: sdio: use same endpoint id for all packets in a bundle
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
        <20180620084222.3521-2-niklas.cassel@linaro.org>
Date:   Fri, 29 Jun 2018 14:49:29 +0300
In-Reply-To: <20180620084222.3521-2-niklas.cassel@linaro.org> (Niklas Cassel's
        message of "Wed, 20 Jun 2018 10:42:20 +0200")
Message-ID: <87zhzdersm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> writes:

> All packets in a bundle should use the same endpoint id as the
> first lookahead.
>
> This matches how things are done is ath6kl, however,
> this patch can theoretically handle several bundles
> in ath10k_sdio_mbox_rx_process_packets().
>
> Without this patch we get lots of errors about invalid endpoint id:
>
> ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
> ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
> ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12
>
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

You have Alagu's s-o-b first so that implies Alagu is the author. So
should I add From header for Alagu and add you (Niklas) as
Co-Developed-by? Or vice versa?

-- 
Kalle Valo
