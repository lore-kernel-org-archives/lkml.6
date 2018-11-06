Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFCCC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CE120882
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdW8oIYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CE120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbeKGGMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeKGGMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:12:09 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC25C20892;
        Tue,  6 Nov 2018 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541537106;
        bh=Xoirapa1MKGkHouc2tMrbGHwQCok2cUCTd4hAEb4Npk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DdW8oIYpYR5olMDAZGaOjIGLnbEQ+LBo5jKN6SwO2PmJO9pJiuhroHNAcyeKTIWHP
         TuFBqu82INd48eSBzsnJGwIja1u7adAa8te/ayg2nMXsvb4HLsAUBFh+bjk8cv2XmO
         Mfoe+VURa9ma3X6ejM8IxSHVmJ7k/qjIo1PskR2c=
Received: by mail-qt1-f170.google.com with SMTP id k12so4266984qtf.7;
        Tue, 06 Nov 2018 12:45:05 -0800 (PST)
X-Gm-Message-State: AGRZ1gLnN7ghowXsxSslnsjbJYuUUmk1xqBkfzd/NrVbiH43qDH9kAHW
        wxxLL+Azq1A/sV6ztIsTc1QdGx9xd2I4QhBvNA==
X-Google-Smtp-Source: AJdET5dw+CfR2bqwM6ZIRZ32h9oGRpbl1UHEcgcMlzAgl6nFIML32gV06cFqKltejf+4kh6fx3srM17Ln6OAeRMIGOg=
X-Received: by 2002:ac8:2d35:: with SMTP id n50mr26151215qta.38.1541537104981;
 Tue, 06 Nov 2018 12:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org> <20181106183609.207702-2-sboyd@kernel.org>
In-Reply-To: <20181106183609.207702-2-sboyd@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Nov 2018 14:44:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
Message-ID: <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> We have a handful of clk drivers that have a collection of slightly
> variant device support keyed off of the compatible string. In each of
> these drivers, we demux the variant and then call the "real" probe
> function based on whatever is stored in the match data for that
> compatible string. Let's generalize this function so that it can be
> re-used as the platform_driver probe function directly.

This looks really hacky to me. It sounds kind of general, but really
only works if we have match data that's a single function and we lose
any type checking on the function. What about things other than
platform devices?

Rob
