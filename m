Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99395C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B40E21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HP8PO4Lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B40E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeKLRJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:09:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43785 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeKLRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:09:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so3861456pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 23:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xh2jCcjbc9FzyXMznbLS6EB6drG14LywQij89/UVNpw=;
        b=HP8PO4LgY/ttCFDDNrtUUacOYEIIiipx5uZns/iBWx/Aqm18xc5wInQ5EoskNm3Dba
         yTbY8mhVLcf+IUv0LNU3uIGiyhnqG7WyB2wLZp1+rSOPir9D967XQWmboCzdh506HEuU
         muuavWrU3d+Vvq7b7VZE0Zcp6HqcWVtQpbjzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xh2jCcjbc9FzyXMznbLS6EB6drG14LywQij89/UVNpw=;
        b=XaQI0osVNKajypWmfo0JQTbBDKWQD/v0ADfm8z3sHE1Vq42QXU5r+rmgeHrL+1s4kQ
         Nmqw1eIJsa61PKXepWcVPUBxXqN5zLjWprNq+mxmUjkdg17IXRyObBt8H4hHQwovazTe
         v8WAT+3sP4CEl9O5SwW380j+u5vhyd3lhUYv/hZYyyKa4rvZvMb5uh/JIaTyWrBD4GsB
         6jjaCq10ihej5xUIxwr3dP8T705mSxEfdAKAsn3h7s7cpSHKgp5SOg8nUS+TnDGyeuBH
         vn/FdEW6rCHqbvMjUlqIJvVSx8fGbxicUbmhSoJpeyyAHniKElKuu8bdSVv6WjSY4ZPU
         qfIg==
X-Gm-Message-State: AGRZ1gItwqQggQoDTXTb+Cs5BJc1cHZhmAp/zbJvsHPYpJtTZcLkcPhA
        XQVmB8Rj+3H4PGTQ5evahDzU
X-Google-Smtp-Source: AJdET5dTudN9Rp614Ez54RN22qtPpb1LYMUDiYih5AgOROUo0ZYDgNkElYbNLPy9Rmahxa3NL379JQ==
X-Received: by 2002:a63:a30a:: with SMTP id s10mr15526522pge.234.1542007038066;
        Sun, 11 Nov 2018 23:17:18 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id i189-v6sm29453177pfc.16.2018.11.11.23.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 23:17:17 -0800 (PST)
Date:   Mon, 12 Nov 2018 12:47:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com
Cc:     linus.walleij@linaro.org, Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
Message-ID: <20181112071708.GA6689@mani>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdbMSYt5aH9fwRijtO=VG1nLAnfxTsfxGza+_Z2iGj2+-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbMSYt5aH9fwRijtO=VG1nLAnfxTsfxGza+_Z2iGj2+-A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:43:00AM +0100, Linus Walleij wrote:
> On Tue, Oct 23, 2018 at 9:07 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
> > found in the HiKey970 developement board. Also, the remaining UARTs are
> > enabled and GPIO line names are added based on the Schematics and the
> > 96Boards Consumer Edition spec.
> >
> > Note: These patches are based on the below common clk patches pushed
> > earlier:
> >
> > arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
> > arm64: dts: hisilicon: Source SoC clock for UART6
> 
> All looks good to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> for the series.
>

Hi Wei,

Any update on this patchset?

Thanks,
Mani
 
> Yours,
> Linus Walleij
