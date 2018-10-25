Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FD520848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHE/+fPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FD520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJZAlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:41:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50477 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZAlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:41:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so2101556wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cN34LRJF8CB80rSj45zqhAl8fSJ91hRGEmfms4j5KzU=;
        b=bHE/+fPQV2uMQvcjU9FHF86QDVbLkXsKC2qUH5OVtMCCV6mMW7aTBRnI9sDaYBw3oS
         pthkrau/U2bHZgn2E6TgYlZxkSPkN17xtbGcBf1g9ADmVpMgASl2cGK9tirTEA9e9ORJ
         1JAQl+x/G4fDVHJTRhW2E66yn5kwrdGZ+Xd0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cN34LRJF8CB80rSj45zqhAl8fSJ91hRGEmfms4j5KzU=;
        b=s3QdlyQYgF/m/CXt52DJzsCFGlnn7nP+eeAx2JAD7B0RLruoMFr+AywT+qtQYziol3
         y5m2Z9nxudXGCjDePhoEC9MjlhiRmBPztZheiNci+GuFz6EkD/BoYTJQhBsp/zKWO/5c
         2iIRpOhiBoMyR462dyBiHxpQnms31IVGmycup0HTeMzwMwVzVaKFsWdXrpwRxKr9FUmJ
         Q6GPDU1rUze0DUSErZoaW4f+7KRcy9/KOqW+pW7wAU7JckCTyiPhmgRRN7FPGyx8irdN
         hMp6hW6KSz312byb35+TAE3T5PfzkICC5zsraloWRTaxoFb+ZF6Js+X92h62O5Dw5Eme
         PQNw==
X-Gm-Message-State: AGRZ1gJlujgVMV1JX7JzPNF3iEfHuOnLLkBdBuqVo6i3UbmwdLuzgvhH
        fh1mMBAnU6b0yj13n8OftnQD/g==
X-Google-Smtp-Source: AJdET5e3/3J3h7yNEGPviZD9M/gymI1JeDj+8A5cUysXJeDrH5AsXW4IzAIs4WnPZdsg2QB41Vx0WA==
X-Received: by 2002:a1c:760b:: with SMTP id r11-v6mr2620315wmc.39.1540483704947;
        Thu, 25 Oct 2018 09:08:24 -0700 (PDT)
Received: from localhost ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id l70-v6sm3144178wma.0.2018.10.25.09.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 09:08:23 -0700 (PDT)
Date:   Thu, 25 Oct 2018 17:08:22 +0100
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        khilman@baylibre.com, Olof Johansson <olof@lixom.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.20
Message-ID: <20181025160822.GA16095@hector.c.hoisthospitality.com>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-2-git-send-email-andy.gross@linaro.org>
 <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
 <20181005142911.GC15665@hector.nxp.com>
 <CAHLCerNKw3_1E0Yoi-jq=hextG=xbbjU3=P=-25zeyc0MdmjxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerNKw3_1E0Yoi-jq=hextG=xbbjU3=P=-25zeyc0MdmjxQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:55:32AM +0530, Amit Kucheria wrote:

<snip>

> Andy,
> 
> While you acked the tsens thermal DT patches[1] so they could go
> through the thermal tree[2] to avoid a dependency, Eduardo would
> prefer the DT changes for tsens to go through the arch tree.
> 
> To avoid a scenario where these DT changes don't get merged until the
> next merge window, would you or arm-soc maintainers consider merging
> them in -rc2 (after the thermal-soc tree gets merged)?
> 
> For convenience, I've provided just the DT changes with all tags in a
> separate branch on top of v4.19 here:
> https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4
> 
> Regards,
> Amit
> [1] Here is a reference to the patch series with Andy's acks:
> https://lore.kernel.org/lkml/cover.1536744310.git.amit.kucheria@linaro.org/T/
> [2] Here is a link to Eduardo's tree containing a subset of the above
> series (I don't yet see a pull request):
> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=linus

I can just send a pull request for -rc1.  No biggie.


Andy

