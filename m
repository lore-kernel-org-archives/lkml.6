Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49770214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBOEQdyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49770214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeISNWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:22:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35167 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeISNWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:22:53 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so3739629iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiXtr5fZL/Y3zAGXyySg6WYsq8BpqUUyK2qzhtBZOwQ=;
        b=nBOEQdyVfmw7k47I60y7bMqtOK12zGUd2jqMhzXU6oYovkvhNjsmNZB5VPvO7uL37S
         yvXomu2Doyny0uGPsdFQhR8J7jaRIwbfTl/SaaTAlkCVE2xo/Oddx1ijA4y4avrSOZOH
         UQQtW8Zv7jN7iJcdzJdR0Nfz9ZNwiF1DjaUys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiXtr5fZL/Y3zAGXyySg6WYsq8BpqUUyK2qzhtBZOwQ=;
        b=UBq3G8ksl7+98/P+BKZ4DX6D2mc4MDTv4YBkCBOdxVWsUJC0ztkYtzfLU9bxe4tRTT
         p/CJC+G6Lvb57adl0w8ePIYlK8fxdqg0HrShfPMe1wyAn2MX7UhQ8x3jEtePOwOVlWFz
         lLXLdL8No0nVhBJteCq63IUb59ie6EKn3VYCAYx/AmiZKusgqEqD8BiYpUJYtzt1mWVL
         ubVTJwFJrVYyVdJj41TqX/UDp0y4rRcA6NW2Jrx9T/WWtEqjU5khKkTcOoSdbND6H406
         BsQho2v5yoJlW70tdF+9OgdnpryzXgPKb0ji5oFvpBCA+LescN1tPNeFr7idujkpoMpN
         1o5w==
X-Gm-Message-State: APzg51Dp1A4XMahhXfWo4EWC2pmNFLZz+bX8X6sjFjT1yuaQrdTKZsu4
        azwNw2qc05jurkPd8pfmhir3AXk2ofhPyQ==
X-Google-Smtp-Source: ANB0VdaE31OQez8Wv5ESK30gQZekDwsLUr0UkUNrTZtXD4grD7FAXdOLslm0f1mo0dpVmE0aQE1u/A==
X-Received: by 2002:a6b:5f12:: with SMTP id t18-v6mr21107529iob.62.1537343172068;
        Wed, 19 Sep 2018 00:46:12 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id p125-v6sm5669327ite.17.2018.09.19.00.46.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 00:46:11 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id 75-v6so3704205iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:46:11 -0700 (PDT)
X-Received: by 2002:a6b:2387:: with SMTP id j129-v6mr27269381ioj.86.1537342736840;
 Wed, 19 Sep 2018 00:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <1537307954-9729-1-git-send-email-vgarodia@codeaurora.org> <72fb5d7d570c7f5520cc304bea800ae6@codeaurora.org>
In-Reply-To: <72fb5d7d570c7f5520cc304bea800ae6@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 19 Sep 2018 16:38:45 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUk14W5hAM=h5rrZF+8w8RnwpNrBya+BPQ+TPdRp_834A@mail.gmail.com>
Message-ID: <CAPBb6MUk14W5hAM=h5rrZF+8w8RnwpNrBya+BPQ+TPdRp_834A@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Venus updates - PIL
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

Thanks for this new revision. I don't have much to add, apart from
maybe a few suggestions to make it easier to follow the "story" this
series tells:

* Maybe the no_tz member is appearing too early in the series. For the
first two patches, we still only support loading the firmware through
TrustZone. In patch 3 we initialize no_tz properly, but still cannot
boot without TrustZone, which creates a state where the driver could
parse the firmware node, but would still attempt to use TrustZone.
* I feel like patch 1 should be merged into patch 4, since the
function it introduces is not used before patch 4 anyway.

If you agree I can maybe do the v9 of the series to address the two
points mentioned above, unless Stanimir is already happy with the
state?

In any case, this is doing the job, so:
Tested-by: Alexandre Courbot <acourbot@chromium.org>

On Wed, Sep 19, 2018 at 8:45 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Ignore the v8 of this series. The code that was modified was added to
> wrong
> patchset while handling the git rebase.
> Please review the version 9.
>
> On 2018-09-19 03:29, Vikash Garodia wrote:
> > This series just fixes the compilation for of_dma_configure.
> > Minor #define name improvement and indentations.
> >
> > Stanimir Varbanov (1):
> >   venus: firmware: register separate platform_device for firmware
> > loader
> >
> > Vikash Garodia (4):
> >   venus: firmware: add routine to reset ARM9
> >   venus: firmware: move load firmware in a separate function
> >   venus: firmware: add no TZ boot and shutdown routine
> >   dt-bindings: media: Document bindings for venus firmware device
> >
> >  .../devicetree/bindings/media/qcom,venus.txt       |  13 +-
> >  drivers/media/platform/qcom/venus/core.c           |  24 ++-
> >  drivers/media/platform/qcom/venus/core.h           |   6 +
> >  drivers/media/platform/qcom/venus/firmware.c       | 234
> > +++++++++++++++++++--
> >  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
> >  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
> >  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
> >  7 files changed, 272 insertions(+), 43 deletions(-)
