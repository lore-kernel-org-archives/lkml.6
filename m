Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B0024E42
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q3QzKZth";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZEiOxwae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B0024E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965061AbeF2Lxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:53:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933005AbeF2Lxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:53:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 889E3606DD; Fri, 29 Jun 2018 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530273229;
        bh=nfeEcQVQhrcpI+78CXaOUQy4pp3fa/y3wn+FB8rydNA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q3QzKZthliPdQXrA1ExhBIloc2XAY0bmiClzWljrcNKhjOpWYCxTVLjLE/gjJ9Mal
         8XsJTeZQBCI3bCzJlViSvGrNC0Em55gbqvj6whmQa4wyynfvWW16yKDi4o01npjIAA
         5ylyZCFidtidqaIKKuIOkRZJLQgjyLbZEEvnI8c4=
Received: from x230.qca.qualcomm.com (85-76-151-243-nat.elisa-mobile.fi [85.76.151.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABE246034E;
        Fri, 29 Jun 2018 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530273228;
        bh=nfeEcQVQhrcpI+78CXaOUQy4pp3fa/y3wn+FB8rydNA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZEiOxwaevuyjofD1S1eXNTDStb0gjX5P3W776Et6WHMO1b9U9D8rKl7WMMgMt0raJ
         GnR7UqIqe/FGzVdDK7fGZUPTJVUr/9ILsYTmhgxDngdu7umSdizSUlkQMGCyuhq76F
         UMrWON1A0kWP62dd8ODydPQ93Yml5UB4+6fJQOy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABE246034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     alagusankar@silex-india.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] ath10k: sdio: use same endpoint id for all packets in a bundle
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
        <20180620084222.3521-2-niklas.cassel@linaro.org>
        <87zhzdersm.fsf@codeaurora.org>
Date:   Fri, 29 Jun 2018 14:53:44 +0300
In-Reply-To: <87zhzdersm.fsf@codeaurora.org> (Kalle Valo's message of "Fri, 29
        Jun 2018 14:49:29 +0300")
Message-ID: <87vaa1erlj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Niklas Cassel <niklas.cassel@linaro.org> writes:
>
>> All packets in a bundle should use the same endpoint id as the
>> first lookahead.
>>
>> This matches how things are done is ath6kl, however,
>> this patch can theoretically handle several bundles
>> in ath10k_sdio_mbox_rx_process_packets().
>>
>> Without this patch we get lots of errors about invalid endpoint id:
>>
>> ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
>> ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
>> ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12
>>
>> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>
> You have Alagu's s-o-b first so that implies Alagu is the author. So
> should I add From header for Alagu and add you (Niklas) as
> Co-Developed-by? Or vice versa?

Ah, the same issue is with all three patches. So whatever we decide,
I'll do the same changes on all three.

-- 
Kalle Valo
