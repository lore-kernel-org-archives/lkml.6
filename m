Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1052FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BFE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a2rJs3bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BFE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH1Xf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:35:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39228 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbeH1Xf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:35:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so2417121lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suo1WyIcVI4l83a25C33AeQAXTojva68GeFklQfFvjo=;
        b=a2rJs3bC3KltCkGF025DhNQZ8Rsm9jCFzRuh8bN7nQCKo8ZTd2nTE0amiWS2IOhXZR
         MsbM+sXOqUCbfaU1C5/Ne5L4z8D4H4CVuCE/JIEus86ufSCwFMwoARLvEDlaaP7rDgXL
         bsDLxciNP1l9J5JpMonjYgRX54rYNZpsRSWU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suo1WyIcVI4l83a25C33AeQAXTojva68GeFklQfFvjo=;
        b=AM3qtzcZHSq6RGNmmlAUIyTUTYlGnkn+KYAtpmPr/gU+IvOrL9yqaVoLdfU9Kg4mf0
         KsOIaKuw1OlRbDdQvjZLK7nyerG3+W31HOdRq3UxvPU1vVbkyKoztPg6p7kY+OvNmHUz
         WQk9qAiyJasMO/4jQMpV2daSi0YgPJ5ttFwu/6fUP6X1QbyKjoCgw6aZLeXaebMLMamB
         8mF/l941exBDNbX3pYB3+s407kEBHDbZ/izRZdHaxxCqOd6PjYwE2VAQoB2/nyxsUS6K
         Iq7XJiklDGsATB5pmVMfgS2UkUsCK9TeZk4j/k293KmhCjWINdHR9TAWOMmE2hW9VVLC
         IEDw==
X-Gm-Message-State: APzg51AWMnvljiK8x5AKh6MTyM1T/A87q3JUXrdoFShJoGvjlRznj5eW
        5nnf7Z1NmsNYcAp6y9ZfkgP07Z4XpTU=
X-Google-Smtp-Source: ANB0VdaVZj508SZ8a6FoxhjavL8I4dnF/r7PlKjTiwn89FlWnwNdhHfpAiwugXY9oYMivca6kidbYA==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr1968311ljf.99.1535485337816;
        Tue, 28 Aug 2018 12:42:17 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g87-v6sm370527lfh.92.2018.08.28.12.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:42:17 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v9-v6so2419606ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:42:16 -0700 (PDT)
X-Received: by 2002:a2e:6385:: with SMTP id s5-v6mr2129969lje.117.1535485335718;
 Tue, 28 Aug 2018 12:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180807174739.23379-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20180807174739.23379-1-vivek.gautam@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 28 Aug 2018 12:41:38 -0700
X-Gmail-Original-Message-ID: <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com>
Message-ID: <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi/ufshcd: Fix NULL pointer dereference for in ufshcd_init
To:     vivek.gautam@codeaurora.org
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        subhashj@codeaurora.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 10:48 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Error paths in ufshcd_init() ufshcd_hba_exit() killed clk_scaling
> workqueue when the workqueue is actually created quite late in
> ufshcd_init().
> So, we end up getting NULL pointer dereference in such error paths.
> Fix this by moving clk_scaling initialization and kill codes to
> two separate methods, and call them at required places.
>
> Fixes: 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during clock
> gating")
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Subhash Jadavani <subhashj@codeaurora.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>
> Bjorn, Subhash,
> I am not certain of some of these devfreq, and clk_scaling bits
> that are moved as part of this patch. Please help in reviewing the
> change in the light of these features, and related sequence should
> be followed.
> Thanks.
>

You're right, there is a lot of logic moving around here. I think this
looks okay to me.

Reviewed-by: Evan Green <evgreen@chromium.org>
