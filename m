Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD8C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3BB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gCEFrucv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3BB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeKHVkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:40:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35246 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:40:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so13993390lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TTUueBeBpfBLQYRaoQvgnRvOkMxtqT6ejgeoRUEFvA=;
        b=gCEFrucvhUGXEv7Q3KPsh78pzAJntBdY3PyTbVltv4vAD3OoJrcDEAiHlxJDw8UgJs
         bnXR48z/1uj2PRkvNSeYWM0+Pqh4n35MB7uxGpIqYSkXXeT3iDd4P51+PD96AtFoQQjb
         n8Monr8EdVb29KgDsCOqA//R9QVgeQBw8XLwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TTUueBeBpfBLQYRaoQvgnRvOkMxtqT6ejgeoRUEFvA=;
        b=r6V3Nz6G01o1g0gBleGSGk5+Vbh5EqG4tdrU8jF9JxEVRr6ltsQYlRpYNSS4OFssAs
         9Ed7sUfc13/CROoceDnvqWwRaXqytykrPu8HWTNr5uhr+KkqxiSqiCfHuTMh06QRSLnL
         Sx2ORop9+BvXWMCBKuS6gGudlrCjMDugRNBnkka60oXR/XtVTeZ64jiQ9DXd8LRrFapu
         DT2uSBgbH6TOI+eAD/kvEXNoFZcDbfC6YjrQw1QMWp5NQQ//RkT0emdTo/ZoujrfdZCg
         5ykwBI98nbxv6YwM9BKO47AzQriWImSloOPjq0CZxEqRm3ODoeiyLf50WaJwLnwFakHd
         +Hlg==
X-Gm-Message-State: AGRZ1gL9p/L0iWVguDWMp1GSABOsxSH00xv+Hrxo6FeyZWAjbPvR3a6b
        8Jfwar/vih1WOWscuM9o37gusKSW1rA=
X-Google-Smtp-Source: AJdET5coTLztk+1pypN1Bd9UW5UctHtKNGHvbCoE5TGnIa00wDAtV7xq1qeCDR8RwT0PLSdq194I0A==
X-Received: by 2002:a19:e601:: with SMTP id d1mr2657057lfh.71.1541678730812;
        Thu, 08 Nov 2018 04:05:30 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n8-v6sm730893lji.90.2018.11.08.04.05.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 04:05:29 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id f23so9427274lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:05:29 -0800 (PST)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr2671583lfc.147.1541678728427;
 Thu, 08 Nov 2018 04:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20181108112513.3daf0053@bbrezillon>
In-Reply-To: <20181108112513.3daf0053@bbrezillon>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Nov 2018 07:05:11 -0500
X-Gmail-Original-Message-ID: <CAHk-=wi3oDSqcEEsXHX_-KHk=XyYLANTiBOONYT3ocnPvYvpgg@mail.gmail.com>
Message-ID: <CAHk-=wi3oDSqcEEsXHX_-KHk=XyYLANTiBOONYT3ocnPvYvpgg@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Fixes for 4.20-rc2
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        marex@denx.de, computersforpeace@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        miquel.raynal@bootlin.com, tudor.ambarus@microchip.com,
        richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 5:25 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Here is the MTD fixes PR for 4.20-rc2.

Pulled,

                Linus
