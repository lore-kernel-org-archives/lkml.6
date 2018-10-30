Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59884C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76DD20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B78OY2Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76DD20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeJ3WSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:18:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39080 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeJ3WSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:18:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id n18so502041lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAHcFRhWCASuk+GafXuZXI2GQUHxPHDvTdbmmtnN4DU=;
        b=B78OY2Ar8kMErJiIF5b1qPqV8v2DEs7wRgI0Oc+usqnYoYwcJOEghq9oYBYkDH9jpm
         V9GiU0+yAPBrhTdMQvrpU+DH2p6zll71X7Bp/ub51iyv3y2IIRVnjNdRs+jBvQs+cDUB
         q8RzqdU6fGWj9uq+3tWsWXc/y3HRbfonyRprQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAHcFRhWCASuk+GafXuZXI2GQUHxPHDvTdbmmtnN4DU=;
        b=EyTwcmB64ctVYlnCgDDa14tgvqqes/ofLgihId0AbdcgRJH3IihvkjbhXbkoRHn94T
         kqT0Bvw8hI8r+sjLS8igC1Z7PdRK5EJTxvHDM6ITM6CJnqVg//olDBUXLDZxC39vRYqG
         E7Sm8/xorqLuWnDF2BHq6OyGx0m2I0FQd19Mo2jrUynQUScVxZaTzLfNdXGYmEftBjHB
         T++Ytop62OpxqF67+ft1eRbG+DFmNgev4PWD0yasMHwqUZijHNPHBTt0dzxC4OSjsd5+
         XmMg/KAnyv1datFFS//CnC3sy+GgwFGEiqJjkPLvCyEmpeJlMDmV/RfFdMFp1qSY+Jdc
         OYDA==
X-Gm-Message-State: AGRZ1gLhqej5bAJxNCS5oTWLw7bXnsFAKNLuWHtwV85xFCCru/SztAaI
        8K8dMG3xs/CAQAcnzvahrkGdDenxzGvz8XsHtFwgCQ==
X-Google-Smtp-Source: AJdET5cCCh1lyY6lIwLe2uVaGunpJcIHueiQtESzGcQHT/m3CgmhvKr9BS7CRzzWsxDGvVsLRVW99VdOOgOCpYTBR2w=
X-Received: by 2002:a19:f813:: with SMTP id a19mr1848602lff.67.1540905906817;
 Tue, 30 Oct 2018 06:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com> <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:24:46 +0100
Message-ID: <CACRpkdYVa=0JOkRT=sm-eB+NSMGjHyWAzzZrc6UY8jdYRpuOtw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: pinctrl-at91-pio4: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied with the acks.

Yours,
Linus Walleij
