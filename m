Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE55C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051520828
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmxBDMWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfAADC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 22:02:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39474 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfAADC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 22:02:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so13164704pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 19:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kxba1AYj0Cp62D3Zqi46mRtdwm+8CtTFp3Dq0lBxQt4=;
        b=TmxBDMWGdbn55y+Uq1FyDcmxHG8zbjT/t8vc/RDlxVDzJRHfVWUnwdVCJTVkC0qoGL
         S7oWWcDD3eePrghi+vDeillWZd/agLArqU9mzGwBouw/QkTBwzoXbYaSmM9sBxOzKC7f
         mffqJVcoNHiFDT7PMZgOP74pW9qCIx1jXJdBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kxba1AYj0Cp62D3Zqi46mRtdwm+8CtTFp3Dq0lBxQt4=;
        b=BKQEjeBA7wsn/tegNSapbP0iSe0HQjYcZWGVOFrEQfvA3ZCwcFDOht0yUitZ8hoFCL
         DAGn8itcu2lhSsRyNhjJDmh2vdi99yEpyfcjxjY7xJNUXQydKspyFUTUUkeM3vcDE/GD
         PAmTkTvLikipbXh4ZR7QmXhPWRcJUSIlMJYK3g4Mu8Dw+5nn1TS8DEsoJSCuyojUA4A8
         xG97Be+wsnMdnntBLRO2yNYbmHkaEslZbjmQZkPkOiMiX+dw02yxzUhg42URTM7TNIXL
         2qDxoC8kVHUdqqnxHz9TpiyMBMaRcHvc8ipd81C7PQMQQfSngZKZIDNcBb33O/PV8o8Q
         3KGw==
X-Gm-Message-State: AJcUukdi8kYGDaSmDL1/8fyMNAHrA5VncTnXqXP4EUyOtQMLLpY3BXxf
        1/rUH1GyGcFtj5BE+LzKJ2gM
X-Google-Smtp-Source: ALg8bN6aVDNvEH0JvMxSuMeIKUBkdWnIsB5SWdw2xIugadFKID7jTTzRJdNdaxJ7x3zNW66etFd94w==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr39073927plr.48.1546311778336;
        Mon, 31 Dec 2018 19:02:58 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:73cf:97ca:3812:84fe:81d3:6fa8])
        by smtp.gmail.com with ESMTPSA id g26sm63005694pfh.61.2018.12.31.19.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 19:02:57 -0800 (PST)
Date:   Tue, 1 Jan 2019 08:32:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net
Subject: Re: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Message-ID: <20190101030247.GB2736@Mani-XPS-13-9360>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
 <20181231211342.ulg4jytermffqi34@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231211342.ulg4jytermffqi34@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Mon, Dec 31, 2018 at 01:13:42PM -0800, Olof Johansson wrote:
> On Tue, Dec 18, 2018 at 08:32:27PM +0530, Manivannan Sadhasivam wrote:
> > Hello Maintainers,
> > 
> > This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
> > i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
> > GPU. The SoC has been added as a new ARM sub architecture with myself as the
> > maintainer.
> > 
> > More information about the boards can be found in below links:
> > 
> > 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> > 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> > 
> > All patches are reviewed by the corresponding subsystem maintainers. The
> > clocksource and irqchip patches are reviewed and merged while the serial
> > driver got review from Greg but I'm not sure who will apply it.
> > 
> > So as per my discussion with Arnd, sending the individual patches instead
> > of a Pull request so that the rest of the patches can go through the
> > ARM SoC tree.
> > 
> > Please consider applying it.
> 
> Hi,
> 
> I've applied this series to our next/late branch. It's a branch we'll try to
> get merged by the end of the merge window, but it's not a guarantee that we'll
> be able to get it done. If not, the material will be moved to the next release
> instead.
>

Okay, thanks for the update!

Regards,
Mani

> 
> Thanks!
> 
> 
> -Olof
