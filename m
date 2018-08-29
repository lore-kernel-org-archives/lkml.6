Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17965C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC532087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC532087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeH2E2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:28:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34863 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2E2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:28:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so6194709oic.2;
        Tue, 28 Aug 2018 17:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p20V5Tge1VBBCw5V+2svOS7YZpTi2q279WEvcjYTQyg=;
        b=dXyRYBoW9Wz3aWY7foA8SwzySFlsNsL0I1aAm2p7c2aBKcQ5/kWG/f7W+AK/KCZSCU
         YndEHHKwHdGhT9tAJo9pabwUc2NqS8hcaiGtuu1ccNdPNtWPxQVh/RIzEAYn0PIJyG23
         CQaLlm69FOHvAJ2X/2FlDFbO+Lt0iO3BA8/0EA1CtDEA3KPn7rKZ2ynNNgqMeO48h5nc
         TAoWPzIitGXrIklj8b6S8fzKtGbb1ubVNclSJYE5K6itI017BqXA57hxVO6ct9T+V7fo
         qw7V1EAO13xWwyNE/7ctvI5hGByoLBNJf/QwlKCkIBf6IycREb+mmX7xGiApHL7T27Kk
         B6KQ==
X-Gm-Message-State: APzg51CFbam6PTqgGmirWx9uiIiVbdlX9g3eMuYq0ZJHeylDHb/BlcKU
        V+v0LlBAfKgeY+Dfqmuafg==
X-Google-Smtp-Source: ANB0VdYiWSVJ1n3lHn0Px3KSr037NwwbeOCcrSTNfGtaVIghWW9eEWGC/0gWZZ9MuUd73BEjmGrEIA==
X-Received: by 2002:aca:438b:: with SMTP id q133-v6mr466772oia.234.1535502860261;
        Tue, 28 Aug 2018 17:34:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f4-v6sm3842986oic.52.2018.08.28.17.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:34:19 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:34:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/3] ata: libahci_platform: add reset control support
Message-ID: <20180829003418.GA18849@bogus>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1534939983-16264-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534939983-16264-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:13:02PM +0900, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
> 
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
> 
> However, according to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset make a path to occur double controls of resets.
> 
> The ahci_platform_get_resources() can get and control the reset
> only when the second argument includes AHCI_PLATFORM_GET_RESETS bit.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/ata/ahci.h                                 |  1 +
>  drivers/ata/libahci_platform.c                     | 31 ++++++++++++++++++----
>  include/linux/ahci_platform.h                      |  2 ++
>  4 files changed, 30 insertions(+), 5 deletions(-)
