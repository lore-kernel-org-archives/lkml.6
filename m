Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8C9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XQUQ8Hiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8C9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967187AbeFSSTR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:19:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54614 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967022AbeFSSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:19:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so1864472wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xa3cYJjMBQXv7geUsRpzb7J7TR6WDACHMUpXEH0lJ78=;
        b=XQUQ8HiytUMtkJxq1uTkFRYSFc+hV7rAc+6octSbiRPcliRs1k4jDHlXhExi3yzGJl
         EMVHzAmFYP+0FhQS4ek0hWqbABl2kah9WU1+POvCV0VtEkb8i4pBNPFmymkfsoH8Kixm
         VQ0uGbHiDHMk0msTO4GlD9mW8a2vipxt2LsPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xa3cYJjMBQXv7geUsRpzb7J7TR6WDACHMUpXEH0lJ78=;
        b=fWs7/ajl3YrCdBVxZ0beqhU7gh0QG6Ezf+DUK9iffAFL4pgFGYM5aHbOZH3bJ8VKiJ
         YVuzYtaash3no6/u6Sw6ULu/XzDpFGirBeDorcJ7Jftlc37wIIoa6175bYzTjTkzSTZj
         Ibfb5DoR8s3r6Ra8L6Yk4rv/KtnN8g6omCL7LC/TlOGfT/+VSZmqrz2iVlhl0sf+Qhjt
         wtXVw4RWVitPS/jk4XhYnbNw6KNboS1b7mpCH+Gcq4rl3gd8EzXL+sO7RUyny74AGVd6
         JywMpGdT2XLCmWRws2B95zuWl53lRu8TLC3diceExsqPpFSXtnPUtTvyk76I42jaol49
         JtOw==
X-Gm-Message-State: APt69E2Nmq7XKneLZgiSSzdEAHQISbnSsupEYbdDddEG3rJ1+DwrAKJ2
        t0vcyK49xyioFk3ZI9/yZ0CLCTcP+yI=
X-Google-Smtp-Source: ADUXVKJSTH3FlF87tkcLWhrcNbEXekpftEQqYPnW8wyRvzzEg5C491QRnuT2AUhxFyTt/VOq2ARXaw==
X-Received: by 2002:a50:8bfa:: with SMTP id n55-v6mr15635923edn.216.1529432353127;
        Tue, 19 Jun 2018 11:19:13 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id u23-v6sm716862edm.7.2018.06.19.11.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 11:19:11 -0700 (PDT)
Subject: Re: [PATCH V2] brcmfmac: stop watchdog before detach and free
 everything
To:     Michael Trimarchi <michael@amarulasolutions.com>
References: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
 <5B0D1C9E.4000800@broadcom.com> <20180530090633.GA15390@panicking>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Ian Molton <ian@mnementh.co.uk>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B294920.5050909@broadcom.com>
Date:   Tue, 19 Jun 2018 20:19:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180530090633.GA15390@panicking>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 11:06 AM, Michael Trimarchi wrote:
> Using built-in in kernel image without a firmware in filesystem
> or in the kernel image can lead to a kernel NULL pointer deference.
> Watchdog need to be stopped in brcmf_sdio_remove
>
> The system is going down NOW!
> [ 1348.110759] Unable to handle kernel NULL pointer dereference at virtual address 000002f8
> Sent SIGTERM to all processes
> [ 1348.121412] Mem abort info:
> [ 1348.126962]   ESR = 0x96000004
> [ 1348.130023]   Exception class = DABT (current EL), IL = 32 bits
> [ 1348.135948]   SET = 0, FnV = 0
> [ 1348.138997]   EA = 0, S1PTW = 0
> [ 1348.142154] Data abort info:
> [ 1348.145045]   ISV = 0, ISS = 0x00000004
> [ 1348.148884]   CM = 0, WnR = 0
> [ 1348.151861] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [ 1348.158475] [00000000000002f8] pgd=0000000000000000
> [ 1348.163364] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [ 1348.168927] Modules linked in: ipv6
> [ 1348.172421] CPU: 3 PID: 1421 Comm: brcmf_wdog/mmc0 Not tainted 4.17.0-rc5-next-20180517 #18
> [ 1348.180757] Hardware name: Amarula A64-Relic (DT)
> [ 1348.185455] pstate: 60000005 (nZCv daif -PAN -UAO)
> [ 1348.190251] pc : brcmf_sdiod_freezer_count+0x0/0x20
> [ 1348.195124] lr : brcmf_sdio_watchdog_thread+0x64/0x290
> [ 1348.200253] sp : ffff00000b85be30
> [ 1348.203561] x29: ffff00000b85be30 x28: 0000000000000000
> [ 1348.208868] x27: ffff00000b6cb918 x26: ffff80003b990638
> [ 1348.214176] x25: ffff0000087b1a20 x24: ffff80003b94f800
> [ 1348.219483] x23: ffff000008e620c8 x22: ffff000008f0b660
> [ 1348.224790] x21: ffff000008c6a858 x20: 00000000fffffe00
> [ 1348.230097] x19: ffff80003b94f800 x18: 0000000000000001
> [ 1348.235404] x17: 0000ffffab2e8a74 x16: ffff0000080d7de8
> [ 1348.240711] x15: 0000000000000000 x14: 0000000000000400
> [ 1348.246018] x13: 0000000000000400 x12: 0000000000000001
> [ 1348.251324] x11: 00000000000002c4 x10: 0000000000000a10
> [ 1348.256631] x9 : ffff00000b85bc40 x8 : ffff80003be11870
> [ 1348.261937] x7 : ffff80003dfc7308 x6 : 000000078ff08b55
> [ 1348.267243] x5 : 00000139e1058400 x4 : 0000000000000000
> [ 1348.272550] x3 : dead000000000100 x2 : 958f2788d6618100
> [ 1348.277856] x1 : 00000000fffffe00 x0 : 0000000000000000

Forgot about this one.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 412a05b..061f69d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4294,6 +4294,13 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
>   	brcmf_dbg(TRACE, "Enter\n");
>
>   	if (bus) {
> +		/* Stop watchdog task */
> +		if (bus->watchdog_tsk) {
> +			send_sig(SIGTERM, bus->watchdog_tsk, 1);
> +			kthread_stop(bus->watchdog_tsk);
> +			bus->watchdog_tsk = NULL;
> +		}
> +
>   		/* De-register interrupt handler */
>   		brcmf_sdiod_intr_unregister(bus->sdiodev);
>
>

