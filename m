Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B232C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2982080D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Y4GPhGOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBIR5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:57:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53975 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfBIR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:57:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so9368769wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4c8ktr7DJt0xFELeIf+lxjXc34XAKhylqbYjXiV5XU=;
        b=Y4GPhGOZ/M3sBwCBLoGnQm39VRnhRvPYlEkGNDWfv2c/1WTyMQOoT2o9gUQrVwLA3T
         ZL+tvfhZmlyhAe2bogjxRpBAGkx+U2alskhamz8Lk9urv5cpiozr7dy2UfL6g0BfI5it
         wXE7yyq1R+kiyLVAG2K+zOlMNJB0fsS4FBqOL4+9hc9yehO01ucJlZZU3zPMZ2NlBls4
         mflOrqv8wQOflFSJ57gv1NdHKsckk8EDsUcyQbHWL0/LZnN5qnbbrJS8I6PHwq3y4Ao5
         hP5YVzJNlvk82WaLa4gKidzXqfCsWd9yPeHdV+UvIM7UeB3CXFGWhIRdnL1xixwCrMsl
         lCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4c8ktr7DJt0xFELeIf+lxjXc34XAKhylqbYjXiV5XU=;
        b=FnH2Il9ZDAXy1na1EkGhjTNjwsd82jP1/DkRyvR7gohnV3Zx5v8XeoUpv0nwq99MBG
         gXajd/807VoNRs2C1E0KGRm6WCSi+ijkt7ZD5bSEqvEQR5ammSWS+YYGhDQ5c1HV6fTq
         Ve1RlbjGCsHGLwZQH4ZtuhKFAIOtdLdGEb3UrkOX07NRY2f+w+9v+VdaCNLj3269x3Xp
         OqYO0n5dUQgeLGox/kMZlCoygqwuuzkcpM+OTWKSfndJql/ec11zMaJ5C+gXi8OF/fAf
         OAdA3TNobBq8PEYaA838B5HLHxO6UGx3PVFBuE+gw2B+/DlzZ/jEKKmNiHlhEroFddw1
         4HZQ==
X-Gm-Message-State: AHQUAuYkmLykWngsalY3Aja46QZHRh04GKO/v3pgMsfYUV+XQ1RmxMuN
        uOXwW77kHEN8w/wYSHaKS05IGw==
X-Google-Smtp-Source: AHgI3IZXsJGX8JQQDhGyyzXJPr8nUEKo/YDNG8+VBLqnP4cUIZIvl0ioTgRMJ1SL4ct1i0EP0uz4CQ==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr4405685wro.321.1549735054087;
        Sat, 09 Feb 2019 09:57:34 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id e27sm11671976wra.67.2019.02.09.09.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:57:33 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:48:22 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 03/16] staging: fsl-dpaa2: ethsw: Check bridge
 port flags during set
Message-ID: <20190209174822.GJ2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:35AM CET, f.fainelli@gmail.com wrote:
>In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
>have ethsw check that the bridge port flags that are being set are
>supported.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
