Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9212BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C186208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TnCKcgah";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TnCKcgah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C186208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933233AbeFLLWR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:22:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932503AbeFLLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:22:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DC8F8607E4; Tue, 12 Jun 2018 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528802535;
        bh=NCAXiKJzkbAgpc85OBSwR10uiM+1VLJV7ivv4UrCjlc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TnCKcgahlKXYk+zzp/RxsZCdvR+51OqtygspxbZY2NWuyrt+XRr77O42dL82ofwgt
         QYLdgS4u7aGVsYqQ1HfPUvJ+Yo98kZAOXe/GYDrEivwOhEhyhkwx6etzq8TaAlDAt5
         OrhVHkqA4ywS4LRR9AG+5olv83Ik6XumopZ2Tp7A=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82C3E602BD;
        Tue, 12 Jun 2018 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528802535;
        bh=NCAXiKJzkbAgpc85OBSwR10uiM+1VLJV7ivv4UrCjlc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TnCKcgahlKXYk+zzp/RxsZCdvR+51OqtygspxbZY2NWuyrt+XRr77O42dL82ofwgt
         QYLdgS4u7aGVsYqQ1HfPUvJ+Yo98kZAOXe/GYDrEivwOhEhyhkwx6etzq8TaAlDAt5
         OrhVHkqA4ywS4LRR9AG+5olv83Ik6XumopZ2Tp7A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82C3E602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 1/4] ath10k: snoc: use correct bus-specific pointer in RX retry
References: <20180611210946.241341-1-briannorris@chromium.org>
Date:   Tue, 12 Jun 2018 14:22:08 +0300
In-Reply-To: <20180611210946.241341-1-briannorris@chromium.org> (Brian
        Norris's message of "Mon, 11 Jun 2018 14:09:43 -0700")
Message-ID: <87wov4ckrj.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> We're 'ath10k_snoc', not 'ath10k_pci'. This probably means we're
> accessing junk data in ath10k_snoc_rx_replenish_retry(), unless
> 'ath10k_snoc' and 'ath10k_pci' happen to have very similar struct
> layouts.
>
> Noticed by inspection.
>
> Fixes: d915105231ca ("ath10k: add hif rx methods for wcn3990")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> It's possible this would be a for-4.18 target, since the buggy patch is
> in the -rc1 merge. But this driver is not fully operational yet. Also,
> I'm sending some companion refactorings to help avoid this bug. They
> probably aren't 4.18 material.

Yeah, in theory this should go to 4.18 but, like you said, snoc support
does not even work on 4.18 so there would be no benefit. Actually just
more work while we add final pieces of wcn3990 support to ath10k. So
I'll queue these to 4.19.

> Let me know if I should do anything differently.

This is very good as is, thanks.

-- 
Kalle Valo
