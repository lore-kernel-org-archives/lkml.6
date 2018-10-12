Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E0C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913D82077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HzRdzh6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913D82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJMAvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:51:01 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37697 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeJMAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:51:01 -0400
Received: by mail-vk1-f196.google.com with SMTP id y128-v6so3157775vky.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kHhlKky1rm4zibnv29GzmfKHWwRn7IfGvLksAOdXcA=;
        b=HzRdzh6NTEo4k6cRq+5387Ki8We2lNOKY0kx00WQRSyZOJOs4XoE9dEMYRtFaUQELu
         9TnoaHJaQLfD7Y1dULFu95opuG/WoRjSC1HcblNRZOVDLvsXBxtkiK2OJSvPdw+4wMQF
         prd4sYQlJS9dzfGzkWxFWsNqbhqTl4nbbVTCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kHhlKky1rm4zibnv29GzmfKHWwRn7IfGvLksAOdXcA=;
        b=WBUBCxjjZ56EBqydkVL+73eDzTRyh9DMB7Ba3OBuNBeZuAKWjF3g9nB1fkjmPSr1n/
         4palr/9q4ebxJDQNqEWu8ZLVTGpiuY54JoX5PUuhXPISljKo2SxJKswVmSQp6hurJ4fz
         XlYVwAo6V9xcIMdbewdu0V6LCZ69Vin5o33GDsaAmQVQ0D5ggqctSoz/4wf6YvYT1my2
         hjj3Ya93ctUfqiPJUqRxmNoGwDwxbDZQNc4KzuclYKKmzWpOZstkvJsw07sO+7p6jb8u
         2/m0yDWfqgtrsX7LBGlp4fv2ONnuxKJrHHq9Lyh2+C1eSe1DVCObozYsdHK/YK9YyQh/
         czVg==
X-Gm-Message-State: ABuFfoiKZPHQ/7nNsIBC0rrtf+14RvNpkOn22aD6xY6B5z16KyG+5V1s
        SSrFrJ46cQAcmOrYrGI9pMplOBfTpP0=
X-Google-Smtp-Source: ACcGV619eeGAhoCOKledDUdc/ZhxuHcHTFIS55d48laXBV06E5rqx+q/q1Cx85JEZozqcYwqX+fIlQ==
X-Received: by 2002:a1f:b995:: with SMTP id j143-v6mr2853507vkf.88.1539364651445;
        Fri, 12 Oct 2018 10:17:31 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id w131-v6sm305830vkw.33.2018.10.12.10.17.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:17:30 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id b65-v6so3161844vkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:17:30 -0700 (PDT)
X-Received: by 2002:a1f:56:: with SMTP id 83mr1346903vka.66.1539364649895;
 Fri, 12 Oct 2018 10:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181005090920.26108-1-mgautam@codeaurora.org>
 <CAD=FV=UgFBzUzjqakJp2OCoKVcbEksrv-QrQ5-303ZqTCfv=hw@mail.gmail.com> <4f1adeecf61643fcba4202be1c520561@codeaurora.org>
In-Reply-To: <4f1adeecf61643fcba4202be1c520561@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 Oct 2018 10:17:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJsBz1-tVyX2uChoKVrb54W3JD-3rCoCyhVcbuuXi0Gw@mail.gmail.com>
Message-ID: <CAD=FV=UJsBz1-tVyX2uChoKVrb54W3JD-3rCoCyhVcbuuXi0Gw@mail.gmail.com>
Subject: Re: [PATCH v1] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value
 for SDM845
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 11, 2018 at 10:57 PM <mgautam@codeaurora.org> wrote:
> Fused value is supposed to always override. If value is not fused for
> some
> parts (which I believe is case with some early samples), then driver
> will
> read it is '0' from nvmem and should use hstx-trim value passed from DT.

OK cool.  Just wanted to make sure.  ...so the fusing must be written
after the SoC is placed on a board.  I wonder if it makes sense to
document this in a comment so I don't ask about it again.  ;-)

In any case, once you've got the patch split in 2 (and added the
"Fixes" tag to each patch) feel free to add my Reviewed-by tag to each
patch.

-Doug
