Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB085C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6271727C29
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fG5Z7+4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6271727C29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936606AbeF2Ss4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:48:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35619 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934305AbeF2Ssx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:48:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so4361747pgp.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B2Bi6Kc1QYq40IqUU3e8QlrpOWsIuoa8e/TYwjoVXlQ=;
        b=fG5Z7+4F27+Sa0/SlfXLz++8lycxG0MK0NojgXb5njPeNJ9gx2RClygR13EA7GahAg
         Bl5QBPsOgfjRuBHxSNJx4FSW13RCN+MUJ1KLvJcQb0GPZDPz1gmYMjCs+q9udml+K0K7
         VmzO6YJTlSXekaURZlJdBB7PFejHAeu76vOKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2Bi6Kc1QYq40IqUU3e8QlrpOWsIuoa8e/TYwjoVXlQ=;
        b=mmL4HnJwKGlTMEa+72sBJN3zAlVbP9XkoIEF5YmxROmxo2KvLZlbmmneDn3Nrk6adn
         aHNWvfx6eAIWr8ur9UueT5hQOflhKxdv2S6R5DKB9dHTL9i4XqgPq5oUP1cjNlzwqtlr
         N3w1yfikBfrqnbLaTIyKh0EeMF2uzA1a3WhfLNwtaha5NF2HZV6J1TOQniVB2E2fWJCH
         td/hGen70CoLZUoGruPN5lQYKOvQx9dJKtMlB70qX3/9fJ5B2iTf54nIENSkfEIC4CIl
         ko5ekxPRdR30KRm7M+T7pX6RqJDsFV8IJf64WD91BjxanG4OeUXtL6r5pFPcXVVDMRGe
         Bu4Q==
X-Gm-Message-State: APt69E3QBK7/BMr7L30x2xEpQ3gJE+BOIzD40jPXyVE6NHTT0bTpP6bF
        DUCL7xhSOxAUBPNoZn3fAX2Afg==
X-Google-Smtp-Source: AAOMgpdlNJZH4EdgHNYD/X7n9k2Zs9FzvExJPPBFzS25oLgQpveMrW9p54mbzKmVEVB4WEQtWOja9A==
X-Received: by 2002:a62:5247:: with SMTP id g68-v6mr15700994pfb.149.1530298133184;
        Fri, 29 Jun 2018 11:48:53 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id f12-v6sm2799581pgt.57.2018.06.29.11.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:48:51 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:48:48 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] cfg80211: use IDA to allocate wiphy indeces
Message-ID: <20180629184847.GA251207@ban.mtv.corp.google.com>
References: <20180621012945.185705-1-briannorris@chromium.org>
 <1530258140.3481.4.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530258140.3481.4.camel@sipsolutions.net>
User-Agent: Mutt/1.10+33 (2f90ec28cf74) (2018-06-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Fri, Jun 29, 2018 at 09:42:20AM +0200, Johannes Berg wrote:
> On Wed, 2018-06-20 at 18:29 -0700, Brian Norris wrote:
> > It's annoying to see the phy index increase arbitrarily, just because a
> > device got removed and re-probed (e.g., during a device reset, or due to
> > probe testing). We can use the in-kernel index allocator for this,
> > instead of just an increasing counter.
> 
> I can understand that it's somewhat annoying to people, but it was
> actually done on purpose to avoid userspace talking to the wrong device.

Hmm, interesting. I'm not dead-set on this patch, so if there are good
reasons to reject it, I won't fret.

> Imagine you have some userspace process running that has remembered the
> wiphy index to use it to talk to nl80211, and now underneath the device
> goes away and reappears. This process should understand that situation,
> and handle it accordingly, rather than being blind to the reset.

How is this different from the wlan (netdev) device naming? We allow
'wlan0' to leave and return under the same name. Isn't the right answer
that user space should be listening for udev and/or netlink events?

Brian
