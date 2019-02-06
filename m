Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04163C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E7020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="jp3NrT9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfBFNdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:33:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33425 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfBFNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:33:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id a16so7615429wrv.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WpNOfvln6hVEciXFR6aW67s0uN9FvFbtqhvXHJG+KTw=;
        b=jp3NrT9/gI/JrO2zDvp0oB5NsKvc8hL1uGeSaFKCtZrtQAa2Q1o8yPT38h5Nh3Hnn5
         lU2AFD0K3fp9eMGxAcPPQzeBDP+0HJFQ2H90XvemBKeVwHq7nA0zY6Kp2PqTef6vfRbu
         SbC2ZzDCKbR4muztlRJYZBuZ5MYiytRUrNOu8enM2hzUq0g5sRacsT6/q5Tj5DBP6dWg
         E6PkQvBYIvQ0tZZADj6TLhx3hwjdEv8iCXpPPQ4JImEf8B9YcJHH5YWeI97xgika6HI4
         cNGWKk7cVmJAHjdyXbN6qgi+cE3OhFFBEk6e/ydTzYQCcZJ6Lr7CPdC2qNWve3KHrvHU
         N5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WpNOfvln6hVEciXFR6aW67s0uN9FvFbtqhvXHJG+KTw=;
        b=QU7aGBQXYPoBZa9K9JgojAAkrI4n1DfnP7aWtlj3loMlAeYpE5dJFiXJUUF9vHRjJ+
         /Eypx/VhCEw4fW4C4mXG4EUp+K6LDaGN3ycfGV4O+dNPw1nRiuhCsfX92F6sllojNU7C
         SMOT4ArOZBmrP/72VFYceM96LZPdlirOJXHSUGhb4SnVGz6i0TqLGNV89NdLtuajunO8
         kWFzvrTBh5b+2dGMRfRmtJv5MrDaLsr/cuOa7f/ksVFbSTzyppDHVqB/pIXpe97ZfEJe
         qRad5YxtdE5Qy6gLbMYdGh6J8lKDZdfMXhU+ffmfpdSH3LmNIpUFQt2PV7ptTe2olGF2
         rxuw==
X-Gm-Message-State: AHQUAuYwR+ka8LeyHxqjVq3L7qBwGaFmclMMwF/a9IPptZYLAzT144d4
        wZgUkit9XWhu3T7dMMxP665isw==
X-Google-Smtp-Source: AHgI3IZPSTW1YHEReBVKBFExtD/mW4LmThPnH8J9kNGbIIOLhJM729bNBtrst3+Ki/VrF1n1aksT9g==
X-Received: by 2002:adf:9c01:: with SMTP id f1mr8356411wrc.286.1549459985067;
        Wed, 06 Feb 2019 05:33:05 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id t199sm29205337wmt.1.2019.02.06.05.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:33:04 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:23:53 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 08/12] rocker: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206132353.GI2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-9-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-9-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:22AM CET, f.fainelli@gmail.com wrote:
>mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
>of switchdev_ops eventually, ease that migration by implementing a
>ndo_get_port_parent_id() function which returns what
>switchdev_port_attr_get() would do.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
