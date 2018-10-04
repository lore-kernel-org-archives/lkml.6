Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBAEC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDC220877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZCnURvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDC220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJDVvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:51:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36605 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:51:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so10290971wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lZvJwahZ8Jz8etz7lg29/i3Ts6gNK6gnJknBYnXFSaY=;
        b=jZCnURvqXbHoijG9SPOiE+q3N5BVkelEbjdvMtdg46WcW99kRjk17IHoSV5UhZsrLa
         gLnnE6WEPsJYHGy3iHuSKiL0q56cFNEiv5AaQkOuz6Uxkhsj4jENUCb63WVTxAR3RhSn
         KC9iHJAoKGroxQxJnNGJxfe04f8b/gQnrFXmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lZvJwahZ8Jz8etz7lg29/i3Ts6gNK6gnJknBYnXFSaY=;
        b=C8bu8XTDYUR21EYJlf3pSVlhcmLsHzkeMcr46OqG5iBPj6IgGXCG+hcfzRWKC1WR9y
         zA6Hrg458ztl58zLNqSBlERrRkUbMr2cQRXFdTCZ06pCyFjPZrV9+Eid5Dq7XlYSVe4c
         DOAjluru+4e6/B/+azIg4eGyyWD69Mnxy5YsX1+oCw2R4On9y6yFM4XCiJHXQAAqc3YN
         xNf7Ie/wkr2O+fFaZkVDAmZazeBmNtk5m9+n8fxKhi0SrspeDcdNsi9L4UuWvb9so44I
         o6tCMsF7ZYstxTAs+cLBos12BErIlGE0U/gEHW2ekInQPvpD/VJoJntWuDa+OMzjI9w/
         G2fA==
X-Gm-Message-State: ABuFfogkzrRqhsRM7kNk/X7xvPDK0/hgGCZi0doxswbtSU9K96COiCpF
        yZzRxtasF2gOqAOSD+gFJzH/p49cZHQ=
X-Google-Smtp-Source: ACcGV60pOwbNG4fWSHVK3rkojPzVWOxieYpr21Ynh4uexrpGKeF5o482dywdRCEWe8UZgWPjbRwgYQ==
X-Received: by 2002:adf:f651:: with SMTP id x17-v6mr4741664wrp.317.1538665055990;
        Thu, 04 Oct 2018 07:57:35 -0700 (PDT)
Received: from mai (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.gmail.com with ESMTPSA id b71-v6sm6019466wma.13.2018.10.04.07.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 07:57:35 -0700 (PDT)
Date:   Thu, 4 Oct 2018 16:57:32 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] cpuidle: menu: Do not update last_state_idx in
 menu_select()
Message-ID: <20181004145732.GC1881@mai>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <1940908.mNKd7HXT40@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1940908.mNKd7HXT40@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:45:07PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not necessary to update data->last_state_idx in menu_select()
> as it only is used in menu_update() which only runs when
> data->needs_update is set and that is set only when updating
> data->last_state_idx in menu_reflect().
> 
> Accordingly, drop the update of data->last_state_idx from
> menu_select() and get rid of the (now redundant) "out" label
> from it.
> 
> No intentional behavior changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
