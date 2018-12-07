Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA285C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BDD20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544204689;
	bh=pDuMxFBv7JUFQbPZQh0piYaooGqFZqIH0D3k+JPA7S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQGWoLErG4JavwCUYwfdifTypsz+JlzN7P8cCovI8fZliu8xklz9MvCG9Wa/BlnGK
	 rbCjNrxxTGbqncV8YC8XNF4o69LEJFbcH858TD7Z8HEUDkh7aU34RQZRl3V0LPGonO
	 umpYOaEmMjB+RXetGeuF33a5d3j1b3om2/gc5Lpk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BDD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLGRos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:44:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35340 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:44:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so4566750otj.2;
        Fri, 07 Dec 2018 09:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TCqTuN2+JhTJ2mdrXlc0P/j7/wJg9XtgZVlSTt84uns=;
        b=NHpsyi1IHBVHRI3dhiPpCMLir6L6j1GQdQzc3TVevTYVENjkaHtcKMvcO4u9aTW1Rf
         T+0b5f1jGi5IUX/Aufc8dfNr5ck7T69R0vJGHe0ZO1zyRrJY612Y1QIL58w4hwxDbl8z
         bg3ZgOR1gCIKJaRlWNlqyzSK1g40rW/IeVVjByK6D+27Xg/HBvIDWDLVBYHbiY5tsjfK
         SRo18U7E4zMTw7oJ5GlGcR2+kGAandtOR6K6ajU/on6Gu51ULYGCVc8L5S60LHvD0qcl
         ndP+GWjGsF3N1qrZDklzA31qIejtAUd/ZvUt6qT0aNSDF8ANq9x8JL8Szk+5srLCqGhm
         s1Nw==
X-Gm-Message-State: AA+aEWbJLabuRRK1bLwUCI4EjXGpz7+C6jZkrnVo+p/x0bqJixgINGyu
        j/aC36s3hxbm8d+7of2eIw==
X-Google-Smtp-Source: AFSGD/VK1xwlxL8+TXvqdvbkIZgCkrDzDREpPdWkcDMXOu2oTIO/3VUP96I1ZNyJhw895ai5TzbPug==
X-Received: by 2002:a9d:3a42:: with SMTP id j60mr1993169otc.202.1544204687090;
        Fri, 07 Dec 2018 09:44:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r1sm1639028oie.44.2018.12.07.09.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:44:46 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:44:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] dt-bindings: anybus-controller: document
 devicetree binding
Message-ID: <20181207174445.GA13582@bogus>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-5-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204220224.27324-5-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:02:22PM -0500, Sven Van Asbroeck wrote:
> From: Sven Van Asbroeck <svendev@arcx.com>
> 
> This patch adds devicetree binding documentation for the
> Arcx anybus controller.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  .../fieldbus/arcx,anybus-controller.txt       | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt

This looks fine to me now, but still seems the rest of the series has 
some discussion. In theory, all that should have no impact on the 
bindings.

Rob
