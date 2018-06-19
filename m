Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D33C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E75520693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J0OZTZ2k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J0OZTZ2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E75520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030553AbeFSTGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:06:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50920 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030505AbeFSTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:06:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B7D4C60B10; Tue, 19 Jun 2018 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529435209;
        bh=WkIam5Dq13yAf6wqufhCGMJDLVWaBxN9t6kBz7cE4xE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J0OZTZ2k8WqQ+LIvLNOo5rjDGxfRA53VsGq+3wMk8TwQNuvVNr4f3/HkxG8nvSI3z
         m5IHcohZX9PemN3u/puMClbCUXza9jjeBOhTdza7TYBX6Vpvo09yfjsFEWNjrUTE8G
         sN/5aQnsMT5oKZjTXUZ1syKgdIECjAf4uJ4/nZvc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E123F60B10;
        Tue, 19 Jun 2018 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529435209;
        bh=WkIam5Dq13yAf6wqufhCGMJDLVWaBxN9t6kBz7cE4xE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J0OZTZ2k8WqQ+LIvLNOo5rjDGxfRA53VsGq+3wMk8TwQNuvVNr4f3/HkxG8nvSI3z
         m5IHcohZX9PemN3u/puMClbCUXza9jjeBOhTdza7TYBX6Vpvo09yfjsFEWNjrUTE8G
         sN/5aQnsMT5oKZjTXUZ1syKgdIECjAf4uJ4/nZvc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E123F60B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Ian Molton <ian@mnementh.co.uk>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] brcmfmac: stop watchdog before detach and free everything
References: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
        <5B0D1C9E.4000800@broadcom.com> <20180530090633.GA15390@panicking>
        <5B294920.5050909@broadcom.com>
Date:   Tue, 19 Jun 2018 22:06:43 +0300
In-Reply-To: <5B294920.5050909@broadcom.com> (Arend van Spriel's message of
        "Tue, 19 Jun 2018 20:19:12 +0200")
Message-ID: <87fu1izjcs.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 5/30/2018 11:06 AM, Michael Trimarchi wrote:
>> Using built-in in kernel image without a firmware in filesystem
>> or in the kernel image can lead to a kernel NULL pointer deference.
>> Watchdog need to be stopped in brcmf_sdio_remove
>>
>> The system is going down NOW!
>> [ 1348.110759] Unable to handle kernel NULL pointer dereference at
>> virtual address 000002f8
>> Sent SIGTERM to all processes
>> [ 1348.121412] Mem abort info:
>> [ 1348.126962]   ESR = 0x96000004
>> [ 1348.130023]   Exception class = DABT (current EL), IL = 32 bits
>> [ 1348.135948]   SET = 0, FnV = 0
>> [ 1348.138997]   EA = 0, S1PTW = 0
>> [ 1348.142154] Data abort info:
>> [ 1348.145045]   ISV = 0, ISS = 0x00000004
>> [ 1348.148884]   CM = 0, WnR = 0
>> [ 1348.151861] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>> [ 1348.158475] [00000000000002f8] pgd=0000000000000000
>> [ 1348.163364] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [ 1348.168927] Modules linked in: ipv6
>> [ 1348.172421] CPU: 3 PID: 1421 Comm: brcmf_wdog/mmc0 Not tainted
>> 4.17.0-rc5-next-20180517 #18
>> [ 1348.180757] Hardware name: Amarula A64-Relic (DT)
>> [ 1348.185455] pstate: 60000005 (nZCv daif -PAN -UAO)
>> [ 1348.190251] pc : brcmf_sdiod_freezer_count+0x0/0x20
>> [ 1348.195124] lr : brcmf_sdio_watchdog_thread+0x64/0x290
>> [ 1348.200253] sp : ffff00000b85be30
>> [ 1348.203561] x29: ffff00000b85be30 x28: 0000000000000000
>> [ 1348.208868] x27: ffff00000b6cb918 x26: ffff80003b990638
>> [ 1348.214176] x25: ffff0000087b1a20 x24: ffff80003b94f800
>> [ 1348.219483] x23: ffff000008e620c8 x22: ffff000008f0b660
>> [ 1348.224790] x21: ffff000008c6a858 x20: 00000000fffffe00
>> [ 1348.230097] x19: ffff80003b94f800 x18: 0000000000000001
>> [ 1348.235404] x17: 0000ffffab2e8a74 x16: ffff0000080d7de8
>> [ 1348.240711] x15: 0000000000000000 x14: 0000000000000400
>> [ 1348.246018] x13: 0000000000000400 x12: 0000000000000001
>> [ 1348.251324] x11: 00000000000002c4 x10: 0000000000000a10
>> [ 1348.256631] x9 : ffff00000b85bc40 x8 : ffff80003be11870
>> [ 1348.261937] x7 : ffff80003dfc7308 x6 : 000000078ff08b55
>> [ 1348.267243] x5 : 00000139e1058400 x4 : 0000000000000000
>> [ 1348.272550] x3 : dead000000000100 x2 : 958f2788d6618100
>> [ 1348.277856] x1 : 00000000fffffe00 x0 : 0000000000000000
>
> Forgot about this one.
>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Should this go to 4.18?

-- 
Kalle Valo
