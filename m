Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56776C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E920645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMJXWmfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0E920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeLKClL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:41:11 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44927 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbeLKClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:41:11 -0500
Received: by mail-vs1-f67.google.com with SMTP id g68so7964041vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 18:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+uv6SsY4MSlK1YGSfr475JyQfEtUlfCRjc/ngS5HSM=;
        b=iMJXWmfu5TKhyEjwnYny5T1/+rUtOMOHltQgH6Kpw25DrKmEC4hIfM9hulJzdVjVv5
         eekGrnWdq5pRejuswvQpXsyfftT7EdGtiO/340o1d0vX0JWJvDETu1y+G9jGZcNyiqCW
         +PzrgDX8Kp0ENs5VT/MPKRcD+FUDWEOzQaWQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+uv6SsY4MSlK1YGSfr475JyQfEtUlfCRjc/ngS5HSM=;
        b=VCV+kGHWFrHr+a2Z3eOJX5Ol5HHBDlYo3rGHae1hMnKSIID1pvyYGVmf/WLAMWGSsf
         07ggCIHTENftFLs3/g3vq9FWR+RuTbLwGJkGVQibT/AyfOvZP7jNVKm3NGLoo4wERQ1Y
         YkunN7v/Eq/8irIoxayeWp78KmG0L6DFEf4VXqcbd7AIMrRUQV7od9BK8C48hcoc4NCa
         WzInlYcsk1PgrH09RiNoYUDu+Kt2PiU7qfS7c46gqYSYr5zLhM9iE6ITqqWzpz6NXlWr
         C1J+k+V1cp7B+3rUKZqXYjMBGwjJKvFHMuEYzGSPkDvPHh2z983kht2RZNfRRln5900y
         1vhw==
X-Gm-Message-State: AA+aEWarIgHKTrzfPkqojgMHxpMDLPyHId24qxOYo9GuSAm9przeL4fD
        77r3TRFgoo4zh1ORyv6ovPDbzNbWDhc=
X-Google-Smtp-Source: AFSGD/Vd+jIEU8ap79ifBElFKWt4Fdbb+Ndu3SmkMga2+51ojOeVcVKTExPSoGn1KS9EsKQ7gs/Efw==
X-Received: by 2002:a67:f696:: with SMTP id n22mr6567995vso.175.1544496069116;
        Mon, 10 Dec 2018 18:41:09 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id d195sm3973075vka.29.2018.12.10.18.41.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 18:41:08 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id o130so3039793vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 18:41:08 -0800 (PST)
X-Received: by 2002:a1f:1e09:: with SMTP id e9mr6437823vke.18.1544496067689;
 Mon, 10 Dec 2018 18:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20181206222318.240401-1-dianders@chromium.org>
 <20181210154311.GF6307@sirena.org.uk> <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
 <20181211005221.GB3004@sirena.org.uk> <20181211010032.GE3004@sirena.org.uk>
In-Reply-To: <20181211010032.GE3004@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Dec 2018 18:40:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xh26OSoMVTJCLiinw94MmgqNRexc=uWP+-58L8fBUavQ@mail.gmail.com>
Message-ID: <CAD=FV=Xh26OSoMVTJCLiinw94MmgqNRexc=uWP+-58L8fBUavQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Evan Green <evgreen@chromium.org>, masneyb@onstation.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Mon, Dec 10, 2018 at 5:00 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 11, 2018 at 12:52:21AM +0000, Mark Brown wrote:
> > On Mon, Dec 10, 2018 at 08:32:32AM -0800, Doug Anderson wrote:
>
> > > Can you clarify?  See below where it's applying cleanly to "for-next" for me:
>
> > I tried a git am on my for-4.21 and for-next branches and it didn't work
> > on either, I didn't investigate beyond that.
>
> Applying: regulator: core: Clean enabling always-on regulators + their supplies
> Using index info to reconstruct a base tree...
> M       drivers/regulator/core.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/regulator/core.c
> CONFLICT (content): Merge conflict in drivers/regulator/core.c
> Recorded preimage for 'drivers/regulator/core.c'
> error: Failed to merge in the changes.
> Patch failed at 0001 regulator: core: Clean enabling always-on regulators + their supplies
> hint: Use 'git am --show-current-patch' to see the failed patch

Can you confirm my patch applies cleanly to your for-next branch?  I
can see that it doesn't apply to your 4.21 branch but I can't see it
fail on your for-next branch.

The problem is that commit 2bb166636933 ("regulator: core: enable
power when setting up constraints") touches the same code but isn't in
the 4.21 branch.  If you pick that to your 4.21 then my patch applies
cleanly.

If you'd prefer that I post my patch atop 4.21 I can do that tomorrow.


-Doug
