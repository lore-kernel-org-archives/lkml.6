Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61742C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2690E2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw+oB33X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2690E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLGMXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:23:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44325 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeLGMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:23:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so3355787lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJXUzTv3gF3riXJraZc7huLySV3V4+RAVqg7x8wSQ0A=;
        b=Iw+oB33XFQAD15aD7K/+6J371aQh8xxUHIHTmS11USs2NYsoZShh1+evFgFHIoGj1a
         6MIaNFzk+m/fwEZexXkZh83OmrYvQUudFDaNp3AJ7pO+qrcdWwTs1nwms/WVauyl5qYr
         xhZHdcnKdX4HP0UOIVfuHl7WMbJN6WmrHXn5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJXUzTv3gF3riXJraZc7huLySV3V4+RAVqg7x8wSQ0A=;
        b=mJbPLs9Hb6zuaYySbumkGEWa7vGe0EBZ3s6ipoIn3Kq94UDqyCNGG2PFmwEWRKDQFE
         7FhV4ErCSlvcAlAd0ExMc1tXBGWkIDXhoRp0iOxhviPTQP7iX3/7G4gH5F7DX95hdMmF
         7ZtoxuCqm1y68ZsSf0hzJ99mgpQgPNT30/3t/aueVhcT29SCobRu1YriD3wG/j29KJAO
         9OdiS4y4f5q10Gwi6TpzSZcaJST3ottpqHUZEfJ/zYZnwfkRWsActrdnZrLypXoaCXYG
         RA78wDFhDDqJzcuWcxD3Q95duObBGjmZZbJ0LyJD1/5BtSijY+A3XcVN+UAoER2GbpI4
         Zt3Q==
X-Gm-Message-State: AA+aEWbLh5b6v3dyicplzJmcrqRjOAEdkA6e+vSvPMpHAtoDjlr0/S/9
        6ns/437vKFTkZsnj3lK/fhQ3JrTHxOFShHiM48eumw==
X-Google-Smtp-Source: AFSGD/U4q4cDYSBmWRQrOY/sqwtiXtTxEkwe/WBKybDJ37NtZx1yqxAG3WCMxsBunN8ATJo9/wmz+lEvrI6Y2DukifU=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr1233585ljp.12.1544185421167;
 Fri, 07 Dec 2018 04:23:41 -0800 (PST)
MIME-Version: 1.0
References: <1543745057-31616-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543745057-31616-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:23:28 +0100
Message-ID: <CACRpkdYB9i5fy9KyBBsqoh4Mh6RgtOx15mTHd_cmT=nHS=f0Dw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sx150x: handle failure case of devm_kstrdup
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 11:08 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> devm_kstrdup() may return NULL if internal allocation failed.
> Thus using  label, name  is unsafe without checking. Therefor
> in the unlikely case of allocation failure, sx150x_probe() simply
> returns -ENOMEM.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")

Patch applied.

> Problem located with an experimental coccinelle script

I like this script.

Yours,
Linus Walleij
