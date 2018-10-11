Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7046DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FCB20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ew2zRSQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FCB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeJKQCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:02:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40592 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeJKQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:02:10 -0400
Received: by mail-it1-f193.google.com with SMTP id i191-v6so12011680iti.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zjf6MQyCDFdcMSyD2Xx/4M9iEgW6bg/scxX/wVhYLXo=;
        b=ew2zRSQkpLK3fXV3O6MUHdjKBlniIy71efieG/J0Mhd1/B8NDahlH/yBKRaCC/WUjd
         lIpb62CO1n2WEFScGKTKJx0qkrFzJw5yXrQKmxjJw6GEmD2iFM1OQHCUDI5P+AhmDbDm
         b/d+0c3bbCdtp8sLhWX//rv1fBVrzL+nHlxHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zjf6MQyCDFdcMSyD2Xx/4M9iEgW6bg/scxX/wVhYLXo=;
        b=n6xxUY3XBMGYa01whYfnxCnjFsSQYbX4o06iSs7hqsoKJKQ++MshYHfF08+Jij34FA
         Jx3snTyRYfchtOiWUdGP3H1iqc5ulHO+TFL/Cx+LpG/wiBb0ZP4ljUSMhJ/IraC3HTzT
         OZOQmMevVtHQEbUZHMlK+ml9Z941mjovGUlrw3N/MRvI+z6Gbu3rKX+mx7K9Q1GhV5n2
         BKEi3t+ib6OZpHWNvedswJo/VZdQaFEwD03oqI2U0gG3pG3B3TxtKSSLM7mfvqZZ+ShS
         1W2lf/Phnfyf8+cqdcHD13j/ZXNziGOZ1iCcZvEpVSGn5EhR/e1N4xJPAwX5YrLaG3Pt
         ls3w==
X-Gm-Message-State: ABuFfogslNtmYn58r4KWvROhSqfflDJEmNJQxKiQRtin/v1gwAjYNd8v
        1R1U8Wdj7WvqjDFZGzfFd+PES+2NkKOUaA==
X-Google-Smtp-Source: ACcGV60NhbSTvnCYxha3Y7a/YK1xwxx43rrcf5eJhRLW//EpoY9j1lDZU2hiZFLOy1df2HzhZN1BSw==
X-Received: by 2002:a24:3c0a:: with SMTP id m10-v6mr673055ita.15.1539246955734;
        Thu, 11 Oct 2018 01:35:55 -0700 (PDT)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id y190-v6sm8952487itg.3.2018.10.11.01.35.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:35:54 -0700 (PDT)
Received: by mail-it1-f175.google.com with SMTP id i76-v6so12010561ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:35:54 -0700 (PDT)
X-Received: by 2002:a24:e47:: with SMTP id 68-v6mr735480ite.23.1539246954546;
 Thu, 11 Oct 2018 01:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181011064608.37435-1-acourbot@chromium.org> <CAPBb6MXXwCOP6w7WdAFXdbmBLWKFp9gVDUW=uE=UFGiq_jPakg@mail.gmail.com>
 <93410466-ae47-b3ef-98ed-7cfe24a91776@linaro.org>
In-Reply-To: <93410466-ae47-b3ef-98ed-7cfe24a91776@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 11 Oct 2018 17:35:42 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVP84xSRrM9tuoG7zhUS1tGSJSNBCjwWBCyqWJ4D8jHRA@mail.gmail.com>
Message-ID: <CAPBb6MVP84xSRrM9tuoG7zhUS1tGSJSNBCjwWBCyqWJ4D8jHRA@mail.gmail.com>
Subject: Re: [PATCH] media: venus: support VB2_USERPTR IO mode
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 5:26 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 10/11/2018 09:50 AM, Alexandre Courbot wrote:
> > Please ignore this patch - I did not notice that a similar one has
> > been sent before.
>
> The difference is that you made it for decoder as well. Do you need
> userptr for decoder?

Not at the moment, so this part has not been tested. Better to take
Malathi's patch.
