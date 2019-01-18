Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F070DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC43720896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dvIfv9pH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="krSNawfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfARMui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:50:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfARMui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:50:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3268C6084F; Fri, 18 Jan 2019 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547815837;
        bh=MorWgsPB6zar4XIBy8lrteAK3Rq9M7qrlojH2wShSnQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dvIfv9pHTtV8n23TW6hD2rCxLUI/2sqEvWz0vGw3HS7L6Djc46B5I/7GmbJgAItwK
         S+swZ5+QwKJ0l4JtbpStvJiQpZYPNF8P08fdytMahIwVdoG/B0+xvrqGJX/NGDpbLj
         +DpnUde0cXtSGjPP4EEpracrgmgR4ewXa/Y5E+no=
Received: from [10.252.100.207] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 117A86053B;
        Fri, 18 Jan 2019 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547815836;
        bh=MorWgsPB6zar4XIBy8lrteAK3Rq9M7qrlojH2wShSnQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=krSNawfD2SsuwrazrdOuTED9aWSVNjSkPd+XYU1kdlXs2YqINvH8k20I29mtZG2cQ
         hq5Q+q4e6tnQFU6eEKvF57lRW0ONT3LO28bC3YfRYbuhPCk3yCXUTnRD1nvQEj1zAn
         aLc66voEPWurd6sC79yiPlb/mSrn6UrhfVMSyY0k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 117A86053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
To:     Li RongQing <lirongqing@baidu.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <ae44b1c5-4d33-110b-a4da-f526d156be2a@codeaurora.org>
Date:   Fri, 18 Jan 2019 18:20:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2019 2:57 PM, Li RongQing wrote:
> There still is a race window after the commit b027e2298bd588
> ("tty: fix data race between tty_init_dev and flush of buf"),
> and we encountered this crash issue if receive_buf call comes
> before tty initialization completes in n_tty_open and
> tty->driver_data may be NULL.
> 
> CPU0                                    CPU1
> ----                                    ----
>                                   n_tty_open
>                                     tty_init_dev
>                                       tty_ldisc_unlock
>                                         schedule
> flush_to_ldisc
>   receive_buf
>    tty_port_default_receive_buf
>     tty_ldisc_receive_buf
>      n_tty_receive_buf_common
>        __receive_buf
>         uart_flush_chars
>          uart_start
>          /*tty->driver_data is NULL*/
>                                     tty->ops->open
>                                     /*init tty->driver_data*/
> 
> it can be fixed by extending ldisc semaphore lock in tty_init_dev
> to driver_data initialized completely after tty->ops->open(), but
> this will lead to put lock on one function and unlock in some other
> function, and hard to maintain, so fix this race only by checking
> tty->driver_data when receiving, and return if tty->driver_data
> is NULL
> 
> Signed-off-by: Wang Li <wangli39@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> V4: add version information
> V3: not used ldisc semaphore lock, only checking tty->driver_data with NULL
> V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
> V1: extend ldisc lock to protect that tty->driver_data is inited
> 
> drivers/tty/tty_port.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 044c3cbdcfa4..86d0bec38322 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -31,6 +31,9 @@ static int tty_port_default_receive_buf(struct tty_port *port,
>   	if (!tty)
>   		return 0;
>   
> +	if (!tty->driver_data)
> +		return 0;
> +
>   	disc = tty_ldisc_ref(tty);
>   	if (!disc)
>   		return 0;
>
Acked-by: Gaurav Kohli <gkohli@codeaurora.org>

It looks good to me w.r.t previous approach, but Let's Maintainer decide 
once.

Regards
Gaurav
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
