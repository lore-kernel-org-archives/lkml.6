Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76350C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F00206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHh/4aC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F00206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeIENis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:38:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33541 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIENis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:38:48 -0400
Received: by mail-io0-f195.google.com with SMTP id r196-v6so5398128iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FzWydskxWa1eeJzsvP5mO5gLmr8n9+1DXH/C0pEx3E=;
        b=bHh/4aC2IcbCZk+OiFMTsyUcasoW7rtSr99K9+liWJDH233NCrLfdqOKhR6UXANg4n
         ELx/0W3by7lhTpoju8xTkIbEnnqGYbvV0AW9F501ae9eONqch5jo//XHCRBg5GZK3DUn
         Vl7v1F0H6XLO/UIyj5RSDHLm0WBVt1PdJCtEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FzWydskxWa1eeJzsvP5mO5gLmr8n9+1DXH/C0pEx3E=;
        b=VDTMOtxe+eQwFYwy/vgNbfykc5BXsp67kn8pEYm5lzZuM43GVh7dFop4OAXfBZLGuZ
         nJ4C5UdCPmtyihctcTNfzWrvwxU/HSZbhHBAobc/dI5bfAc6UTfssclfidJIoMT98o6Y
         v1ZTxFGoVYrXtP6UNH3646fTtE9nrhY2V2x/FzWpyEYgYPWyU+p0dIORbfV22DU2sCye
         FgRx95TgONEEn9kShujdCQBzhB1H0Ww9fAP8432bmNJA0JnFoBN4vRuhiguG03wUe3hG
         5GkOfaTFmBIuKqhRmSWtkSeC8JceIhTPpg4sa2yZB9qNmkl98qThgwuhAEDyqQOcx1d6
         lGJw==
X-Gm-Message-State: APzg51Bw7oKhjcD4LNr22mv35T/LEZZXy8qWu0OBN9Pnbr7I1tZvFDyf
        rxhTniagjjAJed1f1OnrgAZyLaieH0j8kcdOcoQvYdvHXQU=
X-Google-Smtp-Source: ANB0VdYlEgh6Q/FLaOohT6OxOIdkVdVhVqUeZbYSuNY8aW7Tdpx8ibtr+CJEr68fQjlo3ZCcbpGWLvDOsxADxcgFjBY=
X-Received: by 2002:a6b:93c3:: with SMTP id v186-v6mr24732190iod.148.1536138572370;
 Wed, 05 Sep 2018 02:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <1535106534-983-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1535106534-983-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 11:09:21 +0200
Message-ID: <CACRpkdYdGeuFt7c+VJ=4bP+Ekgeq4_srRXD_+eQdkJcgBF6XmQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: u300: add missing check for kmalloc
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:33 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

>  kmalloc return for bigrxbuf_virtual was not being checked - in case
> of failure set status, cleanup bigtxbuf_virtual and baile out.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: c7c8c78fdf6e ("ARM: 5667/3: U300 SSP/SPI board setup and test")

I will delete this testchip instead. It is not in use.

Yours,
Linus Walleij
