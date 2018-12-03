Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D60C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CCF20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CCF20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLCXt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:49:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37691 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:49:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so13440486oth.4;
        Mon, 03 Dec 2018 15:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4MvBUDwDBvP6IkbpGgbsUWMsT7O230KFaf0Js1Dqec=;
        b=PGR98IcxQfgVgVshO/5Tc0uK+V/Demit9JAac8pQzPuo4SqrPr2kbubJP4RfWUzFAQ
         NO+iNpcHUzIbq+hrCc5bNLyQQSBLjuVTGz98ytc3zajNWghKwnBd54f2PFcTjEg0z9nu
         Znc7AyYTVAE00OkxVsM66d7xIBOATckSpPML+Do2U4t/FXaIlaoKyPakAEi5y/iKRu8D
         hQBHJk4FkWoP5qf4pvrBSmhP8goLisfuHFV4l964veU49kxujpIQnXUaZ1ngHC6LH8lw
         4l5DT9OgI3wMlY9SKpJjtwWrqgHevRViAD+o8UHVHkzB8ei61pEJnpL2V3hx4D8Qkz6Z
         nE+w==
X-Gm-Message-State: AA+aEWYV7kfpIE0d0qQG3M3K0RMWqLB2XbVrjjpQBj7tjRvOkKJVEq+J
        98YAkbErwLeUSn+lK7vX5Q==
X-Google-Smtp-Source: AFSGD/W8Xjt4nRNjWGK4y6Qflx6Ikm3pM4oTdrXfNMcrVjDgFZoTC2eO+tOouo99+oPTMRznZ+hhCg==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr10662095oti.83.1543880964976;
        Mon, 03 Dec 2018 15:49:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm7513324otl.16.2018.12.03.15.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:49:24 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:49:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH] power: reset: gpio-poweroff: add ability to specific
 active and inactive delays
Message-ID: <20181203234923.GA29934@bogus>
References: <20181111214538.32477-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111214538.32477-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 22:45:38 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> Similar to gpio-reset allow to specify active and inactive delays
> while keeping the 100ms defaults that were used previously all the time.
> 
> The dt-properties are named the same as in gpio-reset but get an "-ms"
> suffix as properties should contain such a suffix specifying its unit.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
>  .../devicetree/bindings/power/reset/gpio-poweroff.txt  |  2 ++
>  drivers/power/reset/gpio-poweroff.c                    | 10 ++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
