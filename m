Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A9AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBC52159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Joz7NhqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBC52159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeHXLND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:13:03 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:33073 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeHXLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:13:03 -0400
Received: by mail-it0-f41.google.com with SMTP id j198-v6so4085704ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMP/IMKd1TQD/Htf8WDNsvaSBjSvmYtnRmt7QoVRPlw=;
        b=Joz7NhqFFM7uqSGzFuBptZipL5BT7T47Enp2PWoXO+FXBTc/CeXuuhaD48DAgOLkHM
         lU6fMn4RLFN4iTurRs5AhEzbBLDRCwBFMhCbjaqHD2LuufAzIFSSRbvW0HkFU6QAIFJy
         n14bCOx7c5cjNqkZHOKoFuIebjUO1uGgHSPTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMP/IMKd1TQD/Htf8WDNsvaSBjSvmYtnRmt7QoVRPlw=;
        b=QQhAml3G9YyFDdelXlJ5Rf2JPgeVWaNWLtxiRi5NYZVNIrTA7OCmnDGGPBSRiRDL6E
         qEBvvkp11hhlGnGcEhTkjnUGXT+oPspMTZkN+jZC5RQ2pydo/UE4a4ZBQ2Sz/q9IZ0O2
         QLBlyY2yB0QBuNLA5K62FSYDJMEyaIH8mL+etOdqJPQ3Ph9soKQKTcpm8pdUiSW3j80P
         MuvyzhYGLC+IHZF81AVPZQeH9JnArQYkSoz5GLb2jk25V5OaLwxco2x6zkJAzYw5bysO
         dcSsmcrAhVmrkGz6NlwSCWSi0ygR3MIOGlpCcDn16HcPJ5ZXMghs5VhlZERRFUaT6A8A
         UFzw==
X-Gm-Message-State: APzg51Aq96XQ2oziA5mGPHx1y9nc38OOf15OvhCPdLHwOk/j0d/Nf4Yv
        ZxoYgZRv+K6M/G2jeOsRKfrO0DFzLJJ1HA==
X-Google-Smtp-Source: ANB0VdbiKBkxaNWO5ty7uIURjY8oyVKsb0ex2IKiKVzSxLy531ckMOe4vNRVfn0UiQR7GgKuYjMTjA==
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr393451jaa.19.1535096379109;
        Fri, 24 Aug 2018 00:39:39 -0700 (PDT)
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com. [209.85.214.44])
        by smtp.gmail.com with ESMTPSA id j78-v6sm296414itj.44.2018.08.24.00.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 00:39:38 -0700 (PDT)
Received: by mail-it0-f44.google.com with SMTP id 139-v6so956221itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:37 -0700 (PDT)
X-Received: by 2002:a24:dfc6:: with SMTP id r189-v6mr549768itg.36.1535096376765;
 Fri, 24 Aug 2018 00:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 24 Aug 2018 16:39:25 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW8rxj7SQLqKV07CQjjJth7b6iBT9bH8XYd3chtiXcKnw@mail.gmail.com>
Message-ID: <CAPBb6MW8rxj7SQLqKV07CQjjJth7b6iBT9bH8XYd3chtiXcKnw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Venus updates - PIL
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Hello,
>
> Here is v6 with following comments addressed:
>
> * 4/4 from earlier series was dropped as .probe was not needed.
> * indentation as per checkpatch --strict option.
> * tested on Venus v4 hardware.

I have tested this series and it seems to be working fine! Thanks for
pushing it forward!

I have made a few comments inline, but some may be difficult to apply
without reorganizing the series a bit. If my explanations are not
clear, I can take care of submitting the next spin of this series if
you wish.
