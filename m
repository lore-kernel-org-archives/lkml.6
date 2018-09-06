Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D19EC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0FD20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TyAOj2Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0FD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeIGDQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:16:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35165 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbeIGDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:16:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id m26-v6so10473828uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+uUynlFtm3zCJBB2epeUmL3fBTcfaAjqr4oIW2sf3Lc=;
        b=TyAOj2Hf8E9aQunAM4xLsJgLb5gPCjY+SXy/opWPEPstzgHph5vQFfm+RMfcTf7I6v
         Aea/VzoWdxZrXvjLfbQdxFMJs/FQ/HIuQrN0odHVGC7cJUhZzJu0mi3kVVUKf1H3/CNE
         a7NtLhSW164MEAwIIkI+7FqdAOt9nJ4/eeHRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+uUynlFtm3zCJBB2epeUmL3fBTcfaAjqr4oIW2sf3Lc=;
        b=aHvXoy5xQmSSWdFLt5ZOUiC3GMHWWOqFhUXf9CoVSkTDf0hx+r25uRWqoIzxr7zpLK
         bmFiL0WM/Jy/2xNPaiQ+1iTNa8TW5d9YnEwkA0NgraK3MkEEtMoVZNlaNoRT4q102kOH
         +vn+c3tVffINa3dQ1Nhh8iO2LM3/hetBumH/XhBYgb/5MOLIA9gKUn3nDz+f6EZJcfsJ
         F78ETBdWebAo0f9Msk7QRuAFS8y6WEWNGOOZxyVwoFWdZUmWeqvxGmRrSKQkHPbmWJlo
         mlA1Ocs0U3TWvBuZPH/waHYR2FSQPhUwh7ctkNInqlfAtLpzY4nkvjrzzCSo+hcqH8S6
         rJcg==
X-Gm-Message-State: APzg51BNfTva6TKn7YGnbU2/W24SkS3jvvhud5xahTTjW/QsrIq8LLd+
        C9ZkdU1gkPzsfNxVZKrqMhc+IsO2VKY=
X-Google-Smtp-Source: ANB0VdZynSKDid8GM6eEwMNstQK3UJvhvAzS6v/U6krJ+yRnwA7JCkesokjHUPRaVWHSDql40K45ag==
X-Received: by 2002:a67:384e:: with SMTP id f75-v6mr1897395vsa.64.1536273547535;
        Thu, 06 Sep 2018 15:39:07 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id k10-v6sm1834255vkd.51.2018.09.06.15.39.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 15:39:06 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id j14-v6so142168vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:39:05 -0700 (PDT)
X-Received: by 2002:a1f:ac08:: with SMTP id v8-v6mr1706045vke.32.1536273545469;
 Thu, 06 Sep 2018 15:39:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 15:39:04 -0700 (PDT)
In-Reply-To: <201809070658.q1aRNwTN%fengguang.wu@intel.com>
References: <20180906163241.166165-1-dianders@chromium.org> <201809070658.q1aRNwTN%fengguang.wu@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 15:39:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=qcLijE3bUm7SO+cwWzno8SeiYM9zQz+vkipbpafNmg@mail.gmail.com>
Message-ID: <CAD=FV=W=qcLijE3bUm7SO+cwWzno8SeiYM9zQz+vkipbpafNmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: geni: Don't ignore clk_round_rate()
 errors in geni_se_clk_tbl_get()
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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

Hi

On Thu, Sep 6, 2018 at 3:35 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Douglas,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on agross/for-next]
> [also build test WARNING on v4.19-rc2 next-20180906]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/soc-qcom-geni-Don-t-ignore-clk_round_rate-errors-in-geni_se_clk_tbl_get/20180907-045155
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>
> All warnings (new ones prefixed by >>):
>
>    drivers/soc/qcom/qcom-geni-se.c: In function 'geni_se_clk_tbl_get':
>>> drivers/soc/qcom/qcom-geni-se.c:531:39: warning: 'freq' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       freq = clk_round_rate(se->clk, freq + 1);
>                                      ~~~~~^~~

Oh crud.  Yeah.  ...so v1 was right after all.  :(

-Doug
