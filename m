Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6C0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F487214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FF4QM2W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F487214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJISfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:35:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42368 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJISfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:35:36 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so828014ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cNmaELs1oJuQWDqeN4s+EsTIlxYH6u5Apbcxm713ZFo=;
        b=FF4QM2W2aieL5CLJsQEALSLmyZ4AbZjROxA5NTBDo71V4DEhxb4AagUjjosVuOZZSK
         Kzq3fQv9QaDDvClIohPw6SdKJn/ugkel1IGwzg6vxx9RhbW9e21q8eruSFye+AJSlQs5
         0OsUmd7wZJXCA6gW+6NTeSCxQT65aStdSaK8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cNmaELs1oJuQWDqeN4s+EsTIlxYH6u5Apbcxm713ZFo=;
        b=glopEunOkuTJE6eJBafJpw991jFQ7OoiohMfp53o2olwlFI+46hXPuID2MtMf/vc10
         biKBM2vI/Jh6v0Lub4SltFXzKYdxTpoXq2rXhqi9VWfGwI0ip7y5uxmHw2oHpl88xff+
         NcUBAdOpz294QRLXoVXNpIDWYTAEUq6ruOTt8N6p74cl65asRqJIZBAVU5MxEsDhSmO1
         UTOQcGjf5oQzGhzeD/UiL0L9BxsA0biNvw0vOtv82S97ankXOZFmT4O7RxdZUbVFWPcN
         lYsRhoJf3u5aKsMv8DZN2FXC54EUOR8c/WqvZVlRhTESJDhVaxt3kynhm+d3iDJzZScG
         QMAg==
X-Gm-Message-State: ABuFfoiBP4kE4+oeUwJlKqkX23gHrjf4ePeuqGngcIE7/Hm5XpyW5+ym
        BQvoWCDE7X0M8thv1esQ7kAlGoDr07HmTUqI/ctkCQ==
X-Google-Smtp-Source: ACcGV62q1x6L4FfJh7WZIqRrtFT0Ear3f/v06DGJXaPGDxSLYyKIHzqLE2ebMd3wGVr6p0tqi8oCVGSEQqPeQ2+DReI=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr18093348ioc.131.1539083948137;
 Tue, 09 Oct 2018 04:19:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 04:18:27 -0700 (PDT)
In-Reply-To: <cb919bf8-caa2-b2fe-fee4-ae2f0f4c04b5@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFp0oHHS=bkXj_AbiLmbNxW07pFnk-4m9kwQtYkh_ogKgw@mail.gmail.com> <cb919bf8-caa2-b2fe-fee4-ae2f0f4c04b5@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Oct 2018 13:18:27 +0200
Message-ID: <CAPDyKFp4DEtavAqDg-ymaCcus+Hddv0OrgfS54HsTX+aWdzN+w@mail.gmail.com>
Subject: Re: [PATCH V6 00/23] mmc: mmci: add sdmmc variant for stm32
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2018 at 09:54, Ludovic BARRE <ludovic.barre@st.com> wrote:
> hi Ulf
>
> On 10/09/2018 09:30 AM, Ulf Hansson wrote:
>>
>> Applied for next, thanks!
>>
>> FYI, I made little fixup of the help text in the Kconfig for the last
>> patch.
>
>
> Thanks for your review.
> Did you had a feedback on Qcom platform tests?

Nope. I am leaving the tests for Qcom platforms to be done by
kernelci, let's see what the reports are.

Kind regards
Uffe
