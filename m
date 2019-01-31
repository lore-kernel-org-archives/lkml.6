Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0CCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAB9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548929407;
	bh=ny3WccFhsCnB9MMWt3pqskHUVebOLE90q+eXx5MJpyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bwHzvyZopftvyhksNHDhruHqAtbK18LFP7vNrLRZSUdv0BWwF9csP0ijseML79ls5
	 uj/aCGHwLvtsCVYAyZ7EHenjhC1zYXDv8czqK8SdNDmcsEYuBvK4Wd+j/pZR06zdYo
	 iKvV0i7HlPBIGhtl7+elH4iEXqXbtmfxVggGrNN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfAaKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:10:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44097 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbfAaKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:10:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so2213804oig.11;
        Thu, 31 Jan 2019 02:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGtM6G9tEeSNZsYLEbgkdTS8afkAuGom1UMpBmISu+4=;
        b=V0a+dC/2njRLTnRoP8EY3OJXbXH2nuzN+It4xtT33UfEbhpewvA2BFLGU3LiiRuPcZ
         B4NWnRje7ytSGvaVOYRe7+Agxyow0BtR0PkJWiWE8/42RRK9elzr58QXk7lYB9V+DD22
         FivsOUpNeG4Hwjygh7ot5aEWGwXrwOq26ompjUESEH7bDdPxYYWrzW+cQw6hONR6wcww
         lhPM9+lrEfHzv+xEua08lUGVF3o52C0P3ZjEbXRwIEYAk6efT6nDZINY40gTFcKeDfBp
         +cfwS5Tyk6Ptpd4/ml0rD6dxt2jwL1hvVtDYLhS8CySboeBgxnliU0Np3ownjIfKx+tq
         PJWw==
X-Gm-Message-State: AJcUukdXohINE7+1JzYhwvIjGhhAGqrWYeMa+zi3k8cgNmOphXXZNe2D
        e0CRDMRmTQXBYIAF8ZO3+vs4TfcTHrVOn6FaX08=
X-Google-Smtp-Source: ALg8bN6tplGrc5r4WyR9qGEEt/fRd/ATeIyauai7qip0xIarOYpBAnxhSeiI8Mj+9dhwyGnGvHEbjzwspYO1+dXKN7o=
X-Received: by 2002:aca:195:: with SMTP id 143mr14123460oib.322.1548929402230;
 Thu, 31 Jan 2019 02:10:02 -0800 (PST)
MIME-Version: 1.0
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
In-Reply-To: <2493187.oiOpCWJBV7@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 11:09:51 +0100
Message-ID: <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Greg at al,
>
> Recently I have been looking at the device links code because of the
> recent discussion on possibly using them in the DRM subsystem (see for
> example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> found a few issues in that code which should be addressed by this patch
> series.  Please refer to the patch changelogs for details.
>
> None of the problems addressed here should be manifesting themselves in
> mainline kernel today, but if there are more device links users in the
> future, they most likely will be encountered sooner or later.  Also they
> need to be fixed for the DRM use case to be supported IMO.
>
> This series does not fix all issues in device links that have become
> apparent (generally speaking, the idea of returning an existing link
> in case there is one already for the given consumer-supplier pair
> doesn't play well with stateful links and their flags), so there will
> be a follow-up series of patches to clean that up.  Still, I don't see
> a reason to sit on these fixes while working on the other patches, so
> here they go.

Any concerns regarding this lot?

[Please note that patch 5 in the series was replaced with the v2 at
https://patchwork.kernel.org/patch/10781205/]

If not, and if you don't mind, I would like to queue it up next week,
possibly along with the follow-up material posted on Monday
(https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
that is not problematic, so it gets some linux-next coverage before
the next merge window.

Cheers,
Rafael
