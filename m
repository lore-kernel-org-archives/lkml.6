Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1348AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AEA27EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bW0iw886"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AEA27EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965242AbeF2MRc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:17:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39977 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbeF2MRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:17:30 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so2549710ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5MhYel8I9XAiPqOLLMra3q7chW/GxltXVDG7bvWIV4=;
        b=bW0iw886WihgDGJ85sWGbd/QSECsbMnDpZ834yd209lGnkaEGvSvf9943tFDyGdBnW
         mX3EI+m4E56T612cq93O/pTCPdfz5hiVPzpf1is61dDJzQAUbS8jtocFRwBnrk28mC3X
         s+aBZWWEuOcU84n3GY7KWtIqDxbvzTV86DciM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5MhYel8I9XAiPqOLLMra3q7chW/GxltXVDG7bvWIV4=;
        b=gqBfID1+qWlyper7aWP2NrKSXm5g0at3Cm12zgz+xiQWOYZYfnS6TEPUNBQKN3ij1o
         Qf2SAd3WIe+dfcArPpML6ngF9Kyue+v30K7rwGywNWARg/vtI6Etqnq+YdhuLXvsayID
         TYVCTsi5/Xdkio9kIuKPklwReqweDcjw90P95M/2bnRap6qFP5HReNjdGMOksM5QWE+r
         pliWKJzcJOGcR5buAxfh2BWtvMmUwCzKOiDDQLFOORFRIWetUQf5s1HhLCv2vVpb6+SJ
         h16LGgJAYkZsD/SHLHi+rqTSd80E538bQI01sR/CtGUOLTIynQSCVlIveihJbmwDAu5Z
         lFNg==
X-Gm-Message-State: APt69E0m35fEyNHOa5tP444SOt5qvM6lflpIXERWWeN8AkF7WJhl/Ycg
        kXe9d4tLTQ+kLF21Q7aIahqh1/+N1XxP4vJ15FPiAA==
X-Google-Smtp-Source: AAOMgpcfXmyVF7Pe9X4ggrj2ey5jGegluM1zGfxxLRpO5fmbIe6/V2ZQS1nR0QKnSY4hwC2t1Gq6pDiTh8YV7Ed7WSQ=
X-Received: by 2002:a24:8989:: with SMTP id s131-v6mr1496727itd.70.1530274649879;
 Fri, 29 Jun 2018 05:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:17:18 +0200
Message-ID: <CACRpkdbZd_Dj78i9-f1dkNrL8EH6GPrS4TDJXViANn2=SQf8CA@mail.gmail.com>
Subject: Re: [PATCH 1/7] pinctrl: mt7622: fix error path on failing at groups building
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> It should be to return an error code when failing at groups building.
>
> Cc: stable@vger.kernel.org
> Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
