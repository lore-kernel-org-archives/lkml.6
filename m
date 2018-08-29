Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840DEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC1C2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KY844Mca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC1C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeH2Mic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:38:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50302 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeH2Mic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:38:32 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so6566578ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXHMdfBJhx5/rxI+0wcXEaIV8eQBszm+HyaxT+llzqU=;
        b=KY844McaQDqK193e0fMHz8QhfFk1OrzYtcXN3iqjHev3bbS6WlGWWw1Jw6jKB99g5P
         ToMY2eadGzWj+/7buebfjmmCiNrB6syshl39XQegcQ/T0uhaQwRl5HTFXXC6iJZUIGhE
         OBeGfF1Cjx6s3AsLFKZqDnnabg18wbB5FY32I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXHMdfBJhx5/rxI+0wcXEaIV8eQBszm+HyaxT+llzqU=;
        b=CA4mONv7xdQTaAyP3mnpG4ZEXDk0U7AGZurBzoWR3LDJIB7NTAbZN9t8+I8snfMqcm
         6pJoYZTZKMt0bNf6kGExejXbf0Uy60n/ua3vuiFVYb7W11yX/bfsW2WzWA9vQdcv/YOO
         0SHcsWwLPP8xtbr+4qSpinihAya5pWTCNe0RVJerwU+tjOyBrEm2sx8sXNT/HY0HIZJ1
         vrMG6nKAVqcR51fBWwBAplDpiBYJI7u2n4EyVSyv+ez5kVljcJhePAu6+Q78kxqJbrDU
         lCNqVu/Y5yDFbRXKkToVNbTSi3Qi94wbVkdJBpKi30YFsJ7HVQ9hVeTXMrexVGTeD+/Q
         KP0w==
X-Gm-Message-State: APzg51CHcE47FLaUQjmDrHZs3TjzH9B44fir+gsMSNk3w0j6yjCf1qpo
        IIzphMxJ6HIfcqCBPasciuo8BW1OwyYZdoKQRJY2vA==
X-Google-Smtp-Source: ANB0VdbJTX+MwZWy4yzq6quUYXgcj2//upssSJQ2DHHF1dtUmzEVXsTIZ1cWgi2XwVU1QEp/ckJsxmkmlTCc0g8ZPGQ=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr4307425jab.113.1535532162731;
 Wed, 29 Aug 2018 01:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180807093226.5624-1-rf@opensource.cirrus.com> <20180807093226.5624-2-rf@opensource.cirrus.com>
In-Reply-To: <20180807093226.5624-2-rf@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:42:30 +0200
Message-ID: <CACRpkdbxR0OgYfNz39_+koRfJF_hV-m=t1xYERG9wDAhRbr5rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: madera: Return ENOTSUPP for unsupported pin attributes
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 11:32 AM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> The pin_config_[get|set] functions should return ENOTSUPP if
> the requested attribute isn't supported.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Patch applied.

Yours,
Linus Walleij
