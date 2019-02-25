Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152ED21852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGu0uBZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfBZA2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:28:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41590 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:28:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25so9143368ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
        b=IGu0uBZ0JEGH8HSNtooUP31VXROhGihub8ByKCYo6jyf4UrXrRLt9vm1URHxbb+Cme
         Nfht+N1G7l8GYOwZPhAGc6q0qotrPTPk/zXqNuomFhyGAODz2zBgJ8PmYWEh8aABjF1X
         MV9ESsSLrvTd4Rnw65oCYzVttTSBPFhLvIl40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
        b=JiWaSzzidBzjyZX0ZGEQJV/9jwzO2K5RJ9S4nqF1ouAo1Bv2HAtoVL6o7OJ1FZuNSy
         vxnsUelsJtg9rACMS2FhfeYWQcysTkJrQp0V/Lco5xLDRWLp27ZyWVFmAvqYUg0QMH0I
         +wD0Rzbf3zbK7XqUjECL6GFrGMKto5hvTDFuLzm3RupB1Gv3VucZsVy56Yx7BlTloWIO
         NU5tVTrR2+LPb9DlJVXwU64Jn9GqTj9wQDBGPP8AlvOyS6yIhi8+5iANsvhH0PkUBAkc
         sj31JwhsUkBy/fmemD/99FyKXga8jCC+tOeF57A/E1eD3J9ZTYOS/YTr+3o4mi9XAPq4
         cfmw==
X-Gm-Message-State: AHQUAubIFKGMJRaXYofKWv3aYskNcXCmpX5L/ibfKhAp4+SALP18DeMn
        8Jg28WKY7zil9YQkYN+7yubUJggl+og=
X-Google-Smtp-Source: AHgI3IYoa9NqywsJCnpCeuZ6VgsiRu77Q/v1zMjpZKjpS+Q5ylaZNFKxbyap8XE3ezfMmkiFwceIHg==
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr12642877ljj.70.1551140884338;
        Mon, 25 Feb 2019 16:28:04 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e23sm2565794ljj.3.2019.02.25.16.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:28:04 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id w6so9144655ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:28:04 -0800 (PST)
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr11073232lje.126.1551139049916;
 Mon, 25 Feb 2019 15:57:29 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-14-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:56:53 -0800
X-Gmail-Original-Message-ID: <CAE=gft7qao1BdwPdoeBxOhwRtQAhzqeiP-mPQvXtjjf7Q7TZ9Q@mail.gmail.com>
Message-ID: <CAE=gft7qao1BdwPdoeBxOhwRtQAhzqeiP-mPQvXtjjf7Q7TZ9Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64: dts: mediatek: Get rid of mediatek,larb for
 MM nodes
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the IOMMU consumer and smi,
> the mediatek,larb is unnecessary now.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
