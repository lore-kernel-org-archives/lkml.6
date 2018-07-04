Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F372C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32AF223CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbNKvKpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32AF223CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeGDJiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:38:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46738 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeGDJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:38:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id s11-v6so4632302wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WxKlSlDebsb2stq4WbpTsDIilhO3CZwnekZAE85pd+s=;
        b=NbNKvKpaHqdn+V7lIZdmUgt0pVto0TEdDetH+TbRzygfH2O/serXMSKopedZh+/Nzq
         WesFobjQV0mzgCdz6Y0cBVQ2aLlBwHeaGDVqXWdCxTkT4i+cbuLF6HZo8n0srRtUFYgx
         dhj+c/yutJqZYlqsF5U02pxmgJyyzx3+AFOOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WxKlSlDebsb2stq4WbpTsDIilhO3CZwnekZAE85pd+s=;
        b=TTyPt2iPckBc8h1YRzNbnpkgaQP5dDBeRKz8p9ShZqquy3a/jCNZPP8hZu7ra9t+e6
         ASQK+/gMVz/kXQKPruAmHj0/rzI53W2GPMqwtRrxwZg9V1RBYhPUGtnZtiXpWVtB15yW
         uyPRMB87Ypgw2GYHFRBVJ/lzY3LZ3nhYz+c3nEvxdzty7QY/RKIPxH6leBltpAaJCgQ3
         EpNHPDJdLfnLrjWatOo2/6pJRaGYurEuuFmzHWi0wUpiZzc6219kWakdonDlTxqPbxLB
         G6wLiSORiqg+OwbrFaMZ4zEM0txF4+q0GMcNZbRfG4JMbdi0C5aazIwIllMRCQyY1Hb4
         oTLg==
X-Gm-Message-State: APt69E2J9P/hENl05D1Il2lfUixRF68U4Y38B9vAXtsVxfWitRIv9yz3
        rBG+fmcNAXvPdrFRc3iUkbhOjg==
X-Google-Smtp-Source: AAOMgpfGlUl/XO5EP8d87tglOBUH7aEA9h7Fuk7SyKgj+Idkx9vvvvUBu96fIUwYibzpC1HfoCgJPg==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr1101146wrr.138.1530697098352;
        Wed, 04 Jul 2018 02:38:18 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id t1-v6sm4340981wmt.40.2018.07.04.02.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:38:17 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:38:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: remove obsolete comment for ->state
Message-ID: <20180704093816.GV20176@dell>
References: <20180503141517.28207-1-daniel.vetter@ffwll.ch>
 <20180704093447.GU20176@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704093447.GU20176@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Lee Jones wrote:

> > Jani spotted this when reviewing my earlier patch to remove the driver
> > internal usage of this field in
> > 
> > commit 3cf91adaa594e8933af1727942ac560e5c7bc70e
> > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date:   Wed Apr 25 19:42:52 2018 +0200
> > 
> >     backlight: Nuke BL_CORE_DRIVER1
> 
> FYI, sending patches like this is not a good idea.
> 
> I'll clean it up for you this time, but in future please send patches
> properly and place any additional comments you may have below the
> '---' line.

Ah, I see what you've tried to do.  This hurt my eyes! :)

It's more conventional to reference commits like:

  Commit 3cf91adaa594 ("backlight: Nuke BL_CORE_DRIVER1")

Again, I'll make the amendment to avoid further confusion.

> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > ---
> >  include/linux/backlight.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > index 7fbf0539e14a..0b5897446dca 100644
> > --- a/include/linux/backlight.h
> > +++ b/include/linux/backlight.h
> > @@ -79,7 +79,6 @@ struct backlight_properties {
> >  	/* Backlight type */
> >  	enum backlight_type type;
> >  	/* Flags used to signal drivers of state changes */
> > -	/* Upper 4 bits are reserved for driver internal use */
> >  	unsigned int state;
> >  
> >  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
