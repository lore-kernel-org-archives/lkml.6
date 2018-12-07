Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E189320868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9Z0AmxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E189320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLGAPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:15:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45586 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:15:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so864214pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrQCzepF32eSc4nulqWoLfzxYmel15K3WRQ7t0gxsl8=;
        b=A9Z0AmxQgbQ6/n5gJijTU3OosRY1SSL6itGySkugpgf2i7uanLsmLGF3rXlnGrRcF0
         MhqpTQ5GiFRHEFAnx02FqitZWiz3uIha+cDZMMt8mI1C3YXHmpamyTw6dI9ZYiLlCeQK
         ubsMcAoCGK4VayCzEVC18N4zu7ObTMfgBlmYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrQCzepF32eSc4nulqWoLfzxYmel15K3WRQ7t0gxsl8=;
        b=ISryv0YWE/AJmDMBo89QYEBMHu+KX7PknASNxqr00hqy/m9Io1I8Y03FcrPRT1mcfq
         qger71T3QKHwxqlLF3EdOdS9bkRHkfonJeO0Jm3gJdGDCeJIXf1XMO6akUpnkOG9Aamg
         ilFtRcG6j/h1NJUGfzcjU1O/JRRUm73Ms+SE02mw9eTlbbEd/zOj0oLn0xZBCZv9pMRL
         FPm/BDABtIVDRk1T5Hs9UKhhcCYqO/zkkcBv1s+fvpsMMjuXuWBrdwIc2wdGj0M+OfFB
         6yaXsWuUSz4iYNUpmzQ6EhsdudpGbhwfcdB0IWQB5HtTlycVVzl6flHBPwOUZC1dkD6f
         HEQQ==
X-Gm-Message-State: AA+aEWaeZJoaOSgDkuxaMJgl2WMqZT0cLCJvLVSoW2FFSaIkQNxJyKzA
        t1FXzdmbMa9t4AJ9FPChDWiCVg==
X-Google-Smtp-Source: AFSGD/VmNggKG9AdPps+47dVG6ibac4BfZY03f/XpJJt5IQ7hdII7LeIohGHg5q1/1wGkqpB3+PmIA==
X-Received: by 2002:a65:6491:: with SMTP id e17mr52023pgv.418.1544141753790;
        Thu, 06 Dec 2018 16:15:53 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id y6sm2204682pfd.104.2018.12.06.16.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 16:15:45 -0800 (PST)
Date:   Thu, 6 Dec 2018 16:15:42 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mwifiex: debugfs: correct histogram spacing,
 formatting
Message-ID: <20181207001540.GA165647@google.com>
References: <20181130225303.143409-1-briannorris@chromium.org>
 <eef7598bb282218d4700986b15cf9f83a5e7edb5.camel@perches.com>
 <20181203222654.GA155572@google.com>
 <87k1kper11.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1kper11.fsf@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:37:30AM +0200, Kalle Valo wrote:
> Brian Norris <briannorris@chromium.org> writes:
> 
> > Here's a v2 that combines both sets of strings in that way. I'm not
> > resending the other patches, since they were only related in concept
> > (since I was referring to debugfs for implementing the nl80211 stuff),
> > but have no real dependency.
> >
> > @Kalle: I can resend the others as a new series if that helps.
> 
> Yeah, it does. Trying to pick patches from different places in patchwork
> is just too much of a hassle for me. So please do resend the whole
> series.

I've split them up and resent the other 2 unmodified now (as 'RFC PATCH
v2 X/2'), as this patch is trivial and not related to the others
directly. They can be applied in any order. Hopefully that's sufficient.

Brian
