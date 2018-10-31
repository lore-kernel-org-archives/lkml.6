Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2072BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C762080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKrZL2ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C762080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeKAG7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:59:36 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36179 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKAG7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:59:36 -0400
Received: by mail-vs1-f68.google.com with SMTP id v205so8429658vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKWy2oBfvjiLz2Ry6EiaPy1ELeaxR+H0LicNIMjDW/A=;
        b=bKrZL2ds7f9gAMc3RN4yVmwet2VdDpJk8hQk/WMzz0Zoe7/40RUMngaLdO/xvbGK1V
         SECnsTG+N811DcdNqLejMgS9ICPYUa6t5A6XPOJg0/9kkk2s2OFNyuPRRam3wSCrnS83
         e1EFOPhArHI+7LL43atVQ/Qpvi6tNG1bRkjcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKWy2oBfvjiLz2Ry6EiaPy1ELeaxR+H0LicNIMjDW/A=;
        b=Ii4i1d3/V6AjvgzZ6zd2zjLlTw7gViyoQ0zqUvafukrpRW8uGee+5MGTr0vingmLfQ
         kyKBmOtS6r758HNmnXStAdFJ5m6cExhg2Pg2hXtVZWmzRbqvBHekXjL21doLRIztSERi
         e3rsKPswud1MvZe3rvVx2ecMoMllyrrrBUizUYaMn4qskvWw9g+oiutw9+EqQCfDd+ed
         xFjyBn5BUSZxgTJnsQ2EQvtJs4jo6ACkGWGnI0nLDxBtzR9E8sAd/AlshFyLKEXc72yP
         KHSDOeixUFxI+a4E7cOBDRTzTnyMoyuvRxKx9ZQjP+hrT9861Gcq3l/pZDPEDmAbz7sY
         tfmQ==
X-Gm-Message-State: AGRZ1gISzvwk8YfvRph46p7QvlKzpMhcYkEecE1pRqSqp15lReQ5varn
        C5yM06TknMzbIf5NNQZcpW/eGA5E4sY=
X-Google-Smtp-Source: AJdET5dNp5y1oL4WcbsyGrIozcDXb4lVX0Q86v0yuSbLSD5bfiguT+nP+GpS7DCEXVBmlUfVA40cxA==
X-Received: by 2002:a67:2a41:: with SMTP id q62mr2153465vsq.230.1541023178634;
        Wed, 31 Oct 2018 14:59:38 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id j71-v6sm7537763vkj.38.2018.10.31.14.59.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:59:37 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id g144so2853417vke.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:59:37 -0700 (PDT)
X-Received: by 2002:a1f:1053:: with SMTP id g80mr2172535vki.90.1541023176851;
 Wed, 31 Oct 2018 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181031060921.5890-1-sibis@codeaurora.org>
In-Reply-To: <20181031060921.5890-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Oct 2018 14:59:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XpFrt2htDfbkhFQMh7szTcUm4CYqNHsVomOEK6XArC_w@mail.gmail.com>
Message-ID: <CAD=FV=XpFrt2htDfbkhFQMh7szTcUm4CYqNHsVomOEK6XArC_w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add reserve-memory nodes
To:     sibis@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, benchan@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 30, 2018 at 11:09 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add reserve-memory nodes for mpss and mba required for
> remoteproc mss pil.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I'm not an expert on the assignment of these ranges, but my nits have
been addressed and it seems like it matches what we're doing in this
section.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
