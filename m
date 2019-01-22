Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A8EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42592084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548191356;
	bh=UbrDL6M/rDyLH7c+1s3I2esSDu28VVPzkdl7093EqgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08/fhcRs2j7YZBC6pF61XBerFCFRF0KvurcflvzAcI4zD97pEQ8bE0f0KVgOwrNVA
	 +KEvvGRFCtBVkyiloNhSLLAEFSBDJ4s6okZBlm9ILjr5m4+NjArEl5awn3X6DeGW7E
	 P0aW00/8pEFRO7z9NKdlnQWki1+Ahs9KNvD/2Udk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfAVVJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:09:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46493 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAVVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:09:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so12052404ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzB8qQk8vVENoVdx0u49ipI6e12en1ClVoXBqIce/n0=;
        b=kyor9J21TtifISnkIt9RoZU5RIJouVMwsFkTWH6Awi3urQPmylMcf0Fvo55VgjinKZ
         lwMnhDybnSH/DprKQ9DqhtYyDttTIMueIdvlWN2m2Hygm+S6uZ9oVeA4Jwnf80ZKbIPu
         OfnNdsHk5sH1UlvFHD+P4eK+5fvW/0UceST225XSA5dln6KxeT4uSWvGrR5PUV4wMh/4
         YEDYHVix3MZkbWyEJtd9zVpH79OyzNz8vpb6iXoe4GqPcXIbAMm69d2lwLUd+5DbbkDt
         B7U24FkVu46nP184TXJExeD2roL8dTaDmalDtVMg5ygBEf+5mP+OL8TgE00v8XUSDkaX
         ZDwg==
X-Gm-Message-State: AJcUukfCaI0WlOmiEApdDAPfvjZiWmK+x4wUuPteBXeWvcaWqqPjd/Ts
        76Oc2trXZMYRxLhL435sMpMnTHqzv0U=
X-Google-Smtp-Source: ALg8bN7YCbn29ENwwUlrMSYq2NsHGwPTyofpHXen6gr6lQFGWQyx4HZ8ArGtl7HMOKD0C5dofJf+ug==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr36283214pls.12.1548191353762;
        Tue, 22 Jan 2019 13:09:13 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id u6sm19294676pgr.79.2019.01.22.13.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:09:13 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:09:12 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Moritz Fischer <moritz@ettus.com>
Subject: Re: [PATCH v3] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
Message-ID: <20190122210912.GA8081@archbook>
References: <20190110043653.25901-1-mdf@kernel.org>
 <CAFqH_53Mdh6chEDTkNH_ZGC6scHhXXgp7zdDaSS2Xfd--dfrNQ@mail.gmail.com>
 <20190121184017.GA5761@archbook>
 <CAFqH_50fsPx1raFReNt719fT2DmgAb0YHwzzbmfdAy9gYigLiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_50fsPx1raFReNt719fT2DmgAb0YHwzzbmfdAy9gYigLiA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Mon, Jan 21, 2019 at 11:19:34PM +0100, Enric Balletbo Serra wrote:
> I tried with a Samsung Chromebook Plus (arm64 Chromebook)
> 
> > What was the ioctl you ran?
> >
> 
> The code that I ran is this: https://hastebin.com/cupecuvowi.py
> No guarantee :) I'll try to look deeper tomorrow.

I fixed it up to run with python3, but on my device I got either a
protocol error if len is > 120:

root@ni-n3xx-313ABDC:~# python3 foo
Testing EC_DEV_IOCRDMEM cmd
I/O error(71): Protocol error

or it worked for lengths <= 120:

root@ni-n3xx-313ABDC:~# python3 foo
Testing EC_DEV_IOCRDMEM cmd
6b 6f ff ff ff ff ff ff ff ff ff ff ff ff ff ff f0 0f f0 0f ff ff ff ff 
ff ff ff ff ff ff ff ff 45 43 01 02 00 01 01 00 00 00 00 00 00 00 00 00
05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[...]

Did you try smaller reads? If that works maybe we'll have to filter in
the kernel to prevent large reads from crashing the EC?

Thanks,

Moritz
