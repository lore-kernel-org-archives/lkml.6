Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EB02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="avinJzaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EB02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJPPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:53:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43474 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeJPPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:53:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so24610593qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGqYEFuYydMfJDrfrs+i35KBtz025jOyZ9H6FEIV+uw=;
        b=avinJzaqoCHvlzTV29A/9j3SH5jn4HTmQRe6+J7c42A7RFt/urxaiq4u6Rc9ZChobp
         4OkuROkBDL94s2fop5/9A+0K8TL246o5vGoSEAiyxHDJi3KBiaVqk5uxmJED5v8hk7RT
         XCThgyH0CeqORFL1rrHs+fsRS74tB63tu0AKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGqYEFuYydMfJDrfrs+i35KBtz025jOyZ9H6FEIV+uw=;
        b=Vbvk9aV69UuVy2W/OrwCTRNWl45OeoGrpVEoD+YYj1vFACdQ3xFAMZf0HLotxCNjEW
         T0y2vsCeffjXq8R1YGusNYlqF1BFeM1nHbjC/z4YALBAiWaBUXL9sZZDdtNVByWvhy45
         LjUjUeVrVDW3HyzJG9IfAR/ogxoKQMvxM6T0PmVfMq9x6w1JYoSyCul8tacDor3bOWUx
         SFYtZUrSD5NI6qenIeSa1DWRRAdcLfI1fiO2bj9oL/d6QH4LbZRwYMA8yg5vtsf5FidH
         CdwlMMO/ApFGtcThnbZkay4WYW3adDvfv/F8Vp4sKx3bnGqtt/3DyA7qgT0MgYEL6oc9
         3Aug==
X-Gm-Message-State: ABuFfojXBa3+HJQc8ro0hBsh4pIfC7uH0YDkX5CV3ZCIzqEnMOJ9eLgs
        SQKBc7QlnPmdbo6MwT1q81LdFmxXpwdQnOsQ9He5QA==
X-Google-Smtp-Source: ACcGV61D9euALEOUFytNWhMhEKo2nPcpvYZeQumJQ/NpoBJKv+PmPtdMsWNejIu6p965EDgFoQSQ5ToVk95gSpmc21w=
X-Received: by 2002:ac8:1bf2:: with SMTP id m47-v6mr19730639qtk.234.1539677076427;
 Tue, 16 Oct 2018 01:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181016062228.19472-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20181016062228.19472-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 10:04:24 +0200
Message-ID: <CACRpkdYFjz_9mvvikCCdpJh=6S8F-u+kuJ3n55brA8e7wPhHtg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Fix a memory leak in 'sunxi_pinctrl_build_state()'
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 8:22 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> If 'krealloc()' fails, 'pctl->functions' is set to NULL.
> We should instead use a temp variable in order to be able to free the
> previously allocated memeory, in case of OOM.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
