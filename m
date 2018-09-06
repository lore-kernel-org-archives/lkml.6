Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7609FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269552075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+w3gkRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269552075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeIFVJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:09:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38779 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeIFVJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:09:49 -0400
Received: by mail-ua1-f67.google.com with SMTP id o11-v6so9370997uak.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bUHzuFWOjKEc/bjZO8sGI6c0f4HduoCKEF5fzl2fcqw=;
        b=i+w3gkRnxLSfSiQuPQE006Og1gjHQxyP+cIN3xUDg5pD+bvDbVkT7WrOmcfkNDVBLC
         tSmeOtSKHSRpe0xI/apa+u2pXDs0+DM82yEQfg9Dma10pbN3bOkcy5fv+F9gs+M/yxmb
         6Gtl1tusP9s9oD3INE/OWzLWtFosRzQOlEF3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bUHzuFWOjKEc/bjZO8sGI6c0f4HduoCKEF5fzl2fcqw=;
        b=SI+lx+MQxD+KsJ0aB+AP5L4pSYs0aE6zQFSKJsu9hm3nrXoYpwYhlylA1D/7eX36gt
         Vo4IS3z5775Bi0zRIlqtfEvRznjfYvbAovJHfg9HRZS56RJ6nwDgrU1JyKrbpl3kx2O1
         TjNqWC+SLoJSyJWADpmYL2q1MrRe4ozmrQRl737Di9q1Xm+qDUwLBc2Ks3Lg/LBKe7vn
         GqFf0uAJK604osjMLytkdtS4ANpBERqld/JJSRvkY03BpVwLlWtrSTUxzxbrgz3nnmNW
         b1NHXIwW3citDMRWdIUU+Z3QGwtNSxCSGMd6mmE/dCIMeFl8jHHij+t4zkgG0CRuPO6q
         SihA==
X-Gm-Message-State: APzg51CdYhZk0leYFKOU4qGzgDQqSD4p2XtdqFXAxML+L39gI49hgnuv
        +0YDVO2+dcMMgMM76fgf4Zh9o8ZVhFY=
X-Google-Smtp-Source: ANB0VdY6mbTzNsXY6P2BUH5IHGslwMxlbCm1ePDFssYy6VLT+8Wpa23l8J1e8NxjC4fv3si8M5Gb9w==
X-Received: by 2002:a67:3f47:: with SMTP id m68-v6mr1315717vsa.37.1536251611640;
        Thu, 06 Sep 2018 09:33:31 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id t124-v6sm959077vkd.20.2018.09.06.09.33.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 09:33:30 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id q7-v6so9341930uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:33:30 -0700 (PDT)
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr1283839vke.70.1536251609824;
 Thu, 06 Sep 2018 09:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 09:33:29 -0700 (PDT)
In-Reply-To: <20180905233757.GB22824@google.com>
References: <20180830183612.169572-1-dianders@chromium.org> <20180905233757.GB22824@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 09:33:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDz9t8mWBrCSUMAgaxwhwLiv86zTyekG0=ybGQ1f73Yg@mail.gmail.com>
Message-ID: <CAD=FV=XDz9t8mWBrCSUMAgaxwhwLiv86zTyekG0=ybGQ1f73Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: geni: Don't ignore clk_round_rate() errors
 in geni_se_clk_tbl_get()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 5, 2018 at 4:37 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>>  int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
>>  {
>> -     unsigned long freq = 0;
>> +     long freq = 0;
>
> nit: Since you are already touching this you could also remove the
> pointless initialization, 'freq' is always assigned before it is used.

Done.

-Doug
