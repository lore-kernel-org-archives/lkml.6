Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E25C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841AE20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Cu/xmHJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841AE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbeGaUQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:16:08 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:51288 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbeGaUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:16:08 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 66CE03BCEF1;
        Tue, 31 Jul 2018 20:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1533062071;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=zHzXNYUzUEt8oTi7rU9nsw1TzLNtCLrx/potDoaPMEM=;
        b=Cu/xmHJtHxkk3Vba5DKd3+iuATZMyai4UNGjGG98si6ne8xo5RK2q7xkgsD6RGkbcES8EQ
        Ue4bGUjWYwlq1Va4oLJ9c4M7D0658G2quvUnjkxKoKjBcfTFGu5rl9h70CUVxukmcNPIda
        MngHk7tgq7NVgTTKtlWLKYZBfBROK24=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 66CE03BCEF1
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 20:34:31 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     kai.heng.feng@canonical.com
Cc:     arnd@arndb.de, bauer.chen@realtek.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ricky_wu@realtek.com, stern@rowland.harvard.edu,
        ulf.hansson@linaro.org
Subject: Re: [PATCH 0/5 v4] Keep rtsx_usb suspended when there's no card
In-Reply-To:  <<20180731061721.15831-1-kai.heng.feng@canonical.com>>
Message-ID: <17ae77968909919de05cdfb7d53ced3f@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1533062071;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=zHzXNYUzUEt8oTi7rU9nsw1TzLNtCLrx/potDoaPMEM=;
        b=Xc2ZWW/00TvVTjsv4nj/lqyN9JOacrOu1WudsSlgH/hw6Ek4U4pJpBEFPznU/sJut2vueh
        wXsi7QujA5RfGq5qhTp+ja1U475IiNpJdN7TpKtRYAQRWzJnvDv/exDJDHtgnYe7Y9m6EG
        zqxmz6D/FxKS9Aypiv2uNSRlFrkqcyA=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1533062071; a=rsa-sha256;
        cv=none;
        b=Rg+hAWGjinCJ9/HMrty7UEIEBxmTNxXdxIBZevwpbAsarF63wPiorTqtDvIsRJzbbJn//N3WEv+SdU0taZVP9/QXRsHaKUX5rdlSOaFk87fiI4Smc8bSZdx15YfbTE2iFvqyKRiMsk2Y4QHdliVhGrPA0DWomnbwqrIhVbgEi68=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Hi,
> 
> This is based on Ulf's work [1] [2].
> 
> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
> platforms and ~1.5W on AMD platforms.
> 
> [1] https://patchwork.kernel.org/patch/10440583/
> [2] https://patchwork.kernel.org/patch/10445725/
> 
> Kai-Heng Feng (5):
>   misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
>     detection
>   memstick: Prevent memstick host from getting runtime suspended during
>     card detection
>   memstick: rtsx_usb_ms: Use ms_dev() helper
>   memstick: rtsx_usb_ms: Support runtime power management
>   misc: rtsx_usb: / memstick: rtsx_usb_ms: Avoid long delay before
>     system suspend
> 
> v4: Use pm_runtime_put() in memstick_check().
> 
> v3: Skip parent device check in rtsx_usb_resume_child().
>     Remove dev_dbg() if it only prints function name.
>     Use ms_dev() helper at more places.
>     Remove const qualifier for UNIVERSAL_DEV_PM_OPS.
> 
> v2: Resend to linux-usb and LKML.
> 
> ---
> 
> Kai-Heng Feng (5):
>   misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
>     detection
>   memstick: Prevent memstick host from getting runtime suspended during
>     card detection
>   memstick: rtsx_usb_ms: Use ms_dev() helper
>   memstick: rtsx_usb_ms: Support runtime power management
>   misc: rtsx_usb: / memstick: rtsx_usb_ms: Avoid long delay before
>     system suspend
> 
>  drivers/memstick/core/memstick.c    |   4 +
>  drivers/memstick/host/rtsx_usb_ms.c | 148 +++++++++++++++-------------
>  drivers/misc/cardreader/rtsx_usb.c  |   9 ++
>  3 files changed, 91 insertions(+), 70 deletions(-)
> 
> --
> 2.17.1

For the following device:

$ lsusb | grep Realtek
Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 
Card Reader Controller

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

No smoke.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
