Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C06E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550592992;
	bh=STKn35xmsWYhEVYwcDqaRtUehaNhk+Of6+YHjunKDYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XDulxf1zwEdkzdM6PcqXrt1EFfP+J80qxBJPxdHQ1qyiXFPKrQitWWCI5LcJP4sPc
	 xG7biti3aSZqZ+ZU8BoXu+wg30bSsOYCv1d3UcTRRfnjtWIG6MFVfsCJywgqkxdaEW
	 gIVhZALluIWKx0/m04XswU6N/hLf9F1ArfdaRsGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfBSQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:16:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41284 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:16:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so18684671otk.8;
        Tue, 19 Feb 2019 08:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rBwqJIhj7nAqwKM6FOimUnzEHMkrOlGJ8xKKa4+T6g=;
        b=b/H2RVTdChZo6mC/vbvXFzOJyPVuIvQF2V+he82cZNmueiYKFoGsMU+//RK9oBgpOY
         kbfjhvhaybAd5gQ2Kac2414qWRnCRY1d11JIjusBooEDqrQRy1T6Btwt0DPeAbjecTVT
         gXg/rGja3dbNm7t3Hd9CyKoDvLn+9jWGLFVdNitKi9/m4Bb7bJuu1YvoaLYEFlooMtsX
         88SjmcHznS5hmNYothFlDMdlac+3Lb/hOg+u0Hoy6W2X21fi7vRpfv0f303YeA4dW+Y3
         QsdYYhvuD64pwLF/WwBpGk+XGbpjsVJA7yZp1avfGgRN8yViW8CQ0MEiVIbqXTSVqPKw
         UkZg==
X-Gm-Message-State: AHQUAubsKAXer9sccVBzHLae9L0jlyMwBx/bTQ0bo9EHHvGBhubCskvj
        tFlnwzfcVKImYIicuqC0gUQ5OZhCh5S6HmzCR84=
X-Google-Smtp-Source: AHgI3IZbmB0zMtZar5IkvUE4VSgFjWdcTM9jMEFaDxX9/76KBtAzezXaYKutjK3MNGtE4BRkOo97hPpdnWpjybTCJFE=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr18760036otl.343.1550592989931;
 Tue, 19 Feb 2019 08:16:29 -0800 (PST)
MIME-Version: 1.0
References: <14371356.imFjPFOrCi@aspire.rjw.lan> <CAPDyKFrZ8Miy9A2wFksJLxePk+O05NtEmf58Q-8BqDdZ7kL7AQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrZ8Miy9A2wFksJLxePk+O05NtEmf58Q-8BqDdZ7kL7AQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Feb 2019 17:16:18 +0100
Message-ID: <CAJZ5v0gm_eKm4FdJUbuwaZwxoWWoHk0BwH25tpQj+9xrgV7zuA@mail.gmail.com>
Subject: Re: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added
 during consumer probe
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 1:10 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 18 Feb 2019 at 23:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> > counter imbalance") introduced a regression that causes suppliers
> > to be suspended prematurely for device links added during consumer
> > driver probe if the initial PM-runtime status of the consumer is
> > "suspended" and the consumer is resumed after adding the link and
> > before pm_runtime_put_suppliers() is called.  In that case,
> > pm_runtime_put_suppliers() will drop the rpm_active refcount for
> > the link by one and (since rpm_active is equal to two after the
> > preceding consumer resume) the supplier's PM-runtime usage counter
> > will be decremented, which may cause the supplier to suspend even
> > though the consumer's PM-runtime status is "active".
>
> Just to confirm, this is the behavior that I see as well.
>
> However, I am a bit a surprised on my side, that I did not run this
> particular test sequence earlier. Sorry about that!
>
> >
> > For this reason, partially revert commit 4c06c4e6cf63 as the problem
> > it tried to fix needs to be addressed somewhat differently, and
> > change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> > that the latter only drops rpm_active references acquired by the
> > former.  [This requires adding a new field to struct device_link,
> > but I coulnd't find a cleaner way to address the issue that would
> > work in all cases.]
> >
> > Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Besides validating the fix, I can confirm device link add/removal
> during probe works fine, as before.
>
> I also tested the runtime PM autosuspend (several seconds timeout)
> together with DL_FLAG_RPM_ACTIVE - it's working fine! During this
> test, the rpm_active count reaches 3 after probe and the supplier's
> usage count reaches 2. When the consumer becomes runtime suspended,
> after the timeout, these "counts" becomes decremented to 1 and 0, so
> the supplier also becomes runtime suspended.
>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Many thanks to you and Jon for verifying it!
