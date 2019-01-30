Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9090EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591622087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KpwpN3ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbfA3TUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:20:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38911 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfA3TUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:20:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so579580lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YN5U0FYrh6FkR0o1KHBgp086/PB+j1Y8dRv+wNG//Ag=;
        b=KpwpN3ZFQ4vbMUm9l7sXtcQy8j8YXcesm39ZIgfCoV3Sqfg9C3dlURztb0XmMmmabL
         Xk1Q2df3biijflUKXuQ4aQx9OOH4eJJFgNjkqtnBMj2crJIjHqtWFqc2wgfqY36s3ylZ
         Ao9FdNPWutaYb7NOX6tUeT9K9GxQBnSMPa1wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YN5U0FYrh6FkR0o1KHBgp086/PB+j1Y8dRv+wNG//Ag=;
        b=kIiYMRUbuZG7rdu1SIwwDIq7fMv1j5WqoPVeeAIfr7THca4TZOxEzJ385Jnlb73PCC
         4dvaLxq8eX0juU/Sawk2dDG5ke4P0Gt1l3Sg+e5oPTLNEwOYeJDANazVX3ji/QsX4Ka7
         6QevfPe6Qexiz36BA+Jl7FZhFL0OYFeMj9sKGtBsog+m5VYqU7Sucq/d0rP5Og0EPoj5
         OJmwYqvFzBmwZnqU8DnxAr3JHJueEcFE7Ju4zgFsh8sRQ5Czz0PwiIvNPOa8hgQ7nyzn
         +xCCOPQYvWurEbLvh2KhsNnEsHVR6xseERPOlyRQAzaWQe/v7AWFiq7pejdeoiAAA09p
         tZbA==
X-Gm-Message-State: AJcUukfJyILpyR4kqDvr1a41dxBYfV+++P3JpUP4DFHG+NcjHfU3wBKf
        nptIyFcqovvBnHqM4DJI6NGOoi1VIh0=
X-Google-Smtp-Source: ALg8bN4PLyr1hCrqpLDmIGEuy+LMxBi5kPD5Ad0uvrNPRmnR62T4mL3sEnNamH02FS7iopQWrV/ITQ==
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr25071308ljj.149.1548876013418;
        Wed, 30 Jan 2019 11:20:13 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m63-v6sm459071lje.81.2019.01.30.11.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:20:12 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id u89-v6so608169lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:20:12 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr26580031ljc.97.1548876011815;
 Wed, 30 Jan 2019 11:20:11 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 11:11:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft4xwk02tM9cgnLCZDpZgX3z9w8fjXfJxJ7HtzdOaCN7=g@mail.gmail.com>
Message-ID: <CAE=gft4xwk02tM9cgnLCZDpZgX3z9w8fjXfJxJ7HtzdOaCN7=g@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] iommu/mediatek: Fix VLD_PA_RANGE register backup
 when suspend
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The register VLD_PA_RNG(0x118) was forgot to backup while adding 4GB
> mode support for mt2712. this patch add it.
>
> Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
> for 4GB mode")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
