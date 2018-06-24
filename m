Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF88C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD96D25311
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9os9GYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD96D25311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeFXVJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:09:24 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36960 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFXVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:09:22 -0400
Received: by mail-ot0-f194.google.com with SMTP id u6-v6so4762231otk.4;
        Sun, 24 Jun 2018 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fsuYDlw81AyLGe1Z07MKZyAcA5R+PLvqrvGFwygfRAQ=;
        b=c9os9GYxygyi79SLpul+WIf16qhldMFSdrh02StcqJz6VjL4WvfpJXE5DQN/RPEPyQ
         Q7+8rif5E6b/pr+EZyy5JrV3pyO3C9JFF8f3o+aQaKG/BRVKUSfL22qoGp1+usB46n+M
         ZTk3k38QaSgN0wzeKG5NPoerKgNUX5J921V0SDwn+xAY38p2LGXcfCC50q8eoJJew6LY
         55b7xWmZmK+0Ly8zt/rzIKKeu87KmCm6PuaDpQfDIJkxvGIeQAi7d15ZoXGlHmK1jf1N
         8WL8Du9zjsDiMoYnWn56paTZiAec/1GMtvuA8Lyg7QfA76VN/OgbueI6W8mFl8bK3PVD
         GQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fsuYDlw81AyLGe1Z07MKZyAcA5R+PLvqrvGFwygfRAQ=;
        b=EWzF50uG1mXdil/FgOL9/YV2WfsKADx0Ys9Mgz3E7QKYRGU6bgFrFF+LqjMNZbEdVU
         O20kC/HiH8gwN7i6KcQVz0BVW2NFwk5/VnYWlT8Oi7H2EvlOddm6qmiaGEZfb4+f0rPM
         da1UP/TWIgbzG/OVKIgGufPZwEOE7HGjMJrm53s8USgkdaZiG8bJnwK10QmdrlSiTTdI
         m8kv4kTp/UDrbyzgRGzfJ9a7J+2EfOhS4rQjzzPtcIkJd2lT/oRYVBzl1+jKz0g7j3Xc
         x/o21D9I+bNswmBdongyitZRzBxnSJ2oq+C8t9HG1NfM2ecMgBv2weLcR+HkdYUu/soo
         F0TA==
X-Gm-Message-State: APt69E0ze9lW7kj+jGmLQ2J/BoCdlFdL9rxGBeK3rAH8Wbkb/MwlU7dp
        l1hEsN7aYJVFc/dMDzIFhQdWBC7/a8NqhOqMCHE=
X-Google-Smtp-Source: AAOMgpcOnAkjTAuiz602ClF6U3Z0UvNz7QZrLtYJ7UGzU9vsnif0vF6Y68zurXgX47jic6I0DiCyRAaZGXAuofzWUTc=
X-Received: by 2002:a9d:1012:: with SMTP id h18-v6mr5613349ote.364.1529874561522;
 Sun, 24 Jun 2018 14:09:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 14:09:20
 -0700 (PDT)
In-Reply-To: <20180620172226.15012-4-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-4-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 24 Jun 2018 23:09:20 +0200
X-Google-Sender-Auth: 9qq7Fp2Jfb9Ad0OKz4cE5AMijFE
Message-ID: <CAJZ5v0i52JTFbvBBaDyNHCnTz3UMW00NiodFpzS5m614D++9uA@mail.gmail.com>
Subject: Re: [PATCH v8 03/26] PM / Domains: Add generic data pointer to
 genpd_power_state struct
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 7:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
>
> Let's add a data pointer to the genpd_power_state struct, to allow
> platforms to store per state specific data.

Can you please fold it into a patch actually using this pointer?

> Cc: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/pm_domain.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9206a4fef9ac..27fca748344a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -44,6 +44,7 @@ struct genpd_power_state {
>         s64 residency_ns;
>         struct fwnode_handle *fwnode;
>         ktime_t idle_time;
> +       void *data;
>  };
>
>  struct genpd_lock_ops;
> --
> 2.17.1
>
