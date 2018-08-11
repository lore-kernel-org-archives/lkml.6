Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F8C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B452174A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cYALqf7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B452174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeHKWur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:50:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37816 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeHKWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:50:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so5053142wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=n/7NljaXr4c5838zNNC3PM25U9KUcSPkuy6NqzGtAcg=;
        b=cYALqf7VLQSxc8P4GRQaQWmxmuvehrbK0xY0Z6KKo4WrqL5U1FoXeymaw0U2pCr2OQ
         HWVnJu6+5BYiqI61BM0ScdwM58TgiNULQG4g62sFBtjctJndbCTfkV7iDG0CVl5ViTFI
         BBRHNU3iCT6Z/8YMH4OODOttXJ3gi5z7s7bTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=n/7NljaXr4c5838zNNC3PM25U9KUcSPkuy6NqzGtAcg=;
        b=tSxiXtaII1hHfSLV+gwsmdOm1N6oOE5oKtJRGX8RhR+ZqN5e4dFhcu8fu4WLxMhaxj
         xz+7PlM4wIR8apvU7gFthqtf9jaNEkAGTcd6dtmfKeBDq481XtneNrAaR3rytvjF0PpD
         GH3Zq9ExTi6I4uUkPb2HOSrTQ/p+g2a7E4o9cpVLlBheVhBcIVEl+1CJOP22IP8M9ku/
         Le6xcQxL+KY6vNpoCF67kljjUqCyaoRg5i/mhGXqZio08K7gdpXtN0K0MBhcpcIBltHq
         4l1CJ5a10/DIoQPXrviLYNnLK5WKLpgYGJhkuPvj9H0hvjeK/k9P6M6I8AfAmOG7QMyO
         7Wxw==
X-Gm-Message-State: AOUpUlGHQ3D4ewczCj07vRww2P75bmjOxwmz190B9LoHuKeuXnnN+dDG
        ny4J+D12iduvyjze4cRiOHUtgjxZekroUA==
X-Google-Smtp-Source: AA+uWPwxyzyj3MQbVdhONHqoQJHnuRWkth9uOgKCwnhXLI1aU1pweonjNmDlAbK+kAvYI2TFZhHhIQ==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr4543574wmc.27.1534011977545;
        Sat, 11 Aug 2018 11:26:17 -0700 (PDT)
Received: from [10.177.251.221] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 1-v6sm9111002wmf.47.2018.08.11.11.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 11:26:16 -0700 (PDT)
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@qca.qualcomm.com>
References: <20180810233948.144792-1-briannorris@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        linux-kernel@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B6F2A47.7070502@broadcom.com>
Date:   Sat, 11 Aug 2018 20:26:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180810233948.144792-1-briannorris@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2018 1:39 AM, Brian Norris wrote:
> Devices may provide their own MAC address via system firmware (e.g.,

You got me confused by using just "firmware" in the subject.

> device tree), especially in the case where the device doesn't have a
> useful EEPROM on which to store its MAC address (e.g., for integrated
> Wifi).
>
> Use the generic device helper to retrieve the MAC address, and (if
> present) honor it above the MAC address advertised by the card.

But this put me back on track ;-)

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>   drivers/net/wireless/ath/ath10k/core.c | 3 +++
>   drivers/net/wireless/ath/ath10k/wmi.c  | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)

