Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C0C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E8C21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffWS8VD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfBMDUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:20:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37638 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMDUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:20:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so689791edv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oa898J5DYixPpvrXehNIzm+uZ1BeIMAqjC27Zoi9YxY=;
        b=ffWS8VD8LmmK7FtwFSnp21AiBXDQUX32HbDtodD5sxBqnX5tQsX0m671sqeB4M+H4S
         LQ2Xk4BsfGjZuFyOeDCN85TPo2wxUZXsrTa0UKMlbzCVNlBFeIOeoFlzPdxN/axq6Ypk
         Fp9S6jxuuIb3Pv4EgY6TY8H2PHF4rNLMhK8EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oa898J5DYixPpvrXehNIzm+uZ1BeIMAqjC27Zoi9YxY=;
        b=A8d7zCfiaqHWPRRITnLKCOWOkrqxvq0bZKtVTjYr6UxPTYpTYK4Rd/5Eum9CyNAJhY
         tY7RxT9oo9CRBrV1gCbYP2TJ4w1DNwBucUgHL3eo4D2nwplfdFRpJ8rgeCduGtgyYduM
         W1MK1hHTR1fKRWUvHbnXE9WLFyqJ25zcb2ZyjdoSkkpA60t3kL8h4SwHy0GON7b36OGe
         iaFhTiawvZDgvhYOrzLsmg7oqVGUUWZVLJbePR8tVyLftd7AkcSZkRD19d/wqiJuKDtw
         r61nxY6hyATCNO+T+3TyWk7DWq6bBZ1Hxf3GKsmMK8OYmYReVFvkQrDyxDupdnreVzFS
         RHyg==
X-Gm-Message-State: AHQUAuahrExJwsO4HQXHGMsRVYIdCU+1bP3hWE4kNsRYau057Y3Y2z0N
        mwfvt/NXlJNl456M/tKL5BdE85ZjBoiTEGXiCd5z4w==
X-Google-Smtp-Source: AHgI3IbIqqpIwr7rOgFbnQ5uyhJSN2OLeEbQXznz8l9cspkSuxqjvM5RlVEu0GqMwyEzqt1t1qmTWkjGGoI4xRL+sg4=
X-Received: by 2002:a50:9908:: with SMTP id k8mr5319525edb.246.1550028029818;
 Tue, 12 Feb 2019 19:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20190131093131.245531-1-pihsun@chromium.org> <20190131093131.245531-3-pihsun@chromium.org>
 <20190202001749.GT81583@google.com>
In-Reply-To: <20190202001749.GT81583@google.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 13 Feb 2019 11:20:18 +0800
Message-ID: <CANdKZ0ds2s46h-Rs-4aJSuVFkoaeEzXi96m2zbx5XjBhhsc3Xw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review, would address most comments in next version of patch=
.

On Sat, Feb 2, 2019 at 8:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Pi-Hsun,
>
> a few comments inline.
>
> It's the first time I dabble into remoteproc, I don't claim to have a
> complete understanding of the driver at this point ;-)
>
> On Thu, Jan 31, 2019 at 05:31:27PM +0800, Pi-Hsun Shih wrote:
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.=
c
> > new file mode 100644
> > index 00000000000000..920c81c3525c2a
> > --- /dev/null
> > +++ b/drivers/remoteproc/mtk_scp.c
> > +             return ret;
> > +     }
> > +
> > +     writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);
>
> what is the purpose of this write?
>

Answer from Erin:
The code needs to execute on scp=E2=80=99s SRAM.
We need to turn on the power of SRAM before using it.
