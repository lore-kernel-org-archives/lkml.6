Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFEC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A2227CD2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BH+EaSPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A2227CD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934299AbeF2JsI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:48:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43572 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933945AbeF2JsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:48:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so3759074pgw.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7zOQslA5AQgWfJ0KtTksxyDxkYFmWSxv2CTtgvNWZXw=;
        b=BH+EaSPyhzEKBpSw+If3FwMS6AaLW7Wzlx/jhDAaMwZbZg0tzSUCfHEP+QE5cFqbo+
         Sz7rYoEED/JE+kfpxX9K4XPep657zuH4AKUJPQjjFvN+yEJLBqUrYSWVaZaFmMvFVU+k
         naINx8xszuKBYHOpDAJfZUAgbjETqj4Md5tN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7zOQslA5AQgWfJ0KtTksxyDxkYFmWSxv2CTtgvNWZXw=;
        b=W+8YOXxuUctLzY/5gpW2BIdFta8PPFSirPVtttvOl1+K4UhpSYpRfCFVZfV/2A0/k5
         bM9mVUkae85iQnlIUDVDnwzFmzKryeS+3+bMrkx0jg3pcjCt86ztmTwf11xe0S+D/lVI
         bScS59wrBSDyp9QgcWDIvV6j7G8BHmne/iG2BZ4QeaygOh+lNjxU9g7MYmdVzct/cIRL
         Y2T+Vn4K6wPAi8R3FQS0c5uF9RurCIesrSEvMSva7KWFQuSYd5IUHvF7ZSF8g7kXnJUt
         nnCUao8Ya8a3uvuaCypAg2n6BQ7XIEDNRy1HvfLFFZKIveQLRsioBBsEYULEu/fmrQrz
         n1yQ==
X-Gm-Message-State: APt69E2hbmWMb45vMXOio+NaFJW+xO1Qt+OBK9ymQWZqNlNxY3FzIHIU
        cIqGHWo2YOEA9g7EZff+CgH70A==
X-Google-Smtp-Source: AAOMgpe7ln6QcfsrL6kzn51e5a54yQ7b9EdcG4CegvUca+QWFFM8EMx77xpEVy2ZTN0dp+epqu8cUA==
X-Received: by 2002:a65:5b45:: with SMTP id y5-v6mr11159618pgr.63.1530265685304;
        Fri, 29 Jun 2018 02:48:05 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id k12-v6sm13334206pff.31.2018.06.29.02.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:48:04 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:18:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] OPP: Support multiple power-domains per device
Message-ID: <20180629094803.nsk57skh6wu72oxa@vireshk-i7>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
 <2322281.e0L7xCS2Qb@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2322281.e0L7xCS2Qb@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-18, 11:06, Rafael J. Wysocki wrote:
> On Friday, June 29, 2018 8:19:30 AM CEST Viresh Kumar wrote:
> > Hi,
> > 
> > This series improves the OPP core (and a bit of genpd core as well) to
> > support multiple phandles in the "required-opps" property, which are
> > only used for multiple power-domains per device for now.
> > 
> > We still don't propagate the changes to master domains for the
> > sub-domains, but this patchset is an important stepping stone for that
> > to happen.
> > 
> > Tested on Hikey960 after faking some power domains for CPUs.
> 
> I'm assuming that this work will go in via OPP.

Yes.

-- 
viresh
