Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C6FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF79C2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzIxH5JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF79C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH1VCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:02:24 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38508 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeH1VCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:02:24 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so4190082oix.5;
        Tue, 28 Aug 2018 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0poRIq1XefTlCB7rdFpGKwS5PwAFR1W+5FIX16wrzsU=;
        b=pzIxH5JZIRvv/uIyc936MQGmy5YxE/1vPclEUFHINKBbq5Ar4BROhEWQOrIpxwX5Mv
         vgzL3OFQzEjVtiE0HyjOryK+W6iO7MGbBT72RAefoQq22ptcNY3FAu1eptvMoIqtCabr
         /fEHT091ueeAsz8s6wYbeMPltPe2cJTpM2LOt0aXwV11zSQBQypfdU/WPfuNfc2gmmHp
         NGKHrBqMZXP9ozYSSBA2ngywbLTACUZUVs62tFKGjppnoJsfHKNmtDD2h3dviHAYdZt+
         hVu7bIjEhKWuQ76RX6uIOZM7fJGixhBpB093hH1YbePJAjtrLAxIY8RxvsFojMrP6HfP
         G6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0poRIq1XefTlCB7rdFpGKwS5PwAFR1W+5FIX16wrzsU=;
        b=gTY2R4uXzk7gveZDYxd9dcpuMEaB6ES+ED0GSuIHVZYvoWeOIdE1FmOXQ04kdEi20+
         MiTdrX39knLfpNQkOsoQgWGExhg+7GY2sDC5FkCOat49DruXSRDmXJ5zNPigdTOzsgMi
         25BIisUQFRmg9dMV6BINToaMxuecEXgOD5TguFz3SuaKoWTzFVq6r6HB0ZWRAjNv23jv
         k5ZT972BKALG3OcPfpvyyOAecoVa744uLQlB+EDV3cj5Z6AbL/oj4DqWEA4Cdp+AAD7t
         barBppckPSiS94Q2WSK/KNqZsbS7rHX7APom4bdNimGVqpBJ6nwRSIlYudKSeaXboeKd
         tjwA==
X-Gm-Message-State: APzg51DF0w/63QvettD9NPJqlWnVIg1F1XyOXBjDbvfVSVy4nHGSVA+5
        alXeZC3hoi9i0UXNvwcGfeWCe/D6IPEKMYXc2kc=
X-Google-Smtp-Source: ANB0VdbppTtXZahau5kH/6SexW4F7pEIYc6jDGuX1jj84KuHLIAsWDV6JFhYH4q6T+dJT8z/2Sb1n/8LCwUFlNd7uOE=
X-Received: by 2002:aca:c0c1:: with SMTP id q184-v6mr2030097oif.61.1535476188294;
 Tue, 28 Aug 2018 10:09:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 10:09:47
 -0700 (PDT)
In-Reply-To: <1535475997-21027-1-git-send-email-texier.pj2@gmail.com>
References: <1535475997-21027-1-git-send-email-texier.pj2@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 28 Aug 2018 14:09:47 -0300
Message-ID: <CAOMZO5Bfb4ybMj0jYFR34EpJ5rk9PcuJMK7toCpdqJ6M4Tgx1g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7s-warp: use SPDX-License-Identifier
To:     Pierre-Jean Texier <texier.pj2@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 2:06 PM, Pierre-Jean Texier
<texier.pj2@gmail.com> wrote:
> Adopt the SPDX license identifier headers to ease
> license compliance management.
>
> Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
