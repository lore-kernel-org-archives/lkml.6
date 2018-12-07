Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8400C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7319121104
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544225155;
	bh=0/yLuj+6v558gN9ZQSMd6wkldj7UiBLwAxUil163W2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e4fpvQq5oYtDsHxyMw6N4wtsVrzK+hhObh/BKTgg60d2Ef0PV+ZMjSqV0AgdsMPnV
	 bPTFOeV9pJ8AwFl5LEuso37v4oddAei8QLxzmk/+DQ/Fs+1AxEZ2bwpxkoJ/6hqY0G
	 rjCYQIX9BR5VsXDNsKX9ffHrePzl0VTKQTQ2F2Ys=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7319121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLGXZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:25:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40573 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLGXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:25:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so5368150oth.7;
        Fri, 07 Dec 2018 15:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aV/YMN4ro35LqdSd+Zm0fkgn/Mb9vd6cXeuYeRLZvqU=;
        b=AKGY7SS9XgfvFK0P3cZdkiwTpzMebbfl54Br2Q9qyYQ2VauVJUzMk/TSyOgrPl5gwN
         LRI0NHhcxNd1LIyJpqrAAWpgvVMcUIKA/TQwJc6WfBtrS4OLq9Cm5XBGHCu34+LPRFnf
         AN10LJE7qSNfuKQ/D+KONWPGxr5fmpKJjImwatoOumA5YOQhcho5maGrgcQvIY3p9NDY
         Ic7Tks/wto0lGTWcJ3UwNP5AM56Bug2v4EKhqUnddsT3li0fPPAm6WFybDa6CkZOjNXu
         LV/ozD54hZnkO/2b+hzdf00RNJcWdJXXLHuCVul/VdlFDQBUpk2QHzGMXUeN3bh+O4x1
         87Lw==
X-Gm-Message-State: AA+aEWb6AYixMs0vZ5YCYGOpogDbis9DStUELDrOv5uHWtKUKIUQ2ruy
        qpMqrIdOrXJ9TAmZUbTkmQ==
X-Google-Smtp-Source: AFSGD/XT6hhIoyP9TGcIEVqmplPk2A22vA+VKiDr9Yhp4xMkatDfC2WvmDv0eCmwWIgfaQi4KFK3Yg==
X-Received: by 2002:a9d:ac8:: with SMTP id 66mr2961139otq.315.1544225153204;
        Fri, 07 Dec 2018 15:25:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm2087961oth.78.2018.12.07.15.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:25:52 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:25:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: Re: [PATCH v3 5/6] DEV: CLK: sunxi ccu: export clk_apb1 for
 sun8i-r40  soc pwm.
Message-ID: <20181207232552.GA27927@bogus>
References: <20181125162203.GA5392@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125162203.GA5392@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 00:22:03 +0800, Hao Zhang wrote:
> The clock source for sun8i R40 is from apb1, so export it for
> dt parses.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 4 +++-
>  include/dt-bindings/clock/sun8i-r40-ccu.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
