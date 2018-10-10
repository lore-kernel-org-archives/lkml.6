Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A2C2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUwvb8D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A2C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJJPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:51:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35188 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJJPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:51:20 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so3274202iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4q6AUe4sn0mFhuFPN6zYhh2v/khQgoV4JYyb2ywtspE=;
        b=MUwvb8D3vqZa9P57163URj/X+Mxn5yklwu7vKzFEWqVAktt4FLUxt8s3Yel+Lo56MG
         V2NuGfzF2eVBzTc/FVCo516iM7uI2UmppChBLarhN9VQJODKJd95Pq6sP9O7DlMCg4c9
         AvWUn2KA2pfv8jTgDIDr1t3i3eeg70skIKqQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4q6AUe4sn0mFhuFPN6zYhh2v/khQgoV4JYyb2ywtspE=;
        b=pZFczIXMPJqsooLSP6aOWivHm2JFmMAj+tO6a8/spDmcY01TypTL8mA31sAXLzlyey
         NiaOylOwIuVbzaMPzf1b8tkVPWgvE6Af+FNEHV6IoZPrPUwdPfbS/5iz5sfHKrhOHgaZ
         XR6Du9GpP5UsUR+uShZBizMuUUudkTjgLJMY/QRTDaxgbSssrh1o0ndN4khjPRf/01Dz
         3PxO4K5fFaX+cm/JSSKIFRpwlXUY3fuG0G7WkrFj7mwyuDrxotjzVqM4WH3N+3/56HgS
         xUJnqyZzL0uTABF7DyJQ9BwJYIv4cDaU5SuGr12HU2BXKWH3U2Q2NVQChaN9ODK83W1X
         A6RQ==
X-Gm-Message-State: ABuFfojVt2TJkgGv6j7wN21kCo2I28ewus3fw9il//GZlS7t+neAe7C2
        uzkNdTwBXUeSTbtczTBSE81rHbdK5cpx2a/d2Vk7FQ==
X-Google-Smtp-Source: ACcGV63L9Ke8H0uXHm32Koglj47ad21yLbDcN4n1GPLBoMhC+k3GmFQ42Xp2CqEIyY2XQeqJVqtK2kf2O+yDqYJbkMw=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr15172145iog.175.1539160215626;
 Wed, 10 Oct 2018 01:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com> <20181005065300.22882-2-ricardo.ribalda@gmail.com>
In-Reply-To: <20181005065300.22882-2-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 10:30:04 +0200
Message-ID: <CACRpkdaH4zBj9fpWw0KfviF-RPuw5rTLDn5pCNFBdW92vVM+iw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pinctrl: msm: Use init_valid_mask exported function
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jhugo@codeaurora.org, timur@kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 8:53 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> The current code produces XPU violation if get_direction is called just
> after the initialization.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Patch applied with Timur's ACK.
The code makes perfect sense.
I hope Bjorn has no reservations, if he does I guess I have to
just back it out.

Yours,
Linus Walleij
