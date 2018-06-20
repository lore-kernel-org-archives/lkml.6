Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB21205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iBnPjWZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB21205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeFTB57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:57:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52033 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTB5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:57:53 -0400
Received: by mail-it0-f66.google.com with SMTP id n7-v6so3272473itn.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+kChOCY+iImwi7DxDpWN7AfHNxiDAYYC+9rpl7595A=;
        b=iBnPjWZfQiBpwZ6fkKezgV/uZRUzuI0GzmyfehFVM+AeJ/YIu06umuvx+cNjVtAhJ9
         gmIOTHtiOpmQoaVzgdx7hhXtjL11RrvslhqcJsQNSUJnDNnZY3odhnuLPqPZ4FI+qYmQ
         ssjJrn5z7HiSOel0BUvVjgFG7Hnv7RV8YcBQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+kChOCY+iImwi7DxDpWN7AfHNxiDAYYC+9rpl7595A=;
        b=U/9V5wopNm4yQGPtHSCbtNH1u7kiEpQrSZ+RiKXxDexqhAXb/pIzsKaWiK6mMsxegn
         jcqKkU7bNNzuVSHh+CTVawr0cAlOzlFQ5lXcCqTWK2o9WvSDf9PWHdfZf7IY14Z4Y7js
         Gwpsl2xzZS73teTe8qAo9gBGgiMw5cdG9vVmkZ3yfdecp+YQaQpTCbCrQBEG75rdomy3
         tVHj+Exsa14Wfo56lDdbBhXR9TLOwT5Wavxuy77oNpIlDdjfapF6Atua2DZdHVw0Emyg
         Bt69awz23GRHRoIBGxFtDbjhFcDNYCrrdAtRpbt/l5b2bF6QFGeg/jqkQN+UBgt0P/yh
         QicQ==
X-Gm-Message-State: APt69E1MuO6wECNuKMrsbn4qnlic88hAVxztl0nnYup656zEmcFgqn1H
        htW/Vs5DeJebpLD4vdAVMPu3NAC0ZWvkvnIa3gmhJQ==
X-Google-Smtp-Source: ADUXVKI03i70+AWBWSA7+jczfoBehsaJ2ngJjYVTYb8mYiyCWehJS3irYMy5cb1PEUhmnEtzNvxyllbKd626BYWJPzY=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr72107itb.1.1529459872513;
 Tue, 19 Jun 2018 18:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180618134730.GO30522@ZenIV.linux.org.uk>
In-Reply-To: <20180618134730.GO30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 10:57:41 +0900
Message-ID: <CA+55aFzt37S-iKfHAuCL=5XhCvEtRARfs_exyn2o-0LzCWFvXQ@mail.gmail.com>
Subject: Re: [PATCH] __poll_t regressions this cycle
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Do you prefer it in one commit, or split into per-driver pieces?

If it's all the exact same issue with the same commit message, then
just one commit.

                Linus
