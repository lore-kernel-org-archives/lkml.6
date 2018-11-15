Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E23C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ng4M+KQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C7F2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbeKPJ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:27:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42255 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:27:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so11727246lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 15:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3qA3Z8T+gkll+1f2b8huiB8+JsdOCeMXgQ+0JAI2x4=;
        b=Ng4M+KQHkYdO714tc6OBeYue2frZEmGpn9KZE7qsOy4Q9A4GXJZ3LKdQqO+NYYa5Wd
         KHai1MvzUwU65dUonm6X9ZPjrcnZfjMGZZiL9i7y6ta3gEwNusjQ6ZKO5VLAKtx9XpT9
         LFNIKvouX/z7dSMrwdRRZE9c6W9iibosRKLhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3qA3Z8T+gkll+1f2b8huiB8+JsdOCeMXgQ+0JAI2x4=;
        b=qppyNtAI7S0q3OExgb43vA/2y9YCxO8yD5rxq/x/UM1lFpzCHiS2oyP58YksWD9W+P
         qvZt1PtaqlUH2SrBOYy9GCgZwv/jo8nqSYLwnIuskpGkzRWroRm2RNSpHicOV0/vEewp
         SlnAQeVRuA8vhrhU/9wKfbNHML+Z9HmXnspZiDIkxA20qLV6jVIbEYet1TuzvYge7vIm
         Drco4WmlqucNJ6fJp1dDlkDWw+ivligwURzZ2nN6RqlhsredZGCpTQJMVziQDvgucg8b
         SlPDvGpRlxEcwb+Ap++0WiQprHQn/9F0MKX8v9zorheG3nJIXl3c/VZJHegNC6WOfqHb
         HDug==
X-Gm-Message-State: AGRZ1gJ+4pX6or7QAHgw91hOje1hYXuf6zjF9YW+W4XECaBk61TYFbqA
        ZsazApfZSKv4knE/ZZgr8K9tAKvCCME=
X-Google-Smtp-Source: AJdET5emcamn/Jluseaxx18iKyvl69Ys2+lYjVvXJNI69X4xbenPzHZyZ9EXILXSlGg1uIHO9xG2rA==
X-Received: by 2002:a19:24c6:: with SMTP id k189mr4608098lfk.77.1542323858878;
        Thu, 15 Nov 2018 15:17:38 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g70-v6sm859987ljg.92.2018.11.15.15.17.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 15:17:37 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id x85-v6so18737767ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 15:17:37 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr154387ljh.174.1542323856676;
 Thu, 15 Nov 2018 15:17:36 -0800 (PST)
MIME-Version: 1.0
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
 <dcb4a579-b308-76c0-7cc3-22bb95147470@codeaurora.org> <9a4708c8-cc43-a690-7ef7-da351eb1f967@codeaurora.org>
In-Reply-To: <9a4708c8-cc43-a690-7ef7-da351eb1f967@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 15 Nov 2018 15:17:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft7VCzVDS+hDQUiXh=76ytkg4Djf8kZXtESsQsxoPJrwXA@mail.gmail.com>
Message-ID: <CAE=gft7VCzVDS+hDQUiXh=76ytkg4Djf8kZXtESsQsxoPJrwXA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: Allow platform controlled voltage switching
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, Doug Anderson <dianders@google.com>,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vviswana@codeaurora.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 6:36 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >>> index b001cf4..3c28152 100644
> >>> --- a/drivers/mmc/host/sdhci.h
> >>> +++ b/drivers/mmc/host/sdhci.h
> >>> @@ -524,6 +524,7 @@ struct sdhci_host {
> >>>          bool pending_reset;     /* Cmd/data reset is pending */
> >>>          bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >>>          bool v4_mode;           /* Host Version 4 Enable */
> >>> +       bool vqmmc_enabled;     /* Vqmmc is enabled */
> >> I still don't love this, since it doesn't mean what it says. Everyone
> >> else that has a vqmmc_enabled member uses it to actually mean "vqmmc
> >> is enabled", but this doesn't mean that. For example, you don't clear
> >> this when you disable the regulator in patch 3, so this would be set
> >> even if the regulator is disabled, and you don't set it when sdhci
> >> enables the regulator, so the regulator is on when this flag is not
> >> set.
> >>
> Hi Evan
>
> This flag is meant to say "disable vqmmc *only* if it is enabled by host
> driver (sdhci_host)".
> If host driver doesn't enable vqmmc (enabled by platfrm driver) or if it
> fails to enable it, then don't call disable vqmmc.
>
> Agree with you, the present name is not conveying its purpose.
> It must be something like "vqmmc_enabled_by_host".
>
> Please let me know if you have any suggestions on this name.

Yeah. Maybe vqmmc_pltfrm_controlled? Or vqmmc_enabled_by_platfrm as
you suggested?
-Evan
