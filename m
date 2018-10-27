Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D2C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0620856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="iqBhGiUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A0620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJ0VyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:54:17 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:14422 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeJ0VyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:54:17 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 5620444AAA6;
        Sat, 27 Oct 2018 15:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540645996;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=oHoIYWes45xKvCOSnZlWRjPHzuIp2F/5FbW+xmHAwNA=;
        b=iqBhGiULDkk1k7ha3bUmKNwEOeKUy5xEMf6OqWX+yf1Ku7K+vzUWpikaz9SqhQf2I/qNjc
        5q22hqaviT4MelGnU1MhWOh5Ju4OrWFaZrem87zNxHVmSA2DDuJBTvGdjzFgMUaGq9kZL7
        Fb+7YzKRdud1pQ8TU9QWiRgfD7kw880=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 5620444AAA6
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Oct 2018 15:13:16 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     kai.heng.feng@canonical.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, ulf.hansson@linaro.org
Subject: Re: [PATCH 0/4 v5] Keep rtsx_usb suspended when there's no card
In-Reply-To: <20181024084958.4627-1-kai.heng.feng@canonical.com>
Message-ID: <73221b3a7e85c9b68776e3eb257eed6a@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540645996;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=oHoIYWes45xKvCOSnZlWRjPHzuIp2F/5FbW+xmHAwNA=;
        b=opUwEP597l9IisOBQ9Gg4jj8TfRrHDqBxa6A1lSI47Jq+ALpRi+2WD+ozxQkhwq7tErgpb
        7V7FZlzsIOf0cxdyO7f6ILSFmcdhfgKHsdjec5L70g50kIWOl8iLUtzTtpPTEr1cANhM7w
        +sZ0xtSwcq3GcL7VR+PY+l8FF9lYXK0=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540645996; a=rsa-sha256;
        cv=none;
        b=QkV+KLb1Q29AjdVvJX48KYzbmigsO83b0N5vDMAM1nABH48iYsUS3VXhmeaoPBOWfHWgKvg4/ZCOvlzM7biZKgL+0cStgl2swOKb2Lcd3GaaMCiFm/Uxg2JiYhueGOMjVwMkaXozhVduhWCdmqE/vWDsYYvI2OIPFshv1XVkTOw=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> This is based on Ulf's work [1] [2].
> 
> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
> platforms and ~1.5W on AMD platforms.
> 
> [1] https://patchwork.kernel.org/patch/10440583/
> [2] https://patchwork.kernel.org/patch/10445725/
> 
> Kai-Heng Feng (4):
>   misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
>     detection
>   memstick: Prevent memstick host from getting runtime suspended during
>     card detection
>   memstick: rtsx_usb_ms: Use ms_dev() helper
>   memstick: rtsx_usb_ms: Support runtime power management
> 
> v5: Corretly use system suspend/resume and runtime suspend/resume 
> callback.
>     Prevent runtime callbacks get call during system suspend.
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
>  drivers/memstick/core/memstick.c    |   4 +
>  drivers/memstick/host/rtsx_usb_ms.c | 173 +++++++++++++++++-----------
>  drivers/misc/cardreader/rtsx_usb.c  |   8 ++
>  3 files changed, 117 insertions(+), 68 deletions(-)
> 
> --
> 2.17.1

Feel free to add again:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

since it works fine with:

Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 
Card Reader Controller

-- 
   Oleksandr Natalenko (post-factum)
