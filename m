Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D276CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF89208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ilWXP9IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF89208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935909AbeFMX21 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:28:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46193 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935725AbeFMX2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:28:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so3967188oig.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McjHYn3eMKJlbuVj6wv3QmYsV3HSW1nV81lj8HGGZho=;
        b=ilWXP9IRVOrDAuK3rFFqgUvfQD3KiY1zolVdp+onkMnvt1HcJv0d0a6P5yWuUo5N6Z
         DEiroSDosb+Xjf+LJ9JlezvQMaGUWifU5rWkssttWUcONEOk5JsgYSHcKHIMuPQdpktE
         /6wuETmDzegW93N/Xwg4qazrvB1qm13rDXv9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McjHYn3eMKJlbuVj6wv3QmYsV3HSW1nV81lj8HGGZho=;
        b=jWgdEp+SWx+Cg2yFr5KY/ykvGgdc6PbbMABbfQjnfJ8VukJqdNhFtM98HUROJq75go
         0lL7XhdKMi96nwZFswdwlKhGfgMNTNt13qL6w1VBZsQ3qRSJWgfnQZJitR82iIN8dk19
         Kn30iAxlIorvJdpZ1qKGTrN1YynNY4N9DUg689Fcl2c3UM8aYkH52xIpMjWRAYFeFDke
         iCRM990l5ptYRjKbLcXMaOLQavhVFVwrcjTYMGjCkSo/lOtH/NXkJSwMsBYYilLgdsWK
         6dZu772iYbYpy4m3JS22jV8Wx9KnNbxYrnxZKow+++T3hPUDvop3Cj88k7hhk7c0Rx17
         R2ng==
X-Gm-Message-State: APt69E1boyo/1OgkS3AQy4lX+vaxLJxxOzj9VtXt/UspP+WaOcyibI8K
        2k6G7CaiYZfjWHvo1ydhFPmcBjaeLCA=
X-Google-Smtp-Source: ADUXVKK774gdW6RhJLPF72a+v2uhkPJcMQG0Cb2LW13i4426OfhAp3vqw6fljRACSuGJJO0KhnA2Hw==
X-Received: by 2002:aca:30ce:: with SMTP id w197-v6mr118971oiw.264.1528932504951;
        Wed, 13 Jun 2018 16:28:24 -0700 (PDT)
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id q7-v6sm4415629otq.39.2018.06.13.16.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 16:28:23 -0700 (PDT)
Received: by mail-oi0-f53.google.com with SMTP id c128-v6so3969231oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:28:23 -0700 (PDT)
X-Received: by 2002:aca:ea44:: with SMTP id i65-v6mr105497oih.266.1528932502516;
 Wed, 13 Jun 2018 16:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180613152054.54812-1-swboyd@chromium.org>
In-Reply-To: <20180613152054.54812-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 13 Jun 2018 16:27:46 -0700
X-Gmail-Original-Message-ID: <CAE=gft4dFqR+hxLNsAVT6QZPuMMvV7-K-x_w8YXQogh5N00n7g@mail.gmail.com>
Message-ID: <CAE=gft4dFqR+hxLNsAVT6QZPuMMvV7-K-x_w8YXQogh5N00n7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add pm8005 and pm8998 support
To:     swboyd@chromium.org
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add basic support for the pm8005 and pm8998 PMICs. For now just support
> the GPIO controllers.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8005.dtsi | 33 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 55 ++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi
>

Reviewed-by: Evan Green <evgreen@chromium.org>
