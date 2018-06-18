Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC43C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AA32083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AA32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbeFRUE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:04:58 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59777 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755364AbeFRUEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:04:55 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 418hrz1qV7z1qtxB;
        Mon, 18 Jun 2018 22:04:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 418hrz0V29z1qsdt;
        Mon, 18 Jun 2018 22:04:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MqSrGwqGLprY; Mon, 18 Jun 2018 22:04:49 +0200 (CEST)
X-Auth-Info: 95bSsH+oqrLodh7THf8/hzR74wmKCfIo9a9wHYC5WO3dD0Hg4C3d8w/78WhwxYK0
Received: from igel.home (ppp-188-174-155-192.dynamic.mnet-online.de [188.174.155.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 18 Jun 2018 22:04:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 4B1112C10B2; Mon, 18 Jun 2018 22:04:49 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        gerg@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org,
        Meelis Roos <mroos@linux.ee>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/3] powerpc: mac: fix rtc read functions
References: <20180618140518.2920804-1-arnd@arndb.de>
        <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
X-Yow:  I represent a sardine!!
Date:   Mon, 18 Jun 2018 22:04:49 +0200
In-Reply-To: <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
        (Mathieu Malaterre's message of "Mon, 18 Jun 2018 21:10:06 +0200")
Message-ID: <87efh3hndq.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18 2018, Mathieu Malaterre <malat@debian.org> wrote:

> Sadly, trying again today does not work anymore. Adding some printk
> just before WARN_ON:
>
> +printk(KERN_ERR " rtc DBG pmu_get_time1: %lld %d %lld \n", now,
> RTC_OFFSET, now - RTC_OFFSET );
> +printk(KERN_ERR " rtc DBG pmu_get_time2: %x %x %x %x %d \n",
> req.reply[0], req.reply[1], req.reply[2], req.reply[3] ,
> req.reply_len);
>
> leads to:
>
> [    0.000000]  rtc DBG pmu_get_time1: 14096662 2082844800 -2068748138
> [    0.000000]  rtc DBG pmu_get_time2: 0 d7 19 16 4

A good value would have 0xd7 in the first byte.  The problem is that
pmu_set_rtc_time is also broken, and leads to an invalid time value
stored in the RTC.  Since pmu_request is a varargs function passing
values of type time64_t without casting won't work.

You need to reset your RTC before you can continue.

I think the right fix is to change nowtime in pmu_set_rtc_time and
cuda_set_rtc_time back to unsigned int (or to u32).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
