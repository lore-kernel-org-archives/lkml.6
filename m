Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD85217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DjoT86zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD85217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeHDBE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:04:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41421 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbeHDBE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:04:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so5173050lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4d9Y/03WKmP4gHweBCr2t4WPOPu3CeSC6vWHp8pMtU=;
        b=DjoT86zd/ki1Z4ej9wdHTlOT+mfqIIZFx6VcLabcqZIu+AYCqVBeIza2wkr9Bnyib8
         c8hItY4NsVmvPP54BDwP+qXvJQQRihpHAb8Ot/jtyc7KEV+6QxjHAV4Dvz2arC50k9fa
         FhDwCwmdw7t68mmlz5rOQZW8fjlI/OCcxWFFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4d9Y/03WKmP4gHweBCr2t4WPOPu3CeSC6vWHp8pMtU=;
        b=aud80aBqNCThfb6GrR7nma2Dz9hAUWq72rizmYm9pH+YcQHZkPhNCYC2LV1a6P0EtC
         Z1YRlXc1jpdhyufS98IrOiF9qbNZNC1wW8dvGqziC0RDrHV/ucgDnvvtdoRbTflO2yXY
         h3rgVN3tRI/P998u1p5/kQT1R1TVmrb1kK3UJCDyzD9uEJ901Wg8M0J+roBcwur5gSvQ
         KLYJQ0JTUMOB6eHRUUtPOjgoW298KQQTPm8tHYrFDgCA5aY7ssqS1R9KZN3GFgUYYTTK
         Bl9HXlt4iawCKZNPy2IqEzFfZHWNULH9o3AyE0iFlRLF1p8yeC45XVmfH3EJxsXvK53u
         3pQA==
X-Gm-Message-State: AOUpUlHWGymrYLbS+HgqQOmn9+G9R+AlBNxyO75s1mVc69LU2rxft2Mo
        Lj4xPeXbtH1ZT0mOMO3cEzA8TS2hzN0=
X-Google-Smtp-Source: AAOMgpcPNDUEwe4hib1H2XkPaisMnGAOxuHVRjubPRMkfAGz6L8vbUcVBfN5Qwx/97lrikyC7l67Ew==
X-Received: by 2002:a19:9403:: with SMTP id w3-v6mr5641777lfd.29.1533337564760;
        Fri, 03 Aug 2018 16:06:04 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q65-v6sm923183lfb.80.2018.08.03.16.06.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 16:06:04 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id f18-v6so5195039lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:06:04 -0700 (PDT)
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr5654580lfe.33.1533337198997;
 Fri, 03 Aug 2018 15:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-4-georgi.djakov@linaro.org>
In-Reply-To: <20180731161340.13000-4-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 Aug 2018 15:59:22 -0700
X-Gmail-Original-Message-ID: <CAE=gft5Fkp485u6NVDf_cOfxmUgmLM3KtoXZHe0u77o8nFJLmQ@mail.gmail.com>
Message-ID: <CAE=gft5Fkp485u6NVDf_cOfxmUgmLM3KtoXZHe0u77o8nFJLmQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] interconnect: Add debugfs support
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add a functionality to provide information about the current constraints
> per each node and provider.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
