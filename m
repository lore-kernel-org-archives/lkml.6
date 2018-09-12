Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BE0206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="baCKQRKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BE0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeILNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:46:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37114 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeILNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:46:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so1411570wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dBJlzXSsI8ACekgiub8iu0SGNPn/dqoS4S7wlPf3OPQ=;
        b=baCKQRKdVc+m5y3FqaR19rgB+6P9Oscc6XBfXp63DSNITZOd5VRoppaoueHJv47gq+
         hlMW3dCW855zG9zLsBdGgr1DEzLRdrsBXOOiFDROPLt2J/D/BsbRCIXeLclk+7E1Scx2
         MmxjDtyYMkPWdteOt9pcEf1faFs2wW6fvjYAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dBJlzXSsI8ACekgiub8iu0SGNPn/dqoS4S7wlPf3OPQ=;
        b=SEcVVY1DAbOhLGDgJGNb5Ig8hbkYgnTO/LhyQfJIJbXG3qozMhRXBwZhCGd31tTIZy
         SCWuSc0OzMCmZJqFhWlhbCopHrDpJ5Q5akl3MeQegnGtkF1+8NEp+5y7qUrMHkIo9Gzu
         WFG9lJC9MeqSgzpZviHYYVx5M04PyX+8eLwIdz2tAZjVxfjZ3LOUn2glArB2piPlScUP
         1vlrhkyw3bz1C3j79CRoaEr80NVznwlHJw7wZToA5aTkshc5a+j1ttSRfz7nRuP3wRiW
         GkXmwmvO2Lz0NziEIE/7WgWDS1sUcrj46w/h/+M6TG8L33ok+m3VaSOjeLFajcZ6o/ze
         MpfQ==
X-Gm-Message-State: APzg51DBDQknoM4bET0bgBqWNctoAMmBaEw6xTFH9D2QJ0XX41Ois1EP
        BK+GKDPRwFq+NQU3qhIsbF7wbg==
X-Google-Smtp-Source: ANB0VdbV772B6phfMHmGgNcgcwkhAomw6B9k+oJriIqMH3q2Zia04dnnx56aH9tmRbOT8XrD8kslkA==
X-Received: by 2002:a1c:208c:: with SMTP id g134-v6mr855519wmg.144.1536741774496;
        Wed, 12 Sep 2018 01:42:54 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id m68-v6sm1573980wmb.10.2018.09.12.01.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 01:42:53 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:42:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for
 LDO3/4
Message-ID: <20180912084251.GO4185@dell>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911124029.GO4185@dell>
 <20180912074745.GD2381@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912074745.GD2381@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Matti Vaittinen wrote:

> On Tue, Sep 11, 2018 at 01:40:29PM +0100, Lee Jones wrote:
> > On Wed, 29 Aug 2018, Matti Vaittinen wrote:
> > 
> > > There is a HW quirk in BD71837. The shutdown sequence timings for
> > > bucks/LDOs which are enabled via register interface are changed.
> > > At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
> > > beginning of shut-down sequence. This causes LDO5/6 voltage
> > > monitoring to detect under voltage and force PMIC to emergency
> > > state instead of poweroff. Disable voltage monitoring for LDO5 and
> > > LDO6 at probe to avoid this.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >  drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++++++
> > 
> > >  include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++++++++---
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> I m not sure if it is relevant but I think this was already applied to
> Mark's regulator tree.

Where is Mark's acceptance email?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
