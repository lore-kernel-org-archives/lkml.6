Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9CC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841B22148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlD7pH47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbeL0Jnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:43:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44354 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbeL0Jnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:43:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so15768773lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ft+oPhdhSv3FR2GIvMb+uWaKkRRWCfgxjkoYM+jDTHU=;
        b=DlD7pH47wSvQDgEQXAJI00aCiOzF7JZO5u36HnvpoXWeJwXddfamL8nkLz1Qh7RxBP
         xgcKjLdRZra2oZEUEoF6MAs/1UKrGgE8/E5BVNWfxLUkh+2p4GjMa/O2KmNrUPdL0jql
         zeP1Dch7bgDYzJhK+d3nwkeV5SZXsQcIC+eNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ft+oPhdhSv3FR2GIvMb+uWaKkRRWCfgxjkoYM+jDTHU=;
        b=dMDRQsxGG/kd1xEL3JBwxkNB0b/aDayjNi7QPxCG4QB0j08HdZ0+O28x+vEWF9NEY9
         JyZrxod9lD7JQKSw3w17R7HtsZjvn7h67bsu9nQjEvGU5fIii0XJHm/IAJ6tlxxBn3jt
         beS08fdcfAV50y54yBSlNLGs0W9YhuiggfROaSjor45meNQMi9UIHhWNvsmJ/hrogHWw
         dqtF/xQF6CHDRwQcLd4Oea9qPMY+KuC2geYd0j7cjkbf81sSNZ311Mol9295IGa7Eejj
         hLf5oTpR+njOodYiVXoCGjEeZazNn9OqY69OD8rQdzFM1Nl8YYF4P65BPCNNt4zOWFyJ
         ZdLw==
X-Gm-Message-State: AJcUukcuPiFaw28Ks0qB45WNMeD7P/xuodLeBEpi3tYw2RKyhbwajWUy
        6L/9PlpP8FlqbYRIqd9tTTT36ohw21OIy5Vdzwvkmw==
X-Google-Smtp-Source: ALg8bN4AaiiRY0EtKBRNIFxYKF8TkcZwCTQwSQQMaTrAvzFGItE4nKgNeXW6cH24iYCyA7IT5/LCNd9SWQgKaC4G6J0=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr8447228ljj.120.1545903820308;
 Thu, 27 Dec 2018 01:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20181226024333.72236-1-kjlu@umn.edu>
In-Reply-To: <20181226024333.72236-1-kjlu@umn.edu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Dec 2018 10:43:28 +0100
Message-ID: <CACRpkdacqJAuQoCad8L=k_R_Vz-WAc29J9DdV-7jbJDrb5ET=Q@mail.gmail.com>
Subject: Re: [PATCH] rtc: fix a missing check of clk_prepare
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 3:44 AM Kangjie Lu <kjlu@umn.edu> wrote:

> clk_prepare() could fail, so let's check its status and if it fails
> return its error code upstream.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
