Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBF2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3EE21722
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3JtfyC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3EE21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeI1FMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:12:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41491 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1FMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:12:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3-v6so2971606pgv.8;
        Thu, 27 Sep 2018 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqWsuOr30wMexCHYi5ZDbCJx8riagDxZgYmpYeV1W6I=;
        b=X3JtfyC/Qx4Waaiagjt8mO6dImM13VnvzX1CCMHFKyanRkTqnXk9cAUnDqqGulr9nl
         M1IHTw4yHFCWp5VjvG85YeoYVP9iQTvTy9goviepT38bkKItvI/YZfasG2qX525nYaQk
         Ly3Npy7OTJBxXzaQT4GS2r9AJyJXSOdUr6HApvZRrgOzlhArWoiRlxrD5Ko7x8oJFso3
         DxtfEhdj3UrP2S4gJbbTbeGTd941LCNPxdCg9TEMeQb1Dn1wO0rcm6CC4WJAeOhkkvll
         fP3vnPdJoBAOivSZmisZsfPfFGqOkVx1/xapAjgsJ9gvRXsF+/6oMQQdi4uHJmLv6DXJ
         9cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqWsuOr30wMexCHYi5ZDbCJx8riagDxZgYmpYeV1W6I=;
        b=I5LiyfvN9/w9SIsy8kqOuERMU2F2OJPLj96YgE7rsq8RZl6LZRdS+lUAk7GwVi0iYL
         cEbFKUK8YZGBJzYZuiHhqjEN4Rk77DPYUlb8uznp5+5RgskTJFgwgvS1+wZhbrZrBns9
         E8+q/4octHtamP+rmwBlyAMPp4leAq9tTCKCyZPsmcwcW0Temvl8/wbc67u6/PWbk4ep
         E9j4iy6VC/7H2mwcydBGHzKiBa5pnwcISnVkgcrbUQRyQWpr7Q6DnY0ACo7HRDk8H70W
         9tEVqnY5/Q55KaRc+9n8ZGiNKtonpm5RNbpv6mRyc0CuD7KEPOu4uW7n1IiGcmFc/ghJ
         2zKw==
X-Gm-Message-State: ABuFfoghvy8P0KipUX+9ZjVxM0GWenxh74bUU2IXMzmoBNNw92WO3UFq
        1hl70cqOEIIdY4iUxgtKFvo=
X-Google-Smtp-Source: ACcGV60kHzbq3Ipa9cyW3t+SLfXppnBGSUSBeF1Jc9ufAwVNzb2Dwq7ZoodECYPQ3fUSpyqznMxrIQ==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr13251695plk.127.1538088722596;
        Thu, 27 Sep 2018 15:52:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k26-v6sm7072562pfb.167.2018.09.27.15.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:52:01 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:52:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180927225200.GE9198@roeck-us.net>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180927222614.GA8430@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927222614.GA8430@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:26:14PM -0700, Nicolin Chen wrote:
> On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> > > +static inline bool ina3221_is_enable(struct ina3221_data *ina, int channel)
> > 
> > s/is_enable/is_enabled/, maybe ?
> 
> Fixing.
> 
> > > +	return (config & INA3221_CONFIG_CHx_EN(channel)) > 0;
> > 
> > The "> 0" is unnecessary. Conversion to bool is automatic. If you want to make
> > it explicit, please use
> > 
> > 	return !!(config & INA3221_CONFIG_CHx_EN(channel));
> 
> Removing "> 0".
> 
> > It should not be necessary to re-read the value from the chip all the time.
> > I would suggest to cache the value in the 'disabled' variable.
> 
> Regarding this part, I added a cache before sending this one. But
> I realized if the chip got powered off and rebooted during system
> suspend/resume, the cache would not reflect the actual status. As
> I mentioned earlier, this was enlightened by your comments about
> the BIOS. So I feel it'd be safer to read the register every time
> at this point, until I add the suspend/resume feature by syncing
> with regcache. What do you think about it?
> 

The proper fix for this problem would be to add support for suspend /
resume to the driver. At resume time, all channels will have been
re-enabled if the chip was powered off, even if they were explicitly
disabled by devicetree (or via explicit configuration). This means
the driver just behaves badly across suspend/resume, period.
Displaying a raw value instead of a cached one doesn't solve that
problem. By using a cached value, at least the user would not notice
that the chip no longer does what it is supposed to be doing.

I guess we just have different priorities. If I think suspend/resume
is a problem for my use case, I would just go ahead and fix it.
I would not try to write code that doesn't fix the problem causing it,
much less argue for it.

Having said that, I didn't mention that part in my other reply,
meaning I'll accept the code as is.

Thanks,
Guenter
