Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6931AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FB3208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCZiCxdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FB3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934608AbeFKVZz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:25:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40620 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeFKVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:25:52 -0400
Received: by mail-oi0-f65.google.com with SMTP id f79-v6so19233004oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI1khlOY1mioRzfaIGxidTLjBINsXlq/x/Tly+Ot0g4=;
        b=GCZiCxdOBFtn66R0eoni8dald03q2BbrGmlinH3BZAt+8XL1VR2cCjB2n1TNoTGggV
         DfDUWA+RpjwTWJmd/m9gyB+Je8sM0m6RSWpSJLPSuZpJJaj6LDpN6MGWlYa+BoIpiPkE
         LJzSCR0KJFD3zVmbookIAf5MqUWBNUyliGf5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI1khlOY1mioRzfaIGxidTLjBINsXlq/x/Tly+Ot0g4=;
        b=Qtbf6ZVFigO/oBfynj21WawXHgM1fppe4BvXzXmmv55CUKZHOknoSLRK137SibRUKk
         4Vfqh7H+w0B+C9l+lWSr21IkJe9KX3JilNCir9EcpXKm1aegNE5iujrsuVrf+jhVhrLg
         2YaO0pVMhpHGXw9HOGUZyHyhU1LMGqx0XM1x60PYbtRGYYT5YauwuP2YPLMg1yqFZedT
         vikEppDQv1MyqxV7ya4nvvTbOIqi4d8dPZUmY8ZjS8IeW0v71yRw1kgjn/Kq0M2reBgG
         Cxi4abFiJVQKoGL6w+ZfPHsYleqyRBu7Tm+z5m4txApoiFJy9C/LUqEjbLmqDEOIL0/X
         x6Cw==
X-Gm-Message-State: APt69E2CKC49QDPNEq8tq1DNpuT1UACbv5iQNVgE3XMVdYDVHGUqvcth
        NQp9dD487EY9jOn4HOc86pfwZcupBHI=
X-Google-Smtp-Source: ADUXVKITuCTuwGINrrZtwS+XceSU+ozQvVd69sRs/VyPans4FFL3n3dx1WWo9e+gQnQ82qEwBGVn2w==
X-Received: by 2002:aca:49c7:: with SMTP id w190-v6mr495054oia.119.1528752352204;
        Mon, 11 Jun 2018 14:25:52 -0700 (PDT)
Received: from mail-ot0-f174.google.com (mail-ot0-f174.google.com. [74.125.82.174])
        by smtp.gmail.com with ESMTPSA id r40-v6sm13640351otr.62.2018.06.11.14.25.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:25:51 -0700 (PDT)
Received: by mail-ot0-f174.google.com with SMTP id l15-v6so24558476oth.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:25:51 -0700 (PDT)
X-Received: by 2002:a9d:4c86:: with SMTP id m6-v6mr551086otf.273.1528752351056;
 Mon, 11 Jun 2018 14:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-5-git-send-email-vviswana@codeaurora.org> <12fe9a2d-af74-bc84-3b2c-c150e8768b86@intel.com>
In-Reply-To: <12fe9a2d-af74-bc84-3b2c-c150e8768b86@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 11 Jun 2018 14:25:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft4zgJhhug35ApU+4YkHzFQg1nX9-BwOhmoRANc8GUA0+w@mail.gmail.com>
Message-ID: <CAE=gft4zgJhhug35ApU+4YkHzFQg1nX9-BwOhmoRANc8GUA0+w@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] mmc: host: Register changes for sdcc V5
To:     adrian.hunter@intel.com
Cc:     vviswana@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:33 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/05/18 12:52, Vijay Viswanath wrote:
> > Add support to use the new compatible string "qcom,sdhci-msm-v5".
> >
> > Based on the msm variant, pick the relevant variant data and
> > use it for register read/write to msm specific registers.
> >
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
