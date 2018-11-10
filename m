Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9432DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E55920854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HbUtNP0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E55920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbeKJWwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 17:52:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46285 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbeKJWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 17:52:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so3201428lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4+aui5mVTH1eqiv16uE105laAcKcxAzp697wh6tW50=;
        b=HbUtNP0gPDRq4x2n65H/unNEwS0DGjoMYgaLKZZbSTFFQ0mjukQZSThvNWZ4n98Ecu
         thTfTuiz1RTmSDIGmjgfz8PTDMxAvQBZq1VFVnp/AvforWfxKdEYOcQ+FvlSlmmWkn2X
         MOCNzqEPvEFAlYlrN+70zutLk/CWTyy5XAXDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4+aui5mVTH1eqiv16uE105laAcKcxAzp697wh6tW50=;
        b=qlklRrgdxLs2UHmcjnH2in6eYJ+LXj4vYo9ZdcUsMcWggwZDYwdrgsAmXXlQflF1lw
         k81VOsiy1/pz/ANQdTB6+h2NDUA/FJGmv5Zpd+YZ/WSIlw45sWG+7iQCR1kLucH1w3KH
         ibFvs+k7MXCXYieIF60ONwlxvCznmMqBMHmSXPNF7XZX/lKDsrHKuCt+QEMiOJRjKdN5
         7fKVQ2oqgA0MG/0u9/wtikFFnjsL+Ynac53MDiXdWy53V/ZAf22JgykVBa80wiOZuNND
         UJ2rYCgpQY3V2S1+RO/51Jvkn3nAmiS3dwQXPtGNtCGaixiEj1mDmYaATPRGCQDDvGKX
         cKgw==
X-Gm-Message-State: AGRZ1gLVkWCJb4GB+zwX1pjzz24q23X5+5p5WGSyVJbKHQ/DoPTsIISn
        kKnzxU2ic6QomXgqCCORX+GJKcA31G4=
X-Google-Smtp-Source: AJdET5eFowCkpYZXOQ25aQV0Ivc7zka/PuXSeMB17amfO+G4clcnmJcLk9yiq0W10IBP4s6HquHCKQ==
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr7234125lfd.90.1541855230676;
        Sat, 10 Nov 2018 05:07:10 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s14-v6sm1965803lfk.59.2018.11.10.05.07.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 05:07:09 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id q186-v6so3873017ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 05:07:09 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr7599346ljh.59.1541855228742;
 Sat, 10 Nov 2018 05:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20181110112036.GA5905@kunai>
In-Reply-To: <20181110112036.GA5905@kunai>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Nov 2018 07:06:52 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgAJXs32MZNWNO9HjMmgtV9kWmDvjQS7zcFg0PVgJyHog@mail.gmail.com>
Message-ID: <CAHk-=wgAJXs32MZNWNO9HjMmgtV9kWmDvjQS7zcFg0PVgJyHog@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 4.20
To:     wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        peda@axentia.se, brgl@bgdev.pl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 5:20 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> I hope the rc1 rule still applies for this new driver. It consists of the I2C
> master part and UCSI client part which has the needed ack from Heikki.

I've pulled it, but please don't do this again.

The "New driver" rule has become pretty much historical, simply
because releases have been regular enough that it doesn't much make
much sense, and we just have't had the kinds of "basic support"
drivers that make sense pushing out as early as possible just to get
people able to use a machine at all. So in practice, the "new driver"
rule has become a "new ID or quirk" rule.

The nVidia i2c support doesn't sound so special that it couldn't have
waited until the merge window.

                    Linus
