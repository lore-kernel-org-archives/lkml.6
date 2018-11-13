Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB74223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu452UVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB74223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbeKNDUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:20:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44326 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeKNDUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:20:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id b81-v6so5887226pfe.11;
        Tue, 13 Nov 2018 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VRSiZOYWPA1qboblnLmMItrCvZhdOVYvjeXsmUDCdE=;
        b=gu452UVHMzTFRNQ2EU8kDfpopyuKQq+GF/xAU2RJLTWMovn3nYmJu4Mz834AHFEZHS
         8Pwcyqm4koCsfxBLpg8H0uGun0OUP+rp8617p/0e0LpKKs7WNWlaTfIIo3Po87zuZnaX
         TwVhJbHX0laUtwFmEQ5VFznciEagWRGPPTurIg0ZcMSdd8AkLxOo28cY+CyExXEQNyfh
         HDWk2GqAJUZ/WJpC4KxImGsLqpP6aiW0tCWy6E7+cU6nj0o0q5aWFMiKgG6vuMgliR6P
         g3+hp/zO6mxaiWp/Jdzo1jhsCM+8zaOcbYvpxpiB8MAwSuLtvOYNAw/4tG0U/8AgMbUh
         SZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VRSiZOYWPA1qboblnLmMItrCvZhdOVYvjeXsmUDCdE=;
        b=r4z6TgKfVDHE6eXABo23e0vOZCDkJYCy5U7kMLrVmaLQUrFKId9CxQ2ZQksSFPL9Q0
         uIVucHfNbtiV8swhBoc2ovZGfyEP2nv5KVPno8jkevZJs66N7mc9b0XaYaEOx4YXfbMc
         hx9kykUv3kklcL/XfJr3A2C/ceRKsbMDCjsJRjXeRcNvs6qxSiyK5LrrvkoNW0HJFmH2
         Zqn9TwY4ZYfIeQAVe3Rir5A/OdWK14Zu0AeUlPKRg6F70j304P6XvIo2kd+0hIMwXjQu
         P2bSAzgEaQ6foWPGDv9eMfVhOj4MFYv9b32JVx4S26ywUrstajEk9QfMbGvWVOQLQl/w
         zvDw==
X-Gm-Message-State: AGRZ1gJRvmHZ68dOYxlKpVOfvcRVVlBQVNF0BHQDWhc0yyyej+VlNSol
        avrmsP2ndCVBJTuuBbaGwlc=
X-Google-Smtp-Source: AJdET5fLNYWzbBpVhrmTrhZ/TdzhwuLXuNAssU0Bf9BeXZ8bgb76s7rCir7RaVPoBg9aNa3qEjsRNA==
X-Received: by 2002:a62:1e83:: with SMTP id e125-v6mr5947503pfe.231.1542129664149;
        Tue, 13 Nov 2018 09:21:04 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p11-v6sm22592212pfn.53.2018.11.13.09.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:21:03 -0800 (PST)
Date:   Tue, 13 Nov 2018 09:21:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181113172102.GA21714@roeck-us.net>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:58:24PM -0800, Nicolin Chen wrote:
> Hi Guenter,
> 
> On Mon, Nov 12, 2018 at 08:32:48PM -0800, Guenter Roeck wrote:
> > On Mon, Nov 12, 2018 at 08:23:53PM -0800, Nicolin Chen wrote:
> > > INA3221 supports both continuous and single-shot modes. When
> > > running in the continuous mode, it keeps measuring the inputs
> > > and converting them to the data register even if there are no
> > > users reading the data out. In this use case, this could be a
> > > power waste.
> > > 
> > > So this patch adds a single-shot mode support so that ina3221
> > > could do measurement and conversion only if users trigger it,
> > > depending on the use case where it only needs to poll data in
> > > a lower frequency.
> > > 
> > > The change also exposes "mode" and "available_modes" nodes to
> > > allow users to switch between two operating modes.
> > > 
> > Lots and lots of complexity for little gain. Sorry, I don't see
> > the point of this change.
> 
> The chip is causing considerable power waste on battery-powered
> devices so we typically use it running in the single-shot mode.
> 

And you need to be able to do that with a sysfs attribute ?
Are you planning to have some code switching back and forth
between the modes ?

You'll need to provide a good rationale why this needs to be
runtime configurable.

Guenter

> Although the chip now can be powered down, but we still need to
> occasionally poll it for power measurement and critical alerts,
> so single-shot mode is the best choice for us, considering that
> the power-down-and-up routine would be way heavier.
> 
> I could understand that you don't really like it, but it's some
> feature that we truly need. Do you have any suggestion to write
> the code that can make it more convincing to you?
> 
> Thanks
> Nicolin
