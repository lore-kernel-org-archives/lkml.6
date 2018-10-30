Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237B62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="krnm3PAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237B62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJ3WLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:11:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44199 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeJ3WLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:11:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id m18-v6so8816648lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HspSmfBDzptBzR2Kjg+MRKQqBhB8F2WJHal4+FQ9+OI=;
        b=krnm3PAl2Q2dw7BE608+D1YOrmszBaTIwZypoDuKn/3OZDDnrT2XBNeEfDr8PopCSo
         Esd+AiKdifsnnE6i87q6jZ3R1OeVdSdJBHcMo0vEvDna7PPtqZYYDVv2g5df7gVWipZS
         B45dlDSMp2e/0Qj9JDr4/Bcaa4c2BTmVzZdlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HspSmfBDzptBzR2Kjg+MRKQqBhB8F2WJHal4+FQ9+OI=;
        b=cNe4N3Ft7xyWDp6OgvfNUpry+FUIusulkvmgn9MlW6WshkTaEdmwlGCpRb5gPSmAmf
         rvtREElhRrpoNbiUKFpX3Qt0jiHB5P/Ik+GZvRe+CtscfuistXzrPZRXPu0NMOj0RKoq
         XzXwPEBvVTO5xAdZhrhI1HkWNq3NFMtMlKQdbh2fDz9o67pnj3PzpCWF8eVTCBGwu/83
         zUF1gAFTDXTzV9KVjUZD1d5dAGPO5fS0A/VIl0GRw4FQW+oCKEk9tByPqizFFlyz+3Sb
         FaRsDp7fMQ96OJmHyIdpCFR4DukiRRlbyItu2ZCU6qgkU/tBOqITDAx62+qUt4NKyRDZ
         mrNQ==
X-Gm-Message-State: AGRZ1gLhjoSj8cnIkvIeAtY52zRlG1qCOBH4xQimiU9x+d9SigjUJKYL
        d4KLGfQylYycXx8+tj6mP+wMLRtiTPKhs9UaFStpwA==
X-Google-Smtp-Source: AJdET5doJQzolPjph5+shqNr6kaooRc9gaNWu6iuihH1jNrCJ6l936pGSE/u65Pkfk2CCXp73kjc3x5LqvBLLblvYd8=
X-Received: by 2002:a19:2095:: with SMTP id g143-v6mr1849735lfg.62.1540905498217;
 Tue, 30 Oct 2018 06:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com> <20181021200002.1472-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200002.1472-5-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:18:06 +0100
Message-ID: <CACRpkdbT9HuCJSZ6HZwaapz7gtwtmxmE1sZ4FB9_Z_JeUobADQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] gpio: gpio-omap: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied.

Yours,
Linus Walleij
