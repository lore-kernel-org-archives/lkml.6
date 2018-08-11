Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D1FC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2D1223C6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PoOC7Dg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2D1223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHKCq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 22:46:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36034 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeHKCq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 22:46:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id b22-v6so7726274lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isu/2bjwTW1W1CEBaS7T1ApZkb8pdoWekjbye+rJkpw=;
        b=PoOC7Dg3bm7FoijqfMPXuRTZC9S80ykoXKn2hZT66KYMIrEOwQKH28P6BjbXHjmNty
         zcgjIJ60zLMtK8ivZlEQD82vPA5m1e75FaucvCEuTPFL2MOozQQHcnuECuqcUchr2e+7
         XcvYWUYCCfKUw+XGHfJPRMW9ddkSZx/JWISDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isu/2bjwTW1W1CEBaS7T1ApZkb8pdoWekjbye+rJkpw=;
        b=Z/namsah0OOxAnDXZu4oL1mraJ8cEIx8+zeIZlrBtb1L0lltTVbh3/SQQzXzd63Abk
         +puEqhQcExOPh+WwTrg0CFQfT1BjmHmUvMRST1yMYXb8Hab6Qib9QR3NnNG7TMP+VFqu
         DDBzegepxgLejxP4HyZFh+QrZ4paV2dKIZrGw33MSNufsHCE6JQgHx8KaARrl5glN33k
         gVeOtJbvC4GQTby0JXsgZjr4qg9z/yeBqZxC3C0lHh2lpxbcjQ7R80fviZSUAzri4A+D
         KOy/znmjH1mdlbsBI6ERT1mJP7ZIDldwbq3aVYucH4EIsnMuDJxXiWj8EUy4/eBM4EJO
         nDJA==
X-Gm-Message-State: AOUpUlF5veHL/rzQURyTVnYURbpwhysDfTZuTIRt74pX16anjMi7XztI
        JKEl8YphXpp5i5JZVvwCCiPXMOdv95A=
X-Google-Smtp-Source: AA+uWPwTsvU67sDG71IfNSSJ4ypM13YBYn+ILbw9aFSY98O82riPtvq4Va3nERQTUIhlhTEtFyLz7A==
X-Received: by 2002:a19:26d2:: with SMTP id m201-v6mr5492852lfm.43.1533946488891;
        Fri, 10 Aug 2018 17:14:48 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h4-v6sm2059946lfj.69.2018.08.10.17.14.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 17:14:47 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id p6-v6so8408299ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:14:46 -0700 (PDT)
X-Received: by 2002:a2e:540d:: with SMTP id i13-v6mr5734323ljb.51.1533946486671;
 Fri, 10 Aug 2018 17:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <1533155615-27929-1-git-send-email-vnkgutta@codeaurora.org>
 <1533155615-27929-4-git-send-email-vnkgutta@codeaurora.org>
 <CAE=gft5-5sVE-ih26KzJdpeth7Hq6QKNrP+oj_1JR=zYrdo0rw@mail.gmail.com> <2f1f8fcb95ed82219817800577ced67d@codeaurora.org>
In-Reply-To: <2f1f8fcb95ed82219817800577ced67d@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 10 Aug 2018 17:14:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft5dOURp02K9StHsXySCYCu-nO-44Sw0=+CTxkO-Yra_5A@mail.gmail.com>
Message-ID: <CAE=gft5dOURp02K9StHsXySCYCu-nO-44Sw0=+CTxkO-Yra_5A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drivers: edac: Add EDAC driver support for QCOM SoCs
To:     vnkgutta@codeaurora.org
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 4:13 PM <vnkgutta@codeaurora.org> wrote:
>
> On 2018-08-10 10:23, Evan Green wrote:
> > On Wed, Aug 1, 2018 at 1:34 PM Venkata Narendra Kumar Gutta
> > <vnkgutta@codeaurora.org> wrote:
> >>
> >> From: Channagoud Kadabi <ckadabi@codeaurora.org>
> >>
> >> Add error reporting driver for SBEs and DBEs. As of now, this driver
> >> supports erp for Last Level Cache Controller (LLCC). This driver takes
> >> care of dumping registers and adding config options to enable and
> >> disable panic when the errors happen in cache.
> >>
> >> Co-developed-by: Venkata Narendra Kumar Gutta
> >> <vnkgutta@codeaurora.org>
> >> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> >> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> >> ---
> >>  MAINTAINERS              |   7 +
> >>  drivers/edac/Kconfig     |  28 +++
> >>  drivers/edac/Makefile    |   1 +
> >>  drivers/edac/qcom_edac.c | 507
> >> +++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 543 insertions(+)
> >>  create mode 100644 drivers/edac/qcom_edac.c
> >>
> > ...
> >> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> >> new file mode 100644
> >> index 0000000..cf3e2b0
> >> --- /dev/null
> >> +++ b/drivers/edac/qcom_edac.c
> >> @@ -0,0 +1,507 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/edac.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/smp.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/soc/qcom/llcc-qcom.h>
> >
> > Please alphabetize these includes, and remove any unneeded ones.
> Ok, I'll update it in the next version. I didn't know that it's
> mandatory to have in alphabetic order.
> Is it recommended or a strict rule that we have includes in alphabetize
> order?

You know, I'm not actually sure if it's a strict rule. I'm still
learning many of the conventions here myself. But it seems to get
commented on consistently by reviewers, so it's in my bag of "things I
look out for".
