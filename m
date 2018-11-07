Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A8BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EB12085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EB12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbeKHA0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:26:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41574 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:26:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so21203282qkj.8;
        Wed, 07 Nov 2018 06:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si/L+aKbHRPfmPtIIt65UmaAers0MBMp/4VW44YjVBQ=;
        b=ZyEwAbl1K7CJ2GVoU72fWb2RPo/NF82m+FpBBiMQdbNCEgZfvhiEXkualstiB5nuh5
         wM37kGC7+8wA1maYlvoW1EkhZsUvsFiTmsSSiFu0dTbGE9WYY4Jan7iiOZp48joCquNz
         91jSNMNtLkjmPtPKlLfaHavgH7x/Qd1draAukxBtQN+w1oPyhoZlEw7LInitv473NB+E
         DMexsW+qAnqLzqC2AdMVybNm/pH3DIm/SYjjiqw3UE4Nz+NQQwk/UM09UxPbYZPLw64j
         56UoR7DaDw0KwydP1ciU6MlaGIpHOcnL/9S5T9GheULXMpis+qw+4oo9RiobM5Q+J5hB
         RrxQ==
X-Gm-Message-State: AGRZ1gJPPfe970D6yZctm1CoyVfBwjQ1CkMxvmRzUboxtssB83M82u2S
        iAJbC++z7+MRF9v7ONnkPdj4PIHNnfZtQm9JZl+A0wIs
X-Google-Smtp-Source: AJdET5c4JYuugowzgO8c50CNnG+yGOkWpF6iSNiluHtBxGt3Hk0QlKXVuW9W6AfvLYzh34XJfqGDeA2udMnEk73YDxc=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr500468qke.173.1541602538796;
 Wed, 07 Nov 2018 06:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-11-elder@linaro.org>
In-Reply-To: <20181107003250.5832-11-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 15:55:22 +0100
Message-ID: <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/12] soc: qcom: ipa: data path
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>
> This patch contains "ipa_dp.c", which includes the bulk of the data
> path code.  There is an overview in the code of how things operate,
> but there are already plans to rework this portion of the driver.
>
> In particular:
>   - Interrupt handling will be replaced with a threaded interrupt
>     handler.  Currently handling occurs in a combination of
>     interrupt and workqueue context, and this requires locking
>     and atomic operations for proper synchronization.

You probably don't want to use just a threaded IRQ handler to
start the poll function, that would still require an extra indirection.

However, you can probably use the top half of the threaded
handler to request the poll function if necessary but use
the bottom half for anything that does not go through poll.

>   - Currently, only receive endpoints use NAPI.  Transmit
>     completion interrupts are disabled, and are handled in batches
>     by periodically scheduling an interrupting no-op request.
>     The plan is to arrange for transmit requests to generate
>     interrupts, and their completion will be processed with other
>     completions in the NAPI poll function.  This will also allow
>     accurate feedback about packet sojourn time to be provided to
>     queue limiting mechanisms.

Right, that is definitely required here. I also had a look at
the gsi_channel_queue() function, which sits in the middle of
the transmit function and is rather unoptimized. I'd suggest moving
that into the caller so we can see what is going on, and then
optimizing it from there.

>   - Not all receive endpoints use NAPI.  The plan is for *all*
>     endpoints to use NAPI.  And because all endpoints share a
>     common GSI interrupt, a single NAPI structure will used to
>     managing the processing for all completions on all endpoints.
>   - Receive buffers are posted to the hardware by a workqueue
>     function.  Instead, the plan is to have this done by the
>     NAPI poll routine.

Makes sense, yes.

      Arnd
