Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E04C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D726B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYo/Z0Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeIZD70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:59:26 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:47101 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIZD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:59:25 -0400
Received: by mail-vk1-f193.google.com with SMTP id b14-v6so5188760vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rl4ljybCysdU8OjbYPybyZcFxxB8LIwHIFQPKKqCP/M=;
        b=BYo/Z0Q98HB62U+aFv6ANKyL/qWPfjx/VtXgSSR/vI4PbzjHtCpcUPw9F8/95nVsSz
         F4gzoqjhRZ0t20+CkMVLwmhTktKl9f3FDMHG6LbLeNgW5+09UetHyxDyxvPeAxYRHx74
         DHQaXW5TU8B37xjH3x6XoHvH+x4ZKZIb2LzhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rl4ljybCysdU8OjbYPybyZcFxxB8LIwHIFQPKKqCP/M=;
        b=ikG+YBxRDkxhuq1inoXjVMKtznT2+fvOshp5Cl+Wlq/p+JTWzyFMlI7DDQXl+L8wRk
         tLpf2N0+hdOnv97KRs2lLllBu4R7xnPlP4zFyalohk1Knus4jPa7gYqw9x5ixaAP8A3m
         kREZdmJSDdTXEz/s37tFnGIw/RAmilFslgQonIyNS2TfNAmYZPagEp5uwrR+dTyZLPWX
         dPnnqL2u+rz/4tZtNwtGbxvL/ACn69ByfjrUekQq6YT0HOILkl9dwK/er1uDiO1rkdZ5
         sJHDEg3642yoNBiVkS0MzpbZ8NnRIMrVqzJfSgVCRVUO7UfP22qfn4KGKr7AD4gKylKO
         veGw==
X-Gm-Message-State: ABuFfoidwgJfo1uJtla1zhj1XpE+bAsR6ffJpEcJXpgP+Q1ROGCJcs8w
        emWTeKnxlCV7z1CrzlX0/SPtQ6HVYtE=
X-Google-Smtp-Source: ACcGV60PoEbOxzrEDLtbt8cIuj+12Y/f6vTRs5cMTM4SfBlZC4wPv7SRH+HA6Tyl796Dgqgh6to5/g==
X-Received: by 2002:a1f:a003:: with SMTP id j3-v6mr885038vke.23.1537912188721;
        Tue, 25 Sep 2018 14:49:48 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id s203-v6sm884203vks.16.2018.09.25.14.49.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:49:47 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id g18-v6so10104960uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:49:47 -0700 (PDT)
X-Received: by 2002:ab0:274a:: with SMTP id c10-v6mr1005973uap.25.1537912187362;
 Tue, 25 Sep 2018 14:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180924235235.182649-1-swboyd@chromium.org> <20180924235235.182649-2-swboyd@chromium.org>
In-Reply-To: <20180924235235.182649-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Sep 2018 14:49:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9yDF95NvuJGFMWJHBFS87VG4jJP946oH6w8gB3LGRvQ@mail.gmail.com>
Message-ID: <CAD=FV=X9yDF95NvuJGFMWJHBFS87VG4jJP946oH6w8gB3LGRvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] i2c: i2c-qcom-geni: Simplify tx/rx functions
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 24, 2018 at 4:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We never really look at the 'ret' local variable in these functions, so
> let's remove it to make way for shorter and simpler code. Furthermore,
> we can shorten some lines by adding two local variables for the SE and
> the message length so that everything fits in 80 columns and testing the
> 'dma_buf' local variable in lieu of the 'mode' local variable.  And
> kernel style is to leave the return statement by itself, detached from
> the rest of the function.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 79 ++++++++++++++----------------
>  1 file changed, 36 insertions(+), 43 deletions(-)

It's so polished I can see my reflection in it now.  Looks like this
snuck in a few other cleanups compared to v2 (move "gi2c->cur = ..."
to be common between tx/rx and removed a pointless init of time_left).
Seems good.  In total 7 lines shorter and easier to read.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
