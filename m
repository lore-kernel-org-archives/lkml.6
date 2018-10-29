Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0120AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911582064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MmGvlwXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911582064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeJ3DaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:30:20 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:55610 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJ3DaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:30:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 7C1346CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540838426; x=1542652827; bh=uiJoZ2Fn5A
        5d5SaI0Q68f9wc9ZRdYzEp9w+mxJ6RATE=; b=MmGvlwXYGiKLsm7XkIGUyfPxJa
        yJsrvgze1uOSS6n9rva9lc9i3Gspma3sMQUd4rIVbESo9N1EWwoJTxewFke3VOoB
        J0IENNOVN3PbhznowJY/d2UQCYJqBkEaWwXecmeYsS47pkiDoVYewdrZSPRVvr/M
        9T3OnXNfkymo40ZCgi6NAFapG2jAGipMYEdtROlMpZEYnunNjHu+BMwkRL/z0oAh
        tnzdjmifdqPjOvCNDmenDYJi+Wb2MnFaho5ErzsUnvzM8GkTzvh8AumOYeq4CeqR
        5VGKeK+c5eTmNIarXUN+fxvRhRqjPtUl9J475nnoeEhN4vcMMqGz1Etq9e9w==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HyKvJJu3o4Xa for <linux-kernel@vger.kernel.org>;
        Mon, 29 Oct 2018 13:40:26 -0500 (CDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 59B3914F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:40:26 -0500 (CDT)
Received: by mail-io1-f50.google.com with SMTP id c6-v6so5621646iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:40:26 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJUvBKA8xaMsOvc3TwrIDHzr60Wh6Jxi27aDkOknyrx0r86RA/d
        Gni8KaPPhRxgmS8EUGwD0iVWmL5Dhc7x+Br/cqo=
X-Google-Smtp-Source: AJdET5fowOlTOznUvitn7z02GPW0lQMjTAh7pxoAA8ynH8yTCTzz+Eq3YREmZTgqLU5tyYE8+KAqzLShBycES69A5EQ=
X-Received: by 2002:a6b:7f4d:: with SMTP id m13-v6mr9063173ioq.16.1540838426075;
 Mon, 29 Oct 2018 11:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <1539956812-11300-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539956812-11300-1-git-send-email-wang6495@umn.edu>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 13:39:49 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fnx01565vUuturXLefLjsfUwGpD8Zh1bZZnrkSQ=wWpg@mail.gmail.com>
Message-ID: <CAAa=b7fnx01565vUuturXLefLjsfUwGpD8Zh1bZZnrkSQ=wWpg@mail.gmail.com>
Subject: Re: [PATCH] intel_th: Fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, alexander.shishkin@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anyone confirm this bug? Thanks!

Wenwen

On Fri, Oct 19, 2018 at 8:47 AM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In msc_data_sz(), the 'valid_dw' field of the msc block descriptor 'bdesc'
> is firstly checked to see whether the descriptor has a valid data width. If
> yes, i.e., 'bdesc->valid_dw' is not 0, the data size of this descriptor
> will be returned. It is worth noting that the data size is calculated from
> 'bdesc->valid_dw'. The problem here is that 'bdesc' actually points to a
> consistent DMA region, which is allocated through dma_alloc_coherent() in
> msc_buffer_win_alloc(). Given that the device also has the permission to
> access this DMA region, it is possible that a malicious device controlled
> by an attacker can modify the 'valid_dw' field after the if statement but
> before the return statement in msc_data_sz(). Through this way, the device
> can bypass the check and supply unexpected data width.
>
> This patch copies the 'valid_dw' field to a local variable and then
> performs the check and the calculation on the local variable to avoid the
> above issue.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/hwtracing/intel_th/msu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
> index 9cc8ace..b7d846e 100644
> --- a/drivers/hwtracing/intel_th/msu.h
> +++ b/drivers/hwtracing/intel_th/msu.h
> @@ -79,10 +79,12 @@ struct msc_block_desc {
>
>  static inline unsigned long msc_data_sz(struct msc_block_desc *bdesc)
>  {
> -       if (!bdesc->valid_dw)
> +       u32 valid_dw = bdesc->valid_dw;
> +
> +       if (!valid_dw)
>                 return 0;
>
> -       return bdesc->valid_dw * 4 - MSC_BDESC;
> +       return valid_dw * 4 - MSC_BDESC;
>  }
>
>  static inline bool msc_block_wrapped(struct msc_block_desc *bdesc)
> --
> 2.7.4
>
